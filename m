Return-Path: <netdev+bounces-108918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2D926392
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5CB28544A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6717C237;
	Wed,  3 Jul 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="lC8BEujs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2117C7C4
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017489; cv=none; b=chNd9mZ+Qmurj0u/D372jXdawu2O+AiIAbgVYq3fXT6R+96S3aY0aTk7aftrIpBVEUtggt/goldzcfrzgK+bvlhaQACkJs75S0Sz6ZRGgVVsDSeOjBy5iCEKRKLIefBxxdiaD0vG8UulANWfKCTsiLWBi8PJA7M9q5oALZtDPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017489; c=relaxed/simple;
	bh=CYh3BkrG7T+W/+wmTlPOSWNqGCWtE0fTIUBW1jkG2lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U03XAmtUs39QhQkPWxifdMcHKiryrgZ3UDMCfAusGyWrn+p5pC9aMs5OvjIU9lYopn5TvfbCFZNtg2C6AkV1B1nnnmu4S3tam4w12Wx7bD1SQEuld2A0HZsi/1J08XlUtf3Njw18Gdm4XsljIun+dXFJDXIkjuFvLMpMyPsUYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=lC8BEujs; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 463Easi6002785
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jul 2024 16:36:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1720017418; bh=atWuzXJyO5cKrY9JGXJtLK1hvFGQgksnhEvzTYnAiBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lC8BEujsPNu/kDZN4oZ6J0zI/UF76y4/mmM74JwjyttLuZGZ3o/5KO8ghPjs5OOpT
	 b48Yp0N0RxNdZyfKNp4pzRRO/3WZDM5S6gjg4Cw6zAisRrbit85cm6ZDRaq5LCPYc4
	 Mj/ILNyz2kTX3S+pbEt6yp42onJPAQWLoLUUKur4=
Message-ID: <49bf6eca-9ad0-49a7-ac8d-d5104581f137@ans.pl>
Date: Wed, 3 Jul 2024 07:36:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ethtool fails to read some QSFP+ modules.
To: Ido Schimmel <idosch@idosch.org>, Dan Merillat <git@dan.merillat.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
 <ZoJaoLq3sYQcsbDb@shredder.mtl.com> <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
In-Reply-To: <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Good morning,

On 01.07.2024 at 00:41, Ido Schimmel wrote:
> Forgot to add Krzysztof :p
> 
> On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
>> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
>>>
>>> I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
>>> the optional page3 data as a hard failure.
>>>
>>> This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
>>
>> Thanks for the report and the patch. Krzysztof Olędzki reported the same
>> issue earlier this year:
>> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
>>
>> Krzysztof, are you going to submit the ethtool and mlx4 patches?

Yes, and I apologize for the delay - I have been traveling with my family and was unable to get into it.

I should be able to work on the patches later this week, so please expect something from me around the weekend.

>>> From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
>>> From: Dan Merillat <git@dan.eginity.com>
>>> Date: Sun, 30 Jun 2024 13:11:51 -0400
>>> Subject: [PATCH] Some qsfp modules do not support page 3
>>>
>>> Tested on an older Kaiam XQX2502 40G-LR4 module.
>>> ethtool -m aborts with netlink error due to page 3
>>> not existing on the module. Ignore the error and
>>> leave map->page_03h NULL.
>>
>> User space only tries to read this page because the module advertised it
>> as supported. It is more likely that the NIC driver does not return all
>> the pages. Which driver is it?
> 

Thanks,
 Krzysztof

