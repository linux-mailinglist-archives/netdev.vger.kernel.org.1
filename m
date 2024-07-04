Return-Path: <netdev+bounces-109142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047B927212
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD91AB23EC0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B01AAE01;
	Thu,  4 Jul 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfK7OEIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F191A4F1D
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082997; cv=none; b=dbP7wSAlQWyeBAkut9EV42jmE/MpSHadJmnxAYjgUDgfY/clQTdPkrUSwSWAtyvVai5rFWNrNFH5qRRD466PuGPvTpAYFp8i64wuUcEMJkZWfMvHR8IIaM986iuWjJp0VXsd48wCj67ywpRbU2LqxMj9NNypQWTu8sTmqoRR+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082997; c=relaxed/simple;
	bh=9qThL+3P8lKzFUHyhDS878/lZM3tEgVQ2g2r3nsI7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtWIQHqPqbOi1FSSy2p+BIPtqOA66xuIC7iSU4wuJWNXTi2TaiuRtFztPv2ukVEpvoagwa21Goxef6MT84zlZmF4pqjR/rKKj4F4UNMmJI/ytoWtim3lMTXAZUsU3yPG/IE01lA889zSxazyQlWS9sJXPuFCH/ccNJWGROQASd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfK7OEIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B527C3277B;
	Thu,  4 Jul 2024 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720082997;
	bh=9qThL+3P8lKzFUHyhDS878/lZM3tEgVQ2g2r3nsI7+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfK7OEIU85cziov8aM9QQ8EQ5vW8tcWcp7vK2hyuqc8Xs6iJ8gX/qw21xIPYlXS0C
	 xd1DHZ8vzyBFA3dhmHyROqsipMrADlqthC7TaPbvcES6fQA/rdCzwhLW9zFNXWrFiM
	 W1aHbcDAm95630uOSEeDqyeYvEK1kJ3Fu3R28a8f/O2jeK0VZNQPaZVNo7lK4Py2GC
	 vqBfdFRxFc0z1v0TeOAVV8BcIXMWNcbsOKk4O+d2gEGp8YtjYWeCl87TMR1fYVt0HZ
	 pA1OrGzIaoRekcf3io5xcZt6Ha7dXvwQQRR26Iv/hQdkVxoPGDZBcR5pgZFFrrEsf/
	 V4Zh1nWPqqlLg==
Date: Thu, 4 Jul 2024 09:49:53 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next] ice: Fix field vector array data type
Message-ID: <20240704084953.GX598357@kernel.org>
References: <20240703112502.28021-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703112502.28021-1-marcin.szycik@linux.intel.com>

On Wed, Jul 03, 2024 at 01:25:02PM +0200, Marcin Szycik wrote:
> Correct the datatype of fv_idx array in struct ice_sw_recipe to be u8
> instead of u16. This array contents are used solely to be later passed
> to lkup_indx in struct ice_aqc_recipe_content, which is u8.
> 
> Fixes: 6d82b8eda4c7 ("ice: Optimize switch recipe creation")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> Targeting next, as the commit to be fixed is on dev-queue.
> Tony, please squash this with commit 6d82b8eda4c7 ("ice: Optimize switch recipe creation")

FWIIW, this LGTM.

...

