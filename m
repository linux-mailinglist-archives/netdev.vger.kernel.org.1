Return-Path: <netdev+bounces-58753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B444B817FE0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816931C215CD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512F15AB;
	Tue, 19 Dec 2023 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM0UfcDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053911702
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 02:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0CFC433C8;
	Tue, 19 Dec 2023 02:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702953494;
	bh=0PvKh7wwMHm0vkqOj0P4irBZvnROHkhfZw5/YQYdIS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DM0UfcDk8Fuo+uAhCo/RkoWGnAzoP9GLqlgiF2H2atL8ssLCUCJuk/QJx7/d//nw4
	 BnnWurv4TD20NiSSic8HZdKvms1GCfm38TKSto8ApQYZmZpvbMrKsJ8YA0Y3YAUHOS
	 QLxhUSjstW1hOtLExCpXkYnJ6vl2MG8Loq4Uk2+zuSxrV64j3ja1UuieXoLkYGJ5D+
	 9d1C0su5Ia7ItL5EzdzLdWYNuIEcq7+AyUUmAmgxqDYc0hDL2+GE+Wr8EoUnJt6ngN
	 Aa0f0kwuoZ5uW6463Kr4igq9Z8aCpXWjY3KR1zCJ/isUItIirk7mV4fEO6ZG7atio+
	 WPKqmRJzyZAMA==
Message-ID: <c3ae9c3a-9ecd-4b22-a908-9da587c1c88b@kernel.org>
Date: Mon, 18 Dec 2023 19:38:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Revert remove expired routes with a
 separated list of routes
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, Kui-Feng Lee <thinker.li@gmail.com>
References: <20231217185505.22867-1-dsahern@kernel.org>
 <a289e845-f244-48a4-ba75-34ce027c0de4@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <a289e845-f244-48a4-ba75-34ce027c0de4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/23 6:14 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/17/23 10:55, David Ahern wrote:
>> Revert the remainder of 5a08d0065a915 which added a warn on if a fib
>> entry is still on the gc_link list, and then revert  all of the commit
>> in the Fixes tag. The commit has some race conditions given how expires
>> is managed on a fib6_info in relation to timer start, adding the entry
>> to the gc list and setting the timer value leading to UAF. Revert
>> the commit and try again in a later release.
> 
> May I know what your concerns are about the patch I provided?
> Even I try it again later, I still need to know what I miss and should
> address.

This is a judgement call based on 6.7-rc number and upcoming holidays
with people offline. A bug fix is needed for a performance optimization;
the smart response here is to revert the patch and try again after the
holidays.

