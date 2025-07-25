Return-Path: <netdev+bounces-209996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B8B11C08
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B15AC2486
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87592E7180;
	Fri, 25 Jul 2025 10:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62A2E1723
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438333; cv=none; b=iuqqtw1ktK9nobUY3Z/83u5QIzyL6DHFJPyIE2S1Uybs2kS2Df8HJsReODO4Yqton+XTJ7ZXSPLoqw0i1cS54KVnml00GiiJ1JXnLabPnWkRjfqLo3+sfGmk+JOS18S8MslfzulvVUY2kFfkZhk8j8O/EEZ1MrBhC8Ewg3302ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438333; c=relaxed/simple;
	bh=kRroiVwN8VC5mjdK3a+UEFHGD7+4HV0iLUxuCRe43nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEbhUI2edDp2Ruz52y6yOF3nJqIRBRRPJnvcGKodGXnFuzve0+FB89/usJ0sayNHZFL/VUSrTOtwS1VmhG5Xx6lxm/LGeO66a+6BqwEXubDBHctZNpRYLJaJd3DAK+fN3vSDsrbkERMQFyQO2jAPvxqQAm5ACFDv9VZOzThmaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz1t1753438310t6f10c101
X-QQ-Originating-IP: hrXMJrjX1v5SmrXvU/RFaoTkBlV+D++VqopZO1o9Pdc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 25 Jul 2025 18:11:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17354701733030372774
Date: Fri, 25 Jul 2025 18:11:47 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <B257A91F74F6FCCD+20250725101147.GA365950@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <20250722113542.GG2459@horms.kernel.org>
 <78BE2D403125AFDD+20250723030705.GB169181@nic-Precision-5820-Tower>
 <7d191bc9-98cf-4122-8343-7aa5f741d16c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d191bc9-98cf-4122-8343-7aa5f741d16c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MyirvGjpKb1jiub4PmCgIWUaNX5sabUujGEqnQGZoo0cUbpcgU+pcYQk
	tpxNJ4eBKDd9/0C3TJI1Q1JV0GkyRKDHjHSY8mEQ7o9gtp0mmu27KRGgJf0GaDzs1g5CRgA
	Ggt54pF5KH9GiG6sjok4TKXp2ajhojBH6XscLeu9AnTJH8MjOTmRO0k7xnS9D4EOwNZH7Sr
	1/mZF4T8YlLDlidukjRUR2Ggb2dQ7s2GFnD/cTW43ncRHlryB7oo/Ss35RnbE4NmKuqRfKl
	wI0LtP6VNOmnY0qPUjnR4emHgDECd0WuqNxjVq1yB2t/O2nTSxTr/9msGfbfIi5O3ImDO8g
	hhyiKntHxc6p94xd/goXEO6dRoqpOb5qqo7EEiRdUIigR3ifnTJ/wsvyCYnkrH5eCM+Fucm
	TclxbYtIouUVXQzyo7ZYIzDqBLdioKzWiEJhzq78gK9eO5UJQDIShR1POXI+dI52gqX99l7
	1LcNp4gnj7hTRgfccpYhGmuX3Kjsu8W6aqUj5DKdEdpEtpjxrIW/O76Jl/iHT8F/bCuzWnS
	gp8+nXFCiUfDnFQt1akqTLpCtv5X9KkD+sLeMMAAJCTvq5xeIFoCXo0Au3mDM3bDws4qlxA
	BULqJF+naB3RdDlNYIr7xD5dg3JwNOCDyZzhBXsksILcHIloc7Do2lk/nsh2FSGr1Y2z9dc
	78nfRmaB2OYHz5gtlRyvtYeZLjhUqCJvlivgDj3tRTjriUE3uABZToqyeW6BBJPzlThVu8W
	zOBsSJIAgElYSLfs94RYp34qkQxR33oeNyhI7gMieQ4ViiyrxY9pCHWepJvUc78doyeZ1Ex
	qwdhQdcbSqYrO6hwJGljuApS6mdYNoXySPS31d7+Hkq/alzUKzami09sXnu477et5zt221Q
	W3Bkd8Gjef3bmaKmOY7anrrXlnp+teavqpTyo1qO8UXoegxFw0Bv8E2u74E5f2Vd2D2x9Zo
	M5o8uTZFBmtO6xuXC1G1l3qNK87dLueqK7tCu4K/XsL9QuNeHOc4iXfUx7L4XbhPQ160Eqt
	Nrcf0U9b5lWuSiNe3iIXgvpbtaoeJ3VYBz4gF4mg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Jul 23, 2025 at 04:38:00PM +0200, Andrew Lunn wrote:
> > > Flagged by W=1 builds with Clang 20.1.8, and Smatch.
> > > 
> > > > +}
> > > 
> > > ...
> > > 
> > 
> > Got it, I will fix this.
> > Maybe my clang (10.0.0) is too old, I will update it and 
> > try W=1 again.
> 
> 10.0.0 was released 24 Mar 2020. That is a five year old compiler!
> 
> Try something a bit more modern.
> 
> 	Andrew
> 

Ok, I have update it, and got the warning.

Thanks for your feedback.

