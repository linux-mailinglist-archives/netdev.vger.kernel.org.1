Return-Path: <netdev+bounces-66784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E7840A10
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB59C1C24C7C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB2153BDB;
	Mon, 29 Jan 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdN4Q/nQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8183153BC7;
	Mon, 29 Jan 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542355; cv=none; b=oy8X+mcb59RgAJbXlBqWXed/sIrCa/8uyegkf84wUM5oxWa9jvP8320mc+hCUmBbzT/rYeag4L8uQGGNak/Fn3j4F8Np1/WY84pkgqwqjzL02f4AhYe6Sp6djNXxK1v/AsJISbETT1bF+YBa5c/obNuSKEo7KeciwCuFG5FBI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542355; c=relaxed/simple;
	bh=rv/tQCSdhSHyc1IowdjtuKIaCWqNlueesyQh5p9dlV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7pLmLZYU+msGtMNfyvFA+FMyyl+Ku1KkXS+AmbeWf/VO656ZZj+adr/RFXk9+JUP6ioFURBrpfVxPDvi97P5fJkm1H/BHEBf7Tti6k+dpYKw5124WTjWtTmsgXWUr79WpFlN4bWMLdn0/GZzCz+3fRPbaVdgC772kh5X1rVZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdN4Q/nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140DCC433F1;
	Mon, 29 Jan 2024 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542355;
	bh=rv/tQCSdhSHyc1IowdjtuKIaCWqNlueesyQh5p9dlV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GdN4Q/nQbgAf8yKBLR3LkHv8ybB7aoXGqEd19/YX1luHqYjEWpHbyMYEryVtC4Paf
	 KyYZJe78HUxC7kWDJiPL7YH19Lr+H89QpJxtdD81BLEJYoIB8Oep0svC8Dh2MF3Etr
	 izhQq3TXqaoZJSYinGcZ4vk2kL4/3UKKOxC/H/2Pfc0UtRYEBA6Ums5SKmvPvnsOpI
	 QhxQUhSiRevULlG7MeiDZKWBq9GoxSC/kMtSIKb1HkXe4s6X5ztd/IhONGPXn2fEfb
	 nXrBry34dIMlVW8BIAUwPN/bB67J2eOl16/k3cPIyKlcoJlGNLf5EvG5ERyWpfQA81
	 LuTX3wf4SC20g==
Message-ID: <a2df88e6-5ecc-407c-a579-8c8b7b4fbd2b@kernel.org>
Date: Mon, 29 Jan 2024 08:32:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <20240123133925.4b8babdc@kernel.org>
 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
 <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
 <20240124070755.1c8ef2a4@kernel.org> <20240124081919.4c79a07e@kernel.org>
 <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
 <20240124085919.316a48f9@kernel.org>
 <bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
 <c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
 <20240126171346.14647a6f@kernel.org>
 <317aa139-78f8-424b-834a-3730a4c4ad04@kernel.org>
 <ef884f08937fcaab4e4020eb3fca91a938385c75.camel@redhat.com>
 <20240129070304.3f33dcf2@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240129070304.3f33dcf2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 8:03 AM, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 10:23:15 +0100 Paolo Abeni wrote:
>>> It's a bug in that version of iputils ping. It sets the BINDTODEVICE and
>>> then resets it because the source address is not set on the command line
>>> (it should not be required).
>>>
>>> There are a couple of workarounds - one which might not age well (ie.,
>>> amazon linux moving forward to newer packages -I <addr> -I <vrf>) and
>>> one that bypasses the purpose of the test (ip vrf exec)).  
>>
>> Could the script validate the 'ping' command WRT the bad behavior/bug
>> and  eventually skip the related tests?
> 
> Skipping if the package has a bug would be best, if we can figure that
> out. The latest version is fixed, right? I can build it locally, just
> like pretty much everything else..

yes, that is why Ubuntu 23.10 passes. I downloaded iputils, built ping
locally at the Amazon release version and did a side by side comparison
of behavior to verify it is the ping command.

