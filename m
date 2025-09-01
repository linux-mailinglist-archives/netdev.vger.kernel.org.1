Return-Path: <netdev+bounces-218593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C739B3D69A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 04:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61177A3E54
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F181482F2;
	Mon,  1 Sep 2025 02:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2A323E;
	Mon,  1 Sep 2025 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693137; cv=none; b=F/9gG/HCXjIYbeIN7yVxCLO00sYueHO30SOcIiyMl+3/2iNL+7TSBc7b0zveuWDRiCMbi1sjzbJNFZ133ypXvS9RZT3ebP5RxJpKKaH9cEJBZSTZKGJQGpmzplvM4y3mTSVrawbbq22ufVHBPt+YbMdZPmcamqk4HfSyRVimkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693137; c=relaxed/simple;
	bh=l3G0qHAM4WT8AXO5JVFutlptffSlEQXTIdxKQUT1hhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF0RTsfMpNV7SYGoU3fA26M3RR6+qrqZ8xY7gy2YWR3aBf3wZsoxgAnn/HZG6YJx2adzRVCVroZBZIKWIHsAnHsWJBvpnIqUmzdfli0/Kfep6Iw2BRyzPhCr+l2nuW75WkVFm/rXheeVPobGkE3xCEphVkorZ6+pPznT7DYOQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1756693105t63f78bb9
X-QQ-Originating-IP: AlFXuqCpeK5FT3bIkgeoOb8S+ZD0AByeYpc3IJFsmYY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:18:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3786511421050913974
Date: Mon, 1 Sep 2025 10:18:22 +0800
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
Subject: Re: [PATCH net-next v9 5/5] net: rnpgbe: Add register_netdev
Message-ID: <5A57083856F7D3CC+20250901021822.GB21078@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-6-dong100@mucse.com>
 <e0f71a7d-1288-4971-804d-123e3e8a153f@lunn.ch>
 <A5B215AE5EB4FE9D+20250829023648.GB904254@nic-Precision-5820-Tower>
 <6768f943-e226-4d57-b3a8-692aff4cc430@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6768f943-e226-4d57-b3a8-692aff4cc430@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OKpEC/bXOl3K4aIDlsEieN2HqZ+6UhYrCxWNhtjbWXx75Xs7yXJVFK1M
	FqBwDXrv4zlv9R8VoJ+qK6PA0VX1r8WSfkm3fzwf8dlaN3+eV0agA07G3bDFm65rhrseKk0
	HX/RtIV9pW+w3cMPw3xtbr0+DAtek8r0hqoxnQ6be+mTNrCPPgOBqzTg0puNFH9RLM+wkSY
	iE6z8S67VKalizRUcOmiOwe8Tx6lBzYdRvJHy5C+jWoZgAn7/k+f0+kyNS4w/qHsX2a7gJT
	2U84pAxNGeBmAlNdjNqLnibpnukhlfEiVD1RlP8Oy6DKmLDmVjgrCidglmppcLH215no7SK
	n2ToBvbfNkEqu39e/Yl71qkHONHc84s9AaA/POaz2O75J2mz//ymF5ibL7yLMdfrXYmBnq5
	++kS5XahKD/1bT4SKHGj9CMleWo7IW3GTVFdlz3eMzxoVCgHKIVcSmr+2YjSIhX9qOwsoA/
	sPgdrF57gvwnDzxD2iDNwEAlVAobq289C8pBGsdPMHP/t5uSmJi8NBPQLJocH1xkDfOeBcx
	i4P8s9ytBF5ApcqtmROZjsgn9wzOILHh4XwUl5EIRX2X7tkS8htMLJyR2vSylJK6/fJC+Ff
	CuziqdR/GXTlx3N11HqfXoM9X74UCfaATcCyPzA/wVuePs50dkRpZEk7znJkNmT8x3Wo2T9
	d6P1cBmPpBBbU/99mjOBLtThHoArJ5pSFw2IPYZVx3SrFpASackTXp3h7wJItSxulQX8WAI
	ughAtT246qWV/6AzbTt5bQC48axwcgf1DExwCCy5JvM255x9lFBICXxsaxmiYP/hJI67voR
	DyL4KzQftPZvxRLei2mJcEWBQIhFIBfzVszW/WVSYCpDndb0Lap3nlYeqOvi4jsY+4r/QUK
	41u4mPxVCLXj7lj6o3F2WmfMBNHfHvUak528Kl2v1NHak5MPTwHAbYnNKo0hijw6dnXDRI9
	QG+OLklXpmQJOQj/mJxpD7sFnU3APpxxS/kzlhqInrwUq9gXdrHElrSs0+BJxDKAA+q/1D+
	BJVgmPvx+eAVj+R6PHmkjWPTzF0+Eh4zXhnzEs7epDcsErkYUW
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 29, 2025 at 09:51:57PM +0200, Andrew Lunn wrote:
> > > Back to the ^C handling. This could be interrupted before the firmware
> > > is told the driver is loaded. That EINTR is thrown away here, so the
> > > driver thinks everything is O.K, but the firmware still thinks there
> > > is no MAC driver. What happens then?
> > > 
> > 
> > The performance will be very poor since low working frequency,
> > that is not we want.
> > 
> > > And this is the same problem i pointed out before, you ignore EINTR in
> > > a void function. Rather than fix one instance, you should of reviewed
> > > the whole driver and fixed them all. You cannot expect the Reviewers
> > > to do this for you.
> > 
> > I see, I will change 'void' to 'int' in order to handle err, and try to check
> > other functions.
> 
> Also, consider, do you really want ^C handling? How many other drivers
> do this? How much time and effort is it going to take you to fix up
> all the calls which might return -EINTR and your code is currently
> broken?
> 
> 	Andrew
> 

Originally ^C is designed to handle '/sys/xxx’, and as you said before,
'It is pretty unusual for ethernet drivers to export data in /sys'.
I should use 'metex_lock', not 'mutex_lock_interruptible'.

Thanks for your feedback.


