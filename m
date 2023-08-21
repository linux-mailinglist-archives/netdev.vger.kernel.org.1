Return-Path: <netdev+bounces-29415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C477830FD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45F01C20985
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEE11707;
	Mon, 21 Aug 2023 19:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7293F9CA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FB6C433C7;
	Mon, 21 Aug 2023 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692646769;
	bh=2nMPMAQl+BY+zSu0ZVDIh6KboajkKrv3QiT3C7vXeM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf46oul9+a+jU7p6Wa58OmaM8kt84H+fGEAfOv1XVtj9bsZtv8xUPQvF0f41UVsCp
	 bm832nuqFnMJh2lMlmImgiBABgfzzSkmUgrjU4G+ZXagVrKEIlk3JNwVYgdpGpsi21
	 D4t3Sp0WEtLT47d9crE/N5SPTBHt/BXeAu0v+xhJt9sX7BWeeirNcpkYCH/YO70PKN
	 CIFXYZd4n/UuL5N2EF4/qhQzFCotezpBn0r7iGPID518BTVpUL+YGEmLM9Kl3m/xlx
	 h0DNxIXZOTzyZygGqXJ98vwmYzFRQk6UZuGv2KzEfPapbKojo2IPwxAPkRaHt6CxAo
	 6nzZklbbwYVzQ==
Date: Mon, 21 Aug 2023 12:39:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, brett.creeley@amd.com,
 drivers@pensando.io, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
Message-ID: <20230821123927.4806075c@kernel.org>
In-Reply-To: <46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
References: <20230821134717.51936-1-yuehaibing@huawei.com>
	<46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 10:26:40 -0700 Nelson, Shannon wrote:
> > Commit fbfb8031533c ("ionic: Add hardware init and device commands")
> > declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
> > Commit 969f84394604 ("ionic: sync the filters in the work task")
> > declared but never implemented ionic_rx_filters_need_sync().
> > 
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>  
> 
> This should include a "Fixes" tag

Nope, it's harmless, no Fixes needed.
Fixes is for backporting, why would we backport this.

