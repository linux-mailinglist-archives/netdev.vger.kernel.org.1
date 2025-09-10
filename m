Return-Path: <netdev+bounces-221559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BBB50DE1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CD91C22A20
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB92D3EF2;
	Wed, 10 Sep 2025 06:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22602D0C9D;
	Wed, 10 Sep 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484661; cv=none; b=Bo3Qz9J9V1HjM4i/MEOOB1ZpikSb8yr7h8A0pkPE2MDFbf7tiY9yt1hxOdaJez7IiLqyq8WVB2gXZJu8fzSMkWA4w+DaIJ9iBbNBVC1OipA0vhs4j+vcN/1Ugfmg5+bKGc6WsdA8kvqpBfO7AZoToh/4FVCttUJyT0Vw5VlnvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484661; c=relaxed/simple;
	bh=vLKFy2bSOWoxpwLlB07v+Qhq+xNOhw97GihfrFoqGuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN+25e+LHXvkXEUS5muTgzW4EK96nOnVCXN3jeKGguycgHmxvWSYxy1B7a94VFUo5fcn43hlhuPrRd40xc7txQVrqCigvKKr+x5M+AEAcFHrMqCd9sK0VARL1499GhsOaUeZ2SsQL0pUGOT1RbpN9cSTYOaWmuRkNcHZ4nsHbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz6t1757484625t00d54c16
X-QQ-Originating-IP: ZzG+RN8Eyp/Q7pmL/4XIv6a9IoJoZLK6jHje2BlQTtU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 14:10:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8687577365072623023
Date: Wed, 10 Sep 2025 14:10:23 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/5] net: rnpgbe: Add register_netdev
Message-ID: <45285D515B6FB8C9+20250910061023.GC1832711@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-6-dong100@mucse.com>
 <548eb7e2-ebde-464e-9467-7086e9448181@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548eb7e2-ebde-464e-9467-7086e9448181@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYg8s5M+0PzcgFZySDfo5zqR+ceRyyJscFAoC84PIuBUW3EwlC8DtsDY
	dNrw6+2gqW99LTt3+Q4OMKd9BiAv2S/E/+wgh1KbrnmQEfCfdrDaN7reIqdM7kkkEwTWF7i
	ErufNvy3z9uaWzqTLmUgMEZ+PS6x/h12C3u2EGXn3sy4BDzX4AcdEedJWhYCsXt/GUlzYjY
	H/5udv/3wD10T0Ic6BPh9HmiyXVU6iJUyVNFmdiYH5SNdVwtdNR6H4mZtHNwFeLn4kYFSF8
	MnYGSPiWfViAlWIeHZsI6oxA7bpmxzAUSlERrO3TjHLQAtT9LSQctt6oeQ2kccV8+pQ/NMX
	oMvhoJGXIYlaqkFuPmhd3cvZvR4RlqvQyoLguqPjUpJvID3UVs5+Bai7icST25AnPIOcNIw
	24HSLWz0UfRMofG0iZ42YTjB82ZjwuHD4MwEQaFr0UpuNwq9BJoIzchCj7YchdG3J4BTf9M
	vnxmKpEF2umyXKzY3z88yKhHAomOPjoBcVR+B7Ec2DZuz8SAp8FERQDhxENqZWAd1s/JuWC
	mwSeWHFReXOjdGDMpHhFbkWTOXHoRfl2J6ZPLR4Q1N1znqNDLLM8ULesAUd1ebT/DeLPtW9
	KsOGGwtLTu0/Datnk66NaGian+vPiOUBvHITr1AAqGPZ1OQCdEMwM08i/v3o5LTdVg7pJbF
	WBi9Buj0e7FAwxqtA4IHHLkNf0H/WlaYAKK1g8p2qD8vX/vR577MAW9Pemn+ir7fvLWo2Op
	asA86MebNzzZQLbxrbKVCLBmBKmak3fLfmoPJdwt3zO7Tdrt3xv51VOwLJn1RU9g2j5UhLT
	mQhFsgOPabFk/XP5LtJZvxCFMJ0CDNcnOi6FTf4fNTXtXRiB4MwDMOIrwHnEaHSTadbHcSp
	okZ83iKkb1/96VZPtGy3K1YvOAIA9DX/UBEW/jOXquoMOBURjqU1c/oDS45jD797LDubM6z
	7bjZGWRt5QLWS7u0mH4k9/q+zGy1m8zgrQr8xFhnqb2lCsighsPo29mZ7DNkgfCPZZcFNsY
	DAYoCu+AvbbKcNpM2erQWQvQud3zZ/p5YnCil0WaPbhvZ3Vfcj9FG0u5X7M2odNEqqH/3fV
	w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Sep 09, 2025 at 08:01:33PM +0530, Anwar, Md Danish wrote:
> On 9/9/2025 5:39 PM, Dong Yibo wrote:
> > Complete the network device (netdev) registration flow for Mucse Gbe
> > Ethernet chips, including:
> > 1. Hardware state initialization:
> >    - Send powerup notification to firmware (via echo_fw_status)
> >    - Sync with firmware
> >    - Reset hardware
> > 2. MAC address handling:
> >    - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
> >    - Fallback to random valid MAC (eth_random_addr) if not valid mac
> >      from Fw
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> 
> > +/**
> > + * rnpgbe_xmit_frame - Send a skb to driver
> > + * @skb: skb structure to be sent
> > + * @netdev: network interface device structure
> > + *
> > + * Return: NETDEV_TX_OK or NETDEV_TX_BUSY
> > + **/
> > +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> > +				     struct net_device *netdev)
> > +{
> > +	dev_kfree_skb_any(skb);
> > +	netdev->stats.tx_dropped++;
> > +	return NETDEV_TX_OK;
> > +}
> 
> The function comment says it returns NETDEV_TX_OK or NETDEV_TX_BUSY, but
> it only returns NETDEV_TX_OK.
> 
> 

Got it, I will fix it, and also check other functions.

> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.


