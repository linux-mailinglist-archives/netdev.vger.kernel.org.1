Return-Path: <netdev+bounces-77312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD488713B9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8771F238A6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAB24B52;
	Tue,  5 Mar 2024 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEGsdCZ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EF28684
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606470; cv=none; b=CMneLo/DEp+t5kiGDM24NXmCk+rhq0/CD2jUlvn3e+wXDGWl7h+S0ShrBBbf6/bnMCC6bG+6IFmCwLExFRdRLs7tGWD0FssyLqE7IVX/797MnVgVf10wokyD5XJwu7sTcZm/LSDgSrhaXu1YgVdSblQKm+O5km5Fq7uuO++7mKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606470; c=relaxed/simple;
	bh=ajVRT0nwCB34MxHO3njsvkFSUEkust6J9s0OvJjdu90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxyLjjnrI1eeStoJIXGHTgt2DQ+XPidh6KxJNl/oVvyN4hg6lKoDV1Egn8xgDoEbTkvyIBgcpo1HnyfOCn7JbmbMASryh62mCOrS8tZmjYojYp87uGrEpgr7/PuEnQeV7Zzmae+ulWhezcmMblB49S5Xoe7K1vpy03otnmeBiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEGsdCZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A31C433C7;
	Tue,  5 Mar 2024 02:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709606469;
	bh=ajVRT0nwCB34MxHO3njsvkFSUEkust6J9s0OvJjdu90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEGsdCZ6bMjicU5B7bQ6g6ubutX7uGVO9cBTL4qdBAHMoZVjYaBUlCAHTDQpJkCHG
	 YfUJ5zPC+sBKws3BgpQBZxwZdggiMXB0fKqXDXG73BWehX5FujHAwy3EgIqE2u6w/T
	 zcpiidHHfs2CoIUos/1hIv51PF3NbuuKAd+yNBAGZXAPXfWhDIoH9JhC28rDJBXDDZ
	 qeMOOXtjUQUfcoU8QRrVVOe/tUz11sUTT5UJFbisuFh638bTbRkNlMCZTW8QRd4D71
	 ME3L8A+ocdh02AwDJffAma/0enAdAYQsFHIEFqPUKvi8eoMn9qTnyW2ws3pUyNj/SG
	 cFntrsr+yjUKQ==
Message-ID: <d0719417-e67f-48a9-ac1a-970d0c405270@kernel.org>
Date: Mon, 4 Mar 2024 19:41:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
 <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
 <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
 <20240304074421.41726c4d@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240304074421.41726c4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 8:44 AM, Jakub Kicinski wrote:
> On Fri, 1 Mar 2024 16:45:58 -0800 Kui-Feng Lee wrote:
>> However, some extra waiting may be added to it.
>> There are two possible extra waiting. The first one is calling
>> round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
>> one is the granularity of waiting for 5 seconds (in our case) is 512ms
>> for HZ 1000 according to the comment at the very begin of timer.c.
>> In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
>> contribute up to 1144ms.
>>
>> Does that make sense?
>>
>> Debug build is slower. So, the test scripts will be slower than normal
>> build. That means the script is actually waiting longer with a debug build.
> 
> Meaning bumping the wait to $((($EXPIRE + 1) * 2))
> should be enough for the non-debug runner?

I have not had time to do a deep a dive on the timing, but it seems odd
to me that a 1 second timer can turn into 11 sec. That means for 10
seconds (10x the time the user requested) the route survived.

