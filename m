Return-Path: <netdev+bounces-284497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIo1GPoW+mksJQMAu9opvQ
	(envelope-from <netdev+bounces-284497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:12:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EE4D1052
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00A0E30518D6
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894A48AE2F;
	Tue,  5 May 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Bo0T+uYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6747ECF2
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996734; cv=none; b=mZt/3OCejRXOsyvUajS/nz1moPbUupEn2bAoHPd8Qh5DgozboZCQXPLNQrZgs66IC40onm3lC8ns/kuFkAoH1QzmsOmtpFfjERMrVEfb0cENr1VgWVfAO0sFEBZSVJq+A1TiB6NgHQP6D6cb6FqXrs7bIKGe/59VzQjItpPnlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996734; c=relaxed/simple;
	bh=J84KpcArs6vG8jkcaA8eqYNE61DrVpr3S1BqehpaogI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spi7xEXOKiu+fSnfri++0apeBFi4MYCfdH9VugCSGa4mEJ4SzjJOKGvgwczTEowZZuwIVCaqisDD4h/nRVbfUJD7TYxRtf9QgMx3Hs7a4pDXpa5qF7bu8NZYiDjv8EH1Hc68OBkQJ9FbLJZpAx7A9948O+qxNT6059Fb6X0WOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Bo0T+uYt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ba840146so47800705e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777996729; x=1778601529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01VfL6gZZIzvH10mF1K5m6OM2N7Xtov5WNdZLRl6ixg=;
        b=Bo0T+uYtRK7qzCXjEG3X7Xtxbi0zVegst5mQqt045lBgootaHRNsakmETF2OvOIqRH
         SiERBZDmYy0zmbj7hfj/2yMZMxWd5GEeGXYJ6RNMuMAO0XOLy0tIA/Hj9l0fbiPzuqla
         FpX4JZlutMh3cqH2Rjfo+WYomdT1M8uzLHhtMzvXDu1KYE9r8aMNuXReyCfT2VbVfLX1
         IbYo1QmAQeh1aufH3LfK4WoXWBXcGqARcNIXXOyG84cXbrw4vVqVNqIjiidDrsbmgfDP
         mq00/J2YQDL3W8RVPArxjMrdH2yO7PWsSom2FY3i+xQ6Hpq+Byt6BYdIG6PEOsh2stSK
         G6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996729; x=1778601529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01VfL6gZZIzvH10mF1K5m6OM2N7Xtov5WNdZLRl6ixg=;
        b=de4OhiOtNdPBW0rI9DmRLbNGyIGbcZsujq7Dq+ilifyOM3pKBHVF/GHu/9+U7KgDDi
         IuPIQnonbDeP2uaMl+A7Afcq4t2n0l3oYn0PMpt0dENLBuETTQM/MeDxZmoYtzaPkcZS
         ub/Ua/Wee0Zsk+tL0g/eOXXSK3Qt41LMgfcdlfVfpSGiXlcJ8HCKELaeJVayW1swTmJI
         JYQNdDz8OUwIQW+gUv8jSw/y+3x8Cv9SWhG5pNf/E+nvz8Z+nr9Vu3ijjUGrqGnVeeXF
         rLmMG8KY3RXExoTGMrrHyUwMz0iwvleY5DsjyEB9npx3pR/EO9cjBrdpur0YX93HjRS+
         0hyw==
X-Forwarded-Encrypted: i=1; AFNElJ/TRv9qQeLmU13BMwLNpgEugoioA0/sWaQ4tPTkXcUWNQmXQx2v31xQJ31Ci8oZgGkRWu7ZsGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHJngWGHJJmEOb2mC0IK5v2niuxeSvWRkDoQJwGjco04GOAlz
	24TUk8mHhvT+A7wbn/e0dmvROvGcKIqGEOv8SKFHIEKtNEmgfTOA7nxnKVp9Dx60TJo=
X-Gm-Gg: AeBDievI1G8tDR6YCkcuTYXJaoDxYiAFjDuU6iuO3IahcmwS/tMRJoE5F6xYRY13g9F
	5Rd3cllT9BV4Bh3kiL/qW0gpkkkOYYvNHM2xGaxxqQesYlItJ2uxpfQWXw0UFMyo+cMc2NhW9Eg
	4lkh3YMRFniGSga/nKxkkAdSlYpxivuz7WN+HLd8cMZmT9Lh4IGcgHyuShgCkU3TFaWjgCeadUc
	2FdnDBIucBgtd5h//o1whc40opHXAr8Qwz3TrbBk7fXTp4fcBDzIyHldEf99/CRQL8bQFXGxa0c
	yRVUA7viaWzd3skU4F1dHKq7/aGJ3OBhRPf52r1djndyV2uO++MSzszHt2+mIGjhnW1zadO4D9I
	OkRMD87u1DrDA0DY7MvaNBsbU4EApH0KDzmvPpcDQ68t1dGhVfa9c//9jeVRZJBnjIFKfmLaBEh
	QdQkCnNWNdwoX2bRvaCyqEcEILVtLs07Gn495hi+ok2IiSd0ozrrjRtB48wMGKmt2+j5ykd7CVh
	dODU42gMhHDuI9aHdF+VRkpXna7dA8loTQtKV78M+Xaq/dLPIQdWr7mvjl+14bO2XVnqfHJrjOH
	VqNsQye33gyNV8WcHmg=
X-Received: by 2002:a05:600c:528e:b0:489:ecee:c4ef with SMTP id 5b1f17b1804b1-48d18bde33amr61483785e9.13.1777996729166;
        Tue, 05 May 2026 08:58:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bf3ffsm444582355e9.7.2026.05.05.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:58:48 -0700 (PDT)
Date: Tue, 5 May 2026 16:58:45 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating mode
 for 10G-baseR capable PCS
Message-ID: <afoTtdAO23DhOeZ8@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-3-elder@riscstar.com>
 <f9a581a2-02ea-4948-8c97-835cb7638b1d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a581a2-02ea-4948-8c97-835cb7638b1d@lunn.ch>
X-Rspamd-Queue-Id: 6C1EE4D1052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim,aspen.lan:mid]

