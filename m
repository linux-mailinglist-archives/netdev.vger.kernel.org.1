Return-Path: <netdev+bounces-189852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD2AB3EC9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86881894AB8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB5296D26;
	Mon, 12 May 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aCzoCDXj"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB87296D12
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070176; cv=none; b=qyj98qxIYRHbEXNphUfcxEmWiKkl5ipgIp9LqlPD0PfARwnlP0Zau1LXjG4gcJz++vG4EzywiaIeAKyx+rMZsVr9c3BPEDkpjrq1Va/cfRih89Eu23zNP8ZimcvBpMcwksCNHXmFXYXVvNYeOCZLryp42WE5t6IUKGKoOTZHvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070176; c=relaxed/simple;
	bh=Klm9/xnlMVHXujMrDhURyLZBgR3GvxsmIVTqJHHrWl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX8zURn7IYlYUpTFZk0cMmWntvX8HSA7DdLHlAuGAn3erJyvr0T/s/zBln4rhDq6Yim+4Cfu//aEi+BA8tSn24Z/iRGzBEL9Vk0Oe+iG1mnM47Dj8ozdVyCbOxodJ19ActL08FJMrwqD4zRxyNkBJCBOR+ex0ahCEJjq+9n4apo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCzoCDXj; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f99168b-c309-4c60-9313-d6687bb1998c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747070162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8N6GKlbK16hAp/92AuGA8T5bSLcIE21CMka1AVFczE=;
	b=aCzoCDXjrbj/khZWc3y7z15EqUNWmg1j25agjJ4p6xbwu55Ty1xS9zdRCHBWMpvgl1XE2d
	T2RIo99ThvKuKH578Qs7qFHYNP552cmLjy0rOJ10TA1ra3CePl0qIM8khepBF06SERJT8P
	FxLOwkO9bIqHawSbMjbhAcMiFx+rLCE=
Date: Mon, 12 May 2025 13:15:53 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 00/11] Add PCS core support
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 upstream@airoha.com, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Joyce Ooi <joyce.ooi@intel.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>,
 Saravana Kannan <saravanak@google.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <aCIrvTAGP5ukmwnb@makrotopia.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aCIrvTAGP5ukmwnb@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/12/25 13:11, Daniel Golle wrote:
> On Mon, May 12, 2025 at 12:10:02PM -0400, Sean Anderson wrote:
>> This series adds support for creating PCSs as devices on a bus with a
>> driver (patch 3). As initial users,
>> 
>> - The Lynx PCS (and all of its users) is converted to this system (patch 5)
>> - The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
>> - The Cadence MACB driver is converted to support external PCSs (namely
>>   the Xilinx PCS) (patches 9-10).
> 
> Are those changes tested on real hardware?

Yes. I have tested the Xilinx changes on a custom board which uses both
macb and axi ethernet MACs with the Xilinx PCS. I also tested the Lynx
PCS changes on an LS1046ARDB. As noted in the AXI Ethernet commit, it
has also been tested by Suraj Gupta, although I am not sure what
hardware he used.

--Sean

