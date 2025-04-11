Return-Path: <netdev+bounces-181577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43DA858A4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5C9A2BC1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AC29AAE2;
	Fri, 11 Apr 2025 09:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52529614B;
	Fri, 11 Apr 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365392; cv=none; b=pv5uvPyl4Y3twG5ZOKZvvO3z2+kGeuNFkFOKaBuXi1Z/qzAtiAoY5cW0lgKY2+pWJQwIUkXn5r/kbbpALHhRp5N0vrszMr6WFmPKw1p/M4u4E9eCEvMXCWPtKCU4JJ30GmNUec9KEwqGDwqUgZryJrlf1C75l6QHgw0VlrUY0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365392; c=relaxed/simple;
	bh=dI24S8coPzz7k1htKptwmRID8NIsoRVYe1b7fMWVAk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttEZKMhTCw4mmGlNHX4vIFXq8nz///3S0m4/upKrkMwAvUtEzIGHWARPsW5QB2BYhqyZ+sL4kvo+YwTxNNaeBKz311ZRbfoHEvDNqNsUW2Z7PA2SWLz4I3gDFj4AYzl+/b9k2DxysT6qwObIN8TGibm5NSOSs7nZOQ51DI0fNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 10.0.2.15(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cK5WKQw_1744365055 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Apr 2025 17:50:56 +0800
Message-ID: <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
Date: Fri, 11 Apr 2025 17:50:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Parthiban.Veerasooran@microchip.com,
 linux-kernel@vger.kernel.org,
 "andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
 horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
 fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
Content-Language: en-US
From: Frank Sae <Frank.Sae@motor-comm.com>
In-Reply-To: <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/4/8 18:30, Russell King (Oracle) wrote:
> On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
>> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
>>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
>> YT6801 integrates a YT8531S phy.
> 
> What is different between this and the Designware GMAC4 core supported
> by drivers/net/ethernet/stmicro/stmmac/ ?
> 

We support more features: NS, RSS, wpi, wol pattern and aspm control.

> Looking at the register layout, it looks very similar. The layout of the
> MAC control register looks similar. The RX queue and PMT registers are
> at the same relative offset. The MDIO registers as well.
> 
> Can you re-use the stmmac driver?
> 

I can not re-use the stmmac driver, because pcie and ephy can not work well on
the stmmac driver.

