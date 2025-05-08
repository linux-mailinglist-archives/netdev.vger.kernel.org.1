Return-Path: <netdev+bounces-188846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769DAAF0B5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8102E1C24E31
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A71B422A;
	Thu,  8 May 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmfQgXBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43B4B1E6F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668490; cv=none; b=VRXN1Z+kkFD88QjwvALK2XYwPDyU3xa2DccYoruDKuZ0AwTtjYhwj4AChy7zv8zP7IKsnc6zB6Q2Ouz9byHUrDItTWg8KCO4n/wzEjyMClH0DTz9SpC/1Yrt2MdGYSETft3vG8Nyp59hamY4O97WSaIHt9I23qHxnwoI9/AxOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668490; c=relaxed/simple;
	bh=Z0PM/d94yzkaMN6VJvyB7iiatM3xilK+rLfISkspFXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhffapKS60+Pex1Ew5GB1/XMWu7Yk+VDH1OicaAOOnsEj8IxC1+zE9DLFRE8OBvOTayCJ4aK8dHzK7f6TjZnOrC5oD8UG3kHPKOqC2CjfgVpUPg6Cr6nU5gDTUX5KJV2irav0MuyikP+A5nfy3ixB7BixposBeQA/Ds+oJEyDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmfQgXBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEDAC4CEE2;
	Thu,  8 May 2025 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746668490;
	bh=Z0PM/d94yzkaMN6VJvyB7iiatM3xilK+rLfISkspFXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tmfQgXBL0kn+ButHu2ucDFr+MpHKQEoxr/cmsXlLESha+Jwl7Bepb1wTIZKG9RRfa
	 B3c5dy636wtJZExQVusFqHI9r4enVMVdywt2Of1KnBydEUAUREBr1SJN//In0jrSWp
	 3xUtW+qB+BHDXrf02U1G2ms4GGh0qlWCudyu6WAzKIYTr9/aLThmBYwk0LvG7Pejf7
	 xOJcMFxD1m5XxBoUc3zNUKhwevxihe2G6qWgtz7uWza4IbhsqylNfsCQsG/CT+GJaO
	 4Uypme0egLs7icg2BsXahREoyetwgVJTQ1u7T1Apbdo4EAqwVvn1NYyWOVEt8WlFqR
	 vM3Jw/NormiSA==
Date: Wed, 7 May 2025 18:41:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [net PATCH v2 0/8] fbnic: FW IPC Mailbox fixes
Message-ID: <20250507184128.33d5c4ad@kernel.org>
In-Reply-To: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 May 2025 08:59:33 -0700 Alexander Duyck wrote:
> This series is meant to address a number of issues that have been found in
> the FW IPC mailbox over the past several months.
> 
> The main issues addressed are:
> 1. Resolve a potential race between host and FW during initialization that
> can cause the FW to only have the lower 32b of an address.
> 2. Block the FW from issuing DMA requests after we have closed the mailbox
> and before we have started issuing requests on it.
> 3. Fix races in the IRQ handlers that can cause the IRQ to unmask itself if
> it is being processed while we are trying to disable it.
> 4. Cleanup the Tx flush logic so that we actually lock down the Tx path
> before we start flushing it instead of letting it free run while we are
> shutting it down.
> 5. Fix several memory leaks that could occur if we failed initialization.
> 6. Cleanup the mailbox completion if we are flushing Tx since we are no
> longer processing Rx.
> 7. Move several allocations out of a potential IRQ/atomic context.
> 
> There have been a few optimizations we also picked up since then. Rather
> than split them out I just folded them into these diffs. They mostly 
> address minor issues such as how long it takes to initialize and/or fail so
> I thought they could probably go in with the rest of the patches. They
> consist of:
> 1. Do not sleep more than 20ms waiting on FW to respond as the 200ms value 
> likely originated from simulation/emulation testing.
> 2. Use jiffies to determine timeout instead of sleep * attempts for better
> accuracy.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

