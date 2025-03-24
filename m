Return-Path: <netdev+bounces-177241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA98A6E66A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863A116C674
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F91D1EA7C7;
	Mon, 24 Mar 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFHQFc7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFD1A2C06;
	Mon, 24 Mar 2025 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854287; cv=none; b=HSULr29UcEQgS0+jxa2AaGuHvElwnSh9b0+G1xv4fl3jxsOzjidP1hpkJx1YMXnhnsVSoX2qe25zfOtknq/GffuFU3WKbHg4gWdGU2vv2lxBNH12w6aTXug7TJHJV521kXf0R73Z/+/LsDtp5x+51pooJLDTyGnFiLfKkiHYOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854287; c=relaxed/simple;
	bh=25ILf6T8x7Jzl8pp4Bv2f1/2BtN7CZRZip4Sn4QcCqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WusKFGWSs1d0Twn2yulHJp8EiUT2sHZN4gjwuPbmo0hUivcJ2gcbj1cBxxGWKE8axQDHZ626WjjYOC5ZcMvbBJgxZ9uXC2y9KAD6FZ1ZW4ZzyPwZxojyG20DeG5weM631gJxJqmhSHhqdtSEdzQ69cV9BfDueNWzLl+4GjoRVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFHQFc7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED17C4CEDD;
	Mon, 24 Mar 2025 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742854286;
	bh=25ILf6T8x7Jzl8pp4Bv2f1/2BtN7CZRZip4Sn4QcCqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KFHQFc7FbLfKKyS5Y1xzC7nGw/2aP7HgxzbODNUpLKwPjyAY0yf16jmMaxb5H+SVQ
	 r1JhIYDkFXVEYLybyDCTgZduivEnzPrsCgd72j9BpgbBGKKRPy+5rspV8+ggI2t05J
	 bFLqhCjOj06Sc+XTlAWGUjmAFBviSYooQor+VlMyZXGlBISP2ZfsJAKI0N3oJYbzww
	 tnugCe+cOk0vQCvJomiOBCXLBqRn4B794gEFZgrvugqX/Cqmc6qbt2gxSdnxqhanMq
	 6+So3tP9wPXIQNjqyXg0NNf2C1n0OTQD+ogvloGMnzNA/9JR9lCQ1H1LxiwlfI40TU
	 mpXgDFNjkqisQ==
Message-ID: <4bb08c33-eac5-46e1-8d59-acc125946654@kernel.org>
Date: Mon, 24 Mar 2025 23:11:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool
 benchmark
To: Mina Almasry <almasrymina@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250309084118.3080950-1-almasrymina@google.com>
 <87a59txn3v.fsf@toke.dk>
 <CAHS8izM30jZ+bKkpeKQLKk3BGj8nBFLpUFgS2qM7x8EPMV7KOQ@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAHS8izM30jZ+bKkpeKQLKk3BGj8nBFLpUFgS2qM7x8EPMV7KOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/03/2025 21.23, Mina Almasry wrote:
> On Mon, Mar 10, 2025 at 2:15 AM Toke Høiland-Jørgensen <toke@toke.dk> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>
>>> We frequently consult with Jesper's out-of-tree page_pool benchmark to
>>> evaluate page_pool changes.
>>>
>>> Consider importing the benchmark into the upstream linux kernel tree so
>>> that (a) we're all running the same version, (b) pave the way for shared
>>> improvements, and (c) maybe one day integrate it with nipa, if possible.
>>>
>>> I imported the bench_page_pool_simple from commit 35b1716d0c30 ("Add
>>> page_bench06_walk_all"), from this repository:
>>> https://github.com/netoptimizer/prototype-kernel.git
>>>
>>> I imported the benchmark, largely as-is. I only fixed build or
>>> checkpatch issues.
>>>
>>> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
>>> Cc: netdev@vger.kernel.org
>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>>
>>> ---
>>>
>>> RFC discussion points:
>>> - Desirable to import it?
>>
>> I think so, yeah.
>>
>>> - Can the benchmark be imported as-is for an initial version? Or needs
>>>    lots of modifications?
>>
>> One thing that I was discussing with Jesper the other day is that the
>> current version allocates the page_pool itself in softirq context, which
>> leads to some "may sleep" warning. I think we should fix that before
>> upstreaming.
>>
> 
> I don't think I saw that warning for whatever reason. Do you by any
> chance have a fix that I can squash? Or do you think it is very
> critical to fix this before upstreaming? I.e. not follow up with a
> fix?

The tasklet trick in the benchmark module is to fake that code is
running in softirq context, which avoids taking the _bh lock variants.

In the past the performance was really different between the two
execution contexts, but in all of my recent experiments [1][2], the
performance differences are gone. So, I think we can simply drop the
ugly tasklet setup tricks.

  [1] 
https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool07_bench_DMA_fix.org
  [2] 
https://github.com/xdp-project/xdp-project/blob/main/areas/mem/page_pool08_bench_AMD.org

BTW it is awesome that you are pushing this to get upstreamed.

--Jesper

