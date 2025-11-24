Return-Path: <netdev+bounces-241170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18065C80F20
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 229124E41C2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0D30E82E;
	Mon, 24 Nov 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BShA3UMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513930B521;
	Mon, 24 Nov 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993628; cv=none; b=eAwyw6uU/ehUeER+3gWLYfKaPoSheg/Y5Hkv+x1VYS+hxWCNmkb5zLDq3JWEP75trRevp0oFC/8+yr/1i3sQKDcFvcHZexMI6g1J5D48Q+/JJvMKagsESjyvmQNp7X83a5GPaobZ1uUNDXzM0xY096suFBfcSCCMOavXrIVvi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993628; c=relaxed/simple;
	bh=bIqOeuEy5nSo2ASzSEzo99HiwazYCuKVEn4Hay2HMdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1V1AaybisLNxLLd0+7LFDTswZIyjUa5ct1XQZy5LGqttqlKnPZFt46nemc2uzT3JGapfPeFgL73rXzxefAMZ+/SUSPxxu1dbt9vfmulvuInFEGaYACc+8lHtwAt9b93mCgc17P2c+x98zseFSxWo1ku4MoKpBtNEZY30Epn2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BShA3UMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21DFC4CEF1;
	Mon, 24 Nov 2025 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993626;
	bh=bIqOeuEy5nSo2ASzSEzo99HiwazYCuKVEn4Hay2HMdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BShA3UMG3DNAdoxcUlP0dp/lX31L+90Dt3YTixk/HrGZyLzTv2MA4APe6Nb6pqAZI
	 BchPfHRBpI0dAYwG3NUrJcDIWycyUWuliPn4jDAU5X35uSgJNbkaUmrcYs3iTpyg5t
	 MwsyL4b3sxI6/rjZn+4eKE7rSd/S1/iDFlHtFNLaSNtvUEjK3ksMCwbNuwvSk9JvAy
	 cjvdp7lvGR907GEz3mtIfyXhNNsrFzVQ0K5Cq/RmBA15ysNEbb6SGdAfROoLFkZNqb
	 REYnIBOw9whrDL+l3v6MQ/oTE7CmZ9rP3ii6kdbu+bfaYulJ/LHjVEiUi6AHbmHd7X
	 A5QBEiO77Kc8w==
Date: Mon, 24 Nov 2025 14:13:42 +0000
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nfp: tls: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aSRoFj1RIHZNPFwm@horms.kernel.org>
References: <aR5_a1tD9KKp363I@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR5_a1tD9KKp363I@kspp>

On Thu, Nov 20, 2025 at 11:39:39AM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to separate the flexible array from the rest of the members in the
> flexible structure. We then use the newly created tagged `struct
> nfp_crypto_req_add_front_hdr` to replace the type of the objects
> causing trouble in a couple of structures.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> Lastly, use container_of() to retrieve a pointer to the flexible
> structure and, through that, access the flexible-array member when
> needed.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:65:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:58:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:58:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:65:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

