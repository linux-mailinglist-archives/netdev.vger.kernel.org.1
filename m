Return-Path: <netdev+bounces-274461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHi3IbhGzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C221F387C8E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54CF530095FD
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6539447C;
	Thu,  2 Apr 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qPkZVNnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D8390202
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126070; cv=pass; b=hH0TG+BlDS1kpa4m6utow7O6Yxj9NoQ6qF2JPNRzFRyUqPiDdcoK/Ec2GgXiqHew3WxsTkyXDlAvNt2Wt2k+3kKlPWPJm35675jN5spe0qiuf0C0q2OKWfnKsdgeyN8vum1DjEYoPA1CIuTaTfBslljdAxAKXqmLaxyoxZ7UWwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126070; c=relaxed/simple;
	bh=1w5FMOeuqCfsxsOQEhVTxR8HlznOFlOA/37uailIS4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Bdivgpmkg35LZBTo8PgRFMki+P0bAB8TYcuxj1kQfx76QIdjjutx5bZHPU3G3jckdBzlcr8uPOStZGS81NL3cKM0BuD0QI2sfxQwM6aEaLsCpSrR4sd1UgFxIufl2yXJcq6+3TIOfGLoUtAojopQQPtnAUl4QJMeH86LSRsWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qPkZVNnI; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79495b1aaa7so6817677b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775126068; cv=none;
        d=google.com; s=arc-20240605;
        b=OmH1Yat1tU1qpqTPA1PfQlV8lHMyDxJxLA8Dyu4f9ubz3dxPMc6/NohaVGKagzmx66
         5b7xD2ewjZ6yAo6rwhIH25Mqzfv4n06yfjc2CezUe3rlR55VWRL9W/v3nA7h5ZWcZiZk
         PhZQ28xRggPkCahcQga/wj4zLh4nyDOFsI/439PsLZPkjw9rAmnA0p26btEyOE5dDiWl
         0n4/tuOb8KssZv/XyyCsW8iVAx6x158+AVKWFqB7w3MjuxzD5xnBut2kgFV8VJixUX7N
         Zn8km2KmMw9fx8nZe2J2AiOvmb+QGDEbucJC7ll5rDTjgTYY8YGDu9a2AVBDH7i54Vrh
         Q2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVzq32PZWpeRwjy07iQI+o97wwfSRXUfAKKIYm8UZw4=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=NlM2Ie412wo6hKhr5e3YJxnb81VgQgoAK96/TjdPPokkaXhHoE+NlEKpcQdnNqAcOe
         4V3HlVQHgqv8ZVh51NxMcsfFtgd49yW6figqhJF9hh4aiJTnFA4pvR+l1QxiJGoGgHJ3
         za1/cvV6JfR0vsARziHz7CxazAhv0FsZIfMeJ3WiO7aPxqUQQDAQ8KgDI2QZ9UJmYWbh
         a6lIMuT0mX9lYX5/QtruCuJfSCUO1gnC/C4wStSOtnibhQGj/CLxZa1SjKA2Yzjxk1lM
         kkWJJwZ/23EDw4Sr6NQuQvSBArp7NNQDU47HjdwnK8etK34v6xi+HHrCtCbv8VuN5+pV
         s8wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775126068; x=1775730868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVzq32PZWpeRwjy07iQI+o97wwfSRXUfAKKIYm8UZw4=;
        b=qPkZVNnITInZxPQ2vJz1wmqPbKef0GeWCfZ/TuuUgxR2EHU3zKYR+UeSnkcI/sFEaS
         Zsx3cv6lM0FwE9q1Ocsm8x9zCQ6nZq0AYS4X8vDU4NcDuzhsBxWKaD3wQIhcK7g3dYUS
         U6nx/TwGBj+Xf5pISwmkmZTCLisdGYmDCxkvA6o/3rB5Ye9vjv8ZYlkseArJqbdXU08l
         4rO0HuYq7mdrEZXcec4YZLI/hd5MqGER0bT2LTgY7RI3cK2cZntDL39t7cb7c6iDFI03
         CrnkSUXlu6HDeXUet2H+l8nNCbu3l/cZ15jJHmu1XClfW6ay12bn2shRqCs/Xmk2m4Xx
         oNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126068; x=1775730868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVzq32PZWpeRwjy07iQI+o97wwfSRXUfAKKIYm8UZw4=;
        b=eoyhcl11IaIAvo4tHa9b6kkG7wrJmGdUXmv48qDOOH7rRaE0zakxlPTaQmEMNQonP2
         C3fChLnzStfiHNI3aJkjYC1b1o+slqXkYo02G39pinSD/oAcrOikLxEgMbsJQUAtk1eZ
         51svs8bWeBEl/QBRF+waOyIja1oAH+PuDLYZoCtZpFOz22zei4bL7Lcv4AH5GcRk9mLi
         vaQUSkC4kJj4t50SzEfQzk/ohQa5ucKsXe3LZ4B3CRkKQRBQ6j2CPNUATKQjxLsibO3m
         w8ze3qzC3Fa924jQzdL6GfXtPcU3JXrWFGjqdqxdjafDmrxTbXt24RHG5IuI6L72NLx1
         X8bQ==
