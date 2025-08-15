Return-Path: <netdev+bounces-213917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B9B274C7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8DAA23A9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2A1A3166;
	Fri, 15 Aug 2025 01:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8C81ACA
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221540; cv=none; b=sJHz582BZEC3zMtNal2vrTWK+p7nQ2WSyTcXSrCUNEutqJj7strsh88XPbhciWzPrVkNWPBkoxVfgHCm2R74mDkPu91nDdHzVv2vmvS560oRmL/bW5uVfu9mMFas2pkB3xR7x4Fz7ij5L8bCmOR7eM1WPk29tVaz9x6IHr/riss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221540; c=relaxed/simple;
	bh=9sKiNJfyjngAIgU9d5CWTxV4AUcI11DOY+yK5q41XhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpVjombj0e0M6KacSDtIGVAIcr5XFfWym3ffuzTTzC3cd6IWah5R3h71Tl2g4WhXSxeIv9na1gEmelV2rVmAsfYnTGNl7vW5oYkoMnYvrajgAiJBp8zvmGCP2yROe9Hy1UjdT6Kp/83WIIv0GlwdVYeKlsRD2AARZT5uWYs7FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1755221515t7af4e635
X-QQ-Originating-IP: JF5mJYe+rP14nNyYmSDK6SVBxUoGK8zGerfLiLi6wCg=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 09:31:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6925513884918620857
Date: Fri, 15 Aug 2025 09:31:53 +0800
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
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <D19BDA0A798B918F+20250815013153.GA1129045@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-4-dong100@mucse.com>
 <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cd145c-c02e-40da-b180-a8ca041f2ca3@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2J0ax+MgH9H0ssRs2kI9Ad8wnUQ0rHIdavzTQS+xTbHiSEh9IjqyUIu
	IH/jsnxjlIHQWDiy3nx/LEGQ/oPJ3jWOmcQ7GlAU4YGbYlBgms12oqYK1pFOJ/Yo/nJtg+F
	pEC7PikKwcJHW1lq09pVuTNme1A/BQPdWOA3rH/XzIsZikrjtJO0n+ngp1m5hyu69zsujCo
	D8grJfLg2kWhEFtdS95BpWuLODvkKtfoi2Xp2g+Ts48EOb2aF55oeBbGwOJdYRcDlqOuc0q
	gNGFDXyCNuQrI/7cPfjoDPIzbFotTMT0srTajM5xuoif3PltXrTzcZPRWEOdTnXvbk8pp9y
	srROBpb7GFTgcMuNjt5sGeeEdg5rrIJC20b6V/ntqtOlUVrNQQkUw/7lmc6yihZZrupGo9q
	HGFmjdCwfmy+nJYlzUkdbiBT+0LzSG1uotyJVNhK1eOEHGr7pS/tcwfftlnp1qS3cF7tvv3
	9kuxngJ9N7PnBAEu+LTFpJpBODlOBPe0e7rO7gEaqO8aKZ5aQYvL1WGSOhksxVk3w34OKKt
	HzP/gv+ZKNbz0ou8Q3Uiki5m9xsS0ZFVf8loKZYNho+rk+vhop9doG+CapAtGALb4Ojls0m
	8rjAu6BdnE0SqA/wYHEbcvVtxa2Erz+eC7rg+nBNt9fHa/zuKd27SkLiV4cmbnGFRFDnbuY
	6iqfAtN6swdPEqTR1XlJqHPwUYE5r6rb3v0wB+obym8EtLaIbj0IkSd4YHIBqUoPBiQr6SF
	i2IlomGaXF7YhCh8BJ/G9vbkkmdmsBaG7nLhZi2T/+dyzCcWcYSrKZ7X4BlkyYs/kN2mw6y
	4oIVFUKjJDR0nCHnxl/CC3w5r0Lz0PuNJlh+AVb6hZM3Drf00LgsPK3W7Fc+UCTHwwmS1Gi
	z5tw51V4udFKfwGVwj2Pa5u3t204crT0tnMTCwK8RVaT6XpYvyTLGR46ux93BHueg4FSzZ+
	AqWz2RdtnYidG3QB9TbqH+m2Q7M7d8gCI+EerP4m7d7IyE0HQOyQbC4g2qEBGJPeynhH6ju
	Ilxf+vmQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 01:55:42AM +0200, Andrew Lunn wrote:
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	/* limit read size */
> > +	min(size, mbx->size);
> > +	return mbx->ops->read(hw, msg, size);
> 
> As well as the obvious bug pointed out by others, isn't this condition
> actually indicating a bug somewhere else? If size is bigger than
> mbx->size, the caller is broken. You probably want a dev_err() here,
> and return -EINVAL, so you get a hint something else is broken
> somewhere.
> 
> 	Andrew
> 

Ok, the caller is broken when size is bigger than mbx->size. I will use
dev_err here in v5 since I had sent v4 before this mail.
By the way, how long should I wait before sending the new version? If it
is too frequent, it might cause reviewers to check old versions and miss
feedback, link what happened with this mail. And if it is too long, it
is easy to miss the 'open window'....

Thanks for your feedback.


