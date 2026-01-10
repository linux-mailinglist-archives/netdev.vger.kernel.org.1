Return-Path: <netdev+bounces-248757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94DD0DEC2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8313024E51
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D50221DAE;
	Sat, 10 Jan 2026 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roo7Cxva"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AE1DDC1D;
	Sat, 10 Jan 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085574; cv=none; b=AI1STY/2bsIR4VBLjT6PZsqDpLpr7sZ5b/Pr1dq+yBeRpQFTcYf2TVlCRXIpA4UcCBF4m/dGkmqKPR3uiimVWts6UDUpbifPz4ekYpnh91hsNw3EHFkH/rmZ5C7BnCy17PyYzYh7xx7iszr15nvGJO2pwOoZvx803SpfmClcuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085574; c=relaxed/simple;
	bh=kQIXup3eGpGEzFjx2TOrT1yxsfQHKMJt3eerhakTGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaidcNCZaHawXrSgVLN8DAl3/GuRKUSHf6poSozhD9sedVCMDtOuuCeCrl1EWluqlj4c83+WLcXgZvayYX5CV2nFrv0kZB3vm/FOmV504lBUSjC/ehZBVhjYSbTKAcK6Uoc4MfOv1o32v3VqnPzQ45OofntfwjtGwBQFHBp+q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Roo7Cxva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35285C4CEF1;
	Sat, 10 Jan 2026 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085573;
	bh=kQIXup3eGpGEzFjx2TOrT1yxsfQHKMJt3eerhakTGXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Roo7CxvamP7CoBIqa5n8qan8WqlKbrvwTh/prkWhXbZY8PIgtSoSCwHq8oKIr3U0P
	 uevdOn2S6WQvaAYxDJ4ddf+PphsrRqeyFYK/vN77szMOSoXsnqN8ohJlJwABqM0133
	 /0SSL1YgMl10f7JhrG9Mn29mm9O72H1H7VRHXbXU1Mamyo3jxDHXQyMle6QA9PJc/I
	 qPhLTh/zf2nAv7q6bCJnVwWvA7HBurHgZuHekwQdJ2P0rpa+cKcWv2LX7Ey6rdy+ZH
	 qOL5xnlUNbXIN56hyw5p9NXqe8pkpPrDI5GQkAvhmpSAS39whajtTpXRvzLasPyiXu
	 yzgGliAC6Lcyw==
Date: Sat, 10 Jan 2026 14:52:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 09/13] octeontx2-af: npc: cn20k: virtual
 index support
Message-ID: <20260110145252.3ecf939f@kernel.org>
In-Reply-To: <20260109054828.1822307-10-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:18:24 +0530 Ratheesh Kannoth wrote:
> This patch adds support for virtual MCAM index allocation and
> improves CN20K MCAM defragmentation handling. A new field is
> introduced in the non-ref, non-contiguous MCAM allocation mailbox
> request to indicate that virtual indexes should be returned instead
> of physical ones. Virtual indexes allow the hardware to move mapped
> MCAM entries internally, enabling defragmentation and preventing
> scattered allocations across subbanks. The patch also enhances
> defragmentation by treating non-ref, non-contiguous allocations as
> ideal candidates for packing sparsely used regions, which can free
> up subbanks for potential x2 or x4 configuration. All such
> allocations are tracked and always returned as virtual indexes so
> they remain stable even when entries are moved during defrag.
> During defragmentation, MCAM entries may shift between subbanks,
> but their virtual indexes remain unchanged. Additionally, this
> update fixes an issue where entry statistics were not being
> restored correctly after defragmentation.

Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_idx2vidx_map' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_vidx2idx_map' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'defrag_lh' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'lock' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_idx2vidx_map' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'xa_vidx2idx_map' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'defrag_lh' not described in 'npc_priv_t'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:203 struct member 'lock' not described in 'npc_priv_t'

