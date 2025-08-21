Return-Path: <netdev+bounces-215444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB56B2EAFF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F61A0408D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372F25A2DA;
	Thu, 21 Aug 2025 01:54:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FC1E5B70
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741276; cv=none; b=WwfrsfKgayT3yYgXJDbXPo7Is6YudhD5wGrKbfIaP50J1oPo1e08t5y1sd+oIHa4VLWnpl/3o5Nqx6YBsWHvLI3jo33vE5QC4zO9L+Dm8XerdZZg7ek3+1HakVUsdQ3w+JMKnVKLQ7TpfV3Z1rfrtIvp85uSrdOSEMqB60D8mC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741276; c=relaxed/simple;
	bh=Hjt2XKIqo3+Dd1a74qTezfLIh4/05/HZfR0EMUnHXBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spQP92l6Qn4igCuiqT718f8xJPi4m8ggWNTYkNC7LBKwBZ/XdWkenFapR0TbOKtvMpzWh81N6PvFMuox+YaV5ZpKB1lO01h2x7oyiNyrMYC/e9v2lOKfDsAQhYHmpTsb/to1o/SUYH8Mz3/urRSXOSHxIJlBgxvpapeD2nuqsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1755741264t689e7382
X-QQ-Originating-IP: U0fEyWnwHg6dZLkemjeK4dcZ8M2S6VxDy3X/6ajZ+TY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:54:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3627118193617159813
Date: Thu, 21 Aug 2025 09:54:23 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <B6794BB31A93D48F+20250821015423.GD1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
 <3e5e73f7-bbf5-490c-9cff-24f34d550d24@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5e73f7-bbf5-490c-9cff-24f34d550d24@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: No4GWyI4cWt68cK1ENtfPIAGtcHLk4MUfQjDRJagCpBBXDI945mtranl
	W6UrbIN0TAaIslu5eMpXm1AMzHZjFdVBctV8ebKONDAStzmQEqoiLczRdZFTkARr1VMoSzp
	wy35TA1gBySiGYAmulVecp1YOJHs0RE+wL+7iyayvHYD5oR8tDLlZIgIxEYkdED3lObFW4C
	LbAQwlMGgPj+WLCEmCAr4BNOTkjn3olbjHVdbUU5cWvEzHqEWdX8QfdI0xfUdru8xx8c7vg
	CGCjsaWf6jaifP61C+IVpddDwCkYxhI0OnAqXR86LZ+b+hfm/uNAPrBr5Ltx2P7Np/LmCm6
	0jR6xUbb7KdHRfrIttxlTSl4groaaXKQsgRs99gqrWDQQE+YCgJdNloCt8cMAvKSzNn8MH+
	zs1CvIpR0OYnix0sYPHAuJ4U9c4ACVfuryc7evzPqplGOyVJh0gsS1+ZwdmXsAE9FbdHlan
	jUN+8mjTIojqEQMbRfwAUV6FnUPrENjYalmUgTrkfgOI20xGWddYcWwE34VNvGehCAmsL9A
	Quk9VyICJ+GRcu1nXLg4tjyCAAca9j4cRjOfxQ4QAUTFuypUHefRd20UfrkDL7athbwXjOy
	8QC/46LpdxjMUGav3N3Gtets8XBIrd4WDaKtD+B6TDraXtQvshbBakB9BrHgMcwhOQVEHV3
	h4C2ALMeyhsIDy+YWRuD1CE+6+rw6+GV19OBM8CaXaHedonokbbpRCOTGZq0NijzzzovpBa
	AV3IP/o8SfRctstaTAuTDYFT9Alyc4cEbZ07FG0XyJQP6FvnWG8lObhAnyTLGmzKqA5ThDb
	GlsTMDx7OyBnsBPthDAyF9N68oodIzf/vRQpuzycTLmG4zz7ctFVgmWEnv3dzo8Rs0hIRQD
	78MnJM2B4fAUg5nib279v2fubvaBofW1IxInH/p4QxzIw+TsXF737lSSn8XoR6qba+KCRP6
	z97VH4vMNoQ+b1sNyOIeFYLnbNgZV06yKYxc70vi0lc5gHUkqnX4rrMyJD1Sdw5RXZHmCqA
	R5d6OzXfoB4N/bkfiMKUV+FwMXaHd0JVTyar7UTQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:16:00PM +0200, Andrew Lunn wrote:
> > +const struct rnpgbe_info rnpgbe_n500_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n500,
> > +	.init = &rnpgbe_init_n500,
> > +};
> > +
> > +const struct rnpgbe_info rnpgbe_n210_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n210,
> > +	.init = &rnpgbe_init_n210,
> > +};
> > +
> > +const struct rnpgbe_info rnpgbe_n210L_info = {
> > +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> > +	.hw_type = rnpgbe_hw_n210L,
> > +	.init = &rnpgbe_init_n210,
> > +};
> 
> total_queue_pair_cnts is the same for all three. So it probably does
> not need to be in the structure. You can just use RNPGBE_MAX_QUEUES.
> 
>     Andrew
> 

Got it, I will update it.

> ---
> pw-bot: cr
> 

