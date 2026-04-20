Return-Path: <netdev+bounces-279889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J+iD7hr5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:08:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A839432840
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD81311DD15
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F73A875A;
	Mon, 20 Apr 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmhfzXep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725343A7F7A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707825; cv=pass; b=PuCWpvp1lZPk6wWWTCo1Lm2lPQjMTDqEBQnjnW8XjSPCuruTSgnjy1b+VSPRwUJFygR/eh7j7kot0kLEERXU4qvLZtC9peKGGkUcnJGH47XfelAsjlVLzFZwaH669/m50H1Exo9cQhmVxj8t0/wsqKCNTjTDgG+7oa02pQoWg4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707825; c=relaxed/simple;
	bh=B15JpsG4P1Kj3i/I/Ui3oqiio1y32t3Cny8xJf+HiD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkD/bcggRTJCQeJzk7dt0BvHo7yNDRizT45pd0QB6O0CDM1jz0syC92DERtu4wqzu8q3kZG9lUu810jE4SQ41g5NPxltZxzy9C1aaQbNJ29/3psz5MPSOzMal/lH0rOpqA73chQVGi4/AiHj1gc80v0rTDXC4873mGFIjl4k3kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmhfzXep; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649278a69c5so2577277d50.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776707823; cv=none;
        d=google.com; s=arc-20240605;
        b=JF6yyyd5qNEt3vGZLBq9uB0F0BS23+wzpDAvW0fcscDNSZ/Ye2OVW9ptqhtVUAjMII
         Yq3mS2q1V/qJvjTZ1vcVYhi5nQI6D7fA355oVYRLVLd8RvaFhoW+U1v+Qitz/AJuZ7aX
         /vf6N3Dg1kJ7BH0aYRn1krgbfRYltuenM1/NPDYktsSca8cbE/d4sSN5FHWcAeRJSdQ4
         9435Q2hFrSEDYSfrEAphII9Qw6KXrPcXmU8hSgUpbNkXl8AcLJ4d+UfYfKbC67UK0lBQ
         Sot3+lr/uetCOLYfvTQ1CcY9W1c2A7PnDvxDJZlnspQMZiQmI0TOCWFT7tt60k4n1cwr
         AsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ypku1WTHsF3ZhxS56BzW8LnzWIC0yIDkCws0LyrSfGo=;
        fh=dPBR7aTEcGgWMj4t5LmnuGtkttVM9ap7M7zNmk6wx1U=;
        b=gmBCw3FpDaic/zKUzGWikESUnD4fwb06Xsla9+9FjSltXZ6xXLF+OtQAFdZUYEKWlp
         gNMWjvc4tSK1CnCbtoCRjWSIic9CFsB7I34gL1fs9PbGGgTAj9mhzAZ2KCWB8dROGlZA
         RD2uPyj9tDVc5vtWtj0g6mbc4GK9Rab739w5omYPnyfyWp8AVgbDH/iZUmRq3fRbE3mM
         AIlrY21IFfDVftzmGYbpVOqeUhuVGRsCV5+4eMVy+tlPPqXL0GLROc2VkLYSkNu9Y5Kj
         3yHKvhw5TMZXVRaSmUSfh3hE0aGkQpezPhFpFQPJ9Fgcl0oAP7HjVghGyc9tA0zAIcCx
         nnRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776707823; x=1777312623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypku1WTHsF3ZhxS56BzW8LnzWIC0yIDkCws0LyrSfGo=;
        b=MmhfzXepR+i5h7/casUOPemulCXytooFjRDWaGV0XHsBjZtSQ1HfTSS1HuvvtOOfzo
         PFK0vZoxPQFhz5PFRHFokwiqkiyLPcx6wmzQG4EJGkDJDmi1Y+vAAO61GFoxT0f2kYjU
         DVxuM7b+u2gRzKKfY4lpSHFd2YRtGXRQ1qOdzhYFG7uaUwP/2nV7CzIZS3A9J+HRltye
         OTKgpZlOjFE6G5A1i1/V4puD/2VayeJ+OP50A3KWomsdYdG3AHFxGvj/6Y3Hwc65oNAQ
         m/qyEmdI9QhKIhUu9MHUCzEpizldtukhpog016GcmsyAfiSP73XmqvWeuKJvh+8nEHxK
         GYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776707823; x=1777312623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ypku1WTHsF3ZhxS56BzW8LnzWIC0yIDkCws0LyrSfGo=;
        b=SaH57n8XzOLzasHgmRLdJpKXsnf0onHo3Th/MHLN2Yq+ZcXMJXmMTjlHirUO8c4HQh
         fg7dyybHP9cNLJog8piloLnHb9IIvKlQikNtr9Y3KfewaADvopul2Mh3NCquvDw5Uwn8
         ecMdzyAo8T2qreaeyIMKxffJlIvJNxtPgRphZjRmUO0gE9fg7SdXm7wMKb1g4q3zMWp5
         yn4n8u9sJvCy+pQJZEBN731zueCunSWK1wbjpbxIKOVNlGg3yPZG060JVEHz83w/bZWS
         e5kwQ1KSNLITrAWIFSP0UuUCdAhot63I2sz4GYNyIAPR94gq5DWwkw1iBvQe9N5PvtR7
         5yxw==
