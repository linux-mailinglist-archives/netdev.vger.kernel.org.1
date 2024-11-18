Return-Path: <netdev+bounces-145987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155309D193B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0E3283ECA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF71E767B;
	Mon, 18 Nov 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="UBzFkcdS"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA251E884F
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959339; cv=none; b=kxUALOTvmGNOTpUhnBvHAFxmkRffRAd0VtbgQyqB53XekBadW8FHDlC1uZM/me29pwFNxCiO1acw1Le9JlETbad2oSB+KP1tTtUbXHuKfPy4zEUqcTCiYXRTgV07U8hz2xaEZ7c01d16vPPH0cNcfuuIqDqS4LpBXeuDNcdI/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959339; c=relaxed/simple;
	bh=yBX5N+9//W2xVv2JaRA75drvXz2yEwJ1eXsNwFDP0mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EajqrMsAhZQjkPxGT9Cy5rfsmuTSd0Xxsy85RCvd0X5ufGipkvXca/wCFcxB5zFCJ5eFaZgiCo7ucmV01F65Kpn2mfFn3ZHXqnbox0CNegozlPnsNNTHRUrnKMfxnYm9yoWBlt70t9+yO77me/UhdZnqmWidQSdLixei0hHJOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=UBzFkcdS; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F41B2400072;
	Mon, 18 Nov 2024 19:48:54 +0000 (UTC)
Received: from [IPV6:2607:fb90:7393:a63:d3b5:d0bd:6d1f:8490] (unknown [172.56.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B4CD413C2B0;
	Mon, 18 Nov 2024 11:48:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B4CD413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731959333;
	bh=yBX5N+9//W2xVv2JaRA75drvXz2yEwJ1eXsNwFDP0mc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UBzFkcdScO467TlhK+AtNr5yWrQAFtx8EI4mJkT3xrfS5y/ImT//c48yJiCCKU7Y0
	 JGqUgAVhIWW0knCBmncWK+1FEz0gAgXT+djPs2wrzDEfSF0IT9AQL7fjrRAfdrC6IU
	 ymYcG8cmf9estOy4pOg0T8ltWMdpSf1mI1Uu33Bs=
Message-ID: <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
Date: Mon, 18 Nov 2024 11:48:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZzsCNUN1vl01uZcX@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731959335-0wO8PpPw3nAS
X-MDID-O:
 us5;ut7;1731959335;0wO8PpPw3nAS;<greearb@candelatech.com>;a7e0f01e4f1a90fc9a5deb2f83c822d4
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/18/24 1:00 AM, Ido Schimmel wrote:
> On Sun, Nov 17, 2024 at 10:40:18AM -0800, Ben Greear wrote:
>> Hello,
>>
>> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
>> underlying traffic?
>>
>> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
>> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
>> gre interfaces and have that go out whatever the ethernet VRFs route to...
> 
> You can set eth{1,2} as the "physical device" of gre{0,1}
> 
> ip link add name gre0 up type gre [...] dev eth1
> ip link add name gre1 up type gre [...] dev eth2
> 
> The "physical device" can be any interface in the VRF, not necessarily
> eth{1,2}.

Hello,

Thanks for that suggestion.

I'm trying to implement this, but not having much luck.  My current approach
is trying to put gre0 in one VRF, attached to a VETH device in a different VRF.

Would you expect that to work?

And also, is there any way to delete a gre netdev?  ip link delete gre0 doesn't
complain, and doesn't work.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

