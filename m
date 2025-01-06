Return-Path: <netdev+bounces-155413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42910A0247F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098A6164464
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB278F2A;
	Mon,  6 Jan 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH4/xq7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AE40BE0;
	Mon,  6 Jan 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163887; cv=none; b=QlkaoTecnQu6Jwnz1rzLU9bTGbQPsM3U3wZV55Uc3MFndp+j/dg7ckpRVkq8PtNcxv8oHNfe2parK/xPXmw68vkBIs3wB+VWGM+o1NkRSYOocBZEBH5tFSNHWXyiaaIUjOfrvHXLGv3wOZ73W8NYhTf15zzRjsdbgtns6e1lMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163887; c=relaxed/simple;
	bh=p8ZDWepWXOpMQdpmbhwoN5XIWa27UXLvf90nj9ikbLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmUZuxSsNpsunIVfHwre/Z/1Y9rzXmcZRaUH+qb0jlGWUj+SyIGXze1xFPXB9cqEW29eQe34QRtRGgQTk+a0DcSLbKNlTjIoEgAuny2PYG0/I4vFml+znKNAj+ta2sj5bljZXyMbZjzflE0VpyFa1GvlRmZM3wNuvWA5/CRJDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH4/xq7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562FFC4CED2;
	Mon,  6 Jan 2025 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163886;
	bh=p8ZDWepWXOpMQdpmbhwoN5XIWa27UXLvf90nj9ikbLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TH4/xq7iJ862hAZnKtj45kq1IEvzaVa8mDvaUS+l2+UFm/Pd00t9pnIZLV1O2egvf
	 hAV7EF9eJYgrLnGisuAuqwUpkWP4VZJ8A3aitL69FP2b5AVvvzlaDB6+KT+uyw9HQn
	 ZgnsUpfA1CWcBlxEJYn36hJYGglO/SyosA98leGm5OMnK/Z53FIufJFkmrf4wYEn//
	 pZ6aY5e4eyt3Qjept78Gj4CgtFAK4Bpuoo+UClcFE2OPfur+kRm0Zuu9iL1G3rGXfZ
	 xJsJIbB6SCab2Q8Oqt8AMZg1BDXW4HRrKMjoKon6bNtHiY34NgTQWSkWIpuocaI+o2
	 YIMkWx5r7SnBQ==
Date: Mon, 6 Jan 2025 11:44:42 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 6/9] i40e: Remove unused i40e_del_filter
Message-ID: <20250106114442.GG4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-7-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-7-linux@treblig.org>

On Sat, Dec 21, 2024 at 06:42:44PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of i40e_del_filter() was removed in 2016 by
> commit 9569a9a4547d ("i40e: when adding or removing MAC filters, correctly
> handle VLANs")
> 
> Remove it.
> 
> Fix up a comment that referenced it.
> 
> Note: The __ version of this function is still used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


