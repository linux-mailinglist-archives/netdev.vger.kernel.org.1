Return-Path: <netdev+bounces-103560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C19908A49
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA531F2B647
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526FF1946B1;
	Fri, 14 Jun 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzC8a44R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45B481D0;
	Fri, 14 Jun 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361642; cv=none; b=YUXkLqJHTcPjALfM8Uze6F8aX4x7ZwgoKTg3k57sEikcRwU4M58QnX+F8XgkTF2sx0D9Vq0xVJBbmOd13X+/3YwcOWS8Er1SnFzeXDtBm72OuHWYZfchtcc/uAOZkUH9WA1iYOsALjz0mLDPBFsvaD+DkjREVEfbmvTRsgS82gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361642; c=relaxed/simple;
	bh=ub95+rc8EQDLycc7ngH9VSDLKcfdT6+T1cS4ojnuVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WluZxmUjSjwpYbClLmVgaUY//aAwqqpg2uM4NktZWrpVjKnMPx3f8F23iQcmBvWz2EAld597Uc3F8IvSflq07DvnG2ZAxoyvJp3/DyXwpMX5+wiFODkS3306oyqBMab5hrX4veAHt4/KPUyNKS/nE22Ue+t51xRvfnb90DqvYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzC8a44R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176BAC2BD10;
	Fri, 14 Jun 2024 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361641;
	bh=ub95+rc8EQDLycc7ngH9VSDLKcfdT6+T1cS4ojnuVkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzC8a44RKY3IGTRB0xApvqaNQhw+E7jPoiyxFdzAs6FFfzHrLzQVmN2OThroNkq4B
	 is8PU/3GhB80W8g6jbbYB/jazHfBkCdx73X84/CwEGKCSy6ZkKrNwGKocUitnseHBU
	 iMx+ipjNgn+E5cK4onCB2DhnQYmR1kR0r5EpBCs+0bNTLUSEBA5VkuJ8nDFKTp6Ls2
	 CH+1dd37Si+c9wZ1lYFbVFDqMNEKfkIGxg7GE/Zlf5X48N16W1kkTTZlg+mCd84w8x
	 vrpo/nYhPsK0fNP6ni0FVKx4Vov4HorFZD1luK14JsRVLhGwVvSfiHKtwDKbak7XMD
	 +K2Ra1Hngrq9w==
Date: Fri, 14 Jun 2024 11:40:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iwl-next v2 2/5] ice: implement ethtool standard stats
Message-ID: <20240614104037.GE8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-3-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-3-jesse.brandeburg@intel.com>

On Thu, Jun 06, 2024 at 03:46:56PM -0700, Jesse Brandeburg wrote:
> Add support for MAC/pause/RMON stats. This enables reporting hardware
> statistics in a common way via:
> 
> ethtool -S eth0 --all-groups
> and
> ethtool --include-statistics --show-pause eth0
> 
> While doing so, add support for one new stat, receive length error
> (RLEC), which is extremely unlikely to happen since most L2 frames have
> a type/length field specifying a "type", and raw ethernet frames aren't
> used much any longer.
> 
> NOTE: I didn't implement Ctrl aka control frame stats because the
> hardware doesn't seem to implement support.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


