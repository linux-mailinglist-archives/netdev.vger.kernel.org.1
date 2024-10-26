Return-Path: <netdev+bounces-139349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBD9B192C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E50A1F2222A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D677603F;
	Sat, 26 Oct 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rImhvYBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DB70810
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956918; cv=none; b=CFLrzsferbOFAFp7vg5T3i1K8tU4O2euG5XKpNjcJHOBVwKrctCk0VAjI8vXrnvM04faOYHDeBDG3E8ExxAm9o4cycCYc8t5D8VWFh0iM9GRu2xYV6drL2mWB+DRanbMF7tK2CWL3j+WUIQfIlr0j0EkJeAlyvQEAguZZBm3ssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956918; c=relaxed/simple;
	bh=27y2eQMWRM3rJO8oWUJS/e+94tVAUer22rCGrCg+wbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7X+JMBpagXKoa8Ik9vjUKIpPR2A63wTwkBdy7Inl+uaE3z3ASqT4jPYFRC2VG7Ytw9eyTpBGDHutJzgvxKIeOMtdakJ8WeOuU6KSk8KAbnl3q9ji0zNABRBBNUUGdyCIXMv9UTdshjtgwHrg9VBqE45rRw8uzM9iQ/eyKiHURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rImhvYBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1295BC4CECC;
	Sat, 26 Oct 2024 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729956917;
	bh=27y2eQMWRM3rJO8oWUJS/e+94tVAUer22rCGrCg+wbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rImhvYBGT6evwJw96r9mLgOJ+Ty6LvnDsTbEhUfyN/8uY+SJyuErIGERx4C8u1mR2
	 l4LnRyUJ4xnC0CS0ZKKJal3DIkzEz3h3db3h1hgoimi49wOIp2WQ3lRrfGrmC9uSpV
	 hZ1l+BrbE/SvmCUbRzi2u/dMWTJWHy2Cur11AdjFpYUIgGzDw4t+jIUBQ2lqkdos74
	 iZS2+r12mf9LYjkluhz6VGQww7sFH40oxfuTPxZpre0loIbUAUmrcp6RIJtpimouDc
	 WizmENWxzjD7Qhz9t4a6ljeD4oy6hEnwb/3PYXM4JTk+TpCB/sJxH0Xa/ai3/zqEBz
	 nOht3IyYQe6OA==
Date: Sat, 26 Oct 2024 16:35:13 +0100
From: Simon Horman <horms@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bna: Remove error checking for debugfs create APIs
Message-ID: <20241026153513.GI1507976@kernel.org>
References: <20241026034800.450-1-thunder.leizhen@huawei.com>
 <20241026034800.450-2-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026034800.450-2-thunder.leizhen@huawei.com>

On Sat, Oct 26, 2024 at 11:47:59AM +0800, Zhen Lei wrote:
> Driver bna can work fine even if any previous call to debugfs create
> APIs failed. All return value checks of them should be dropped, as
> debugfs APIs say.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> index 97291bfbeea589e..220d20a829c8a84 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> @@ -500,19 +500,12 @@ bnad_debugfs_init(struct bnad *bnad)
>  	if (!bna_debugfs_root) {
>  		bna_debugfs_root = debugfs_create_dir("bna", NULL);
>  		atomic_set(&bna_debugfs_port_count, 0);
> -		if (!bna_debugfs_root) {
> -			netdev_warn(bnad->netdev,
> -				    "debugfs root dir creation failed\n");
> -			return;
> -		}
>  	}
>  
>  	/* Setup the pci_dev debugfs directory for the port */
>  	snprintf(name, sizeof(name), "pci_dev:%s", pci_name(bnad->pcidev));
>  	if (!bnad->port_debugfs_root) {
> -		bnad->port_debugfs_root =
> -			debugfs_create_dir(name, bna_debugfs_root);
> -
> +		bnad->port_debugfs_root = debugfs_create_dir(name, bna_debugfs_root);

nit: This change seems to only change line wrapping from <= 80 columns wide
     (still preferred for Networking code) to > 80 columns wide (not so good).

     Probably this part of the patch should be removed.
     If not, reworked so it is <= 80 columns wide.

Otherwise, this patch looks good to me.

>  		atomic_inc(&bna_debugfs_port_count);
>  
>  		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
> @@ -523,12 +516,6 @@ bnad_debugfs_init(struct bnad *bnad)
>  							bnad->port_debugfs_root,
>  							bnad,
>  							file->fops);
> -			if (!bnad->bnad_dentry_files[i]) {
> -				netdev_warn(bnad->netdev,
> -					    "create %s entry failed\n",
> -					    file->name);
> -				return;
> -			}
>  		}
>  	}
>  }

-- 
pw-bot: changes-requested

