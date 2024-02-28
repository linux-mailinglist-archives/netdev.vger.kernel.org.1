Return-Path: <netdev+bounces-75781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5586B29A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99749285EA5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F215CD52;
	Wed, 28 Feb 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W99YsBqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FE15B116
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132670; cv=none; b=Nrs7tyLKpkeTtrKE3cM825pCnVlzMtu50inH9MJ6RYps68gh3quux3HR/uzuDg9ER89vA/9Ah2/r8rrUCHOoK5qbK1NqDFucIMVzzgJWHGTzHZFUeBDVI2tBmz7AxeUDFY6hv5Wtdzhkbvp24cNnCZn46rWi11rtxOEFcT3MkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132670; c=relaxed/simple;
	bh=bxlS65jKUcIIlPjtM8o4MKI1ryyJX5H10x4xbVKgzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg8550HZNo928kZPMmm3uj1f07lPZ/paDxsjvnAmzQW9YTVsEjM6N3WIJa1QBvdfVAkzr5iVFxwdXlf4S7fnEPfvOOMzoK38K0gnSJEdXpwhH504NtOinNi2nfzWEtWJqQvQNIJCPf7Ur+zk8NmaFoj5vc01BcnPobzLNKrxT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W99YsBqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F207AC433C7;
	Wed, 28 Feb 2024 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709132668;
	bh=bxlS65jKUcIIlPjtM8o4MKI1ryyJX5H10x4xbVKgzQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W99YsBqxURjgSYIfPoc40LS3B3EEqf9sNAUUfWR9LYQu/yxjDsMJlnl1DUUhDOW+i
	 nd4YekzkqIdhAfQ1lQtHW6QvwczIbplbGVMqsidCTq+F6h3xtjJ22ZQMzot9c9T7To
	 bcCx/G59uWtEOnknJFcLnPal8OKAe1pKE0Oeplg3wgO2ij5pAKp/grlrqTa3QSLTPz
	 kwOdmqegfcjO06DYlGD7mEjU5SQn1u7OJy36zrc5a7XJWAY8M/oYTLVBzBWxMZb+59
	 KfWou4t+MIlg5VNcfziyEFotcQ5hsbe/MEAyXP9j+aqw+namYBrIrrbGksM/Rv09ew
	 vMLLNvwdAfhig==
Date: Wed, 28 Feb 2024 15:04:25 +0000
From: Simon Horman <horms@kernel.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2] net: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240228150425.GI292522@kernel.org>
References: <20240227170937.GD277116@kernel.org>
 <20240228030658.3512782-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228030658.3512782-1-chengming.zhou@linux.dev>

On Wed, Feb 28, 2024 at 03:06:58AM +0000, Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
> 
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - Update the patch description and include the related link to
>    make it clearer that SLAB_MEM_SPREAD flag is now a no-op.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

