Return-Path: <netdev+bounces-68011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F184595F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30121B25D78
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6A5CDF9;
	Thu,  1 Feb 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2JGfPwG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC75B669
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795636; cv=none; b=Zjn2Eq+kXddxZ4Zb1L00o2Cc3VRr5NvFrBwrZHUTFRoPUwHXiCrBFrAWwNpe9N/F0fzpfvhsrgVKmkRPc1gzaCo3cFyqFps7bLBiZRPg8pUTJLlOS5Gj1WJRlvnyU0ml5Xggj6xU9wsVbNBIAv1K92yJylNlSS66N2D27REF4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795636; c=relaxed/simple;
	bh=mQzhuHyJ7EmC6IfNC8Dr1ePiBdLmnGDhdQv4CKrw4Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZnuZstaPHMpZUc6mVDBKtxZii1qx/82DqmmkfevzJAH0nj1kzvlsNyveZ7NqHmCStXVXZaTYmdeWOK3aFXWQ6DXYSapHImVOlFr2sOf5gRf8HltIJjZCkuA4K7K+11I4nf4XvH+8TEeNTeo2psgAoW+UjKrAua0pD+RpBHmUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2JGfPwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA97C433C7;
	Thu,  1 Feb 2024 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795636;
	bh=mQzhuHyJ7EmC6IfNC8Dr1ePiBdLmnGDhdQv4CKrw4Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2JGfPwGPIL3Je0uSIMUpTN4/URiruKvlhugyzXhAfJ8/ILTsXLVqzsgQj6aHE5re
	 g3rW9h0ackbZQMZrruDCjYNalm6keklP2nd/zR4tvjrNHs8a8/Y8H5uuD9UhOp0ETb
	 2RC/W1WoYTvs3sTZFwja1qG7OqaC+7bCM07hF4q5jjT0L1m5DJp5sc2HvfrI/ytzY2
	 hM69ltd/m4RQAEzIEqwsBEu+oHTlaeoNQey4sNf3Gv9zT/dlpRSDAnx+KMfIR9aG5n
	 c0slM8MhpMKDOVErVcVF91KMoKnFAJG5X7EBIMjdIPK3OFjjNDNca6xeJevj3mkHd7
	 6+1diN2KXjD9w==
Date: Thu, 1 Feb 2024 14:53:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: Re: [patch net-next v2 3/3] net/mlx5: DPLL, Implement lock status
 error value
Message-ID: <20240201135350.GG530335@kernel.org>
References: <20240130120831.261085-1-jiri@resnulli.us>
 <20240130120831.261085-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130120831.261085-4-jiri@resnulli.us>

On Tue, Jan 30, 2024 at 01:08:31PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Fill-up the lock status error value properly.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


