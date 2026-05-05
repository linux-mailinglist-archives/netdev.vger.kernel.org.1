Return-Path: <netdev+bounces-284509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGReLi0b+mkJJgMAu9opvQ
	(envelope-from <netdev+bounces-284509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8644D14E1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7007030684F7
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C848C3EC;
	Tue,  5 May 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="BOLA12n2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45733ACF0F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998335; cv=none; b=f1VxkuK9AgJL/np/LgS6uDt7qxZoiHpy70PmOE8GBMJGYuN3OTMeIEMWCYBQp27UcDESZRZIshUW5UfLU1e/o+8/vVMxtd1tUVMK1toX9ucbLYOdJNx8YhIWn3O3Np5z8eYw5lh74FRXkeqkw+C7wNEBBuLN2E1ouF/siCF6XD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998335; c=relaxed/simple;
	bh=10ad65O0ps7iM6dei8qNX30QY3FkTiMh2oPpwbtxSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTkDfk+QC0HOTMC34pEU3M59I14iiQOfa/dLB5HUO9L5jRV94hm5msYqC+hQ6t70vPPi/V3bWLZX4ATCVEbsfU7sAqE1tFA5o85EP8gsGx3qMSZTHq6lwP2zD+YAnEQkW4FmrxsMmnKo+PJ7GqLO2mj2p7FvquFlDRaylJZpm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=BOLA12n2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48558415e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777998332; x=1778603132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvgEgjFlnhgVavTSLAwA8kue6OnY1fSQmcbYOk/Oxj8=;
        b=BOLA12n2zlvmTn6BetXu2cIMwXhJbX+fAz/gLq6do6zp3kF4K8bysb/R3kx6QmU/sL
         sy3LWQoP4bi8cfnuP560JUjb7CQJze1XckvA6zXP0cQCyFX4ek6Ex+BhPLyNPHbkcKvi
         mi3Mf1XGJcV9KZdHYB4NPiQe4Be5mJyy0DlMvUJcGYrNtvX/tmmSESSG8uRanKtf6QrH
         +jXCiqbm1qvvfa3oR65MrApVGLhfnE5RhpdCkSitxFVUhnKXbOyeOYf85Na4ivlYhRxp
         29xl5m38ckNZuCyrfLY9/TP0RzuQ/yCbLpPNfD20ghiwdgtgdjyIoXBIwXneCGn1k6w7
         F+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998332; x=1778603132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvgEgjFlnhgVavTSLAwA8kue6OnY1fSQmcbYOk/Oxj8=;
        b=YZbnoC1v/2Ikn3MFjifc1c4u1/hwBd0YRclObDbxIY4Hk82GOKON73OTg6kUFP4SpT
         iDVxJxIvtO9tc+A8zLK2xQE24r5akpT+R7C0Q/fYZlC4XwfVzFCZyoblMwP89rHS4t5P
         c6mp69EQENnycmqXFV5I/KXB5rMWKfinQ2BOkNhc+L2a01kwNTMRgBxp1G1Hjl1ueo87
         BctxINlXz2+Rm1PzpU5kEZexO3G4IVYxQbrsn2jiog0czLAXBbXKiqgYVqYUwixtdDG6
         GlLk38TqOFatJ3Gm8HTEIvfDpU1cp/9ixsFcnx4vKls6CYCLeQ+ISlF1WNrpXfBu8qVf
         VoWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V4mHlO64EJ3g/W0sfBy/v6EOro4r3Z9WvMBqhcdRYIsWZ6Slov3kXfr2wx4/EJNr9mYxgLAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMdJPLSjQPFuPTju3K3+YdtFETtWSkMi9EvtJurmD3OX2tdhb
	fhN+9DOk0SJ2DbPsn725zifY9+r6zcihb5lnK5KNuxhGaR5NtNQhkCu/dRlgmrDhxH0=
X-Gm-Gg: AeBDietmVv9+F/o40qAoK7YGMuE0KLkpqSZohVLZj7P68+N6cFILq8nFW0cVWaOpmlW
	XpAZeVrC/KeS7c7nSE+FVwSx30cFw1zC3QtPUjPpY2mIiKuw/WQEC8EXq6q9D8oZcu7y1iMKyuv
	oumWSdCZf2DqQ7+9ipqB2tJCk/Qi/PbDPFnpMlsXbm8l5SgdioZZD0/668grCsVcycsrdv/ztVU
	54b4pU76IrtjsEUX6LwVCrhorhrdeWxMtEJk3uFFrW2xFz4vlOze+QGR28ecIz0HHd//2D1cApb
	90q4SzwV7tkAqMqsVjunAaQX6GY+PEiH88+O5Jsbha39A7bSw+vTDVxK9J3EoOjziMaVyglKAoT
	t3ARCnPmGBPfAP48nitTSalZBQSkKRU6L5A2JW/hREaFVXNQnw+BdEtUgix0ePJras0Mk5sWbuI
	SWczsuGe0kjbvOdm6DTA/5+afUdWsJ8WPSAUknHGS+PCA/Ek8Y0kj0Bk0Zu8+CD7RYCLuiNk/Oq
	+50v+DCWMdQCV4Ef4eHR/v0rQ2QWUBzFdZY7qwXyZA41omeIM/w6sprHegqDJ4O8zlCb5gBUSbZ
	DbvNAPDKl9Yjd+y8jcs=
X-Received: by 2002:a05:600c:3e05:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48a9852fbcfmr256956845e9.1.1777998332149;
        Tue, 05 May 2026 09:25:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm737620655e9.2.2026.05.05.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:25:31 -0700 (PDT)
Date: Tue, 5 May 2026 17:25:28 +0100
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
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
Message-ID: <afoZ-LuVRaX6ixs4@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
 <d29621c3-07fc-4720-abff-d8901a0d791c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29621c3-07fc-4720-abff-d8901a0d791c@lunn.ch>
X-Rspamd-Queue-Id: 2E8644D14E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspen.lan:mid,1c:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

On Fri, May 01, 2026 at 11:09:42PM +0200, Andrew Lunn wrote:
> > +					tc956x_emac1_phy: ethernet-phy@1c {
> > +						compatible = "ethernet-phy-id004d.d101";
> > +						reg = <0x1c>;
> > +						reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>;
> > +						reset-assert-us = <20>;
> > +						reset-deassert-us = <20>;
> > +
> > +						pinctrl-names = "default";
> > +						pinctrl-0 = <&qep_irq_pin>;
> > +						interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
>
> What is probably wrong. PHY interrupts are level, not edge.

Thanks (and agree). Will fix.


Daniel.

