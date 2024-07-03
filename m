Return-Path: <netdev+bounces-109008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D728B9267F9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817221F24784
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58281185095;
	Wed,  3 Jul 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWNgtFDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E117B4E8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030822; cv=none; b=rHbKAiwvzcMn9mMtpvvYKY5FDqY43MvT8fEzXss7ghbABKcLMPE4su6QqltvnszHbGfP9NWdmePjDOUVziqwNmOUqM5/NpMDudVkHJccl2ho7bcGbs+6sumj1Q/7rZsSPKXJZQsEBSMlCj1wjT4qb1Ly+cBl+iD8ate/Gmcf5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030822; c=relaxed/simple;
	bh=RLJpAju0if/8vtqX09gKAH57p4K258/Vmn2XXW4O5mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLU32pziTdkYUvmFwaMAYLQFfIOZ/WC7GT3+87VkR5tOEeGgCdFKpjRnNz3dzhQMtgWqWrkQ44IhdB4sHRzylUEmFBJ2oJ5cQeuLHFmw4Tp+1dnHrOAECh7gUy5lItCVIdTdrLniqliFh1TiTA7xAWX5fq3TU23Oq/T4R5dRmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWNgtFDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528EC2BD10;
	Wed,  3 Jul 2024 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030821;
	bh=RLJpAju0if/8vtqX09gKAH57p4K258/Vmn2XXW4O5mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWNgtFDeIvfpzITTxNIFMkk384bjll0E41s/vdu+Ta+wTHmcQI0jbaF9s5E8+hEtK
	 yB4F122bqE3+DcSUzN+DfcokwEr+e/WrQqwuqo9z2lVKPffgPX3Ogdk6NUg0sV8r4W
	 n59zR1WhcdEFXZnSISgGalN8mm37THW5k+gtVN2Qn42V1cPC0VZAqdCNnm1WV9AGou
	 TI3uCssVHoCyidxTS6LH6IRXHuFR/ts3SV8NfNSYHLFvDXquqHpnXRqTQBVta1QILs
	 sRd7ND1VyRhGL1HAqs5IJagX6xLVbJli7ewXt0m1H3lUpyUNm+AXOv9BPuCdZ4myfL
	 q55N/7N1paCQw==
Date: Wed, 3 Jul 2024 19:20:18 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 2/7] ice: Add SDPs support for E825C
Message-ID: <20240703182018.GL598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-11-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-11-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:31PM +0200, Karol Kolacinski wrote:
> Add support of PTP SDPs (Software Definable Pins) for E825C products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Removed redundant n_pins assignment and enable and verify move

Reviewed-by: Simon Horman <horms@kernel.org>


