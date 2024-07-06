Return-Path: <netdev+bounces-109646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2992948D
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A8E1F22568
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3C13A418;
	Sat,  6 Jul 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW24CNfD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701860275;
	Sat,  6 Jul 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279608; cv=none; b=bCbd30UNGbP94NVjeR+QwE8BcmtLjSh5nqIMP248J+AecD96Cjp0Z9NUAiDFXVRill4Qazt7cxUWstcx+zSFY7uq5WC+p3FZRsJYgYQPppve3aM0yelVMDkMLeV0hDdJRGKmGPacVX+9Thc9fT0cA3vH9Nng6X7r9yYybeD235I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279608; c=relaxed/simple;
	bh=Z4s7Ke8P4I+dajGWfpsCZLdONC21kEws/gzbQw0g1SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cd/emRdVIpHcx8xoD8F/F0XkPvtiB7cyYbAYSSbM94AQ0H0DQ/xur0sRqmSQJmQcJCyDhTSWI/v/QO3/fq47vZUMvc4JmA85iK7WH1p/fxIDIYkKE1o5UzmTFKwsBlKgKSefOphfsUwBVdKJZZprCAuBRFzRCA8gMIrziX8JJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW24CNfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724BCC2BD10;
	Sat,  6 Jul 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720279607;
	bh=Z4s7Ke8P4I+dajGWfpsCZLdONC21kEws/gzbQw0g1SE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XW24CNfDSiQ6BhGYyY4G9W+0MBlaUDzOdOZAmss3k5bXnjVVTrxIBDQ3ArzjknnCx
	 Lns/SSaBvEZ7nvBR1+Dwko4w3zg9LPsw6GtboRCYyElSURSD46x9LkHoY5AQ5p+v/c
	 N7n2gUVhwbd9xsvqqClpFq1rWrJJYxI4Ovnk6NjIxGy3b5OQb3XfpkKpvZ5gIIZbqq
	 5pJZGqKDwmnJHN/6JiwlnevZpfe2RhHfyFYm+WXKC8ZWIhzRk9qmxBDGlUpwtu1JBC
	 G2dWaLDAytkFWJ+4VAJoT6VyeW5wkgBbaNQLh8QgC0TroWl7dFLIxeTPbnB5j6EqKH
	 zmcn/diDwHlyA==
Message-ID: <547c13c8-c3c3-495e-8ca9-d87156bfe3f5@kernel.org>
Date: Sat, 6 Jul 2024 09:26:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
 <172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
 <d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
 <20240705204915.1e9333ae@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240705204915.1e9333ae@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 9:49 PM, Stephen Hemminger wrote:
> On Fri, 5 Jul 2024 18:53:47 -0600
> David Ahern <dsahern@kernel.org> wrote:
> 
>> On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:
>>> Hello:
>>>
>>> This series was applied to iproute2/iproute2.git (main)
>>> by Stephen Hemminger <stephen@networkplumber.org>:
>>>   
>>
>> Why was this merged to the main repro? As a new feature to iproute2 this
>> should be committed to next and only put in main on the next dev cycle.
> 
> Because the kernel support was already added, I prefer to not force waiting
> for code that is non-intrusive and kernel support is already present.

I have told multiple people - with you in CC - that is not how iproute2
branching works. People need to send userspace patches for iproute2 in
the same dev cycle as the kernel patches. You are now selectively
undermining that process. What is the point of -next branch then?

