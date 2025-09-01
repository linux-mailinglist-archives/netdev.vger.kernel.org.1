Return-Path: <netdev+bounces-218649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C259B3DC35
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8365818962DB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A726B769;
	Mon,  1 Sep 2025 08:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B323B632;
	Mon,  1 Sep 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714884; cv=none; b=KRpCQeuiN/A8W8FcH6G2xhZkHM2nPzHVPjKyYkfdntBCL6OJlvw3Q6oVaTH0PW2JYr+6mfLQPWVRu953A1ESPbVCRkVw9sLSl2K1SzkybjshciSjnGPR/hqFDduMWpGE9sYjZsEwDLPUeXVQl0WpRupqX43IwQVMDRWqM5n/jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714884; c=relaxed/simple;
	bh=v9fif//9C7xOO7pC2ese9vUbSP7DolrbV5tCB3F7bCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp4heYt9nTRFLmLUcRRsTrxcDR0f9CYwfpjjrOWwdBBcvaNZfHYxgmRE19w07dnk91HVaXOe2se8PvB3qwnc8RMhx1ypDHVJ7u5JH81ZxfqOV5onPxFIV1PPt5FeFkxwd/KwjejOXhbWZbTDBF3541pZo+8BxkTv9hw2pBAtW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1756714854td02a6ce6
X-QQ-Originating-IP: OVw0v/uv0qvupYGv9rfV7KCl5TmY2GA9fodwbrC3cXs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 16:20:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15377409509470357136
Date: Mon, 1 Sep 2025 16:20:52 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next v9 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-2-dong100@mucse.com>
 <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mf+wQkWJ2TuYoRAc945Q+9sbZ49S6jt/KM5fyBReB+U+2FoPujaarpB8
	zss4KX1w+2pMKdqIDdd1JEXbl/iDzSB3kS2OfyHoDbCvTdOj6F72wdsHC+0p/OoGP13fFSv
	h+LqJQ1aEojmkkDaK3COnTTaGOC8QP03drw/KohIZGCGKjod0ScPb/o8/htSCKVSSwXxKbk
	CO+7ISjmTTRONTd/i9Qyg2xcbwSMpFNmGdgHuiZANWiy1Bmv7tK6wkhSAEDtUlVE0kHkBCS
	nO+I35axIOZSe4SYKcOQvr7OGX5BnX/KQMb27MHtmX8mS/SpssqR4FrfGknUwscL5a12Iej
	WEf0Jn+AO+jfjozmqJG07EAmuYu7uIWiO+CjzDXqbVbBifTnstKS2+iiAZzaaNqmLxrpl5w
	v8XwfmAWqNuyIW985LW135FJWQOThhZXpPt2MJsHmdcR1Pp0LeNLTKmuwrn38VJLTG5vphZ
	v7auNT5Pam6JCwilXF1P006Qzfqt70AWzRI8HFdn1ah7njQX5Zc0UvCMZvLFBGqumPc0tGD
	JJz1i5No06PpLEb6iYtvAS6aks3MyBXXVlSRLxe2u+jfDoAD+N58cIgsY/dTmkl0cw2vrE9
	FarE7E7BNtwSMrixwCbWS24C/5vi/i3/sm0E0PZnfG7tzCF8W7W1MvHk9g3p+aZYyNkwSlL
	FglY8Xd7Hx8ylDo6d7RQfvISZ2jFoeUvVYKWTtvBtb6+hQ6+Znk+HFQaU5xLR2WMX8ceQJz
	iNovCG0XMse9LNhhzun3Zcvto5XjrP+kxoPqxnFqQce3PDjzLdpMAlF+73D8z1wQt8fcYRc
	cDzY2/5I9YGaRBN+xp/p0FKrKtWZEKv2hrsNGZcG9rrx0AOcefw1wXTlEW3xEGERTqiBd/Z
	JrdVXvkXSl67jZpc8TUuYgO+6yA4iqD6QlOhl73W9fTXqbo607UecT77CKO6OT8j0dpj8FY
	6NwUFs96OMHTAHfV9lKk6t2s0BkB3SLN2PdaB5R5C8L6UjTinIVonx2jNHI0rAlAHk4dHlo
	iZ9sLteg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 02:51:07PM +0200, Andrew Lunn wrote:
> On Thu, Aug 28, 2025 at 10:55:43AM +0800, Dong Yibo wrote:

Hi, Andrew:

> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 

Should I add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>' to commit for
[PATCH 1/5] in the next version?

Thanks for your review.

