Return-Path: <netdev+bounces-165642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E2A32EB8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4381888EC5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958221129C;
	Wed, 12 Feb 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwOAx+5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B527180B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385140; cv=none; b=GNztbaxMj0R6m0Zzdl1PphbOwKo9MdpMVPz70x2KvR/nM8+9QgcNr2rLRTxPowwfLEKj8RkubBA9ncMzqJX4AwfQTa92mCRoV9gde0MACDianQiA3o3MJrUQUwnIc3gADoLFoUvoHsI9TMPscw2XXwc+Lp/i4OPa3T+3mGRBwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385140; c=relaxed/simple;
	bh=2qDrIVAXTZT3x6z+YVTK5v4twAJ6NYLMlH0hoHkMmRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHjFiZEyavXprmk6JR98GWGOWeDbWjgHtmg+pROm0zx3BePjbXGaO4uAZVmLLyiavjj79BlplLSgPjb5Ass6xR5vF4CDr+2W8cmPhUC/UUlA34W7sJeAIFgtiS9UmuNVgJZ8gWbgwTtoBJPtp2fD6PaFopkq4z+Fi9VA076XLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwOAx+5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347A1C4CEDF;
	Wed, 12 Feb 2025 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739385139;
	bh=2qDrIVAXTZT3x6z+YVTK5v4twAJ6NYLMlH0hoHkMmRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwOAx+5bnlp+KpF4zdmgbAoeJMG6JVTCS8U4tjmuXWuAq1JfgPghSYNAVoIFyojHd
	 Ap+QBfAvTd3etCXX/FhCSSJrUY/wHGKnQ5vecVDMkviH5aHlYuZaLqe6ANzHxPifis
	 SebmzRWzlzOJ39P0dFG5+l4VzJyGACFA+HUvNJrtOQib8AAnRIR8pfeTDhTTx5DLCQ
	 fj1shtsAaQ06pzDCFzq3MhToRjRonu7Ve32fHl4saU8MowsDzvNJODmeW9JGJtS+vX
	 w1GXkLCbXfWDha8KDD/JpJFXNpWRsTRK2443cn1rqFO6tuZ3LD5yfQ+tpcUrRiuo3k
	 RTdv4M/xDfvhg==
Date: Wed, 12 Feb 2025 10:32:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 0/7] eth: fbnic: support RSS contexts and
 ntuple filters
Message-ID: <20250212103218.723304fa@kernel.org>
In-Reply-To: <3d364d65-6db7-4daf-9657-8f547b850710@nvidia.com>
References: <20250206235334.1425329-1-kuba@kernel.org>
	<173920504025.3817523.12316203538556886634.git-patchwork-notify@kernel.org>
	<3d364d65-6db7-4daf-9657-8f547b850710@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 08:05:31 +0200 Gal Pressman wrote:
> On 10/02/2025 18:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:  
> 
> You ignored my comments on patch #1.

Ah, sorry about that! Not sure how I missed it, maybe the ongoing 
lore problems :(

