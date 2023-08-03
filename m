Return-Path: <netdev+bounces-24157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D362476F042
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75C31C215B7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B923BEE;
	Thu,  3 Aug 2023 17:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13B1ED55
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F72DC433C7;
	Thu,  3 Aug 2023 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691082067;
	bh=wA474XymD65CC5dKuW2W6SsS3E8kJfOKWrF/MmoRlJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jsZfPcoyR8Af89qv4Cg96ZnoZCeyumtSb2fNCwWlelSv5SUZpq3/Cqai2s+krJ8LN
	 /RFqxgf87lMmNZ/q31ff9mKTT7kK/Cec8imGAtL1KxAEBshrLkzbSRhVPuEW7V9H/r
	 dJNHaU3MMbtiii9M3LQ5ly4cMH4OhrD99/CPCzjnN0pgdRPYiL3tKfJdRe1QU6Hpj4
	 NYHAIKopdtKTg37LajlwF8z1d7DxhwSJwdjZEZi65n37nGZu1gaZKNG4rtzHQaKq0q
	 Z+flf6uRcd5T/OktAdV5yNF5z7oWiXWMrHmJmza/VXe/7+UzQgHhjS941QcJxIQ0zQ
	 +bU2z6iOKAIFA==
Date: Thu, 3 Aug 2023 10:01:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/6] page_pool: a couple of assorted
 optimizations
Message-ID: <20230803100106.4dd4f12a@kernel.org>
In-Reply-To: <20230803164014.993838-1-aleksander.lobakin@intel.com>
References: <20230803164014.993838-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 18:40:08 +0200 Alexander Lobakin wrote:
> That initially was a spin-off of the IAVF PP series[0], but has grown
> (and shrunk) since then a bunch. In fact, it consists of three
> semi-independent blocks:
> 
> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>   not overbloat the consumers not needing complex inline helpers and
>   then stop including it in skbuff.h at all. The first patch is also
>   prereq for the whole series.
> * #3: Improve cacheline locality for users of the Page Pool frag API.
> * #4-6: Use direct cache recycling more aggressively, when it is safe
>   obviously. In addition, make sure nobody wants to use Page Pool API
>   with disabled interrupts.
> 
> Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
> small modifications from my side as per ML discussions.
> For the perf numbers for #3-6, please see individual commit messages.
> 
> Also available on my GH with many more Page Pool goodies[1].

Replying here so that potential reviewers see.

I just pushed the update to docs which will conflict with this series.
Please rebase and repost (without the 24h wait).
-- 
pw-bot: cr

