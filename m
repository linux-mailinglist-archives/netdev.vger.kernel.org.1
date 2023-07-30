Return-Path: <netdev+bounces-22646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDA7686A6
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDB02816C7
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF19D100B9;
	Sun, 30 Jul 2023 17:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0FDF4F
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE51C433C7;
	Sun, 30 Jul 2023 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690737809;
	bh=Td3SQZbECPhAKn9YumidUWiUzer2inokUiFedh9UIQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8vqCgbUxJMpRM7WhgzoyORVKYM/QsO+7LLS0A3EbKt+wAHXPx+VxaorGMokaS135
	 HzROxvssCuwwnoM2/yg2wpkn6gCgDgSic9nI/yMGiMZ1wD2fb40Jej26TTAZJpU3y3
	 BApf50enc6Q6b6gScLxJa3PG7W/0jM/k7ut+oCBJqK8OFuWG5ji72Eh7YB3SNxiyMA
	 x25sw1sIj3hfq+4A3OE4aahSVRmLXmd01kFBAzhn2WvoQ5HHVXWRfpPvalcnLHyYV4
	 Lxk5bx98lzGmWmmncpNdkvMub+sJvuMCixMgp+4hYFvh9wdNavpBz4Wwo9115gECv6
	 nyQulmuLsV7Bw==
Date: Sun, 30 Jul 2023 19:23:25 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Remove unused declaration
 nl80211_pmsr_dump_results()
Message-ID: <ZMacjbACX9SCeIAf@kernel.org>
References: <20230729121651.36836-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121651.36836-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:16:51PM +0800, Yue Haibing wrote:
> nl80211_pmsr_dump_results() is never implemented since introducted in
> commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


