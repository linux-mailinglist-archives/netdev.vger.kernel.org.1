Return-Path: <netdev+bounces-126850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CA972ACB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AA21C24214
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DA158DB2;
	Tue, 10 Sep 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btx9+Xyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D2335A7
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953471; cv=none; b=KQo1yRzABgH9WIWFQKHtHd0ddpirKNCx9fp13zI1TKSwZEDwDIwlSww7Re7IFsQpuQiOmnqez6ki79o6rfGPrlcqLVlVCqF9KSFDfI7rhFGwJcOOrwCsiF4YSSRuceirU51U5TPG6lNqkwJjvr8l190s+SDorwYjXCXDmAsTk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953471; c=relaxed/simple;
	bh=Hl9K7dWuggPXSUr9wt7jGrQahl6IduA53CdSnaNV/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N95nGH/fa0tXXUCYgc9jC8iuyAonaR21MOliymt6qEt40UJjEVKEPNoy8mwHPOTpp0N6t5txnu+mzoG8Im3WBEE5wVGzo4Np4UmdqmBAzN2lVldhn2y6AEZ2kdf6YDiX4AmYZtCuNjvBoDxxpD4pEMfN8yWkNZi7Oo5VLtth5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btx9+Xyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838F9C4CEC3;
	Tue, 10 Sep 2024 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725953471;
	bh=Hl9K7dWuggPXSUr9wt7jGrQahl6IduA53CdSnaNV/YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Btx9+Xyd7hmFc7WsldrQiSB8zD5PXdUViTghKuJXhXEgL9kGgfA0v21B1ooKnXsq/
	 uPLkGmvmSch73YMXQOL7WhOyDI56/E0ZS18rxg4FDSu1fiBD5RyYLhOAssngEwb9+S
	 53UqsMki4652y/Vog2uDPsI6lKCwWYSt0LRDnaymjrAZF//Dh8wazrw7Cc7N4+prBd
	 vN2QBIGhYu5dQ/lLkmaBbrEw3qjflpC9ZIf7cWErX1/PamW5GF6XIxuotJ+r8hCv/O
	 ums5ykN9n8qIPUjutNcetxi1gFt0u98UxJ1Tn+JCwjUuxwBB2NF4bxJ5hkZqlEUu1C
	 BnO/6US2aI9zQ==
Date: Tue, 10 Sep 2024 08:31:07 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [pull request][net-next V4 00/15] mlx5 updates 2024-09-02
Message-ID: <20240910073107.GA525413@kernel.org>
References: <20240909181250.41596-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909181250.41596-1-saeed@kernel.org>

On Mon, Sep 09, 2024 at 11:12:33AM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> This series adds HW steering support in mlx5.
> For more information please see tag log below.
> 
> V1->V2:
>  - Fix sparse and checkpatch issue.
> 
> V2->V3:
>  - Smatch and coccicheck fixes.
> 
> V3->V4:
>  - Error path fixes.
> 
> Please pull and let me know if there is any problem.

Thanks for addressing my review of v2 and v3.
I confirm that my concerns have been addressed.

...

