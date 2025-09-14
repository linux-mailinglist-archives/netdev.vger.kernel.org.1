Return-Path: <netdev+bounces-222830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDC8B56561
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 05:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E516D16E006
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B191F2749ED;
	Sun, 14 Sep 2025 03:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D32272E71;
	Sun, 14 Sep 2025 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822165; cv=none; b=BKwKGgIr0+N4t23FZm61eqjZnbBAURSbsRlr/0Q1jk7XNne0JROAnrpDYEshMUbD4Y3ct0reDfXrGjjslNQy+r2eRdUJuh6rhnSKRvD5s57FTkmqRDVRrS7JyWo2VsGNlhkGhkBLhbjWyDcMzhV7oZeQsv+wgge5GI5ObAmQi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822165; c=relaxed/simple;
	bh=u02mMUaIVtvdrURtSKHtzwR4LI8cy7hQrvFjwPb8eKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iClVXYA8uff8cucqlSDeYQvF7FohjskD3CcsvSfGS9isr8MYdnKwjwR7r5yhQY+0HFWw4HCExiqIcK94aAfh2s/vBxhFOTcb4BHj7lzNRbuUg4lEDE7TK1Fg/fDUl57msyV2Fqe6MzZSAHHDyQHkTfNkIWJUAWZ5AHVmScLPe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowADX64V+PMZoDyHBAg--.5992S2;
	Sun, 14 Sep 2025 11:54:39 +0800 (CST)
Message-ID: <850e769c-ea03-4777-b91b-c7a8b0ad6455@iscas.ac.cn>
Date: Sun, 14 Sep 2025 11:54:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/5] net: spacemit: Add K1 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <uwu@dram.page>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn>
 <20250912-net-k1-emac-v11-2-aa3e84f8043b@iscas.ac.cn>
 <1f2887e4-2644-48a4-8171-98bd310d190f@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <1f2887e4-2644-48a4-8171-98bd310d190f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowADX64V+PMZoDyHBAg--.5992S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1UArWkXr4kCw1DZrWDurg_yoWktFgE9r
	1DXwnrGwnxArsrCw4akr1UJa9Y9rZrZFnrZ3WfG39xZa9FvFWkZrW8Ar1Sgr97Ar4fGryS
	kr9xuF4xCa48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jDKsUUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 9/13/25 05:10, Andrew Lunn wrote:
>> +static u32 emac_rd(struct emac_priv *priv, u32 reg)
>> +{
>> +	return readl(priv->iobase + reg);
>> +}
>> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
>> +{
>> +	struct emac_priv *priv = bus->priv;
>> +	u32 cmd = 0, val;
>> +	int ret;
>> +
>> +	cmd |= FIELD_PREP(MREGBIT_PHY_ADDRESS, phy_addr);
>> +	cmd |= FIELD_PREP(MREGBIT_REGISTER_ADDRESS, regnum);
>> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
>> +
>> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
>> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
>> +
>> +	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
>> +				 !(val & MREGBIT_START_MDIO_TRANS), 100, 10000);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = emac_rd(priv, MAC_MDIO_DATA);
>> +	return val;
> emac_rd() returns a u32. Is it guaranteed by the hardware that the
> upper word is 0? Maybe this needs to be masked?

This should be fine, since most of the registers only have lower 16
bits, and the upper 16 bits ignores writes and read as zeros. But I'll
change it to a FIELD_GET for v12 just so there's no question on whether
this is safe.

Thanks,
Vivian "dramforever" Wang

> 	Andrew


