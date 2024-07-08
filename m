Return-Path: <netdev+bounces-109715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F7929B21
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 05:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11E21F214CC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F146FB6;
	Mon,  8 Jul 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="E6vZPO0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B03FC2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410213; cv=none; b=DFfDBUIjoD+I/pxZShTQaxLJDfNF+ygNt/JbD+7eUnAxiR2/vAFn1tIfI8wBOjvGfkzgCR200B4AhhrijkJ/NyXApQCkzaUHNWWcqRIqNldxUSi+g7w6k1CUhLWvHythfjAldaKv69vLadO0rb8xPEN21PkpHc8BevmW8Vh4e/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410213; c=relaxed/simple;
	bh=tTsvtJxiivGQUDwdDlzI16o5n8r8V4S6PzVR4cwl8jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjdB2VP8x3HAq2xagwjwpAUh7tTXu8usDdXoXLMAMPe3SBproSA79ZUqB3WN+FO9pSJo3KKYu5e006c6NeNkO0cIOKJ2HppvyVrAOuFDQfggH1YRpSai5Mn2sus4smsYQC/5BWwqEc8B1u9lK1VVtpoeK6NwkRud5SwXi6zSwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=E6vZPO0W; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4683gndt008170
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Jul 2024 05:42:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1720410171; bh=X2kiB7fKeiT8pjqapBJGMfj7BOiI1x79mJcwD+xQV0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E6vZPO0W66smXX4tqxoObVPo6jczZpyyl19O04SinOOJoE0InzmKzw2nsm1WKLq7T
	 f6Y3ts3ihTdGzj0bZhCkcdtdMxl6v9IL76aYLd7+KPQiRsP6slpdYkYfENT4fOoVjP
	 Dp/ISLLK6C2ifXfpLUN1SehzNp2nNnBy0avXjaBw=
Message-ID: <ebbb0690-13d1-452d-95d7-5ce61bb8a0e8@ans.pl>
Date: Sun, 7 Jul 2024 20:42:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ethtool fails to read some QSFP+ modules.
To: Ido Schimmel <idosch@idosch.org>
Cc: Dan Merillat <git@dan.merillat.org>, Michal Kubecek <mkubecek@suse.cz>,
        netdev <netdev@vger.kernel.org>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
 <ZoJaoLq3sYQcsbDb@shredder.mtl.com> <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
 <49bf6eca-9ad0-49a7-ac8d-d5104581f137@ans.pl>
 <8711f66b-9461-4e3c-8881-5bda2379b926@ans.pl>
 <ZopTTqrHRekd8d8u@shredder.mtl.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <ZopTTqrHRekd8d8u@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07.07.2024 at 01:35, Ido Schimmel wrote:
> On Thu, Jul 04, 2024 at 05:27:49AM -0700, Krzysztof Olędzki wrote:
>> On 03.07.2024 at 07:36, Krzysztof Olędzki wrote:
>>> Good morning,
>>>
>>> On 01.07.2024 at 00:41, Ido Schimmel wrote:
>>>> Forgot to add Krzysztof :p
>>>>
>>>> On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
>>>>> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
>>>>>>
>>>>>> I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
>>>>>> the optional page3 data as a hard failure.
>>>>>>
>>>>>> This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
>>>>>
>>>>> Thanks for the report and the patch. Krzysztof Olędzki reported the same
>>>>> issue earlier this year:
>>>>> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
>>>>>
>>>>> Krzysztof, are you going to submit the ethtool and mlx4 patches?
>>>
>>> Yes, and I apologize for the delay - I have been traveling with my family and was unable to get into it.
>>>
>>> I should be able to work on the patches later this week, so please expect something from me around the weekend.
>>>
>>>>>> From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
>>>>>> From: Dan Merillat <git@dan.eginity.com>
>>>>>> Date: Sun, 30 Jun 2024 13:11:51 -0400
>>>>>> Subject: [PATCH] Some qsfp modules do not support page 3
>>>>>>
>>>>>> Tested on an older Kaiam XQX2502 40G-LR4 module.
>>>>>> ethtool -m aborts with netlink error due to page 3
>>>>>> not existing on the module. Ignore the error and
>>>>>> leave map->page_03h NULL.
>>
>> BTW - the code change does what we have discussed, but I think the comment
>> may be incorrect? Before we call nl_get_eeprom_page, there is a check to
>> verify that Page 03h is present:
>>
>>         /* Page 03h is only present when the module memory model is paged and
>>          * not flat.
>>          */
>>         if (map->lower_memory[SFF8636_STATUS_2_OFFSET] &
>>             SFF8636_STATUS_PAGE_3_PRESENT)
>>                 return 0;
>>
>> In this case, it seems to me that the failure can only be caused by either
>> HW issues (NIC or SFP) *or* a bug in the driver. Assuming we want to provide
>> some details in the code, maybe something like this may be better?
>>
>> +	/* Page 03h is not available due to either HW issue or a bug
>> +	 * in the driver. This is a non-fatal error and sff8636_dom_parse()
>> +	 * handles this correctly.
>> +	 */
> 
> Looks fine to me although I believe an error in this case will always be
> returned because of a driver bug. Reading a page that does not exist
> should not result in an error, but in the module returning Upper Page
> 00h. Yet to encounter a module that works in a different way. From
> SFF-8636 Section 6.1:
> 
> "Writing the value of a non-supported page shall not be accepted by the
> slave. The Page Select byte shall revert to 0h and read/write operations
> shall be to Upper Page 00h. Because Upper Page 00h is read-only, this
> scheme prevents the inadvertent corruption of module memory by a host
> attempting to write to a non-supported location."

Fair, I updated the comment based on your feedback.

>>
>> We were also discussing if printing a warning in such situation may make sense.
>> As I was thinking about this more, I wonder if we can just use the same check
>> in sff8636_show_dom() and if map->page_03h is NULL print for
>>  "Alarm/warning flags implemented"
>> something like:
>>  "Failed (Page 03h access error, HW issue or kernel driver bug?)"
>>
>> We would get it in addition to "netlink error: Invalid argument" that comes from:
>> ./netlink/nlsock.c:             perror("netlink error");
> 
> I think it's better to print it in sff8636_memory_map_init_pages() as
> that way the user can more easily understand the reason for "netlink
> error: Invalid argument":
> 
> # ./ethtool -m swp13                                                                                                                                                                                                                                                                 
> netlink error: Invalid argument
> Failed to read Upper Page 03h
>         Identifier                                : 0x11 (QSFP28)
>         Extended identifier                       : 0xcf
> [...]

Great idea, done.


> BTW, just to be sure, you are going to post patches for both ethtool and
> mlx4, right?

Yes, I just sent both.
 
Krzysztof

