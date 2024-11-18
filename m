Return-Path: <netdev+bounces-145935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1570B9D1585
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BACAB251D8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155241B21A0;
	Mon, 18 Nov 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TXLIKwoL"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92F225D6
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947937; cv=none; b=pbrUu6S2sAR2W8nsqrbOGeDr5w84+EAKwnS1cwAftVAN6+0FIhtGtRaKGSNtFOqMklbiNHYBFUgwFhwnY3QfDidQjLew5uW1VWLHF8F4eQA+3o5Gna+qVCPv0KPnj4wtwhxT6WU4Nok0+2Em5XMaWLX7IIXCf1h+61aNEABijEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947937; c=relaxed/simple;
	bh=UGXiLmY28Qvmoa7dQpAUBYhEp6CXGy6eDDdScHBO/eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LA7JQOYwOelgq6BM7tDQBFvz3Tmtzlytc43IPEAdRlT5JwNYqPFL7IaZOXgCZA5ZdPOuZA7hyzs4HsWuWHI6rAIHclmIXEVI3wCy72Wt9D3aSOCP9/NoGde4Qri2zkwUY3QsxKZyFgbzZ9vcoz/mH5mPxL8NW3YU/DPWlIC+b/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TXLIKwoL; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2E6DE780078;
	Mon, 18 Nov 2024 16:38:47 +0000 (UTC)
Received: from [172.20.0.209] (unknown [12.22.205.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 83A6213C2B0;
	Mon, 18 Nov 2024 08:38:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 83A6213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731947926;
	bh=UGXiLmY28Qvmoa7dQpAUBYhEp6CXGy6eDDdScHBO/eg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TXLIKwoLz9+Vb96h6gNA6XjbZ/lRuofkodN4oo6cJHMWNGIT94SLL/zXtqqPaeU39
	 MEYhDg7/0yXU2aHa401DrgMuycCPiT5Gy9VFWFAoVAFKHXZWI8Nmb/sQM2QiUsYPvd
	 6i7oxjBX6NhlrX+/yr5cD5h8w4V12F5BoUDa5oKg=
Message-ID: <3c146ffd-0ecf-45f8-92b6-1cf96a3f5d20@candelatech.com>
Date: Mon, 18 Nov 2024 08:38:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <88c439e9-0771-4bfc-a4af-70b4be76ea1f@orange.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <88c439e9-0771-4bfc-a4af-70b4be76ea1f@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731947928-gnQQFDSDvX9T
X-MDID-O:
 us5;ut7;1731947928;gnQQFDSDvX9T;<greearb@candelatech.com>;2a320b93dc8a19c3bbe1022bab805ac5
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/17/24 2:41 PM, Alexandre Ferrieux wrote:
> On 17/11/2024 19:40, Ben Greear wrote:
>> Hello,
>>
>> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
>> underlying traffic?
>>
>> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
>> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
>> gre interfaces and have that go out whatever the ethernet VRFs route to...
> 
> A netns is vastly more flexible than a VRF, with much cleaner operation. In your
> case I'd just move each eth to a separate netns, and create its GRE there.
> 

I vastly prefer VRF since it is cleaner for my use case.  But glad to know
netns works well for you.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

