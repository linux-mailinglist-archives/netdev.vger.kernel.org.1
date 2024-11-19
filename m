Return-Path: <netdev+bounces-146266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55B9D28C0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B3E280E0D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19C1CEE91;
	Tue, 19 Nov 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="h3aEOqpG"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B81CF296
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028378; cv=none; b=flXnlpdyoQVkLKRRbN4voVYUYre2/3LoA3hQBUy0VlI9YCbdI44mqQ2/sDM8P50J5RbbipredVDRQEy0BX06t03xRU11XQupImzl+nat4YWMAB0HT/PXrh7OSnGcBRtW7G3fcEeOMOlBs2ClrJo9dqEgFRMNN49aqWiP7X9TPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028378; c=relaxed/simple;
	bh=rpcNWXGYDIWTYOMlYLXYd+yPHO0MrCXcIaSwMc/b29U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FGLwkL2CCkKaDW7wGxwHmTf/cmqzkMZ+tEzPTL3uUTc+GdVQ5Cyu22fjPome63kUVV8xpD045lDF1dX26B1AFxlHCMIzN9+GSg3L3OH4vqeGGzUXkpL/t10WEW+2N67Tux0YlQR08+ip4pI767dT95e1a9dY6pOOJlKxpXhaX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=h3aEOqpG; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C4F97240089;
	Tue, 19 Nov 2024 14:59:33 +0000 (UTC)
Received: from [172.20.0.209] (unknown [12.22.205.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2CED413C2B0;
	Tue, 19 Nov 2024 06:59:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2CED413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732028373;
	bh=rpcNWXGYDIWTYOMlYLXYd+yPHO0MrCXcIaSwMc/b29U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=h3aEOqpGW5/rNkzsINRKGIYE+Wwr81lSCLooXrgdOCX822kBZEBa4+3t8nMdS68lS
	 fIwJL4eVvn8TO9M7fXmAwOFnCkwIRzOc2BIFHQOgyR/y0F6d3y5u/UgTzx0Q1O96Mq
	 sP8GQFCHMnjHIyKIJeKsnP9NM6QCyoC18Qwv+0No=
Message-ID: <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
Date: Tue, 19 Nov 2024 06:59:32 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
From: Ben Greear <greearb@candelatech.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
 <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
Content-Language: en-MW
Organization: Candela Technologies
In-Reply-To: <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1732028374-JMNnj7EPBC8w
X-MDID-O:
 us5;ut7;1732028374;JMNnj7EPBC8w;<greearb@candelatech.com>;a7e0f01e4f1a90fc9a5deb2f83c822d4
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/18/24 5:47 PM, Ben Greear wrote:
> On 11/18/24 11:48 AM, Ben Greear wrote:
>> On 11/18/24 1:00 AM, Ido Schimmel wrote:
>>> On Sun, Nov 17, 2024 at 10:40:18AM -0800, Ben Greear wrote:
>>>> Hello,
>>>>
>>>> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
>>>> underlying traffic?
>>>>
>>>> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
>>>> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
>>>> gre interfaces and have that go out whatever the ethernet VRFs route to...
>>>
>>> You can set eth{1,2} as the "physical device" of gre{0,1}
>>>
>>> ip link add name gre0 up type gre [...] dev eth1
>>> ip link add name gre1 up type gre [...] dev eth2
>>>
>>> The "physical device" can be any interface in the VRF, not necessarily
>>> eth{1,2}.
>>
>> Hello,
>>
>> Thanks for that suggestion.
>>
>> I'm trying to implement this, but not having much luck.  My current approach
>> is trying to put gre0 in one VRF, attached to a VETH device in a different VRF.
>>
>> Would you expect that to work?
> 
> I found some other problems with my config, will try this again now that some other
> problems are solved...

Ok, I am happy to report that GRE with lower-dev bound to one VRF and greX in a different
VRF works fine.

Thanks,
Ben

> 
>>
>> And also, is there any way to delete a gre netdev?  ip link delete gre0 doesn't
>> complain, and doesn't work.
> 
> I found answer to this, for reference, it seems gre0 is default instance built by the
> ip_gre module when it is loaded, and used for special purpose.
> 
> Thanks,
> Ben
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