On Fri, May 01, 2026 at 06:50:45PM +0200, Andrew Lunn wrote:
> > +static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
> > +{
> > +	int mdio_stat2, ret;
> > +
> > +	switch (an_mode) {
> > +	case DW_AN_C37_SGMII:
> > +	case DW_AN_C37_1000BASEX:
> > +	case DW_2500BASEX:
> > +		mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
> > +		if (mdio_stat2 < 0)
> > +			return mdio_stat2;
> > +
> > +		/*
> > +		 * If this XPCS supports 10Gbase-R then it will be the default
> > +		 * which prevents 1000base-X and slower from working correctly.
>
> It would be interesting to know if Toshiba messed up the integration
> of the PCS, or there is an errata for the licensed IP.

I'm afraid I don't know, but it looks like the issue is not unique to
Toshiba!

This is a discovery which, rather to my chagrin, I only made after we
posted the patches (thanks to a hint from Sashiko): there is similar
code in txgbe_xpcs_switch_mode(). I cleary overlooked that when I
originally reviewed the existing XPCS code. I suspect I stopped
scanning that code path due to the PMA related conditional branch...

Regardless of how I missed it, txgbe_xpcs_switch_mode() implements
similar logic to this patch. I think it is using MDIO_PCS_CTRL2_10GBX as
the Reserved value but otherwise looks similar. There are comments that
imply 10Gbase-X isn't implemented by their XPCS which would make
MDIO_PCS_CTRL2_10GBX reserved (but are too vague to be 100% sure).

Right now it looks like xpcs_switch_interface_mode() and my
xpcs_config_operating_mode() are more closely related than I realized
so I plan to move my code into xpcs_switch_interface_mode().

I don't think I can unify the Wangxun and Toshiba code (the waits and
resets in the Wangxun code make that too high risk) but I'm not yet
ready to give up and just make the Toshiba changes into another vendor
quirk!


Daniel.

