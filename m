Return-Path: <netdev+bounces-204454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10725AFA9F2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6612F171261
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E857E792;
	Mon,  7 Jul 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjXN5o+Y"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF517E0
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857401; cv=none; b=OwAruPruGiCILIg+OD8q2eOoZKwGdKWhZ9HNcBBgfXWAoFiFGjsBWSRiKswZ+cMF7aXp/Di4wmwv4E3dtxUyJq06UbHhiEHTnAe+uZo5znwDKnQe3sg+88T4znZpHOwOZdpmoAGa0kaPvTmTYxXqUTHI/W6VNscG35l5EnhYzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857401; c=relaxed/simple;
	bh=XXrDjKkn+I7HQXaUYwBZC9+hak0veYwk0GFoTZswCgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX5OLhl8NJn56obrLHcVLVqNVBdePGeh+brh/p/BzIl4dU7Gu11qwVMPQbKmSnglFRQHtyzDK1QDgDrD+uhfL4s+QP+f/apDzn2F7nbuHQYKOvHbZeIeFYHI8OreV+GZ0murOTJr5Sdj0LoeleLO9mQPduVZIYVhvcE+oWv/qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjXN5o+Y; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef56c834-0e8c-410c-ada0-dc2b8be34cab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751857387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywlnlRGZ0Kdlw+99ZDcpRUHN/MXyl9e/75luEMxwyak=;
	b=LjXN5o+YS0pU591RwbFe58yEnnr9sjYfhpJjLC8fZnQj9Ofh3OWmnzE0IqQBuO3IRWpSPU
	6Kp5Nj7bgM90OatBXy1Ly5YEvixDo6QnXJ/CpsnyNVsF7Yd3AC2CQB3lBEzoHDrgMRqGko
	BVjA8hj7yH8eCrJ9zeazg1Oxo5ZSVbo=
Date: Mon, 7 Jul 2025 11:02:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFT net-next 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: wens@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>
References: <20250701165756.258356-1-wens@kernel.org>
 <20250701165756.258356-3-wens@kernel.org>
 <15ba0933-b0c1-40eb-9d3c-d8837d6ee12a@linux.dev>
 <CAGb2v646pxuT-nrwtDD-wvrA0eoxaee6sq2-mb0WoqUCPzpRjg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAGb2v646pxuT-nrwtDD-wvrA0eoxaee6sq2-mb0WoqUCPzpRjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 7/2/25 10:09 AM, Chen-Yu Tsai 写道:
>>> +/* EMAC PHY Interface Type */
>>> +#define SYSCON_EPIT                  BIT(2) /* 1: RGMII, 0: MII */
>>> +#define SYSCON_ETCS_MASK             GENMASK(1, 0)
>>> +#define SYSCON_ETCS_MII              0x0
>>> +#define SYSCON_ETCS_EXT_GMII 0x1
>>> +#define SYSCON_ETCS_INT_GMII 0x2
>>> +
>>> +#define MASK_TO_VAL(mask)   ((mask) >> (__builtin_ffsll(mask) - 1))
>>> +
>>> +static int sun55i_gmac200_set_syscon(struct device *dev,
>>> +                                  struct plat_stmmacenet_data *plat)
>>> +{
>>> +     struct device_node *node = dev->of_node;
>>> +     struct regmap *regmap;
>>> +     u32 val, reg = 0;
>>> +
>>> +     regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
>>> +     if (IS_ERR(regmap))
>>> +             return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
>>> +
>> -----------
>>> +     if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
>>> +             if (val % 100) {
>>> +                     dev_err(dev, "tx-delay must be a multiple of 100\n");
>>> +                     return -EINVAL;
>>> +             }
>>> +             val /= 100;
>>> +             dev_dbg(dev, "set tx-delay to %x\n", val);
>>> +             if (val > MASK_TO_VAL(SYSCON_ETXDC_MASK))
>>> +                     return dev_err_probe(dev, -EINVAL,
>>> +                                          "Invalid TX clock delay: %d\n",
>>> +                                          val);
>>> +
>>> +             reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
>>> +     }
>>> +
>>> +     if (!of_property_read_u32(node, "allwinner,rx-delay-ps", &val)) {
>>> +             if (val % 100) {
>>> +                     dev_err(dev, "rx-delay must be a multiple of 100\n");
>>> +                     return -EINVAL;
>>> +             }
>>> +             val /= 100;
>>> +             dev_dbg(dev, "set rx-delay to %x\n", val);
>>> +             if (val > MASK_TO_VAL(SYSCON_ERXDC_MASK))
>>> +                     return dev_err_probe(dev, -EINVAL,
>>> +                                          "Invalid RX clock delay: %d\n",
>>> +                                          val);
>>> +
>>> +             reg |= FIELD_PREP(SYSCON_ERXDC_MASK, val);
>>> +     }
>> ------------
>> These two parts of the code are highly similar.
>> Can you construct a separate function?
> As in, have a function that sets up either TX or RX delay based on
> a parameter? That also means constructing the property name on the
> fly or using ternary ops. And chopping up the log messages.
> 
> I don't think this makes it easier to read. And chopping up the log
> message makes it harder to grep.
I've looked through other driver codes, and it seems they
are all written this way, so let's keep it as it is for now.

Thanks,
Yanteng


