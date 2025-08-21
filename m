Return-Path: <netdev+bounces-215443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016AB2EAF9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942481BA240E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE225A35A;
	Thu, 21 Aug 2025 01:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEB258ED7;
	Thu, 21 Aug 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741199; cv=none; b=qYZgmQ6pxMTjMaMjXYxaOMYI0tPC2GN07Hwm+Aq8KVJPuEiuyEsULqbeD41qKwZpVh5pWBlxwePu45aJnA5mVDsAwA75Kug6QlGUqccKEi1prV54WReU1WFEYimR8TVI7sl63PMhreFL70quFxvNK933u7Gmp4+HtQKPBp59iK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741199; c=relaxed/simple;
	bh=cx5YUdGMO0svEm7a/UadbxDXZqCmBpAVHoAU3bdhdGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0OgywwcIjB1JRmO5i4u5zIeFnE9MfgeSDFr16O4CH9GZSg27jeER2um5Wqtfh/IAMd8IOcCZIh7dpHah+A7q6PoFiwH1KRG+7WxUAITEnG/xBgZZAH4/ibFQ7XHi9c2PlHMO0yTM4UH/NfvdP7c/cvYYRJpb/RVx6r/E+a234w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1755741186t3b5f08ce
X-QQ-Originating-IP: jz3qN019iMHA861p4VQp21bgDluXpW5XD56RTS7CiPM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:53:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13122141616914188234
Date: Thu, 21 Aug 2025 09:53:05 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <4E76D5F5691FF908+20250821015305.GC1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
 <d4a84d76-8982-4a9d-a383-2e2d4d66550a@linux.dev>
 <78DD9702C797EEA1+20250820014341.GA1580474@nic-Precision-5820-Tower>
 <77d89708-19a1-4394-bd6b-ca5aef6bafc1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d89708-19a1-4394-bd6b-ca5aef6bafc1@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OST2d686M2k2FvKF74kfwoElwBaRjyAts83XUAM/gK8fIK32u5JfF6sV
	kr+CDvDHV39S7SMR0hssCX0YcIC4PdEaq28J//P1s+hPc9AtkrOsHcgfyJUrmIbkS2biY7D
	+QtRBYPn98t6W844jbwOaScItYL3ewiOLtZT/T+545JTZum0W4X2TxrGx834BhgCKRWFEXM
	Ze/H+CA944Ewg0fsGk20turXOhgqql/uJ3qpNrJeFN0oKEtdTyIWgRnDjd02flXCUdYl6Rp
	Aud5PqlJGyGLi4bbUOontDVXWtumBNlvTaWNJRrPVWbKw5p6RusFhzCot/nz4w3iUdfr7J8
	nagY6Tn4YS9SoQJMEJdn0wdtWKnRD2HZ2oQR/BVrbCIFFST9MpnfgDH1nuP3Lx9HcsBgCQV
	wUGkLNv5wgBjzufwMwTEAkDdKWFukHQv25vDVq4X1Q6qj+Yyl2/1ngj+gKKyouHxpRlbXdS
	2uK9CGPBAi1VLXGZY9Rxazw4or5yucasDxRebtcY3qO0eENZMbnPH8Ff6wlBTdkmG+Pc6ha
	MbPsOLbkqu87kZvUOY1bvVtiJ5rjRH3zNBGHAiucID/Taqw8tBYqY5/fnwyoqwX5Hk0jRMM
	cia2BOZ6lLKqN03EeimJmslJe2S7O8/SoJzyOLqIa9Oshqhgc2Z2l4ZXteQJ+B46akDgLTj
	WE/3veOBaJ+VEY4/sna7cBrI1EXfifcpjJ91oduoyHHojGD7n3rQnwjg/fKox3UmM11u2TC
	nADBVZxl0/nY4hXXJLmiWQeeozUEyrrIoBEEsl0YzQzRfWAlgmJyPvZEiEDlOi5Nb39YZPz
	W1RXKelxibdpjGZQFJEqZPnrH4Xo34ZiXplEBMDFiEhwL5bKev0O4xQSTRtCocO/awy73BB
	eXaD8YdXjsQGDv7QNBIA0rsXRPBU5x0Cc6jZ/cmZs4vSvuzp81a+iDqiWlsbhd1s9Wnek3R
	vlZmmSvMh8RyIm63MVmLsZXwKgDOEr7i9jkrlyfYIY3ORsUaQO6bzuGYCJleobQDjkl4jmG
	6miFopQcK9sCqWdCgGDi5t4sMzrm0=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:10:00PM +0200, Andrew Lunn wrote:
> On Wed, Aug 20, 2025 at 09:43:41AM +0800, Yibo Dong wrote:
> > On Tue, Aug 19, 2025 at 02:59:09PM +0100, Vadim Fedorenko wrote:
> > > On 18/08/2025 12:28, Dong Yibo wrote:
> > > > Initialize n500/n210 chip bar resource map and
> > > > dma, eth, mbx ... info for future use.
> > > > 
> > > [...]
> > > 
> > > > +struct mucse_hw {
> > > > +	void __iomem *hw_addr;
> > > > +	void __iomem *ring_msix_base;
> > > > +	struct pci_dev *pdev;
> > > > +	enum rnpgbe_hw_type hw_type;
> > > > +	struct mucse_dma_info dma;
> > > > +	struct mucse_eth_info eth;
> > > > +	struct mucse_mac_info mac;
> > > > +	struct mucse_mbx_info mbx;
> > > > +	u32 usecstocount;
> > > 
> > > What is this field for? You don't use it anywhere in the patchset apart
> > > from initialization. Maybe it's better to introduce it once it's used?
> > > Together with the defines of values for this field...
> > > 
> > 
> > It is used to store chip frequency which is used to calculate values
> > related to 'delay register' in the future. I will improve this.
> 
> Maybe also see if you can find a better name. count is rather
> vague. Count of what?
> 
> 	Andrew
> 

Chip use clock cycle not us(microsecond) to achieve timing. If chip is 125MHz,
driver setups a register to 125 to get 1us timing(125 * 10^6 * 10^(-6)). 
Maybe usecstocycle better?

Thanks for your feedback.


