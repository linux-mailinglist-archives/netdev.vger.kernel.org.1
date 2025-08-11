Return-Path: <netdev+bounces-212503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDEB21098
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B541C7B3325
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B62E2822;
	Mon, 11 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhoioDC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4D2E2821
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926904; cv=none; b=L2aNGDgmkth3+Lz8w9pxtRBW1BfQ58NbjnS2FDesXPhAJeqixoN5I4BxAjVxL9o3YFmr8OD4GT5+9iBeDE3QUTgXlh9sDA/zR+Q28UDadJaBNV9+SCzlxzzq7FqtF2ISWsz7/ejRs8hqe095BCY1/EUpzpY5VeZpHJasu5DlQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926904; c=relaxed/simple;
	bh=F5bH9wCajdZ8aY2x4pPk3brOqFaahwF3R3J0oiktE78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJmIq8Ebm8t2e7UJgdCPb2F3lozoOPSFRGdSnthc0WIT4EOofI2PD78c5JfDm5xyMKbM6EePA0d2indKoLo/wVHPzCahVi3Dgn/xRbplS9GGakTRDB5gxNy5J8pwKdezIDviF06D4stYBR3MkAreLvb5vj43dJz+1T3lt4MMJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhoioDC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA879C4CEED;
	Mon, 11 Aug 2025 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926904;
	bh=F5bH9wCajdZ8aY2x4pPk3brOqFaahwF3R3J0oiktE78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhoioDC6njhfhtCdQh5Trj5t3/sonMmMfi9zz469Ck8UHeiWwy9z+BVdj6dx4oC2n
	 WVIGrbFAeWjrUp1UTXyuAbEgHJqUY+7wuyC1t5L+Fi7sAtkzstuQVdRWwwI/NfkKrD
	 8ujQ03SHM81qkx469j1HANCqnx8aDp7cn1ZDjHQFHH2K14VIeQ70Y6QAJ/GQgjcKJU
	 QdYOTliB4P8dOLiXmAgJraigUw/OQ0/jIsk/k7kXRzfyYNfFqr7jpc2YzNPduijqA/
	 rRhF1bVlgUE8iKH34HHoODxWt7EWGfFA8Fq8P0enzVYnSODd0T3JHc36Qz2knoz/9s
	 jjbm9j2eMQDRg==
Date: Mon, 11 Aug 2025 08:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH v4] ethtool: add FEC bins histogramm report
Message-ID: <20250811084142.459a9a75@kernel.org>
In-Reply-To: <ec9e7da6-30f0-40aa-8cb7-bfa0ff814126@linux.dev>
References: <20250807155924.2272507-1-vadfed@meta.com>
	<20250808131522.0dc26de4@kernel.org>
	<ec9e7da6-30f0-40aa-8cb7-bfa0ff814126@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 11:52:55 +0100 Vadim Fedorenko wrote:
> > TBH I'm a bit unsure if this is really worth breaking out into
> > individual nla_puts(). We generally recommend that, but here it's
> > an array of simple ints.. maybe we're better of with a binary / C
> > array of u64. Like the existing FEC stats but without also folding
> > the total value into index 0.  
> 
> Well, the current implementation is straight forward. Do you propose to
> have drivers fill in the amount of lanes they have histogram for, or
> should we always put array of ETHTOOL_MAX_LANES values and let
> user-space to figure out what to show?

Similar logic to what you have, you can move the put outside of the
loop, let the loop break or exit, and then @j will tell you how many
entries to fill..

