Return-Path: <netdev+bounces-127698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46E9761CB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916FB28A259
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126C18BB99;
	Thu, 12 Sep 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="ip32X/Ps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAEE189525
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123595; cv=none; b=OUGpafzM8V/mO/z/y2QlF5BHw69RZhQ5ckAJcytOrpapboGVIF3QIobX6n0m1R/bqFuqhUw9XCyuLp8HsecQWYnQnYGXtS3y8gKVUc+csnFAxp/9UnR4TeTzk2m5SAEqchElrb/6CnQKX2zyiTxxVj545q1pWodORBtpXH3yyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123595; c=relaxed/simple;
	bh=nnoABaii1aTumxEs1JmI7A34FVyvzdxhQcZB8xjzVL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thn7/vyrm2T6OixwKuMtePStXeVtf4sL6+cqe6OYVD1rD9ODOPMOcoS1G+THv0UsLhnWyJKZFI6RCgOZC4amx5ZbbZCaHrJVHaV9w8weIsb9MLSRPcllA243B1VKra1aLqvE4DEplUTX+FPmdtn0KlMOepOM1nCRSq4JTkbcM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=ip32X/Ps; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6kCA4019891
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:46:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726123576; bh=nZDpbOUF3whLL83H5z8GFpVSwyHgTX2OKDH3nupdcGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ip32X/Psc7sspJa3wnz7ul5qFat8aLnXp2xAkca5YkMPCPXVSF1wg+zAiQ9UjdAzn
	 FoPL58Ym8N3UXA65Loszl/6zlz/YqwE/Pdq2Iu4gMM1U5HdKZp9jnsf7ekZ/1qOYYO
	 y+WrsuA3Izes0maaDF73UWwAX41I+oaBjy3aUMK8=
Message-ID: <dabeaf9c-fe6c-464e-a647-815e51ec33ce@ans.pl>
Date: Wed, 11 Sep 2024 23:46:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
To: Ido Schimmel <idosch@nvidia.com>
Cc: gal@nvidia.com, Tariq Toukan <tariqt@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
 <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
 <7ba77c1e-9146-4a58-8f21-5ff5e1445a87@ans.pl>
 <Ztna8O1ZGUc4kvKJ@shredder.mtl.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <Ztna8O1ZGUc4kvKJ@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Good morning Ido,

On 05.09.2024 at 09:23, Ido Schimmel wrote:
> On Wed, Sep 04, 2024 at 09:47:04PM -0700, Krzysztof Olędzki wrote:
>> This BTW looks like another problem:
>>
>> # ethtool -m eth1 hex on offset 254 length 1
>> Offset          Values
>> ------          ------
>> 0x00fe:         00
>>
>> # ethtool -m eth1 hex on offset 255 length 1
>> Cannot get Module EEPROM data: Unknown error 1564
>>
>> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(255) size(1): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
>> mlx4_en: eth1: mlx4_get_module_info i(0) offset(255) bytes_to_read(1) - FAILED (0xfffff9e4)
>>
>> With the netlink interface, ethtool seems to be only asking for for the first 128 bytes, which works:
> 
> Yes. The upper 128 bytes are reserved so sff8079_show_all_nl() doesn't
> bother querying them. Explains why you don't see this error with
> netlink.
> 
> Regarding the runtime "--disable-netlink" patch, I personally don't mind
> and Andrew seems in favor, so please post a proper patch and lets see
> what Michal says.

Thanks. Will send it, let's see how it goes.
 
> Regarding the patch that unmasks the I2C address error, I would target
> it at net-next as it doesn't really fix a bug (ethtool already displays
> what it can).

Well, I would argue that it does fix a bug to some extent, because otherwise
"ethtool -m" shows wrong DOM data, instead of just not showing it at all.
Also, judging from the date of the commit [1], I would say it is likely that
the workaround was actually added to address the limitation of the firmware
that was there at that time.

That said, definitely a net-next target, same for the other three patches
that I just sent.

> Thinking about it, I believe it would be more worthwhile
> to implement the much simpler get_module_eeprom_by_page() ethtool
> operation in mlx4 (I can help with the review). It would've helped
> avoiding the current issue (kernel will return an error) and the
> previous bug [1] you encountered with the legacy operations.

Sure, I can also try to work on that one. Would mlx5/core/en_ethtool.c
be a good example of how this should be implemented?
 
> Regarding the fact that these modules work properly with CX3, but not
> with CX2 (which uses the same driver), it really seems like a HW/FW
> problem and unfortunately I can't help with that.

Yes, understood. Initially I was hoping for this to be either a bug in
the driver, or something that could be quirked there, but after spending
the last week playing with both the kernel and the firmware, I am convinced
this it is a firmware issue (at least for the "offset(255)" and the "A2h"
problems) and both could be only fixed there. At this point, I cannot
count how many times I used mlxburn/flint and the "reset" button after
crashing either the NIC FW or the kernel, but I think I now understand
where the problem is and even have some ideas how to fix...

For the "offset(255)" issue, I am confident this is an off-by-one error,
(address+size is compared to 255 instead of 256) that most likely never
got fixed for the CX2 firmware, at least not in the ones that are available
in public. :( I was able to reproduce almost exactly the same behavior
on CX3 flashing a very, very ancient version.

For the "A2h" issue, it looks like a FW limitation as the old (CX2) version
of firmware only allows to access 0x50 i2c address, instead of 0x50 (for A0h)
*and* 0x51 for A02h. I was also able to reproduce it with the ancient CX3 FW.

The QSFP error is a big mystery that most likely will never be solved (at least
not by me), as I don't have the knowledge nor the documentation to make any 
progress there and after all, CX2 is technically a retro-hardware at this point:
"ConnectX-2 is End-of-Life since 2015 and End-of-Service since 2017" says
it all and is 100% spot on. Still, fun to use! ;)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32a173c7f9e9ec2b87142f67e1478cd20084a45b

Thanks,
 Krzysztof

