Return-Path: <netdev+bounces-183605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC045A91393
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FD13A5DF7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC1F12F2;
	Thu, 17 Apr 2025 06:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A32DFA4B;
	Thu, 17 Apr 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870301; cv=none; b=PVnaUd2jamsgCrV65C1sppbw67acBk6qXXjaMvVM1HtSUKMYEFXFLvy2D6QTTqRnyurS7NQf5F/rbV4GXjeVr/TN7eH0jJBFBRlfwes6CE8nJpWu75q5JVzBkv27sNc97IpzCbc1qkK7srCSYsSOgTwMB6mfwDeGtVTyn7+vfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870301; c=relaxed/simple;
	bh=kgZhkApVvXyr4ZTTDLeZEnQIzIKe2sIDfbZoq5Z1UpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CESLL0mMJzmfrjyM2mPM7zu/TVpQghy74aZxRDnezN9rSV34uZ+yBG6uXavbqmN4x+Jz2NGDueN45+52vq/Jdx3hEA7VY4i3jtC322CCo0w16bQ/8B325zDwk16Cjq9q9Qpg6059HS/XpwxHXnIbKoaJQV/zsJ6neNrHXbbsgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 10.0.2.15(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cPFBVRS_1744869966 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Apr 2025 14:06:07 +0800
Message-ID: <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
Date: Thu, 17 Apr 2025 14:06:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
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
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
 <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
Content-Language: en-US
From: Frank Sae <Frank.Sae@motor-comm.com>
In-Reply-To: <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/4/14 04:33, Andrew Lunn wrote:
> On Fri, Apr 11, 2025 at 05:50:55PM +0800, Frank Sae wrote:
>>
>>
>> On 2025/4/8 18:30, Russell King (Oracle) wrote:
>>> On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
>>>> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
>>>>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
>>>> YT6801 integrates a YT8531S phy.
>>>
>>> What is different between this and the Designware GMAC4 core supported
>>> by drivers/net/ethernet/stmicro/stmmac/ ?
>>>
>>
>> We support more features: NS, RSS, wpi, wol pattern and aspm control.
> 
> Details please as to why these preventing the stmmac driver from being
> used? Our default opinion will be that you will extend that stmmac
> driver. In order to change that, you need to give us deep technical
> arguments why it cannot be done.
> 

After internal discussion, we have decided to temporarily suspend upstream.
Thanks again!

>>> Looking at the register layout, it looks very similar. The layout of the
>>> MAC control register looks similar. The RX queue and PMT registers are
>>> at the same relative offset. The MDIO registers as well.
>>>
>>> Can you re-use the stmmac driver?
>>>
>>
>> I can not re-use the stmmac driver, because pcie and ephy can not work well on
>> the stmmac driver.
> 
> Please could you explain that in detail. What exactly does not work?
> What is stmmac_pci.c about if not PCI?
> 
> 	Andrew

