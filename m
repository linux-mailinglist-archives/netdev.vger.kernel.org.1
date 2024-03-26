Return-Path: <netdev+bounces-82067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002688C435
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CF22C6A50
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779D75806;
	Tue, 26 Mar 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qONJxGIK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24094757F9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461523; cv=none; b=APju4/UGlHCnLt/LktVHDLB/iosGbj81FqPE4WvneDHVhHtvYWPE6C5s8wKE9V9nJ/xLhfOwM0pj7bdfeutDYcWDsMn2H++byn73CbBU/XlonXxSUhki7Z4qLp1U+QjtKrJLJA74rxzO9VjE3CHIJ/CDnAp5WFEwgpfrPUQ3JAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461523; c=relaxed/simple;
	bh=yyvQj/ggAgR1YIAGtJLB7gWLu8PfGZ8S8ihCiRxRCDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4PIWWcpNnzNq4b6tgebhJ/IBXFwHw3meLj/5ZRn2GnIUqLYzf4be0s544kqUcegAke9xyrzhieC9+bsM7KHloptSJB/LetsBrmvwPbbNvPa8AHr1Qx4vKGOHAa/4z7ohEu5t5MxueOGGn7hAZCHyzal4CLOg3/ukPxtGA/0lvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qONJxGIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADC5C43390;
	Tue, 26 Mar 2024 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461522;
	bh=yyvQj/ggAgR1YIAGtJLB7gWLu8PfGZ8S8ihCiRxRCDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qONJxGIKoqdANIfaF45NfOkCbBD5RprNgBtS8CY61/LYuwKyOXfxU+heOLL2sLONi
	 6VMcOoRDMc64pu+wBLO4cJbqBxv/cts4I3DIVECaOrtWBplykcVElp+dorxKAsaXEu
	 KG002JgzQKoJHxXZvPAXrwSFMmoffQEgM0ImPsVfANTnq/J5nZmhOLgPH1lTDpjF6L
	 ZpnYRjIp9x6uSbrh24M8Cta5Sp4aDiLNb2ZDJrOli4vT1NS9l5lw8/1hTutwI+LXba
	 xo9VpalqbzgJOPPUg32xfs41hkguHzxcyR4x6iSck/vAfhsC+6XOl4drhcCPnurdvl
	 5KyLdf8byP+Cg==
Date: Tue, 26 Mar 2024 13:58:39 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jesse.brandeburg@intel.com
Subject: Re: [PATCH iwl-next] i40e: avoid forward declarations in i40e_nvm.c
Message-ID: <20240326135839.GT403975@kernel.org>
References: <20240306163054.90627-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306163054.90627-1-maciej.fijalkowski@intel.com>

On Wed, Mar 06, 2024 at 05:30:54PM +0100, Maciej Fijalkowski wrote:
> Move code around to get rid of forward declarations. No functional
> changes.
> 
> After a plain code juggling, checkpatch reported:
> total: 0 errors, 7 warnings, 12 checks, 1581 lines checked
> 
> so while at it let's address old issues as well. Should we ever address
> the remaining unnecessary forward declarations within
> drivers/net/ethernet/intel/, consider this change as a starting
> point/reference.
> 
> As reported in [0], there would be a lot more of work to do...if we
> care.
> 
> [0]: https://lore.kernel.org/intel-wired-lan/Zeh8qadiTGf413YU@boxer/T/#u
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 1050 ++++++++++----------
>  1 file changed, 509 insertions(+), 541 deletions(-)

Thanks Maciej,

FWIIW, it might have been easier to review if this had been broken up.
But I appreciate that is a lot more work, and perhaps it wouldn't
have been easier to review anyway.

In any case, I did find time to work through this and I agree that
the patch matches it's description. And is a positive step IMHO.

Reviewed-by: Simon Horman <horms@kernel.org>

