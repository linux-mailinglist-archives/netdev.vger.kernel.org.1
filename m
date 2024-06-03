Return-Path: <netdev+bounces-100113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADD58D7E6E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17696282FFC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3487E578;
	Mon,  3 Jun 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GEi6pGeA"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B153392;
	Mon,  3 Jun 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406677; cv=none; b=e0bblhG1Km+ouwtnkUhAV+hpxjtQ4aIBd1BCvE1C3xkP3jK13o1aShAZA1WK8t/HwwZLvkmriOywkLbats7DV/NF8T2jZ5e8CiBrUTxLy3WQzRrUKbhOqAx7LF93V0dld0dnkHbadIYvdqwu2Ui7fFTWI7Lut0Wf2UkB4USsHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406677; c=relaxed/simple;
	bh=sZV9sGIYSh32X5aVunx+X2ZqSTjZPK2NT/Sq952/+IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0raopD2Lhmg24eKXHKjW0fn8+gm3ktbMoT9ErwfQkpcJqIq7t52WmA4zZ6MC3Ure/oOcVt18lNJTF11lDf3X7ETXuv2NotEMfzi5yDtQgUwlrd2OxSRymqe9gjaealHqvkC/mH37nCRhsDv7rH3ncvKcqbbzrnSDoGzbLVkPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GEi6pGeA; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=4BPrmksCSYYF0YoAvQOx1MdXjMUjY3TOtCFspO/clO8=; t=1717406675;
	x=1717838675; b=GEi6pGeA0SqqzsGnSeST0BR+0GEbolCOMP5GEQFl2JQUd5NmU9WWNsx+tsS5Y
	woa6oQUtzS89cfn0gaplwUVd6sKIwT/479LlWPhk4cgPvh6W4IJ4TUj39lhgZThHFCemHo6YHrfJF
	K5WwWvr12ERnK+1G13eVUgShzsRKdfWYRMuwk7xr2Tuxndnxu4p1o5H4YNC1IK1QuxLwMdST2JFuG
	0Fy4V8TlvIawALgfBD/PrjdEla4UJT3fBwRqAaQnBDI9kwuma34aKxPmms47XMkv02VZo2HHR1C62
	0ihOGdchLqLW8f9yva8buh48l9hWHzQbGSAN1tJZFL44c3sjSA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sE3vU-00070K-Ue; Mon, 03 Jun 2024 11:24:25 +0200
Message-ID: <7d22ac7e-c505-430b-82cc-6b14b04f3c90@leemhuis.info>
Date: Mon, 3 Jun 2024 11:24:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ERROR: modpost: "icssg_queue_pop" [...] undefined" on arm64
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Diogo Ivo <diogo.ivo@siemens.com>, Roger Quadros <rogerq@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240528113734.379422-1-danishanwar@ti.com>
 <20240528113734.379422-2-danishanwar@ti.com>
 <de980a49-b802-417a-a57e-2c47f67b08e4@leemhuis.info>
 <b4256b15-997d-4e10-a6a9-a1b41011c867@ti.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <b4256b15-997d-4e10-a6a9-a1b41011c867@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1717406675;4e76c9a1;
X-HE-SMSGID: 1sE3vU-00070K-Ue

On 03.06.24 10:14, MD Danish Anwar wrote:
> On 03/06/24 12:39 pm, Thorsten Leemhuis wrote:
>> On 28.05.24 13:37, MD Danish Anwar wrote:
>>> Introduce helper functions to configure firmware FDB tables, VLAN tables
>>> and Port VLAN ID settings to aid adding Switch mode support.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>
>> Hi! Since Friday I get a compile error in my -next builds for Fedora:
>>
>> ERROR: modpost: "icssg_queue_push"
>> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
>> ERROR: modpost: "icssg_queue_pop"
>> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> 
> Before posting the patches I had tested them with defconfig and I didn't
> see any ERRORs.
> 
> I think in the config that you are using most probably
> CONFIG_TI_ICSSG_PRUETH_SR1 is enabled. The patch adds APIs in
> icssg_config.c which uses APIs added in icssg_qeueus.c.
> 
> Now CONFIG_TI_ICSSG_PRUETH_SR1 also uses icssg_config.c but
> icssg_queues.c is not built for SR1 as a result this error is coming.
> 
> Fix for this will be to build icssg_queues as well for SR1 driver.
> 
> I will test the fix and post it to net-next soon.

thx!

>> Looks like this problem was found and reported mid May by the kernel
>> test robot already, which identified a earlier version of the patch I'm
>> replying to to be the cause:
>> https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/
>>
>> That and the fact that the patch showed up in -next on Friday makes me
>> assume that my problem is caused by this change as well as well. A build
>> log can be found here:
>> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-39-aarch64/07523690-next-next-all/builder-live.log.gz
>>
>> I don't have the .config at hand, but can provide it when needed.
> 
> Yes that would be helpful. If possible just check in the .config what
> symbols are enabled related to ICSS. (`cat .config | grep ICSS`)

I can't easily access the .config used the build system used for the
build, but unless I did something stupid it should be identical to this one:
https://www.leemhuis.info/files/misc/kernel-6.10.0-aarch64.config

FWIW, that .config is generated by some scripts Fedora uses when
building their kernels.

$ grep ICSS kernel-6.10.0-aarch64.config
CONFIG_TI_ICSSG_PRUETH=m
CONFIG_TI_ICSSG_PRUETH_SR1=m
CONFIG_TI_ICSS_IEP=m

HTH, Ciao, Thorsten

