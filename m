Return-Path: <netdev+bounces-284919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIOGGp1f+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A74DD537
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F998302CD07
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8248B360;
	Wed,  6 May 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="C+XW4o+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA6481A82
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081302; cv=none; b=RA4Ns/thDU/NZweqzmL/8ZjT8wQXwz3V2CgrHrT3fkdUXzLjogYmZjZ6jp/38NfWcM9YJPENCySi58INZgcRNIEBBCQDHodsmXAWhY+YGTkEEoWMUU86IfVrBz07M78BsmH35GCO/NqLlEMtbTnDk+3NN5B78dwplxe2ez7Qu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081302; c=relaxed/simple;
	bh=ZjEF3HpGwOZm1XS1TR6kZf0bNGfRZAZycuJei4ErS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssm6sZ1n3g/4RHRwwdFb/EIuQtfRK1Y+lAokKRjWQnBjYpogKj/EMc+QHCFZlzJCJn3owky6LIFq/EhbDkpba0TcXk+x0qPGq8KDW8Z+xLCWm6FmztU5vaCT2Fos8bDjKevtSsZqiipxRqWziHMvs/jIVfBG3t42sExg5COZEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=C+XW4o+3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44da2de25f3so2454028f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778081300; x=1778686100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGs4aXiGfe9FWzGIQNV1c8scbxohD/REqUQGlNaM17Q=;
        b=C+XW4o+3BpfIYq+R7bvkXpReBGJrMLl/LMNXIlRWJaDMCP8l12gnAozRU838922lJO
         RRMdFfzQKpQnWzb6ARXvdQ/RtmoNDrD6n6niAyKgqBRMYhB4EgtCI9TgzaWGrCFvQr69
         fFOwH466Yb5gBEBbxEPPUBIughRl1DS0H5ACmf77Pp1KVqBLSvWKdCqpaMHf8bQrkbrG
         WSEmp1uejt1RRMTrd2KyJVV6XAhyvlzZlZ6XjoIR5zHH8AFIBX7xOryI1vY82/TAmX2r
         QaH5nTkRIC2PshdIC8H4YqtCezuEp5OV4V4OailE6fk5iyxuluRnpcZi1h4qmNgHK/m3
         OkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081300; x=1778686100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGs4aXiGfe9FWzGIQNV1c8scbxohD/REqUQGlNaM17Q=;
        b=ewfyzKe+AXdJhrjbwvaDNr5+7aZ72ZXV/MIEq2/8SBDEi+l6fsnLTURa+DotJ3X93V
         10QFAsr6BR434Mq1NjydYkrI405L5CoY6fsNVlmJUUWcOGYTcB+zr2uBotAuv4jXO022
         +iKn1XHGYx91z426GNvV3Wr0vwlDd+KXsB0Sy+uHB1lzM0hq6iRdfYLVr2dTHpL9bUwP
         Nykp3UR896jkdksl0J6F0MvvLNcdwyfQsJQvbqKR3TpwDfqVismQhOX+Q8W1g9HSEwJk
         1yOKzQtETnlab4Lmuq4xt34Ln/0wUaGGo5y6am52kFZbLVOpFl58fER2JpNWy12ZFnJH
         VYXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RdltB9Claa7CkUISr2VRRzq0AUKr9YTGEkz2u2xTCJ7CwE1sYj/UAYSIVTIpIrU9VpmC2uRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoii5Zxk0ImhbX+GQ8Ao1PASz7rrkFqKErpO4yaOgdlaWcLDbr
	5+rz1cUY/x97yzj2819e5+3LZfBeAwb4S0ABc02colkhMQIZacyPtReE2rwVHKa/HK8=
X-Gm-Gg: AeBDiev8ZIHqooi3mpl38ksnRswvptoCMgah1IHaor0r6nEMjm2ASLcDYNhUBOg6t+0
	eGc3++ptjAdfR4yg1+dRuSUaPEOLJRR34ChyAJuQA4K4OMqye2rY5X9LEFKWIK4NxQLzItmKu5d
	cWXx9gCR/X8SBTi8umX/UAFOgOC3k7rG7hNrURdppHwUWZceRViZd9VnA60pBOfEvz60JNkWY4Y
	pwXvug7Fg/9bKlDvwAKXrp+3cTdMq7pFLpXkjAn2o/7sjU8g37qffTZQd4Lu22mHwYGo76HE2yf
	01Ox3kIMz/5hvMlfAWl1RVHsQqDctJbNVIvuZf6YoPkNbvPn5hGvnj4Anj8PSvBIH5cVL7ut/zw
	nOwvV6cycyE5Adp3o9ZYaHHMX+X1C+LxEkiSm4Hlim22hSprqmCOAD9FpMBe9wOFhtCqRPsC/dH
	gwXaFdl3oqeuWZcnIrj1y7krrmzPwSFIX34Zy14bAfBpTc1aDZK+Wbslcxf1H5sL1d90dSGGFfJ
	6w4YBPu9kgibHgBk7JPdyZqIemiYjDKFD1ryAjp65xNuULMQWmcgs5TegXdxlTp7gXeB0S6z00R
	N5pEJi/RnGT8qlQThhg=
