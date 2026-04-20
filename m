Return-Path: <netdev+bounces-279901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NTsvJ5h05mkNwwEAu9opvQ
	(envelope-from <netdev+bounces-279901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5AF4330A6
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42AF3301C91C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974073B774B;
	Mon, 20 Apr 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRyXshF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7353B7B70
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710777; cv=pass; b=NpJHTqyI5AaRW4qDihqGZ6uEKfbGjX69ZOBMuK/7S9DOlkZywbIwT9XU1xKEekUBd2yy5JWalfueAetVddqcJxluBaX4KHpL9YJd6T2RHw10ykzxcQYJiML26/xc/a8nRKaI2N5xgj3x/QsTrMLdXOLCC2LBij67pGj31ICwXSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710777; c=relaxed/simple;
	bh=Y/jhZoYZ7u2Ged+VXPha5LdCk0Asr+jJmY7wL/sWqJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0qJp2bNcmS8AgSpS4qgugsbuDWf8XG6ANm/i9njt/WNDo4vyaElJNvwV7eh2QA6cEY9SrLBs6mnhjn3QTgy7/56D77D1+9enqOif4LqCOc5wRNcPRrMfKEOlPQrnnm/sM5E8sJNz/1ip4g4CZBT5kh6VYkLQOu/i3xPh2FZWVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRyXshF3; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fc4425b6bso25965077b3.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776710772; cv=none;
        d=google.com; s=arc-20240605;
        b=XwSueLeGbLW7QneYTG4VXxfb9XLmm0/petFWnDtjYCe8p+a4fwv8VTtZrLirEDtOzc
         MG6GDUge4Eqo/K4KzpcFNgnWQ2tHhlLFIBzNiPvxGEDPmtIJsfycgTJav6S+nDm4YI4z
         YI+dmW8F6WclD1YtVTK87/lg01QHLcrmXAaKcX4+MlpmA4HFygPk4tXLWEAyvONqmFew
         F9lGvbfjLYTqQCrqqBoQ39Wy2UYA62zmJBj4DT6rOxUNpLuvdsyAUwmbvem43RncG4/S
         dtjOXDU1dhctFyg3QyT/TmLwGmc8+hXCO5DaKvcttudQ866ZiVvIQabWmLdmWeuTjNfW
         Dccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fb11Hsc5Ur1XxoLKr/XJHrlwpYesMOucLSi/NqEXMr0=;
        fh=CLgnvEAZFEi2QNbEQLANqET+aGNVnQptDNRqPN0HAdo=;
        b=EfXRFkAnmS5GOXYVIiT3o8ONrbC6Eo8M/XNJTP4JktWi9s8kEmDdvquhuocT1XkWrk
         BBvl9LYcfzk0D7JOR/dJU0YcZ5G8kNH7q8Xu6DyEWxo/AatvnKedSm+2I+jBjuKTmLsN
         fCZr8qIqB1gSmIA8+N8bB6zrMYARVbfdMfjT7Qy/80Uzc9dX4astuLFgdQFyv3Q36bBy
         JaR0cCZoQ3+Xwii+cfdU2PNDzsa8ziNj3QROXX8A/jzn/on0vWiFu0kvIBQH7wGX6iaa
         7wWnKwnd1nLCFLHDhKrH/I/zb3il5/mBTNNeWYk9Q9zd183k3d6MhgPquJEXyffGptzC
         b/zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776710772; x=1777315572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb11Hsc5Ur1XxoLKr/XJHrlwpYesMOucLSi/NqEXMr0=;
        b=kRyXshF3qTlagjgsrcy9/5tQXzw2QHdnaC2VyLFhSU1Py2oh1e0mPyz44dOEpCeJ43
         8FrmAEBZmtb0I6/TrFuqPMNWoQGUn/5MTxaTP47kHqPCFzE5/geuKtZzJhiNvWBxnXp0
         xepFNZiQkmJQTZVELYd/U+9wMZ+1VPI3AFUfkXy1qswMYOEEpUE7fN0zWvH1efuxQq/N
         k5l2lmyhE8x5OVwGxcqplY5lIxlUCrvZYBSMALAlsRQf0U3vKl0SeyIdCh4Zqdms2Mh4
         GiAHCFQveHqOLcbRv7nV1OW9Zkhv7rAY9/cjKo3d3XM0x044ZxAfV8TqQQ+JzdzmkOLJ
         cTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710772; x=1777315572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fb11Hsc5Ur1XxoLKr/XJHrlwpYesMOucLSi/NqEXMr0=;
        b=l7T4Dcnji4v87qIFqb0DjVj7kXpG/QU1JWFAf+W5Yr9bjswTehh2dP8HSTJPEFvi6u
         hbgW9FlCgRcUWoCQz1/zisymc2nVJP//oFoIZ5pdvG81kh5XyNh4bF67bv4ZzUi16LYf
         FGUt2BTd9WuLMLakCajQXZcvJZBoIw0MidqnnQhor2aGmbfwjYw5lpK2PAuqKA8+ePFL
         R/cg1MoKHQZ1CjoV6iWgvm8X0fRWF7qnynlCQoPnrZcpD9I8KU2qOdXRcVBDjF1gVnBA
         9WLdrjAi1MzSszI7/+qBqyJUsASwhl5bQ29/pxzKEHt5VPFRxtH7NIs1ePNVIhxbL6uW
         dUKw==
X-Forwarded-Encrypted: i=1; AFNElJ8EF/GqD/9bffziuAQne+71O1zY//Bnz3g4GqxJMqnvvq33wGfm9KPCY3t0KGKJCgxoTpdjrtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8T3G2RD+5KyeUTBnGxriHQ2S/ZtUMKLRK1mtJeKCvhrsPsOB
	EhPnpuxAotV2JKm8G5lGUReq7ThANz9jbA/Q1d5bd9tMQkYlLc7KpZirXWPU6NBye64S3RNE7H9
	kEv39AOTVISMlN8kJIY6Mf5laQd68D8LqWw6hAH3X
X-Gm-Gg: AeBDietxVsk9xPQjrQomQYg1uaZF59dqVgZdjJg7wZn6bxYfUcQeOENHtJB31XfCL7M
	4dTFFs0uw6OMbJLXfi5jPmnrG9b2L2a81eoEaAXCkrH6/7hsFKU1FvQaK/LIwc4WJ0WfXvxcjG+
	8W2FHWmla5UL8mF4ruIxqAjHIF/JsiNxHZUVq+280lMZU5Qr2b5TQvt1WZeHlXfqN1B8Ha1xhpQ
	5PuecSSU0P3bwYVZ4sXX+z6Ld1k1EimbLSS5FprnLfR4QQ1qcVHDW31jet49n8B58txA9X3q2FX
	nVwlDxyDih7FiVPQLJjINO7fo5Puhol5IaGbXdNfX6/pJnTORDcA2NoqUaYlJkSc+IJBQgLukin
	JWpOa7Gnw
X-Received: by 2002:a05:690c:8d09:b0:79a:be42:661e with SMTP id
 00721157ae682-7bad58a3732mr92921487b3.24.1776710771225; Mon, 20 Apr 2026
 11:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com> <20260420113346.34735a1e@kernel.org>
In-Reply-To: <20260420113346.34735a1e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Apr 2026 11:45:59 -0700
X-Gm-Features: AQROBzBE9v4PKV-mmqHZoipbjQQT6spPjfGzjOA5S0UztWOR8OJzvlNdXCIVdn8
Message-ID: <CANn89iKuu-0G0X33n3OxRWd6TGRYASxDxpGw1c56fN=zWUZ9mQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Altan Hacigumus <ahacigu.linux@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,paloaltonetworks.com];
	TAGGED_FROM(0.00)[bounces-279901-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0A5AF4330A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 Apr 2026 18:36:34 -0700 Altan Hacigumus wrote:
> > tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> > using subtraction with an unsigned lvalue.  If elapsed probing time
> > already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> > underflows and yields a large value.
> >
> > Handle this expiration case similarly to tcp_clamp_rto_to_user_timeout(=
).
> >
> > Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero wind=
ow probes")
> > Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
>
> Hi Eric, Neal, does this makes sense?
>

I missed this patch. I will take a look asap.
Thanks.

