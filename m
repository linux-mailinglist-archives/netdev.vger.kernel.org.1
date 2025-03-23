Return-Path: <netdev+bounces-176973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA7A6D065
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B616E0DE
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE81624EB;
	Sun, 23 Mar 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6e7PBeZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89B158D8B
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752070; cv=none; b=MIdN9GdIIKEg0ixG4oNNUa2Q8x5ow2SCVcd3nMuGOzT4y6UUstPuhqcINEUTxW/AY51OiDIr4BJz5mLdFxSmBp5ku8KZcysuFcGE58LbbX0VdwmtFVVxP6cjO41yxklIphADHgpAbPXLGBb8XL7v55rAKKSUA3gl3+aFQnoueww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752070; c=relaxed/simple;
	bh=FXr/hxHeYGFuuSfuXBmPhBV/M7YIV3uxC77EtrMamB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjyR+bONjVASjsztsuaAmGiDDqcJ636ubsUiD78DsOmS7XvpQ0SQrDFM3nHZuE4SD3POC2dv8gjWtShz9MBay3dyo6WhIEx01By/kQjGNuRUVAh7DImnyJtB7GTNJut9nljjMfo2NkyibAA1h4t+7+/M+TlbfblYgBzyCbxcUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6e7PBeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA99C4CEE2;
	Sun, 23 Mar 2025 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742752069;
	bh=FXr/hxHeYGFuuSfuXBmPhBV/M7YIV3uxC77EtrMamB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6e7PBeZja7pQYoHjtObkWC3VdrG+vKsKWy9JXwFXJ5CMUQKPslbLV/3owEDc3UUa
	 oCoFXLg9/eQebbp5SNv857MVVZS6XHpkSxyOsyA4COPXFh80OVXcZ/6voE0M5jwH+U
	 xu0qfgmTa47WwySvdRIR3r/WmyFtoz1tj8kWKAMgI3Ioq3pVC+RQNKAh3obeg90UKS
	 zWWUWichSALi1PbGkrodHkd5QU99O/MLVtYUzHYvSmpu1caZto5fGZaIduO5mFN9XW
	 NHrh+TIFgB22tTIERWPHHKeeoCTcKJCDSSlnotqJp+fmo1V9BFs9mg8zlb4/hMW5QM
	 NfB/MgSHBxPIw==
Date: Sun, 23 Mar 2025 17:47:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 3/4] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250323174743.GB892515@horms.kernel.org>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320085947.103419-4-jiri@resnulli.us>

On Thu, Mar 20, 2025 at 09:59:46AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Presently, for multi-PF NIC each PF reports the same serial_number and
> board.serial_number.
> 
> To universally identify a function, add function unique identifier (uid)
> to be obtained from the driver as a string of arbitrary length.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


