Return-Path: <netdev+bounces-61400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A904F8239E5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56109287D12
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B636C;
	Thu,  4 Jan 2024 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr43Cizp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1C1FA1;
	Thu,  4 Jan 2024 00:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E9C433C8;
	Thu,  4 Jan 2024 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704329732;
	bh=ZzByeT7rvxWucxRsnlluNP4y5hW/90iqC5LkYgaNBVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kr43CizpdpMQwR7z5EXLo1+z2mnf95SpEqkwWE6zzN8V4OhmTezfL/BqrKx64J3oT
	 ZoyliYykQIuNDknwH7+nn12Tt7dYkgoc9opDmVB2JIRie6AoIzDMZjRK/BMNw2wZOP
	 +7UZi4adER+oE1GlsvJiP3ZMa9UzyRe3HFzmrkyqWi3aUVaqpNRPnB8ohM4cGX2pVH
	 uRlJ8EWIyy3M9gXXsVZYnrEzE0jUQszwclGA6Av12yYM+Z3HAuOJEB4TV4mY048mFR
	 8vbqhk0/4fcJ3gp4O/rLRCVWL3dgucN5RAsDAR5Wzz9F1bDVE3maXvNU2YjKs5o3U8
	 lIMZlD7rOIFQw==
Date: Wed, 3 Jan 2024 16:55:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zhu Yanjun <yanjun.zhu@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Zhu Yanjun
 <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 1/1] virtio_net: Fix =?UTF-8?B?IuKAmCVk4oCZ?=
 directive writing between 1 and 11 bytes into a region of size 10" warnings
Message-ID: <20240103165531.12390f0e@kernel.org>
In-Reply-To: <20231227142637.2479149-1-yanjun.zhu@intel.com>
References: <20231227142637.2479149-1-yanjun.zhu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 22:26:37 +0800 Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Fix the warnings when building virtio_net driver.

This got marked as Not Applicable in patchwork, not sure why.
Could you repost?

