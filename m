Return-Path: <netdev+bounces-109206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E29275FA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B6E282E68
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7F11AE845;
	Thu,  4 Jul 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="FyFg0wZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F01AE842
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096124; cv=none; b=S5uRfjipaFxYqiID1bjJkA1+eeG4UmM3XqS2DpvFTEGQcpSsXnlbDkH9FCwRZ6NdSYBj8t+q/br0AXx9Apsr2qtmUfh1Q/7964riyDv/qNOA7xHzXb6So0jWPEb/X6JfZexc6H9DV0DWFlVsKKaBi/Ew27ndHe9y9uVINMb/AhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096124; c=relaxed/simple;
	bh=GSgU6z84HFCsGnjYik2f1z6k+gv7IzsJmDFTjYYdZhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ulXgdt63vlgGUxoeauhSNGg2rIqii6O4U7nhxyovExWJyqtCQ1o/I2gfygqE6H2DTM2PzHNSufamrHqbokBXEMn5MYWWgAkpABlvY0jXccEUhKHFi8EvT4LQb4r1/YR+MmtBf5OCnEog+9ywWuqFA+VVmRdcMY663idnJJqdFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=FyFg0wZG; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 464CRqBX025570
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jul 2024 14:27:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1720096075; bh=fc4aP9yklrajGNF7Ody1qzxVFCGxKEODf6A9Gc6nlg4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=FyFg0wZG6sZ+DsJenhKqWycyi5icas1kiISNqY6iMxR5Ke+lizwwi5adLdXTuEijT
	 VifLY6Rcut7ES7MNDu0GsjJG6VNzUR+SKR3ROmPwokUuUt3qjGum1aGnMCjp5dO+DJ
	 OooTTnPw5X6h+v6m+wsdJahl0xatgPTuOt7oa05c=
Message-ID: <8711f66b-9461-4e3c-8881-5bda2379b926@ans.pl>
Date: Thu, 4 Jul 2024 05:27:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ethtool fails to read some QSFP+ modules.
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@idosch.org>, Dan Merillat <git@dan.merillat.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
 <ZoJaoLq3sYQcsbDb@shredder.mtl.com> <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
 <49bf6eca-9ad0-49a7-ac8d-d5104581f137@ans.pl>
Content-Language: en-US
In-Reply-To: <49bf6eca-9ad0-49a7-ac8d-d5104581f137@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.07.2024 at 07:36, Krzysztof Olędzki wrote:
> Good morning,
> 
> On 01.07.2024 at 00:41, Ido Schimmel wrote:
>> Forgot to add Krzysztof :p
>>
>> On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
>>> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
>>>>
>>>> I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
>>>> the optional page3 data as a hard failure.
>>>>
>>>> This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
>>>
>>> Thanks for the report and the patch. Krzysztof Olędzki reported the same
>>> issue earlier this year:
>>> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
>>>
>>> Krzysztof, are you going to submit the ethtool and mlx4 patches?
> 
> Yes, and I apologize for the delay - I have been traveling with my family and was unable to get into it.
> 
> I should be able to work on the patches later this week, so please expect something from me around the weekend.
> 
>>>> From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
>>>> From: Dan Merillat <git@dan.eginity.com>
>>>> Date: Sun, 30 Jun 2024 13:11:51 -0400
>>>> Subject: [PATCH] Some qsfp modules do not support page 3
>>>>
>>>> Tested on an older Kaiam XQX2502 40G-LR4 module.
>>>> ethtool -m aborts with netlink error due to page 3
>>>> not existing on the module. Ignore the error and
>>>> leave map->page_03h NULL.

BTW - the code change does what we have discussed, but I think the comment
may be incorrect? Before we call nl_get_eeprom_page, there is a check to
verify that Page 03h is present:

        /* Page 03h is only present when the module memory model is paged and
         * not flat.
         */
        if (map->lower_memory[SFF8636_STATUS_2_OFFSET] &
            SFF8636_STATUS_PAGE_3_PRESENT)
                return 0;

In this case, it seems to me that the failure can only be caused by either
HW issues (NIC or SFP) *or* a bug in the driver. Assuming we want to provide
some details in the code, maybe something like this may be better?

+	/* Page 03h is not available due to either HW issue or a bug
+	 * in the driver. This is a non-fatal error and sff8636_dom_parse()
+	 * handles this correctly.
+	 */

We were also discussing if printing a warning in such situation may make sense.
As I was thinking about this more, I wonder if we can just use the same check
in sff8636_show_dom() and if map->page_03h is NULL print for
 "Alarm/warning flags implemented"
something like:
 "Failed (Page 03h access error, HW issue or kernel driver bug?)"

We would get it in addition to "netlink error: Invalid argument" that comes from:
./netlink/nlsock.c:             perror("netlink error");


>>> User space only tries to read this page because the module advertised it
>>> as supported. It is more likely that the NIC driver does not return all
>>> the pages. Which driver is it?
>>

Krzysztof


