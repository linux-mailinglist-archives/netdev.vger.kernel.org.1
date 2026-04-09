Return-Path: <netdev+bounces-277029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDWKFFu912mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EB3CC3FC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26762301573A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D9C33344A;
	Thu,  9 Apr 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXQpXiEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294B244675
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746338; cv=pass; b=onIo5HzZu+0+tZE22VZRLiVA1OaGoYW2JQITYmfVRiDhJIjW1w67YTnQpKbIwFoGboXvIdrDERSoZDP3I0Dq49bnNLvs+vCId+9izt+2EwsUFFcdswUd4+630ZxXPN0yoV7i2tNqvwGgwebFizC6jziZVfP3xl00Qz8S4kD6Lg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746338; c=relaxed/simple;
	bh=hKJi0lQLwObxwCEMQQcUOOh16bysbmx0/laXW6Pjd3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwW1iIvfApofNpn/t5k0/sxkuSiTBaVLIYkaBdVY0r48eKBn1PRvoNFGoof3qhzmbqb4rYB6PhSqda/u0kttOFm+xKv0pbKiDjgPppO4HgiAySij9prYpNaLqhz55GyHFOKoqfqVsBu9F4eWa0MCZEnBdK5vpznzRj89YESLMAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXQpXiEV; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79d991c7b6aso10168557b3.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746336; cv=none;
        d=google.com; s=arc-20240605;
        b=Or+hCBSLGWLSbka4vng2mWgbxZxOngrZ0Mw5wPTe81vP+c5AQ/HG2QGwFD4AwdGBZr
         q6fYlEyw6Kunr7J2OPJsBTFrADME7aVZ+4s/4P4L3bbF11VABw2uS9WW0t3tm2Fahwvb
         GhTSHTSzCpGAzdINzPGyiPXi146J8Fuwkp2QeiFmjgjeF2J06hAUjtoLitwaZsboEwUy
         /iQ6jnD4ebKwTYhpntntMR+Aip3vUSHHDDjAiD1eH4vlrR6w6Pov2p5Gbvo++gll3ssB
         baEM8Z4RLYnLf6cqMDKOI8oudWLfatoswxj6Gl/558FmHZ0ui24+bt2hJUtzZ2mGMRQ0
         Dp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DiNnldnjPMSbCMNtz3veOwqHeM68J275SUUTDTaa04Y=;
        fh=FCOImpI2RA8b4LfrQZi6kVutxibzfYmiXDVBwAlObeM=;
        b=KPXONjHNDnLVPXTFFRNjghYcjdHYgGL5UtTdq43J8mw5ABwIxM9zKFEL+sZwEFN9mO
         MW8Sh2lXLHCIM+UYYXTujt+LATA/VmM2IS9s0sHS7Zbt/L+qYTwE3xDkYCIKW2uA+0dp
         phoowWuRnCNOao69b0GqUxiIyzQVW4D+yDRa3+g6rs0fprFHHJ1Pzmpdva7Zdx8G6mVi
         n/GzacIUfTB+X0HDhMU4/82//rqx2Pui/2yIJFaZoqzvn5B5wJVoiE1+9QyWQZigqTzU
         g+kz8DX9eTfGEGAPWuyOaAmAAL5f9aNJVsk12T2ZnOy4NOYiXFC8x6aWGThn8tor0gyN
         KDxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746336; x=1776351136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiNnldnjPMSbCMNtz3veOwqHeM68J275SUUTDTaa04Y=;
        b=BXQpXiEVEfTKCoSJocQ+XQFTSU+pTmWZPgq+66PKXkZyw7p3K8/4unhm37fvyMnqlq
         Re7ppKzOFr9v9ToX+zivCxfMmSQLUxe0MNt/x8i+Z6j4Z09ofgOJj0KvdcDwqaLoV8Qn
         i1Ah3wH5lW5Lg5nKrJbv5nHHYm+aizA0CXNGldBaAlX26IW1A7+JiHkOrTQBTgJdJfdP
         eTJHsuVfUUzRvOueKmdTqd2F/v/ernBIRYDPFmr1Fqr1Z9Khn0gcZNdumIQFV00Js5Ck
         IUnhAAMR7UOopsziBFs6tJB92aRNG36yXXANg6Qc1uQZ8tbCPv/LyG9K1vp2Sn8FL3qR
         do7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746336; x=1776351136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiNnldnjPMSbCMNtz3veOwqHeM68J275SUUTDTaa04Y=;
        b=oUGdWJ/Xmlb7SMbjZ7BabZIl4AyyE8e5BZ+F/M09JBtAIpexEt3Z0sheWwIF9ttI9F
         1G3UWluodDE4V+sUpPcIcUv1uhyUiFqEzTYmtqakOUYAMuMXal9gr74SVmrrdc+hhJAw
         dYTjaMAvzLI9Z3kWm4S8GKcWI+gd6wJSjhnFYqpxeEdCwiSXyoGev56Zz4eMuUUa0jz1
         1rckWYQQcNO+fc4mOdMiRacV5/+CMPZ+mVtSZ3ibZeakw22aIIecb4d2qdwqfRLENoTI
         Sanp+yFUMl2PVguK4ro25OO9Uq5iLTBQ+6ybwn7RyYwURc3QIsYHoO5jRHA6B74P//6L
         tcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKajoKCfTxlIr8S+US9HSYOi6I4KWatuDnpO9lgeDb49hxIYURC3Sk2hLTTrZTDowVib/34E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Bujn/YKzuBBUax7XqT1kFQZ9iJoNuecmW6K0/7ObJz0Auqmu
	tY4W4A9/B4ht7XGXSwigFk/50cVOw2eiwEMx1XDw5a/B7lmhqAP+WbvRpRurDBV4soajLKaKaQj
	oyPZu885YDWOAW6+flUN5diA7bullt2PMMAxdSprm
