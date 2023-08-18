Return-Path: <netdev+bounces-28855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592578104A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2342823F7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278F219BC7;
	Fri, 18 Aug 2023 16:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BF19BBA
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524C8C433C8;
	Fri, 18 Aug 2023 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692375973;
	bh=t5qWE8/TCYMEmPf18F9zukAy1jscVTI0vNiLTNKC6U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jxNmZK/lzxXvVcPl6UwRkQncA+3x/UisIVRA71DuRqijytOKm8PFZLXYvW79vl1J2
	 hi1m694A7s3epb/7tAqE8fzebJ35hm1Zqp6RdtiBIg4GQN3/b3eKjhkw1nR8+qEZMu
	 LqOgXLq6Xf0XlIDvt94eDrxHkNgTI3wJHMRurrZEM2X4lkFpxyn/XAJR41VBxYJmz+
	 JofFeBdghmbQyWvjPi8riZLfldDobAn/3TR161jRfNYRs8up8NdDZRHKDGVnMoHIEJ
	 FiV+28wSepp2Lpb+Cl+QyP70JyAscQ9cCeHGgFDQDScgJqdsnchBWmoh5TxqedzaNG
	 PuhU6ar4LNnUw==
Date: Fri, 18 Aug 2023 09:26:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, vbabka@suse.cz, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>,
 Christoph Lameter <cl@linux.com>, roman.gushchin@linux.dev,
 dsterba@suse.com
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Message-ID: <20230818092612.74025dc7@kernel.org>
In-Reply-To: <169211265663.1491038.8580163757548985946.stgit@firesoul>
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 17:17:36 +0200 Jesper Dangaard Brouer wrote:
> Subject: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache

Has this been a problem "forever"?
We're getting late in the release cycle for non-regression & non-crash
changes, even if small regression potential..

