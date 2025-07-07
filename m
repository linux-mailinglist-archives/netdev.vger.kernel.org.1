Return-Path: <netdev+bounces-204449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9ECAFA943
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DF3188BD14
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5A1A8F6D;
	Mon,  7 Jul 2025 01:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318D1E379B;
	Mon,  7 Jul 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751852032; cv=none; b=i2NFzkcZUwfwEtOFoVC+0eBTjoqvL526oc78yORTJqxgTy/H9iplFFwITyp9z7yg0ILiNxRKiTzi+ex2tUzb9ODhUZRlzcZqi/BKKlSTRpy4fEIOHsEcPXET/GSxUyEtpemJA0T046v/AenLOeG7acCfAdoqFTzdPjt9X6Be7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751852032; c=relaxed/simple;
	bh=MciWweHvQB2NtpzxZf2w/+oDgf2sdTGWiZTywc435t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEh/CfXnoRku4Xb6cNwn8nKazcQ/rtsWq1IDjTYFCO9Fah6IpIvQdeFQaxy8H23QMi4GI/wr6wY0PcRAZt5NpN3K3PqT5X+oDwHq6mjp+IbOVQCiWa6f2oZiwlGz1ZlJvuG+/srvla45C36Jd4RpAU46SQKmhWDmWgh7uEY3gpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1751851963t07aee121
X-QQ-Originating-IP: qa6YJhuflzK+wHht4l6gRJZFvUQBoyK2hYypibZViIU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 09:32:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10452172534868935923
Date: Mon, 7 Jul 2025 09:32:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <0412FE867055AD77+20250707013236.GA122831@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-3-dong100@mucse.com>
 <3d0a5666-c57a-4026-b6a1-284821f25943@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0a5666-c57a-4026-b6a1-284821f25943@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OHTF91J1Rz8hoMMIA7Duh70bMvN4qNV/yNfMxMdX6l9I5zx5RegTJj9S
	t0vp5cwkF9KuBpMn/ZSxzQXAfxdQwcqQvejWBmZjRjsJhaI+a0pNAL/QELutMSj/sDpykwl
	BNwpbVgqyQG6fIEdhMFuuJPmU+CB6j/9Dmsx4FrQyw9S9P/BwXZ4o8E0o38klYErVKtbP/F
	Ggja6hjdMCF6FKcI0PpTG3OZSQQe4s+SJFoSt7Bjz/02kjH7ZjpxdZigWMuVBZUlloNj8Y+
	aOXoFI+7YQleoix3HLLyQhnFIHn4q5kJuBWFI3YR1MTaI/oyBAES3eTCJsTnVhTOUeVlpNq
	SGhmLCodELvJ5WuGhrAie9ghl5K4GAq4wfcDH1uQgy9E07l536DttTaM3RmcA3FhKxCyMxg
	qjnPHxPSjQezMiWToTse2hdo3J5gTfrfP9YyPPbwckpMYzLk8hvLmFxh1kf2E8YNlc/xUDP
	/4wV9FAZ1ITH/E1UMA3lb24+/xt1TFz+hddgtQ2Ze2yIeCMO+4uqxJTCu/sDivroUfqOPFv
	y7iD6hC0uIlH45YoKTUfqFqScvgnyQcHiFahRxWRwBbp1jeHybhvcHfkuvusJTIvpDSjfFS
	Xg3aPBInFgzQRYd5tATbpbVKArlyjJglMOpoTbToWyzRFWV9rLoKYG2eXs28ZUJOmUf2LQl
	ZXR0A2WxKtpkER02Yt92k3SJGuGxIklxhFfWPSgjOdZcibsWlSYC2xyfr7EcCPInXpza4sJ
	Z/MxPbDs9xQpXVGuf+8j4agJzHoRelLvf1gwWbsuV+fPxHUI7wrR/BDgYETVKz0g4nHzfns
	CqNsZgWK4E5yXqqb7IoOox0uJrlWiY2Uh2fSantZf1+w+db5x4nqqIPg8tghBwUZ4O/iDKQ
	TA2VHVCG43j5xFKpAw/tqLU4/sZLmm3U0NQS5VPxl5jBgMc9bFqEMLSr/OvgSZEbReiy+FW
	I5PFm5dyxvIMLZ38Di+5YJSYf
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Jul 04, 2025 at 08:03:47PM +0200, Andrew Lunn wrote:
> > +#define M_NET_FEATURE_SG ((u32)(1 << 0))
> > +#define M_NET_FEATURE_TX_CHECKSUM ((u32)(1 << 1))
> > +#define M_NET_FEATURE_RX_CHECKSUM ((u32)(1 << 2))
> 
> Please use the BIT() macro.
> 
Got it, I will fix this.
> > +	u32 feature_flags;
> > +	u16 usecstocount;
> > +};
> > +
> 
> > +#define rnpgbe_rd_reg(reg) readl((void *)(reg))
> > +#define rnpgbe_wr_reg(reg, val) writel((val), (void *)(reg))
> 
> These casts look wrong. You should be getting your basic iomem pointer
> from a function which returns an void __iomem* pointer, so the cast
> should not be needed.
> 
Yes, I also get failed from 'patch status' website, I should remove
'void *' here.
> > -static int rnpgbe_add_adpater(struct pci_dev *pdev)
> > +static int rnpgbe_add_adpater(struct pci_dev *pdev,
> > +			      const struct rnpgbe_info *ii)
> >  {
> > +	int err = 0;
> >  	struct mucse *mucse = NULL;
> >  	struct net_device *netdev;
> > +	struct mucse_hw *hw = NULL;
> > +	u8 __iomem *hw_addr = NULL;
> > +	u32 dma_version = 0;
> >  	static int bd_number;
> > +	u32 queues = ii->total_queue_pair_cnts;
> 
> You need to work on your reverse Christmas tree. Local variables
> should be ordered longest to shortest.
> 
>        Andrew
> 
Got it, I will fix it, and try to check other patches.
Thanks for your feedback.

