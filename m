Return-Path: <netdev+bounces-218770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FBAB3E651
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880D11A851FB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50033A011;
	Mon,  1 Sep 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwx9lZUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CED33A003
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734998; cv=none; b=QHykBFfNs5/urRFTUuSUsWnL/lKzIafjYykZw1eBr0r9SZfNiteK7vUvasBsNyH4Ciktkd3XWkLPxs/vqFMULgyt+8CMcyWokz8kDiKH4EBBXeJTp5NdBFElHlDPCl3pcDkbKIV+UT+7WWfaZJhip6aG8KLQ4aRJ8of/7WNyRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734998; c=relaxed/simple;
	bh=asAQ1rU9wQg5Jw8z/zz8HqbStFkcokLIB+1C8gbNlTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7JDbWygwUmNwXh/SNVri1ATMiZ27uithapcWI+QYGdxQ6aVNhRfFWcWGC9om3v5gbf15ZMD1ashHJWYyJDp++m3f90MBfuEC9jLkZQ7nIer53ZrROTSKq6y894kJ1rHms2RH3wDLloraepp4Pa0ljzFwUZri9T7gqLSQdEcP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwx9lZUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A7FC4CEF1;
	Mon,  1 Sep 2025 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734998;
	bh=asAQ1rU9wQg5Jw8z/zz8HqbStFkcokLIB+1C8gbNlTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwx9lZUNn5ud6c3n50UvP8qILOvFaDF9ecgpIMT+IhtAE1GICx2ncUFL52zwD52QR
	 RNIkVrYh20XkvqT9qPl5Fb3DNbz2bF+xbEEcOPkcu4zaeVMUl/YQdIgURBelQIrctk
	 w9mm3LClKEAKppAfjjBuvZAZY4LsIC+jwdHONqtpbZZEP2CcgR0neVI1KCB81hxDeI
	 bVKW52nrJyFnN1yIXDeA+iAHkQEGt3bJtn3KpNFmP6A/TqYJFdOhJOnB+9Cg2ngn34
	 gl7GKWREc8ILb+LhZBgHdIyZvAF4eWwAWy06pDQXh4g5Hs8Kx6tF+TAnRiXtXdHHpr
	 739dR6kWtkLCQ==
Date: Mon, 1 Sep 2025 14:56:35 +0100
From: Simon Horman <horms@kernel.org>
To: Madhu Chittim <madhu.chittim@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] idpf: add support for IDPF PCI programming
 interface
Message-ID: <20250901135635.GD15473@horms.kernel.org>
References: <20250829172453.2059973-1-madhu.chittim@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829172453.2059973-1-madhu.chittim@intel.com>

On Fri, Aug 29, 2025 at 10:24:53AM -0700, Madhu Chittim wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> Write and read the VF_ARQBAL mailbox register to find if the current
> device is a PF or a VF.
> 
> PCI SIG allocated a new programming interface for the IDPF compliant
> ethernet network controller devices. It can be found at:
> https://members.pcisig.com/wg/PCI-SIG/document/20113
> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
> or any latest revisions.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> 
> ---
> v3:
> - reworked logic to avoid gotos

Thanks,

I see that Paul has provided some review, which I don't disagree with.
But overall this looks good to me. Feel free to add.

Reviewed-by: Simon Horman <horms@kernel.org>

...

