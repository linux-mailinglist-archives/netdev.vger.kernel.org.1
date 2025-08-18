Return-Path: <netdev+bounces-214433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C0B29608
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC600189C688
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 01:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F322A817;
	Mon, 18 Aug 2025 01:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B92236FC
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479702; cv=none; b=g1u6dmUyxJH6ZfcOGHYCXcG+x3D6Lu+WwhFG/q7Xyu4qyeqG9QafNGdUpIuZIB3uYX/zPRfm5ctV/m63P/ur521TIqFMj7L1DEOlrlsaGI4Ey8I2R+w4UwA22r2POHu9WPvgdfV2Zb+8McnzsvcvPJe4w/0FLDxFVwwLdidLn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479702; c=relaxed/simple;
	bh=re+a3hWvgegvjpaptPnpkLKcIKZ7lfEQo+cdRQVOra0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU2YTs7zendHgTUXO4n32LW74N1YxZGB0XpLUlR3NwDk4gfgFcItEVLWyiAatuJrNcFye0V2P1rVKncKzRUeZc1WNvonOJmUJH7HlpdvUqp23VZGKyjLaBmlxntJrrcFiDCqygZEvQ2p3LdPGx/3KaEF+ruyHFXKgKJu5CLGQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755479679t304d19fa
X-QQ-Originating-IP: U+HouEQjyiYAmzyTLPl5BSeqSP+HEtl38Pp5dE5JTBQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 09:14:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10326870123005562293
Date: Mon, 18 Aug 2025 09:14:37 +0800
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
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <154C964FB97A8BAE+20250818011437.GA1370135@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
 <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
 <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>
 <ade28286-33b9-421c-9f3f-da7963a69d4e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade28286-33b9-421c-9f3f-da7963a69d4e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MFyAKqap4x//RpEpeccJuhJyZkL+ocQhhcx219bVkF0Fg27hMfFyJJy9
	qWqrRIwUm2enhnj04cduuf/IYz15YK9RK7RqksUM1PgSGCLRgrDvRivd0kIAcixnU4uJeZ6
	VRL//WotM0cT685i6fjscKf97wgtuJJpGHINfC2OSiYse3knAfwqKMoyniBLz9vlop8up3w
	7YTBmqCHyxlrENw+z+UkUxnq9PubDZcU8vXcKlmOZc97oOyXlMD68l2NnohtFTmZ0hXbf5B
	xYCQCo1bMjj0ajmpxzcuX4XJq58lPQWs4bIRM6X5luYYZ4lKNC224UNv55BAF3E0Jw35YuB
	7UeypyKOOhNd/pLiRoyIhyRO6dck06gQTdeq2s1QImwF/5938AEl8Wu/9nWloBqnAUF/NSE
	MDmkgTmcV+qHepXa2vtd1ecu1e4cI2JP5V2d9qRed7ZdAMFXK98VttgSmylRs4mloRMPTHW
	jCroF/eaDeoy9tXVdwS+Lja3r0XT6Zkjkl9hRDY5IVMu/slu4HWMGElz3uCY2XHwKfzlmo+
	spdWYgiZfe+QIpQsIKfSc20ObTHFZTBHxsq6TV4FyEjzO6TCZzwBjvkU2kunDoaqn/I7C1U
	ol5f8TW6GSQRRCp6QC3KJdvu0OIAbcuQfFoVcjtjFqw9CrPiPW/PIs1k/bYNvjAhePeXpoQ
	lUHhfaxNzXMibBm/s2y+huFcV9jLpPE+5b25tUN1CirPd37e7uXlRJrQJCgUG7YO5k70n/j
	e3OJtjF4bdlrhtxaIPhMi5Q9eHBn6bLgo7MKOsVmktKFsUltJH79ClGAZwI8B1AXb7kGLWS
	iy/qMRXeCgjbeT5NcyaB/r69vI8JIrwyFo6CMLQGf7Tnc+W0HcMBhQR30q4/aUrX8uHINhC
	ERtNKUqp9R9Y4YiR2YD7g319iiR+r6MxHpohq7+zqoE+X9TwrqyRDUZ1beS0XJ3mtxsktAC
	FQtCKo7dLJ38cRq+vuJre18kUuCMTffz3Yl8kgm0APrOJl+MPPjEa3lg4sIyBtfuF6d/d6C
	GZQioSGr16v1IZSg6uODGjRonvG9CVmZVpTvfVRt7TTA+erAzLnOKhVnISvgkO2+/uIH8w/
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 03:36:10PM +0200, Andrew Lunn wrote:
> On Fri, Aug 15, 2025 at 03:21:03PM +0800, Yibo Dong wrote:
> > On Fri, Aug 15, 2025 at 05:56:30AM +0200, Andrew Lunn wrote:
> > > > It means driver version 0.2.4.16.
> > > 
> > > And what does that mean?
> > > 
> > > > I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> > > > to echo 'driver version' to FW. FW reply different command for different driver.
> > > 
> > > There only is one driver. This driver.
> > > 
> > > This all sounds backwards around. Normally the driver asks the
> > > firmware what version it is. From that, it knows what operations the
> > > firmware supports, and hence what it can offer to user space.
> > > 
> > > So what is your long terms plan? How do you keep backwards
> > > compatibility between the driver and the firmware?
> > > 
> > > 	Andrew
> > > 
> > 
> > To the driver, it is the only driver. It get the fw version and do
> > interactive with fw, this is ok.
> > But to the fw, I think it is not interactive with only 'this driver'?
> > Chips has been provided to various customers with different driver
> > version......
> 
> They theoretically exist, but mainline does not care about them. 
> 
> > More specific, our FW can report link state with 2 version:
> > a: without pause status (to driver < 0.2.1.0)
> > b: with pause status (driver >= 0.2.1.0)
> 
> But mainline does not care about this. It should ask the firmware, do
> you support pause? If yes, report it, if not EOPNOTSUP. You want to be
> able to run any version of mainline on any version of the
> firmware. This means the ABI between the driver and the firmware is
> fixed. You can extend the ABI, but you cannot make fundamental
> changes, like adding new fields in the middle of messages. With care,
> you can add new fields to the end of an existing messages, but you
> need to do it such that you don't break older versions of the driver
> which don't expect it.
> 
> Please look at other drivers. This is how they all do this. I don't
> know of any driver which reports its version to the firmware and
> expects the firmware to change its ABI.
> 
> So maybe you should just fill this version with 0xffffffff so the
> firmware enables everything, and that is the ABI you use. Does the
> firmware have an RPC to get its version? You can then use that for
> future extensions to the ABI. Same as all other drivers.
> 
> 	Andrew
> 

Ok, I will fill 0xffffffff in mucse_mbx_ifinsmod to echo firmware.

Thanks for your feedback.

