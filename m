Return-Path: <netdev+bounces-248755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA69D0DEB6
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3FD300BD80
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB250221DAE;
	Sat, 10 Jan 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpwWQiui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88810F4FA;
	Sat, 10 Jan 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085476; cv=none; b=QQFkFW8MVpE1BbEvhKdtzvCMnTy9MgVHdvOXMZoY4T2vbERJ2uS99boZKI6HyEBNg5KRdgTZRCdj2rLhZzwYE0qjzvVdaRS04NbCDkg0DggvzkVfvjKU01cN3kJzP5WCKGWAkzTh04tSlwfRi9vuFmmuesKB5ouUbHrKK8cQ2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085476; c=relaxed/simple;
	bh=zQuvGiK9Qg90Id6ZPqyAZI4D5tpmRlHZXJme2Plx3Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETXmPeinKkcCK8qOXq8JHw1ETXr6Kv0+yFzuScHvXpQLVgxSZthpMGckWBkZ8hjEMbwn1OnzXaBA60uSq8fx4HNFyG5rHiHIlTIulry89oL5Gf3Y4R5nnT8yhQ1TcxB/R6+iD69QqIp9pgY9cbpZmKGfaMBHw6fMRk612giIA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpwWQiui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85788C4CEF1;
	Sat, 10 Jan 2026 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085475;
	bh=zQuvGiK9Qg90Id6ZPqyAZI4D5tpmRlHZXJme2Plx3Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpwWQiuioXs9b8WEl8OqSRmb6c0vEGfhvfFHg39xrPBoVxr8zGvBe6PQBjOEt+O0t
	 ltdntShNpU8VlO0lHV5jUoz8Oow6ByoZ/USugSCf0LD4kRpG0EEQg6VLMhnwt2DcZ/
	 JAyiVb+QnlQLPDZ6DdmYJDQdbAVkD/2Cm0IATk0VtgX7nXT7gDVCVEjz1/WlufltF0
	 EKcKm2jSVIdgVtQNroAWRJtrf3ourh/XAqxAJAnXIDZUHKa+FHSg4ESuXfGSM5whAN
	 h3xa6QK6QqMqweC5aAxn+uwyk/g+oLuwxfAZB8st6Nf39Vz0SKLm3LAT6yPuvlGFC1
	 Mhb5VUgraQhXA==
Date: Sat, 10 Jan 2026 14:51:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <20260110145114.0533cb52@kernel.org>
In-Reply-To: <20260109054828.1822307-2-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:
> +/**
> + * struct npc_priv_t - NPC private structure.
> + * @bank_depth:		Total entries in each bank.
> + * @num_banks:		Number of banks.
> + * @subbank_depth:	Depth of subbank.
> + * @kw:			Kex configured key type.
> + * @sb:			Subbank array.
> + * @xa_sb_used:		Array of used subbanks.
> + * @xa_sb_free:		Array of free subbanks.
> + * @xa_pf2idx_map:	PF to mcam index map.
> + * @xa_idx2pf_map:	Mcam index to PF map.
> + * @xa_pf_map:		Pcifunc to index map.
> + * @pf_cnt:		Number of PFs.A
> + * @init_don:		Indicates MCAM initialization is done.
> + *
> + * This structure is populated during probing time by reading
> + * HW csr registers.
> + */
> +struct npc_priv_t {
> +	int bank_depth;
> +	const int num_banks;
> +	int num_subbanks;
> +	int subbank_depth;
> +	u8 kw;				/* Kex configure Keywidth. */
> +	struct npc_subbank *sb;		/* Array of subbanks */
> +	struct xarray xa_sb_used;	/* xarray of used subbanks */
> +	struct xarray xa_sb_free;	/* xarray of free subbanks */
> +	struct xarray *xa_pf2idx_map;	/* Each PF to map its mcam idxes */
> +	struct xarray xa_idx2pf_map;	/* Mcam idxes to pf map. */
> +	struct xarray xa_pf_map;	/* pcifunc to index map. */
> +	int pf_cnt;
> +	bool init_done;
> +};

Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'num_subbanks' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'init_done' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'num_subbanks' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:93 struct member 'init_done' not described in 'npc_priv_t'
-- 
pw-bot: cr

