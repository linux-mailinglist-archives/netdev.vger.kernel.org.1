Return-Path: <netdev+bounces-122961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1496349F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0621F24BF4
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AA1AB526;
	Wed, 28 Aug 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uebokyti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF0167D97
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883732; cv=none; b=Q1Yx00enwXuaeDbj/dCrJPXHNEh11Q4OOVER1WKfT5McKQv5K8zXAqAFoI07k4un/DIWAzMKae/xmWUTbdTwAG9oPzMe3RVNFJfuh0gSgIvrPVJjYh52pfTseC/BUg7YozuuAX8KNbiDYAW1GC4g6X9ihqG0Uo2kktw492Mn7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883732; c=relaxed/simple;
	bh=Hmtl3c01oJ06Lz1m1g4PtXOCUxPMf2GC9TKRbGODzzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0jP4AKVUp5oaUWYFf75z/y+RldwJ8TwhwNEoYz1qbzaCnXbaBL+GBggUzEuecWnMMJnnCKXofHgafKvZthkTBA57ixscZdmvLh4uIEUAMHtlcJLwPSxPDtDuo9U5IU7d1T9LI+BCgQQv7ltid+LVQvH6X5976fnNUsM2nPibN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uebokyti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFA0C4CEC0;
	Wed, 28 Aug 2024 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724883731;
	bh=Hmtl3c01oJ06Lz1m1g4PtXOCUxPMf2GC9TKRbGODzzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uebokytiXKJv6eJYXodNpzUOal8ZQDc/xxdlXw22U3ZfcoWRRnZZNglOPjWD/TJW/
	 f6E7cUnC1JCwy4Nj0OuD4vKGLQnwMC3OKTgm34aiAAPm9BQw9D1IRRAfnKLvqZciUb
	 xtWbeR6lNJBdx4kpq7ArqW9Du7DHCtgRsA8+389CnB/+C7BIv7W1qcUOKyKGRXe+ji
	 IOSmsV3d1n3eBOA685o5LbEQs89iovKSz+ydggbSSPycmSAZSyNmSQ9J3mz5D8wl3+
	 ZGanck7ZlwjpRQVWh6oNtkzHp3ba4moiLywnUfzykVXWbV0VEdUQ3n4SoF/Pxaj1MP
	 4Sew1FDs29T+A==
Message-ID: <9654009f-5ea8-433e-a4ba-28602f8bb61a@kernel.org>
Date: Wed, 28 Aug 2024 15:22:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/2] ip: lwtunnel: tunsrc support
Content-Language: en-US
To: Justin Iurman <justin.iurman@uliege.be>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20240826135229.13220-1-justin.iurman@uliege.be>
 <20240826135229.13220-2-justin.iurman@uliege.be>
 <20240826085914.445c3510@hermes.local>
 <e8420765-dec6-4802-8255-89f9f6965c59@uliege.be>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e8420765-dec6-4802-8255-89f9f6965c59@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/24 1:41 AM, Justin Iurman wrote:
> On 8/26/24 17:59, Stephen Hemminger wrote:
>> On Mon, 26 Aug 2024 15:52:28 +0200
>> Justin Iurman <justin.iurman@uliege.be> wrote:
>>
>>> -    if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
>>> +    if (mode != IOAM6_IPTUNNEL_MODE_INLINE) {
>>> +        if (tb[IOAM6_IPTUNNEL_SRC]) {
>>> +            print_string(PRINT_ANY, "tunsrc", "tunsrc %s ",
>>> +                     rt_addr_n2a_rta(AF_INET6,
>>> +                             tb[IOAM6_IPTUNNEL_SRC]));
>>> +        }
>>> +
>>>           print_string(PRINT_ANY, "tundst", "tundst %s ",
>>>                    rt_addr_n2a_rta(AF_INET6, tb[IOAM6_IPTUNNEL_DST]));
>>> +    }
>>
>> Looks good.
>> These strings should be printed with
>>         print_color_string(PRINT_ANY, COLOR_INET6, ...
>>
>> but that is not urgent. Just to follow convention.
> 
> Ack, thanks! I can submit -v3 now to include the change though. WDYT?

sure. send an update now. I most likely will not have time to update the
headers and commit until this weekend.

