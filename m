Return-Path: <netdev+bounces-190408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B93AB6BE0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81453173A56
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD32277808;
	Wed, 14 May 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVN5awS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FE27510A
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227330; cv=none; b=G1RRH8g+d3DBgbmuT7g5r690b/GTyBTUVYxWt6lu0cVcV/JId6d/oe6UlP1t90UQeQA1qjdiPmnsz3Q/6p59HhcrnRdCf/lMZAHO0IpsrUc3ZHtoSVkZ7qDlHDuWlqstiH96g/Vh7pbUaWr+0IkjK5tDX6WemVpBTwMX8gfm3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227330; c=relaxed/simple;
	bh=Otncq1rB8JJrYsjSRIBuPMipOTmSy3WcftHfLm7CEtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3SnjD6/rNQEFZiLgalofIUVn0FBG0kksi+Skyhbf0kGGTCoSWEGrUjO3Zyy+5DmQkMT2tI5bGQEIa3ylBNH6bSKn6TriHj+AkkKM3CQskrrpj74yRPpXREVkT1hbKJ4Z/CnlusbpBX7SEUZ1pM25Qtt/35WEI/VQXEMrYQuV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVN5awS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD7CC4CEE9;
	Wed, 14 May 2025 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747227329;
	bh=Otncq1rB8JJrYsjSRIBuPMipOTmSy3WcftHfLm7CEtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVN5awS0T8UzWBusKPCuhkH7A6rIqLc3qs3/lN/3RPo1U9c+GbP9g3vvpMtSPYKZl
	 quu2Y9g0Nf3u+oy/Dp300icLdGvIWZfn/35vfC3+RZb7kj/P8FcUwXVKXgDJ32/obZ
	 18bbWvpNq6Xj/TQBnUQmrXNcHzGa4kMhs4Upc3AFUjJckutgKb5H4dDKWeNIBfq721
	 6PY8+PSVdwytgusWYwD94e+ONLdqpqFwuAFc1/qcyPDVx2rfJ0v7NfDiIPaJSavTaf
	 dFtkmN3Wsc+oTGsKhnx9ynztN04B3KjB7m8NrTDnaig4qaTCCFjQ/w6CCG+LFXDqq7
	 +XuddAnHhriCA==
Date: Wed, 14 May 2025 13:55:25 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next v2 PATCH 1/2] octeontx2-af: Add MACSEC capability flag
Message-ID: <20250514125525.GM3339421@horms.kernel.org>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
 <1746969767-13129-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746969767-13129-2-git-send-email-sbhatta@marvell.com>

On Sun, May 11, 2025 at 06:52:46PM +0530, Subbaraya Sundeep wrote:
> MACSEC block may be fused out on some silicons hence modify
> get_hw_cap mailbox message to set a capability flag in its
> response message based on MACSEC block availability.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