X-Forwarded-Encrypted: i=1; AFNElJ/Rs0J3EeIv5b1LD/JaGC0G4uORsvj2VYZLzMdzLNZ7JayQhRkfZ8Kc8qep2Vc3UF+kSCkn1so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rp5xVUNyO3WoEBmHfqMfTd1hDSLFbTvmiu9bFwM1WOQHmjKC
	QgJmzyALr6Nuz1ids2xzK8Z9qKjD6lzWfO1lzC3KMN/T48apWgukUH6zXpzYBVBx6d2P0Rqw5f7
	KpFggyWqQLLf+X60Kutcaw/QaRRikf6o=
X-Gm-Gg: AeBDiet8DYFWqeUhLbmEohmnfI08/XvgeX4LyHw5uqw/AjltwhVlEWF4XaiVYQxPhbe
	RJ2tpJ55x69pu2h3HphCgkQ02e6CHu5+m3Xb6LIMTPpsEQUk4kFhaqnauWGjvXBEycRETrP2pCL
	n93a/AukVjgrVQN8FYDbrc4IcrsQBTPCuNlzimlixi26BugPJGKuhRuGsKGYYVjfFv7E4bMtgqm
	SFyRCRlG7DI2a4WUSh0ywMufLkeqJWe+rIUZBHq726uUX8DOXB9rJr8p/pkib0bv6q5o0eY8BZn
	JDGTaikWK+yDRZxJrEjOEFn9ZTlAEacpbmN7j/y5UeenEwQ=
X-Received: by 2002:a05:690e:4182:b0:650:4a79:f3b2 with SMTP id
 956f58d0204a3-6531090983emr12797124d50.28.1776707823417; Mon, 20 Apr 2026
 10:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420162734.854587-1-michael.bommarito@gmail.com> <20260420103715.347fbd4a@kernel.org>
In-Reply-To: <20260420103715.347fbd4a@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 20 Apr 2026 13:56:51 -0400
X-Gm-Features: AQROBzD2fKaJKgqYdE6tGjS5VvLq_gbBenK8vdG_L5MufBX5O8IB762kYTQbPCE
Message-ID: <CAJJ9bXzoQKWgzYca_Ko9DfuBVwF-c7uKZZXE4MJxE_Aty7_u1w@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: clean up failed initial dump-start state
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A839432840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 1:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On a quick look I can't see which path clears the dump state in case we
> keep failing to allocate an skb. Could you add more info on that?
> ...
> This should be part of the commit message, it's useful to understanding
> the problem. Actually more than the current commit msg TBH.
> ...
> If you're planning to repost - please wait until tomorrow, we ask that
> revisions are at least 24h apart so that people across the timezones
> have a chance to chime in.

Thanks, good points.  I'll set a reminder and follow up tomorrow with
your ideas if we don't hear from others.

Thanks,
Mike Bommarito