X-Gm-Message-State: AOJu0YwNwDOFNXqC6uzqS6btC1zG1Z8zdfrYZj/tfMI+1lJOYY7LzMDH
	dKg4/80U6uDKe03LrrEsg6FP5XtxvSc8mTLrqhtbPCz9xd4FLPRh0fZ64tbgARUDc63niSJFJh7
	bF4WmATVbLJsnCkOPrUAYgmF167KD+tvYYO7TOWFHMgnE9ANr9WEQiw==
X-Gm-Gg: AeBDietJAmxTKONDaPE+Fl9aP/61K242+gLtGFOQ353SuZSaOexoei9F0nwSoe9jDzd
	soFOs7x4r8i0Cr0l6/fV6mJi8DRxnI+6JWJAwJYpq2l9tY0LcSBOVmWPjl5UxYc7Se8yzPKeG9v
	jOdan9jcPu9/1qNeJTvaXehSTdelT3f2sWGVIa6B5KVYzf916BZF2tF7QT4nTDMRNfJ93tGPb0l
	yUtYC3PGu7GsiT5aMc2NrVC90lIDqwoM/zpDyHD5v+Ph1oZySkWX1fBomQAcEWN203AN2GB8NS5
	idGoNqDLExkeisIpwAU=
X-Received: by 2002:a05:690c:6e86:b0:79e:766d:81ee with SMTP id
 00721157ae682-7a37b827be6mr21653107b3.3.1775126068322; Thu, 02 Apr 2026
 03:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331050217.504278-1-xmei5@asu.edu> <20260331050217.504278-2-xmei5@asu.edu>
In-Reply-To: <20260331050217.504278-2-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 2 Apr 2026 06:34:13 -0400
X-Gm-Features: AQROBzByvr0kst1A40C3f0RC0ouOrGahdv7Uy05wqInP9AlD_jHCp_AitbuXLnY
Message-ID: <CAM0EoM=-dk8HOwWS7VOyAdzYgWPpmQ0F3m4H=7awbvd5kwckmg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net/sched: cls_flow: fix NULL pointer
 dereference on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274461-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: C221F387C8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 1:02=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> flow_change() calls tcf_block_q() and dereferences q->handle to derive
> a default baseclass.  Shared blocks leave block->q NULL, causing a NULL
> deref when a flow filter without a fully qualified baseclass is created
> on a shared block.
>
> Check tcf_block_shared() before accessing block->q and return -EINVAL
> for shared blocks.  This avoids the null-deref shown below:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> RIP: 0010:flow_change (net/sched/cls_flow.c:508)
> Call Trace:
>  tc_new_tfilter (net/sched/cls_api.c:2432)
>  rtnetlink_rcv_msg (net/core/rtnetlink.c:6980)
>  [...]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q help=
er to get struct Qdisc")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> v2: Correct 3/3 selftest case
> v3: add error message
>
>  net/sched/cls_flow.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
> index 339c664beff6..ab364e4e4686 100644
> --- a/net/sched/cls_flow.c
> +++ b/net/sched/cls_flow.c
> @@ -503,8 +503,16 @@ static int flow_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 }
>
>                 if (TC_H_MAJ(baseclass) =3D=3D 0) {
> -                       struct Qdisc *q =3D tcf_block_q(tp->chain->block)=
;
> +                       struct tcf_block *block =3D tp->chain->block;
> +                       struct Qdisc *q;
>
> +                       if (tcf_block_shared(block)) {
> +                               NL_SET_ERR_MSG(extack,
> +                                              "Must specify baseclass wh=
en attaching flow filter to block");
> +                               goto err2;
> +                       }
> +
> +                       q =3D tcf_block_q(block);
>                         baseclass =3D TC_H_MAKE(q->handle, baseclass);
>                 }
>                 if (TC_H_MIN(baseclass) =3D=3D 0)
> --
> 2.43.0
>

