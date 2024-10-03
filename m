Return-Path: <netdev+bounces-131619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D76898F0C9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB721F21B47
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240D19CC04;
	Thu,  3 Oct 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Q8W4G3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630D19C57F;
	Thu,  3 Oct 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963293; cv=none; b=L7JZFKdQAgWLeZ9KQmAxRDlQU6+agv95w6gGM7/AKUGp2rwPqTKSFTli2lxBDV3yoRv8/Ulqe//OSMgP1cCvv82/4x89kqgfeGR9UJ56MIprpeI29kBqrsIb9XTkBi8qFq7h4uDXree08uWaXVI8o/aIcp20e9BYOy3SjejCewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963293; c=relaxed/simple;
	bh=Pcf1C/POCe7HwoUC3D/WWJhTwc+2H52b9z20++v3c5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR2r9M3N2fJfGg252RTj9exkCuLYUPwhQX1oxsQTl44r/YIMPAFIUFa00VT+EOeA4q+qyKc3YZljfWPJzEZL62Y3fF/jE0exibgqXZqTHlGe1UImo/8Phokea9CB8A5Uzjnu9lMZurbSusU7S2j7wUXa/v9ru5vJqDGvdMnddgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Q8W4G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDB9C4CEC5;
	Thu,  3 Oct 2024 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727963292;
	bh=Pcf1C/POCe7HwoUC3D/WWJhTwc+2H52b9z20++v3c5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Q8W4G3HmS7/4f0qaPq+APBpihg0ujMldpyTwjlXalVBYhiJWUIkTk9fF9+G0piB
	 F/bbab+kuve8wA5RHts2SiofPmYccJLedQAaoCsvUNtFZv/z3FuiGUYs1A/DIPJX/K
	 meekCRUoM03MBC5CD8riu18oN9A5cXY2h6d/yM8uGmkjrmtcr2zdv2Bk73qGWiP9md
	 yON1QodmF03ig9IYmJazUe+5V7oC6ce2DOFEhIgYtfQSHJHXEFDvhTOXkkRtXFAnbM
	 QqQKfRpOuiTU2yDDIAtSUdAuwgv1TV8yH1wtYKx4ezhYZL9RwipvKoh/t3q5jobuAS
	 U5pJAFGqGFhLA==
Date: Thu, 3 Oct 2024 14:48:04 +0100
From: Simon Horman <horms@kernel.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rsaladi2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] octeontx2-af: Change block parameter to
 const pointer in get_lf_str_list
Message-ID: <20241003134804.GO1310185@kernel.org>
References: <20241001110542.5404-2-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001110542.5404-2-riyandhiman14@gmail.com>

On Tue, Oct 01, 2024 at 04:35:43PM +0530, Riyan Dhiman wrote:
> Convert struct rvu_block block to const struct rvu_block *block in
> get_lf_str_list() function parameter. This improves efficiency by
> avoiding structure copying and reflects the function's read-only
> access to block.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> v2: change target branch to net-next and remove fix tag.
> Compile tested only

Reviewed-by: Simon Horman <horms@kernel.org>


