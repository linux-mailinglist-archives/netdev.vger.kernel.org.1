Return-Path: <netdev+bounces-37717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634967B6BBA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D8B8BB2097A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CDC1772C;
	Tue,  3 Oct 2023 14:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F22328BD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A95C433C8;
	Tue,  3 Oct 2023 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696343687;
	bh=D3JHpbuUCsOPCV2/Kb8gL0Xp3qFkbADEWPSvE7cDcFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsN5Yq+OBWTY57OCo7MXg9a79vV07FR0Zcnz/xaLUM/UwZNKIkQY1q1j9+Fy4j59R
	 xWkkVeb5CuVkZZ+1hltxiCElnEXtUonqGJcsLb4zbnekw3nAaR2Eiu+k03P5Ib38/t
	 SiAPoFF3f+snBIefeoy9fKh8LpcpKHENGsAYRxdinjp73fWPwzbmUelbceDtkuVAXc
	 8eS8eqtIWszZYyc5/ZXkXxLU7eXtM5y9lRHzVH8hpwybchZCpnWUxF3661v0TDY8Q+
	 tu01g1zFJ0nxXihMD8oknPEutZTC07dm4qIoIlQsaQMkbbyxwfItG/i7yAdqtOCoHh
	 8o4Im3mWwqgDQ==
Date: Tue, 3 Oct 2023 16:34:44 +0200
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] ice: fix over-shifted variable
Message-ID: <ZRwmhINftLVQ8EnU@kernel.org>
References: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003053110.3872424-1-jesse.brandeburg@intel.com>

On Mon, Oct 02, 2023 at 10:31:10PM -0700, Jesse Brandeburg wrote:
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
> 
> Most places in the code got it right, but one line was still wrong. Fix
> this one location for easy backports to stable. An in-progress patch
> fixes the defines to "standard" and will be applied as part of the
> regular -next process sometime after this one.
> 
> Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


