Return-Path: <netdev+bounces-297804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QDsADMG0KWrWcAMAu9opvQ
	(envelope-from <netdev+bounces-297804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:02:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256666C692
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=G2pyZoBK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297804-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68DF31337E9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F931353C;
	Wed, 10 Jun 2026 19:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AC25B084
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:01:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118102; cv=pass; b=U/GlNR/JHTJsmO9mgMzIU9lSdSY/ynH0N+xKoUYWbUfRFbozGj8K7zcAmkVyW8ykRqFelpVtsdHRzxDazPw9EYLOYXtVeSIgLUoxHs6o8yVUGYtYABHApAIp8QhMltvtBRFFszDWLxVqYTYlp2Aa7D+C15+0aS0bAI9n4GlTQTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118102; c=relaxed/simple;
	bh=ADvlYorAINTAdZKi/gSUUQtzjQRr746ylKWGnamsPJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA2B9ZFMSnUxZ376jmDTrZqYk37MZbr8KSWk4YpAhJ54hj8hxDN3xcqEiOvGY6573EyokNATIA3W3EUV9MmPFu+1LNw/goO4evEYHQWrSJJaKYiRwranaDJo9j2PrIi/Tr15VlX3chR+YzH4aKTLTrcbSoDC/ZAQ2ex4BcD+abo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=G2pyZoBK; arc=pass smtp.client-ip=209.85.208.172
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967620ceabso66693711fa.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118099; cv=none;
        d=google.com; s=arc-20240605;
        b=NOElDDsetC7HGV6kNDIaYodGRc0lGvcmEorSPa/XKhHNAP/+8eczmDog4L9GKgurN1
         +2abzzc+Q3NGYvXdLIczSMiRLKFsvgVD71pTfk0D6b11ppzaiIMS2RIYwNsK8qLhFqaz
         L1P4KnRnhuR+6u9LocrMQH0ZcHAXLLEpGptV9+CINVxf7cE+FCH4Z5/68LQOxAnYw8gS
         eSzZetyoA72MAU4AX5sxriKyaNXu0kS74vm7iLp5o12ItXJ5eCC4KrlnsywnPJ3KGLC3
         tX/OfuR5kH9tmmPEcUPEbvmc1OpGiJoXIBCXTgR026pdCzfF6l7hRCtMIMylUnG+60jI
         SqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJdk5WspnDQ44Uor9tJB/rnlHDH5fOpb1gld6Poeqnw=;
        fh=5KQ/evFBaXC+b03VG7r8n+OehV2DarhvQOc/sVZKUXA=;
        b=EvVUxVFf5dxWV+hzS/dF7jaEDMQ6FfHfX9q+KG3GVIJnPxUD1c1+KxTQ6Hc9M1EVuL
         ajKLhbuFQJRzO3fjfBxn1fSBWz2alRPzUBsInyV9lxl7aVfWpDrnn8xDYooADQPN6cQr
         K9N+/WxLEP5kbuOAt/6H5MC8NbqdsRiSsMEADxpwjtcO7mW4oHpHyXu7Wyn2wJELc31K
         ceUrmVc/TKXP4dh2VVQAVvsmGilC1nPYMV3BV7KKOXjIhQVaYAVlSwcLQtcJrDtgCS9B
         0UPDM7ZYE5R1FsVJiNFfaMX99psUuL3mXQeY3M2SK7TMNpQg9srHP00Ma1h1/xY8QMom
         dlxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118099; x=1781722899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJdk5WspnDQ44Uor9tJB/rnlHDH5fOpb1gld6Poeqnw=;
        b=G2pyZoBKTDF0O4OZ7RvIINsZQkaRNzr5Qyv/fFTO/BsF1Z5VpSVMr0sck9lR24pGgX
         BjchlE6x+ZY0IkU4+6CetXaaPtOO9jeLJ80NEctyWYEeFnbf8f2oXe7awK8BVPOORyxb
         TFyX7N35IUr4qBJCIhmuXYdMsmjvqHdd5Yx65XWBTr9lt6TCiG0V1zvQzw/QPr7xHLet
         zeWeeaaO1K9LEr1SURrrPJlytsQ0dyH47YNp4R2QwThBmgSj2lrt/Zqyx1thN8UIPObx
         lXF20y6vQEn70GGqawgI3lemlSU5TOSXJsKnDGqIpsHzRYc2acVUc+qE4/W9dObqFs0z
         JWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118099; x=1781722899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJdk5WspnDQ44Uor9tJB/rnlHDH5fOpb1gld6Poeqnw=;
        b=sg+Ffe9rBvhbMs32GmKH60W64JBYjfYSFQ4MB5KYh5KbA67SAtPt9q6E4+It0P6rlV
         W9sfwwLrvjUqfUmq3KJY5TYn1QSc0VgVhPAYOAA8yZbKFuBGStrjHOrBmu2CKkRtiYDI
         CBB0/mxTdFHBqp+K7OnfgTEv4VVeqBQUJyuP5+qGR1tig6Yxa4518n+Jb8pOpzXt5IOe
         fllJmnFbNV7zh/XR1sJiU92TvxV0fEmnAuaQy42I0JmoyqBxtn9vqtWxJ/DBohhSQRzb
         I/Ky7agHGG0iIunVSEXS5783Z98XB8wNKOxKDHW06XbJZ/QYB/gMBL4cWdHDA5xwaklD
         YNbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kmO+yixs6o3/8vKBdLN1iohKvbd0P5P121XSZkt/PFTafB0cloKrBoSJPN8FYo+0H/CwjYr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/ZOS2ypvdaRSLQn9s2OPQkcOX1ORZo4iSirE7DgaLNuiOUVv
	rJGURdwCS6OJQDUt7Vgf9/WDkvgibldxrQyKrTQnQn3JeDfUxgNOdG0/ab4PeMTyQPgmjxhoyhg
	wjARYrBDyFT5iGglh3aHRu6SseumCjVd+dBD7XiVzHA==
X-Gm-Gg: Acq92OFTxZYofzi2beVq75G0/oEewJklbdBSATnDGYBSr8lO+kcxa2+OG2JadnYuYtV
	3bz2JEgO+m2N7HNdndLwXPX4V+NpsayL3TFhne6wUV3Cfs5vTjytG2/QbwXwUvFsA57jh9JzIFh
	Cs087Dbl1tEh/scppSTNF1EpgnTuq7RTF25PY4J26UZyn+xOxpwcxeD6Is3FAyARvnyPXmba4um
	0orBthhngfhqiYDFOGLvD1aGLKrEbmHuPN6Vsk5pWUEzQGYjNTV71ehIW4jHK7vSx0ycfnlBEAh
	ZNhUZ4zAPlfXtYdO
X-Received: by 2002:a05:6512:1114:b0:5aa:7ad2:f4d5 with SMTP id
 2adb3069b0e04-5aa87bad505mr1509720e87.38.1781118099011; Wed, 10 Jun 2026
 12:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
 <20260609185625.6e4bb757@kernel.org>
In-Reply-To: <20260609185625.6e4bb757@kernel.org>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:01:27 -0400
X-Gm-Features: AVVi8CdkQq5bCIJlUNoaQew70B4DnoaJMjfUFlzba5HbsNKOShAHYP8C1ZPc4AE
Message-ID: <CAE+C+DaarCw9cNGn4G8PFO5vXwuOxm5sP4EqF+dtvLGnrMEQPg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: drr: reseed active class deficit after quantum changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297804-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,trailofbits.com:dkim,trailofbits.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8256666C692

On Tue, Jun 9, 2026 at 9:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  9 Jun 2026 00:36:18 +0000 Samuel Moelius wrote:
> > Subject: [PATCH] net/sched: drr: reseed active class deficit after quan=
tum changes
>
> If the change is not for a serious bug it needs to be generated against
> net-next. This was generated against Linus's tree I guess and doesn't
> apply to -next.
>
> > Changing the quantum of an active DRR class leaves the old deficit in
> > place.  The next scheduling round can therefore use credit accumulated
> > under a different quantum.
> >
> > This can be observed by making a class active, changing its quantum, an=
d
> > then dequeuing with the old deficit still present.
> >
> > When an active class quantum changes, reseed its deficit from the new
> > quantum so the changed class weight is reflected immediately.
>
> TBH the current implementation is how I would expect DRR to work.
> quantum is the "refill" value, it should not reset the state of
> the current round? It wouldn't in an ASIC.
> --
> pw-bot: cr

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.

