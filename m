Return-Path: <netdev+bounces-295043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 80daCa39IGrC+AAAu9opvQ
	(envelope-from <netdev+bounces-295043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 06:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A46863CCF1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 06:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mBfF/g2z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295043-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CA63300D76A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FE37C0F9;
	Thu,  4 Jun 2026 04:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8392517A5
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 04:23:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546982; cv=pass; b=nkYNkJqAI+8zYPOsjNYcUU/YVKjxarxo3ocxPPJLZ+uxG5LOQPpfbHQu998RDLTrAxtqCxyRNTWJCgTS6x3mxfomeFoxk/WuWJcUv+us1t62EVPzPho5VtHSCQtHhXa0d73qwVQUVVQDzBF/KnP9YJTFdaqrp+xvdsp0Pl5ifv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546982; c=relaxed/simple;
	bh=vMJIO0/VJDOw3ph6V6pYDwvUo/TujnLGusvcPY/NRBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lACikk4pKe6rsUC6H7xkJO+ljiUMx+HBG/baWI5cQLFc75Hhmc1IfK8zxp4qTYQiZMGVUGIrJLWA3Dx3ANeKR2K0i4uJdPGBmKQva8zX50UbW2lUysARIpTDPQUuHt+E2PE7BXr3nOZNQNEPOtQJlXWYSWmPxinX7aPWAdVqgg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBfF/g2z; arc=pass smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660ea43107fso338847d50.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 21:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780546980; cv=none;
        d=google.com; s=arc-20240605;
        b=PsNOzykpvzg54V3dHpU8tcCHeAEAFrErWvi0u1znc9wlfI3cykEZZXKnwTUe8b50pj
         1t7g6XfYBYYQAkseG7FeMCH754ePY9d0aE3YI41LiEOP7myyrK4L+Kj9VYDdbLWGIqMy
         QAAGUIiLhn1iJvRR2eUruAHrAeFnkwyZL1mOsJkwlqmOEq7ffAuN37egiEMHaXkjGmuL
         PHMRA9QCeAIE1O5C27T8qUpDmI8y6tAc9CHGSaHoMQ5GQMeBWIgBshgyY/L67WH7h9rY
         5QCweQgGXhZLOsBh6oVDL3tQY2vUb95XHUEi5dKexgIP7zdEecOKfME6tW7zfWgpNPIo
         LMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        fh=iBQVPOJ8q8dG3GkM6VDzCYFSCHidC3FZEje5e8FD2ZE=;
        b=aNAnaVFYC7XitUsOzyAGLc0EiaptfFeSkYjv1uTtOEYZS/mC5htmkWRphw15Q7hMGl
         wzk2GSZ2FsXB8L7JKnmxTdZj/ChKzh8f5macq3IEJliGsbpwRA0Wv6hdeyn6bmCYsBpI
         v5ybpO49IDJyTX/7cD9fM4QAlNPgOq1e8gDwXPglTzMW5aRsZy69wDsnE+wzPx98s0Sn
         wFWNC5t2QL6H4zPCVRX0YzAfxHWgFCj6DRc/S67tOasL89mgO72LWL0QrsSloOyd3JQT
         x8fXhaPVrezFVUxpEWmcpyUKnsi4hCuwdo0qZSXJ+f4cOJg/h8qOSmSo2nL2yBada1cV
         b0vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780546980; x=1781151780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        b=mBfF/g2zB4gACyYVb9XP4LyaU0EG5WoHgpANzjyxewBby6dZ2hdCl2ExRGBWIc1AS2
         D+JxfImGyizH/cHCnr/1YI/ddiFBncQbU4/Tvxx7yT3He4bZHiOs3Y4ddowo/VV4E7gl
         nJQbjHV0xkiQOSdVy59kC10UdS6ZoN29h1q8FYugJfclAa8Wn1l2qvuyEtU5duhlAu44
         XhFvx+dyzDBIn+FOvXLgyeeUPeb/nULsdOjY0ts4cjVkDrqc8DigECuQ2zyLQPIPES5M
         KHXOnzJxYQmAsTB1WYePVs5jdGjXFD9OVzGrOW7+6ZMOLy6mK5r+XInkeskd8FRGaTY8
         BVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780546980; x=1781151780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+UAvzNp7kr1X+8H+52+phqg8y1TmFeAUeyBSpAhRxc=;
        b=sd5s3XwmTib3oSWWUim9Rtcvx2OBbgqeb0Ynz5/r8Xa+si8Kkl0p0uR/NZWEORxN4c
         9oEZLjPIPCUiouf4vyTQ54LNNGbylvOm3P8UZO8BGZDltR63gw3VOZ+vM+CMvz4B8R6E
         yUyQZ83PxRYQFrXH9+3nmIqCFVJK00+55ytOTvQvfevmZmAQEkCD4P1vMc97PFE7saiR
         ljiILez7AG0URkVUnoiQJuWRobCKOyceBhQhtNZQbKD8QXmvpn7eEI0JP+eMRcw5StC6
         +ig/kTr555j9l8urH1s+UQIkPGzG/Sgv+YK8xjzPJNVcczfOs1dsACx5K6WKnH01CKaj
         5r2A==
X-Gm-Message-State: AOJu0YyFOyUd3SYwJxTJ/oxCPecEW+cu9BWfhpB20rg/ctwvsyj1KXGv
	OAEbXI7+mMcsIErz8EKBlNBLq1Pae+w5JDj3+V2QQDYfwx02S6JRmdM4QnKxGv7h9RgJS/odV5e
	pLTJ7a1CkoE/goNTfy8ydvtHPwpNh9jI=
X-Gm-Gg: Acq92OGIWq60YsRDFnDi+haLe5mbqvR1V+XyM1UQ2lkSR9c3iqWIiBfzpYWoAnKrhBk
	q5rPo8J8bj6PywD7bQfhXaf3heFgciq1D3qMb4siHjhFi6pHfm4AcUU3Z+zC548aLQCSt1y+r7G
	jgmYCdUa9GYIqZjD8D1NR9m6Z3jLapS9IbRsauQ8mNTWowWNRhFgK2RqfA7WfYVDiPxzIYOImE6
	sPoTMKyzv4ogxr+kuTF6ARNdNyQj9CIqEeZSGO5XJMDulS6kIEdLiI8cHQoP6WE67yx7w1tHVfD
	CHbStxrbXkDntIWE5U5CoTq5BNIpwkE=
X-Received: by 2002:a05:690e:4199:b0:660:651a:26e2 with SMTP id
 956f58d0204a3-660dbe97c0amr5430479d50.13.1780546980048; Wed, 03 Jun 2026
 21:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603140742.1398659-1-lgs201920130244@gmail.com> <c835f4f16639eb47111aa64c2968193fb71957ad.camel@siemens.com>
In-Reply-To: <c835f4f16639eb47111aa64c2968193fb71957ad.camel@siemens.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 4 Jun 2026 12:22:48 +0800
X-Gm-Features: AVHnY4JWw6Atno5IMaMOvNK1N0PCOo-mGo6u3aZynkumDnwNDuJeF5ImeFCvCAA
Message-ID: <CANUHTR-Z2qwdEwnG1dzfe8zH1z3hbdmGMaDNhch3oOxxA2RihQ@mail.gmail.com>
Subject: Re: [PATCH] net: cpsw_new: unregister devlink on port registration failure
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295043-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.sverdlin@siemens.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-omap@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,siemens.com:url,siemens.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A46863CCF1

Hi,

Thank you for your review and comments.

On Thu, 4 Jun 2026 at 00:58, Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hi Guangshuo,
>
> On Wed, 2026-06-03 at 22:07 +0800, Guangshuo Li wrote:
> > cpsw_probe() registers devlink before registering the CPSW ports.
> >
> > If cpsw_register_ports() fails, the error path only unregisters the
> > notifiers and then releases the lower level resources. It does not undo
> > the successful cpsw_register_devlink() call, leaving the devlink instance
> > and its parameters registered after probe has failed.
> >
> > Add a devlink cleanup label for the path where devlink registration has
> > already succeeded, and use it when port registration fails.
> >
> > Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> thanks for the patch! Apart from the issue Andrew mentioned, the fix itself
> looks good to me,
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> > ---
> >  drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
> > index 7f42f58a4b03..95b3b58db6e0 100644
> > --- a/drivers/net/ethernet/ti/cpsw_new.c
> > +++ b/drivers/net/ethernet/ti/cpsw_new.c
> > @@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
> >
> >       ret = cpsw_register_ports(cpsw);
> >       if (ret)
> > -             goto clean_unregister_notifiers;
> > +             goto clean_unregister_devlink;
> >
> >       dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
> >                  &ss_res->start, descs_pool_size,
> > @@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
> >
> >       return 0;
> >
> > +clean_unregister_devlink:
> > +     cpsw_unregister_devlink(cpsw);
> >  clean_unregister_notifiers:
> >       cpsw_unregister_notifiers(cpsw);
> >  clean_cpts:
>
> --
> Alexander Sverdlin
> Siemens AG
> www.siemens.com
I will address Andrew's feedback and send a v2 with the subject updated
accordingly. I will also target net-next and drop the Fixes tag.

Thanks,
Guangshuo

