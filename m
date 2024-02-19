Return-Path: <netdev+bounces-72859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDC859F91
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DF1C206AA
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328522F0F;
	Mon, 19 Feb 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVjO1g5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7322F0E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334540; cv=none; b=lAm/OZsAJY/CSgRp3alA1CI5fdjBQFsVuY8LIX/uBmfA0bOsdBSWuHjioD6A2BvFm/x7WfbELuTvscMRqn+fRTXAru34J+o/jmCETxHL9v3BUCW+lnl95ELGUJA3JaBQu+2DFfbr5FyYr3DRT76jpT2kM/+TcGY8grc1zbukAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334540; c=relaxed/simple;
	bh=cqhT+74jMS/y3CvA29elHMcdXkWm7rk1p2NPRXtt7Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMhFsZF0uepgBzDxw0gEnBGo1G5VCbY80McnOgvHRQHF6w4/CCYJPM1arIiCAmhaRQ3uNAzCSNcoDYdwxxgWyByVUF2+9t3evRkItNoZcK1wfArMMZEXIfwd7t3LILUQ9K+30NWuOYS/uPaj3t3DL8zHcw+mGbFr6agVQW/l/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVjO1g5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5CAC433C7;
	Mon, 19 Feb 2024 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334540;
	bh=cqhT+74jMS/y3CvA29elHMcdXkWm7rk1p2NPRXtt7Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVjO1g5qgZhdv5kKrgNWOVv9jQadckfvjZbQKGe8FI4Y7QUlkLA0W+jM1P56nCHu0
	 XPNF7PNzlnaykbCFmUSMdmFVQMgWkgmDhcBzzAcvtwGbdMljPkUrXYCIT0iZb8EcGx
	 u+du8QtWtY2hfuiutoHbY+977duM8+37Hv7dsezPQP3vwvDf5txqLRpCv8gRjsCH5R
	 ZWtJ536c7lD/wllWWkpgPMGPoqnGPp716fsDGqM38NlLO6iMsQjq/4clZDmh4wLcgz
	 Wdn0UL/QTFgqsS6W1qUAQS3NAwup9z6ErQx+jegpiTfadwHSzFcJmHIYJbO1SGYykl
	 jZsJh7VhgzOxQ==
Date: Mon, 19 Feb 2024 09:22:16 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v1 2/2] net: intel: implement modern PM ops
 declarations
Message-ID: <20240219092216.GT40273@kernel.org>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
 <20240210220109.3179408-3-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210220109.3179408-3-jesse.brandeburg@intel.com>

On Sat, Feb 10, 2024 at 02:01:09PM -0800, Jesse Brandeburg wrote:
> Switch the Intel networking drivers to use the new power management ops
> declaration formats and macros, which allows us to drop __maybe_unused,
> as well as a bunch of ifdef checking CONFIG_PM.
> 
> This is safe to do because the compiler drops the unused functions,
> verified by checking for any of the power management function symbols
> being present in System.map for a build without CONFIG_PM.
> 
> If a driver has runtime PM, define the ops with pm_ptr(), and if the
> driver has Simple PM, use pm_sleep_ptr(), as well as the new versions of
> the macros for declaring the members of the pm_ops structs.
> 
> Checked with network-enabled allnoconfig, allyesconfig, allmodconfig on
> x64_64.
> 
> Reviewed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


