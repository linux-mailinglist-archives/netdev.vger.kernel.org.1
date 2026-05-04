Return-Path: <netdev+bounces-284030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II2lAl31+Glr3gIAu9opvQ
	(envelope-from <netdev+bounces-284030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC514C34D4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C12301E21F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFD3E3159;
	Mon,  4 May 2026 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="LWeTmMIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A61F3BA2
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923260; cv=pass; b=bZPu4EE88al8NPecXtMUCy2VraeMIxR8N2evrPRi7c81WxXD8Ey+4swxrKwimjZSInvtyfrlupHFRciKtqI/mvh2ZFFVTnBNJH1MGSPAev6ruKxBvvtBY4ix8X9vJSh8jJWqnBjAyMYfCjLv+PX74GVJ1WADBUhXOfLz4ZR5VdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923260; c=relaxed/simple;
	bh=zj6ULZj67Vqj1Mse5JGlo6IoRtgXQL6j3pjArb/71BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Poi3eslQJkFzjmBmGXS2AmXYZrOIjwuhWvEs67obfs53JKRUA+ODOGBGZAuQnDEDrRpDncKuD/0bZLfWLsjfxOAWOf5uGofnqDNz4A4TOzKBj8bHwwiPpE9t7zNbczSdy3mOACJIfofJvnX9ga7s1JVLfbz1lFRiB8J3DBj9b78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=LWeTmMIZ; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3256020b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777923258; cv=none;
        d=google.com; s=arc-20240605;
        b=Rc6Tg6KFXfASJLQPZBrMyuJvKX8DPsm8+2F+Dcp9RglhNhhlqA0KQihu3e0mwF4BJM
         N2JG8a1uydm0IwnvXynF7hRIKz3Fuvn6WGcGOBXbyzEZ6iNr8qN6ZpUA9Xj7iLD0RaE+
         tLLvAgyNWxCl4rlQPUzenTN8KXF4MjaaAkkyNwUbMEe/y+rg6db8ocWIeN98N1RK0pUY
         +hPJ+46ckEN3NHbJQIuchjDJK4Ai0gAP5BYwKWWQTLbH3ZAVS63Vd9GMF+7n1025Fqnp
         G3NSgh73x2z6HCOgRBpG+IXadj7443Rdgp4wM45mtRg0v4Hf9es0YAB7lwkSMM53ltHp
         nfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tFgwmP0p6qo8nLGW4UxMcwNl1CxRtvNw8UOsQAVjVio=;
        fh=U982vp40VPY3eAQz5eX5XRjZxqSW0hG2OzYjssu2lHY=;
        b=WBBQWzgJ///jKN/rrE0XIvfihC2Wb/a6p667Zy9i5ibmCfxIUbrIWyY5RUX2HSStPG
         bjhSoBuLmkeGjsyA3fOXirabtBQH61Smy4Bx7V29Vvq+JLojwArDSTzio9csrKxX4jMv
         XkmFlEVSlzVHXPV+3WGJNPpflY43Ba22nLwPhopX8BTmNYsvn9d8C8A8btjyXADsq3cS
         ICj7voYaUPj7j/ooXsmBYYHR7dm9zOwhyljcRBaUY2LDplHhAybMLnuhyxUC041QBQJf
         NGEUd6ITkZPJnqYOq9AEn17UUkGTWSEheyb+meftWCYJITwuFO086WDyUIhl0Du1YdGv
         AwJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777923258; x=1778528058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFgwmP0p6qo8nLGW4UxMcwNl1CxRtvNw8UOsQAVjVio=;
        b=LWeTmMIZWB4a3dKfzzb0TD6czGre/LX4IZ8C+0ronz6HOwjkYUjMP/BAKFfcbH6LwS
         DKfdLdP+/OhRZDTVCnYOZM+A3awIgSsuIilIKidtsuSQSeKlfbhjnjIbzz/1OwetzRGo
         DO2eS9G/eN8kY9WO+fAZN8rER59GQ7D370cvyHwvlqJH+DNO9qe5hxbb6p10yM6e+yS2
         oMF8I04jmuaCPQUCT3f34LMsi1ZbvFSyyhC4wddVXKQn1OW2qZ9veVdtKNZSGd+03/P3
         deCWQUW8hIM4OUxW1Gvs2uy6ff4Yxtz1+tgmwh9PZT++HeCc+rnT2h4X0Di6ISIphwWI
         smXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923258; x=1778528058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFgwmP0p6qo8nLGW4UxMcwNl1CxRtvNw8UOsQAVjVio=;
        b=MmxLf0GbJE8aRIbAn2U/QHstYfyte5Ewod9W0MjbPefjdJWf+mYOYTma/4hI4+PCcb
         g/++yIOXXNzT+i3fVfmbu41HMFQ0BJst4JgG3ohJYoxSljK8DcSFk+Rj//7W6GqPXXvr
         JKWJrVnylzbe0Ije2SVqVFbjH1YYkBZ3E1OG9sYWecWZJ+LIYxDlYUscuCxXw66uFw5x
         05VWRN0z7ovSWsr8zja2QaCiE7ogv0CKSnE/cZBbLzK4IMzEkMsVH9Yx/OAj5zzk6Oya
         x5gcqJhpqW70hGJ7K4UG4ckPGJ77fr72wzc+4D/URx+9FpR6sOMuWt5HW+ScshZ5WHVu
         KqKA==
X-Forwarded-Encrypted: i=1; AFNElJ9/Z9zdUcUce4zaXL+2XWqidyyEFn7XAPg9aTJzCggW1znUi8CfLzR4GuT5inQbXYTSbeM/EqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaf4EE6PRt1si/4vhu4Cyf3uUmsLaTphiXme3vonM2ztBN2ja
	Pr13Qh2kbdz4wDU0wmdeXdztDho30OQZepBA4ZmH0pxZe6gtAzzDG3ort5XkdBFSx8wbK6Exfva
	7bQR5TJ2OCQFJHH5wMuLGbM9fJKctSykDC9RjQA8Y
X-Gm-Gg: AeBDievLjWTbZ8HaTeCXaXABVjkxsgFtOgasPx1FEXzI3RzO5zB0pRpuq9Og9P0RFmP
	F7ZGY9FmwPs2yX6T1e3hsnEPohDXY418PTgcwRCmyq2n2q72+B4G7h00M2hnvq4obzPEqCw/mp2
	fKOkdRWqk/aXCwFL5zXTiEfGze9QL/pA4dT+1UeR6GU+8cr1f9xKVoU7jArmh4OIr46xIsh+Sr/
	3beuv5Wi8xZVRNLRPlo7qyYqiIjm1xlgztoSXbFoeaVfKKYA8ZJZlK0FixnMeEfElfJcEV/wn8f
	Mxahgzr08CDFJPFYbQjHjtjzAKLGSA==
X-Received: by 2002:a05:6a00:4b10:b0:82c:247b:ffdc with SMTP id
 d2e1a72fcca58-83923e9857cmr209899b3a.29.1777923258428; Mon, 04 May 2026
 12:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503114515.2460477-1-edumazet@google.com> <CAM0EoMkH-7jjV3Z=74yF4ZKbPsw5JCJo1RRjnt3fEVvzgNbRSg@mail.gmail.com>
 <CANn89iKAdEGGZ_q09-3EtY_SUhjq__T9nU-jNkgDy2urYsqpkA@mail.gmail.com>
In-Reply-To: <CANn89iKAdEGGZ_q09-3EtY_SUhjq__T9nU-jNkgDy2urYsqpkA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 May 2026 15:34:07 -0400
X-Gm-Features: AVHnY4KBIGS7IZdMRRJuW7KH9rEMuF4h9k1YE7vd9LPda8hz3pUgdmCStYUzLwo
Message-ID: <CAM0EoMkwojA87PR3mzmGiKZfHdx9nu8RbuYAP3Kku82rQdZ+Jg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when
 tcm_handle is provided
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5CC514C34D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284030-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]

On Mon, May 4, 2026 at 3:20=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, May 4, 2026 at 12:13=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, May 3, 2026 at 7:45=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > "tc qdisc show ... handle xxx" filtering can be done by the kernel.
> > >
> > > A followup patch can do the same for tcm_parent.
> > >
> > > iproute2/tc needs a small companion patch.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > If you ever redo this for whatever reason, showing the dump of before
> > and after will be good documentation.
>
> There is no difference in tc output.
>
>  One can use strace and look at all the recvmsg() values, but they are
> quite verbose :/

Ah, i see it now ;->

cheers,
jamal

