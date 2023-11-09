Return-Path: <netdev+bounces-46731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39D7E61FB
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548D4280F98
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468B10E1;
	Thu,  9 Nov 2023 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdhREZbP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385364C8D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77689C433C8;
	Thu,  9 Nov 2023 02:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699495573;
	bh=mha02uxgjSUNHXZ17TIvV0cebQbUGfZb35U/ymU9+eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PdhREZbP9T1Uyq0vGVeFoS8iwCAcVqPhEGTfjDSCUsmmx2ccUzp6vkWGZliUsjE3W
	 +h0w5izhyJP6lA7IrD3jSnC0In0Jy6/9wZmd6vLkvfh7XafoKtgaTuAiu7f2G2sI4d
	 lifjctretbhItLsBseLsqG95Ak72w6MzDgbljGEwVfR6QY5JIijY3dMMdKLgeqy0SM
	 HUEq+bhzA8w0qZOWh2jmBSkviWzup946X8StjaERsh+JqXxpfHcPjg4yqEIJFPD8ou
	 Q7/xZNxhpBFPRW4DXvR5YBGW1MJPyIjmJ7Is/Cg4yHZvEkj4bChl12ZHNPiO98pFmQ
	 6C9NwUxzDJXyA==
Date: Wed, 8 Nov 2023 18:06:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [PATCH][ncsi] Revert NCSI link loss/gain commit
Message-ID: <20231108180602.43c2bfad@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20231108222943.4098887-1-johnathanx.mantey@intel.com>
References: <20231108222943.4098887-1-johnathanx.mantey@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 14:29:43 -0800 Johnathan Mantey wrote:
> The NCSI commit
> ncsi: Propagate carrier gain/loss events to the NCSI controller
> introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> This change, when merged, needs to be backported to stable kernels.

You need to add a Fixes tag (pointing at the reverted change), 
and a CC: stable tag. Here's an example of a well formatted fix:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=02d5fdbf4f2b8c406f7a4c98fa52aa181a11d733

When you repost make sure you use get_maintainers on the patch file, 
to catch all reviewers. And put [PATCH net v2] ncsi: Revert...
as the subject.
-- 
pw-bot: cr

