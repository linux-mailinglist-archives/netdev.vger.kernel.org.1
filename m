Return-Path: <netdev+bounces-146052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA59D1D8B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05603281383
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEF822619;
	Tue, 19 Nov 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CioJkKLH"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE81BC2A
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980846; cv=none; b=S7EWxMLA0tjI56JzXVzJDYxuTc+Gu3aX9+6eS6QmVSvj4Uf77U41k29uQb3ICH0TgiucTx0DdaOouqNA/DdTQJtO6s0LHLwuEP9XaFWhSeV0KQ+mCGk7FPDQMGmXqtLhDp5t74Y6e/FoiAZBgnfbeUXcEYzZs3TLdl1+0mqMAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980846; c=relaxed/simple;
	bh=j5WxfRQC5jwGpkbKBTTUzm4fUjxqxW59kP6t1LgCYS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cmrNWBE8/EYcMsK83o1HBc6gc+mvLuotF+Gk2Z5P+O2WPj19YAYX00dTr/g3zTrVjTAzEhCxmYdZvLo5cFkpZ/1+BAxh13N5SruAQxJfg2Oz/RESPBgTaVABqfC5SMzJp53MAq/y4AaAw4NAP54T/l4rbeOOs19P4WiNWawimYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CioJkKLH; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 62AB828006D;
	Tue, 19 Nov 2024 01:47:16 +0000 (UTC)
Received: from [IPV6:2607:fb90:7312:5479:23bd:24ab:9b46:7022] (unknown [172.56.241.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AFC0613C2B0;
	Mon, 18 Nov 2024 17:47:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AFC0613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731980835;
	bh=j5WxfRQC5jwGpkbKBTTUzm4fUjxqxW59kP6t1LgCYS8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CioJkKLHgqfGC6g0M3MZonSVc8OS2H1X3/XzzqaSJvcRvtAYBSjYHyhbIL1nSYI9b
	 7YP9eWuMX+Zi+yg0fK1x7XLeU+zIqzkLJmTirkLBQVivBer56QzW3IomnOzk5qzBgU
	 tTxPMtCZJ/B7GgPybKd1/WI07p4Nq6TgcjVm3Pu8=
Message-ID: <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
Date: Mon, 18 Nov 2024 17:47:12 -0800
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
Content-Language: en-MW
Organization: Candela Technologies
In-Reply-To: <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1731980837-wjwe4CmXjNkc
X-MDID-O:
 us5;ut7;1731980837;wjwe4CmXjNkc;<greearb@candelatech.com>;a7e0f01e4f1a90fc9a5deb2f83c822d4
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/18/24 11:48 AM, Ben Greear wrote:
> On 11/18/24 1:00 AM, Ido Schimmel wrote:
>> On Sun, Nov 17, 2024 at 10:40:18AM -0800, Ben Greear wrote:
>>> Hello,
>>>
>>> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
>>> underlying traffic?
>>>
>>> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
>>> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
>>> gre interfaces and have that go out whatever the ethernet VRFs route to...
>>
>> You can set eth{1,2} as the "physical device" of gre{0,1}
>>
>> ip link add name gre0 up type gre [...] dev eth1
>> ip link add name gre1 up type gre [...] dev eth2
>>
>> The "physical device" can be any interface in the VRF, not necessarily
>> eth{1,2}.
> 
> Hello,
> 
> Thanks for that suggestion.
> 
> I'm trying to implement this, but not having much luck.  My current approach
> is trying to put gre0 in one VRF, attached to a VETH device in a different VRF.
> 
> Would you expect that to work?

I found some other problems with my config, will try this again now that some other
problems are solved...

> 
> And also, is there any way to delete a gre netdev?  ip link delete gre0 doesn't
> complain, and doesn't work.

I found answer to this, for reference, it seems gre0 is default instance built by the
ip_gre module when it is loaded, and used for special purpose.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