X-Gm-Gg: AeBDieuDfP6T6zhXORGz5M8hl4IRH9Auvw/Xmf1ojfWgM29TJ7O3/AC8zQO2p+paHwP
	aftqdBcpvY7MCuzApw0V4UIyVybH44iR8ipylx1F5TNX+mFYpzigGpRN7TwI/LA2kbKZdju/3S0
	xRGxSMQ+5QdCB7JzeBMJ2ZzJzBy9UGSleYi1AQAlIu2HdqF3Gtt7YtTGx60ZRpgPgp6qXR4lR+L
	XJQT+BEZxRoST5QvxkNHsjDhU36ATDEBaiq6YD/TDxom/tsvSVTWSIiMO8gb9JIyKmwo68Dt1tP
	nMG0bpI=
X-Received: by 2002:a05:690c:e689:b0:79a:b1ad:d464 with SMTP id
 00721157ae682-7a4d3ace655mr154256017b3.23.1775746335985; Thu, 09 Apr 2026
 07:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
In-Reply-To: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 07:52:03 -0700
X-Gm-Features: AQROBzBj7fptL0gFliY6j_31as4pbCwrq5Bq_bkPULRfmYI_lFnOgafWpGVCNZI
Message-ID: <CANn89iJO5DTWeVVfMYh7y3e9Npsu+FQ_a=W9ZqbMtb_wLeBL7A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] tcp: restrict rcv_wnd and window_clamp to
 representable window
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-277029-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB3EB3CC3FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 2:50=E2=80=AFPM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> Hi,
>
> this series ensures that rcv_wnd and window_clamp do not exceed the
> maximum window size representable for the connection's window scale
> factor.
>
> This is most visible when TCP window scaling is not used for a
> connection. In that case, the advertised window is limited to 65535
> bytes, but rcv_wnd or window_clamp can still grow beyond 65535 when
> large receive buffers are used. The resulting mismatch breaks
> calculations that depend on the advertised window, such as the ACK
> decision in __tcp_ack_snd_check(), and can prevent immediate ACKs.
>
> Similar effects may also occur when window scaling is in use, e.g. if
> the application dynamically adjusts SO_RCVBUF in unusual ways or when
> the rmem sysctl parameters change during a connection=E2=80=99s lifetime.
>
> Summary:
>
> - Patch 1 keeps rcv_wnd capped by the (window scale-limited)
>   window_clamp at connection start.
> - Patch 3 and 6 ensure that window_clamp is limited to the
>   representable window when it is updated.
> - The other patches add packetdrill tests to verify the new behavior.
>
> A simple iperf test on a virtme-ng VM (Intel i5-7500, 4 cores,
> loopback) shows a noticeable improvement with window scaling disabled:

Explain why we should spend time reviewing patches trying to help
stacks from 2 decades ago,
risking breaking other usages.

Almost every time we change the rcvbuf logic, we introduce bugs.

Not using window scaling in 2026 and expecting "iperf improvement" is
quite something!

Out of curiosity, which legacy product is stuck in the 20th century?