X-Received: by 2002:a05:6000:2405:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-4515cf11ce9mr6889250f8f.20.1778081299271;
        Wed, 06 May 2026 08:28:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm14773996f8f.28.2026.05.06.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:28:18 -0700 (PDT)
Date: Wed, 6 May 2026 16:28:15 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xilin Wu <sophon@radxa.com>, Alex Elder <elder@riscstar.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
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
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <afteD2d8d87Nyvl7@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <224E233C593EF171+8c8a43dd-5061-40f8-9eb7-f360eabf2ecc@radxa.com>
 <4015f47a-af62-441d-b1b8-a8598f963970@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4015f47a-af62-441d-b1b8-a8598f963970@lunn.ch>
X-Rspamd-Queue-Id: C96A74DD537
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
	FREEMAIL_CC(0.00)[radxa.com,riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284919-lists,netdev=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspen.lan:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

On Wed, May 06, 2026 at 04:19:54PM +0200, Andrew Lunn wrote:
> On Wed, May 06, 2026 at 08:59:01PM +0800, Xilin Wu wrote:
> > On 5/1/2026 11:54 PM, Alex Elder wrote:
> > > +	/* AXI Configuration */
> > > +	axi = &td->axi;
> > > +	axi->axi_lpi_en = 1;
> > > +	axi->axi_wr_osr_lmt = 31;
> > > +	axi->axi_rd_osr_lmt = 31;
> > > +	/* All sizes (2^2..2^8) are supported */
> > > +	axi->axi_blen_regval = DMA_AXI_BLEN_MASK;
> > > +	plat->axi = axi;
> > > +
> > > +	plat->mac_port_sel_speed = speed;
> > > +	plat->flags = STMMAC_FLAG_MULTI_MSI_EN | STMMAC_FLAG_TSO_EN;
> >
> > I got WoL working only after adding STMMAC_FLAG_USE_PHY_WOL here. I guess
> > it's required, since the driver clocks down the MAC/PMA/XPCS in its suspend
> > hook?
>
> Nice to see somebody testing WoL.

Absolutely!

We recently stripped out the (obviously broken and partially ported)
WoL support we had in tc956x-pci.c. We planned to bring it back later.
Hadn't realized it could be so easy.


> In your testing, is it the PHY doing the WoL, or the MAC? I assume
> PHY.
>
> If i remember the DT correctly, the PHY interrupt is connected to a
> SoC GPIO, not a GPIO of this chip.

On RB3Gen2 (and I think also the QPS615 reference design) the phy
interrupt is routed twice. It is connected both to the TC9564 GPIO
block and to the host SoC.


> So for your board, it is the SoCs
> GPIO controllers ability to perform the wake which is
> important. However, where the PHY interrupt is connected is a board
> design issue. Could the PHY interrupt be connected to the chip? Would
> the chip be able to wake the system? Should STMMAC_FLAG_USE_PHY_WOL be
> conditional?

I couldn't think of any reason to use the TC9564 GPIO block for the
interrupts on RB3gen2 so I left it unused and the DT describes the SoC
routing only.

However if TC9564 were to be mounted on a real PCIe card then we'd have
to use the TC9564 GPIO instead and would have to leave enough of the
TC9564 enabled to handle the interrupt (and also to load a firmware to
catch the interrupt and drive the PCI wake up signal).

However such systems would need extensions to the current driver. We
have done all we can to make it possible to add those extensions in the
future but we would not be able to test them: not only do would a real
PCIe card need extra driver features to play nice with ACPI but the
card would also need an I2C EEPROM. We don't have that EEPROM on
RB3gen2 (and again, we'd need firmware to read it).

TL;DR - there are conceivable (and sane) hardware designs where the
interrupt goes only to the TC9564 GPIO, but they are too different to
RB3gen2 (and related SBC designs) for them to be supported before
they exist!


Daniel.

