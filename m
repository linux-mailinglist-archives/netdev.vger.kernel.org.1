Return-Path: <netdev+bounces-157173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63716A092E2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825E63A5C93
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971620CCFF;
	Fri, 10 Jan 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zMvidE4V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A015139587;
	Fri, 10 Jan 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517889; cv=none; b=Ol9DboLM6sQlvjDkZyCRy25MwW7hel4/Lz/r5AEXCyziVTTZ/pXGWCuCipNESmsTRe1B/Ygo6BY1OHV+vNhyXuR+wl6xbiG66TJJwVjpE80VPDt1/D3cy/XcqCs6AHCr6v17CvPYbebhkWS4ZKc0PKG2wuc05BuMQ/9CSpDyJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517889; c=relaxed/simple;
	bh=35rfx4Y0AQAVS0eYZBFYNfKcIxVqe4IpwtHYWGJ91kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd+j8Dw2FMjTzXb7YtNortq8Kxylsubfq33CXaloXeCpGlbQNF2pe9fYQVftdZyly3n3Tw85d5kPBVqWA1+4f+z8y/XyBIFFYSdGnq0/3mIp1IpmyM5XmvuTFaJZ3+UcroE+oatLaWWQTch6i/8U/PrWEnW2ZYJMy/M9/n7P20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zMvidE4V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7HjnwD9AZ9bpagwc/lNQ4PWx4QhMbmgXIuOqNi1NcM4=; b=zMvidE4VIvrovRs9QONvhitB+e
	kR5gnG6ymO+glm9en1J1Nlb08FgSGdcAS+0mGVXiKMTo+P9EkwKryA4kVyfERm1Ro9LhQYslrd09E
	sm6f5XyNdv5meaPSUYbpk7Qr0SMHYYNNELxgiDRGuNUJX1sksmTlMQI8AiClUojT3jeQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWFcM-003FJ8-1r; Fri, 10 Jan 2025 15:04:06 +0100
Date: Fri, 10 Jan 2025 15:04:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H?= v2 05/10]
 ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> Agree. You are right. This part is used to create a gated clock.
> We will configure these RGMII delay in bootloader like U-boot.
> Therefore, here does not configure delay again.

> Because AST2600 MAC1/2 RGMII delay setting in scu region is combined to one 32-bit register, 
> MAC3/4 is also. I will also use 'aliase' to get MAC index to set delay in scu.
> 
> // aspeed-g6.dtsi
> aliases {
> 		..........
> 		mac0 = &mac0;
> 		mac1 = &mac1;
> 		mac2 = &mac2;
> 		mac4 = &mac3;
> 	};

I would avoid that, because they are under control of the DT
developer. You sometimes seen the order changed in the hope of
changing the interface names, rather than use a udev script, or
systemd naming scheme.

The physical address of each interface is well known and fixed? Are
they the same for all ASTxxxx devices? I would hard code them into the
driver to identify the instance.

But first we need to fix what is broken with the existing DT phy-modes
etc.

What is the reset default of these SCU registers? 0? So we can tell if
the bootloader has modified it and inserted a delay?

What i think you need to do is during probe of the MAC driver, compare
phy-mode and how the delays are configured in hardware. If the delays
in hardware are 0, assume phy-mode is correct and use it. If the
delays are not 0, compare them with phy-mode. If the delays and
phy-mode agree, use them. If they disagree, assume phy-mode is wrong,
issue a dev_warn() that the DT blob is out of date, and modify
phy-mode to match the delays in the hardware, including a good
explanation of what is going on in the commit message to help those
with out of tree DT files. And then patch all the in tree DT files to
use the correct phy-mode.

Please double check my logic, just to make sure it is correct. If i
have it correct, it should be backwards compatible. The one feature
you loose out on is when the bootloader sets the wrong delays and you
want phy-mode to actually override it.

When AST2700 comes along, you can skip all this, get it right from the
start and not need this workaround.

	Andrew

