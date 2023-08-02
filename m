Return-Path: <netdev+bounces-23671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B376D118
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1711C212F2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF4882D;
	Wed,  2 Aug 2023 15:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEF8BE3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C46C433C9;
	Wed,  2 Aug 2023 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988954;
	bh=l7L4Zg40wpvg7phjkfx5DUjxF1SbkFE+rcjcKObTNbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDNposHknVlDeMRvEG/MDfZEnwJ71kGx1q+njzovP0cEra9ZXAQiEAh5s8mMjaPh/
	 PA+ibKsLBc3S4Hfyr5lVG9Xo9Q8m+9ZUJFBTO5g5ynCNSPv93NA/ltLhK649RYfbZ6
	 dyQzFJPy5/G4sw1tyONwGRfIalJEXGCg8ttcHPlpLWrnUA109Gj4c8vRrvirV46Awy
	 0/39n+MfmhG8QoFtgMMzH1xLFTK943KXoQt4rshAidjus/9dEnkN/YYRbBj+cTJTtq
	 uGAzhdXqCjKueKjesF7fbGPNONwtl4Pk1l2CYbwAIshuRDj6yEEtZ2mvDwvNTbjneC
	 w1gtUZkfbq/Rw==
Date: Wed, 2 Aug 2023 17:09:10 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lucien.xin@gmail.com, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipc: Remove unused function declarations
Message-ID: <ZMpxllF9qdtC6nVd@kernel.org>
References: <20230802034659.39840-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802034659.39840-1-yuehaibing@huawei.com>

On Wed, Aug 02, 2023 at 11:46:59AM +0800, Yue Haibing wrote:
> Commit d50ccc2d3909 ("tipc: add 128-bit node identifier") declared but never
> implemented tipc_node_id2hash().
> Also commit 5c216e1d28c8 ("tipc: Allow run-time alteration of default link settings")
> never implemented tipc_media_set_priority() and tipc_media_set_window(),
> commit cad2929dc432 ("tipc: update a binding service via broadcast") only declared
> tipc_named_bcast().
> 
> Since commit be07f056396d ("tipc: simplify the finalize work queue")
> tipc_sched_net_finalize() is removed and declaration is unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

