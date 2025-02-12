Return-Path: <netdev+bounces-165616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCCA32C32
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E73A4867
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647020CCD0;
	Wed, 12 Feb 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0TvkmT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3C24C663
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378760; cv=none; b=VB4rJ7ysbEAOUgygcWPZL89U7QFz6UgklJg8X7QBwKsfk3g4D5M/3B1E0IfuuiGcMYlENxv/p5O2i8CcKVbfImBrT3bs7wNStmw+e3H6xskcCIwzxsHebP1Vty64oK2UeuCAbGqwRZ6f93HSm3qbHTogotYIWxRHUAU4RKanN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378760; c=relaxed/simple;
	bh=0W+Ty3BPfd5R21VuddlUfeffZiNupXMXzYVKfGLPhCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJfn8RenBQTOuEgmXEDU0RTDcS9SU+SVSxukA5B0wWtKwuIVH/S7/cThJR3fVGHGBgN9LevF5oV+M5G7kfrZGEqhjsVQIyyFgMtlWp+IEACQZ7J3Yho4qtFxJ1eQXhkgG8epr9C4GxFFDRlSH4w4c9ihqmZREX69ZQSsBtcv3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0TvkmT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0C3C4CEDF;
	Wed, 12 Feb 2025 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739378759;
	bh=0W+Ty3BPfd5R21VuddlUfeffZiNupXMXzYVKfGLPhCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0TvkmT5AoMo1oi+TJbcUWGrFtROcA9lBSPrDeJU4z472DFtbIpYrMmCITCz9bTB5
	 wnXJ36K8FbMjv0Ar+Qj9FVUpjs024Yh5VpvXM6ysB6oJmY/yPwG/tPhgi6b997sIrx
	 umiZA/zJlAgwx8BqCZJNovuqL7mO2jBUDoc9N9y/Z0DBMaZ5430yg4238OFESb5leR
	 ofadKwa+QwNE3o3BeC73zp8owTepwun3DATWaoB5C16pbgafwtoSViZlQaiK+Dpk0a
	 aJK0IvR1stU5RTJXIf2H27+uVpTOFTPPIQpZhxolOEi2GU3/dffm1eRXw1c6uRLYFZ
	 8ujouxV4Rgx0Q==
Date: Wed, 12 Feb 2025 16:45:55 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v2 2/3] ice: Refactor E825C PHY registers info
 struct
Message-ID: <20250212164555.GE1615191@kernel.org>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
 <20250210141112.3445723-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210141112.3445723-3-grzegorz.nitka@intel.com>

On Mon, Feb 10, 2025 at 03:11:11PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Simplify ice_phy_reg_info_eth56g struct definition to include base
> address for the very first quad. Use base address info and 'step'
> value to determine address for specific PHY quad.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


