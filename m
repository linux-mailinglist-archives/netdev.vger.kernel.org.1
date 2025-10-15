Return-Path: <netdev+bounces-229522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D5BDD79D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABB33A5DFE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797133064B5;
	Wed, 15 Oct 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk/WMTDM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DE25D1E6
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517882; cv=none; b=oiHByExl8LkMqManrLW3P1V4HQAps7ghZnrtIhZ6PUaZAyNBJjQxrulUovYJE22swpraq9oro8uKw10r+pkH0+f88hz6ONRewVkbJiHcalwPaqf7y+Uaxg9DAq52sPgL/WBMHBygg8BNvQDRnPFQlXysmFBKGH5XqYsRjatLQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517882; c=relaxed/simple;
	bh=9gCgcNDZMLI33rXS3SXu4duzcgmjeLbz/3YFKtX+M/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJOojtbRN0Y53bPWtDVFchpeen4evMk4x14CTKkhpW/B+QP3ddxllgX//0N7IjeNUF45PfzDqlbS342CAk0xQzpH47CB3uEf07FEgu6vUHkN0qADMbvVAQJN2rwuflg6oJMbbSTg1Ebc/W7xDRdd14G64AfG8VRLKMDzjGLI4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk/WMTDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C2C4CEF8;
	Wed, 15 Oct 2025 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760517882;
	bh=9gCgcNDZMLI33rXS3SXu4duzcgmjeLbz/3YFKtX+M/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hk/WMTDMmauQaQohmserq9/6qPb3Le7RvdVMWS7XTtYxTK2mGntDP+p8Oxkbilx+U
	 XpVOQJqQRLaU3JPAIkH5Lm17pUdjxHcbwX/qJs772fzjIQPcUQiiymN3LuqtPZ9qyg
	 VCVJAC3RdbK82ZHi0CMf1jvERY54iVmIXrCPT8qJu7J6PxuO2T4vUNXkk8baCR2Ixz
	 0Zb34u3DeFsr+aBx/k++AD3UFVGEEMJX0RPNjaiP9DgvOfeQcxgWGf8wwlxKqSIWKp
	 LkkjxdbqYZ2LYFV+aLtrd1zHIi7oIAPo+CizXtwy1dYRGR0JtXEo3744ooqJd1I3vr
	 9rbUY8neS46fA==
Date: Wed, 15 Oct 2025 09:44:38 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next] ice: unify PHY FW loading status handler for
 E800 devices
Message-ID: <aO9e9ix2jHA30pY0@horms.kernel.org>
References: <20251014084618.2746755-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014084618.2746755-1-grzegorz.nitka@intel.com>

On Tue, Oct 14, 2025 at 10:46:18AM +0200, Grzegorz Nitka wrote:
> Unify handling of PHY firmware load delays across all E800 family
> devices. There is an existing mechanism to poll GL_MNG_FWSM_FW_LOADING_M
> bit of GL_MNG_FWSM register in order to verify whether PHY FW loading
> completed or not. Previously, this logic was limited to E827 variants
> only.
> 
> Also, inform a user of possible delay in initialization process, by
> dumping informational message in dmesg log.
> 
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


