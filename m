Return-Path: <netdev+bounces-163911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDAA2C025
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5156D166DFD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A71D31B8;
	Fri,  7 Feb 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUXXEvG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970471A5BA8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922615; cv=none; b=AFSc3FQxeBPXn4LhqzGvFViwxzybF+F3LfGmPvyz+13w9nNWLtzzN7cfXAPWqdwJLQkLb/R9UcREEn2Jo0ccAr1oapHWt8iUTBc2cO6e0dRCxg0fEGQhDxjv2jDDc/IcJx3kKd84B4+d2vnipBJ7w3yQEYlAcWN+0RpZJpu1M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922615; c=relaxed/simple;
	bh=RGnkpRzNX1wHMm+X38Zfh1HcOja9meKUs+/O4gamjDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9DeSfjSu6TV1LCE3NnNbcZZLLfRFwV7eb2BTDL7q6mRSBHBHyCIBimQ5gJhbfxO5KEFTcaAz1Z5XxxgbOoB64WXhtdrbeL95Fv22aFE8uDwgUSysCHWwu4/Hleb2ajo8nM8V9NKaXx/7ZJJZMK2AV0pl3NBWuyNLo9DBYrsSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUXXEvG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD77CC4CED1;
	Fri,  7 Feb 2025 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738922615;
	bh=RGnkpRzNX1wHMm+X38Zfh1HcOja9meKUs+/O4gamjDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUXXEvG0IMm2aMA9Hl6/0W4n2R8covHwWbrNkeMh8T2AeSD0c68gbaAAB5Qvyy2nl
	 MEJu/J3kjGFUsvJFvxZEQ8MFc4YDwsPU03etjSED13gFWSx9giaq9qwxsyipXJngeS
	 S/WKB2wlBReiCosfG5K+InJ6Xd0nTl5Es+rGd6AC8lNIsmR7Y+MoAqP3jXt7ruU35U
	 JJO9lGQ25v64tpR7oRbnz/jjrUefVJAR1U++cAtbVjDKrGFLvhsnTdxSOrwMXdpgZo
	 2nbqCcut25c8pqwQiWif47/uZ/dpcedO9FIIxjhFlfouYYgWitmQmfv+EcKulFDwoE
	 yS6b76NrYEXUw==
Date: Fri, 7 Feb 2025 10:03:31 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v1 1/3] ice: Add sync delay for E825C
Message-ID: <20250207100331.GJ554665@kernel.org>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
 <20250206083655.3005151-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206083655.3005151-2-grzegorz.nitka@intel.com>

On Thu, Feb 06, 2025 at 09:36:53AM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Implement setting GLTSYN_SYNC_DLAY for E825C products.
> This is the execution delay compensation of SYNC command between
> PHC and PHY.
> Also, refactor the code by changing ice_ptp_init_phc_eth56g function
> name to ice_ptp_init_phc_e825, to be consistent with the naming pattern
> for other devices.

Adding support for GLTSYN_SYNC_DLAY and the refactor seem
to be two distinct changes, albeit touching common code.

I think it would be slightly better to split this into two patches.

> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

...

