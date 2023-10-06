Return-Path: <netdev+bounces-38552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6C7BB653
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AA11C209A3
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3F1C685;
	Fri,  6 Oct 2023 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCcUDI1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B501C2B8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EC9C43391;
	Fri,  6 Oct 2023 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696591239;
	bh=kFxs3hCHi5I7QGQEivRopqVOmOAgS/9t+tGmtdBttGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCcUDI1sjfPB1CvknDDtG1tn84Y2URFKyd53KY8zku88U5DB3EpJUDU3bB0SYda5X
	 R8kuI8ImDqWCZLYUwRdoNXSu48nYi2cUNyMUFB0iVNiEm2Dnh9WQUs1Q0ZxzijHWUi
	 ldakbVs5lCckneaPw05pgx0pSmhRyJxOmh2DPS5BpG+6tgLo78DJp6wVUipVrWGkmD
	 pQOSI8PdCeSfO03ABwPZoAoF7jSRsWH3WgSG1bB3OgAd0nPJAEpOKgwQUOuEhrX4AQ
	 tWI7HMTjThoTtNScL8bvsXILW3dx195PD515nL244Ev8QV80MWcYzPy5drLO61/sau
	 TsqFRUGLKqPPg==
Date: Fri, 6 Oct 2023 13:20:34 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] igb: Fix an end of loop test
Message-ID: <ZR/tginYKa7Zcwug@kernel.org>
References: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>

On Thu, Oct 05, 2023 at 04:57:21PM +0300, Dan Carpenter wrote:
> When we exit a list_for_each_entry() without hitting a break statement,
> the list iterator isn't NULL, it just point to an offset off the
> list_head.  In that situation, it wouldn't be too surprising for
> entry->free to be true and we end up corrupting memory.
> 
> The way to test for these is to just set a flag.
> 
> Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>

