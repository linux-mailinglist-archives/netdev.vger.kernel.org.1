Return-Path: <netdev+bounces-275053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMjPLaDDz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:41:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F28394A06
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DCA300BCA4
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19433BD243;
	Fri,  3 Apr 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdZ+71Bl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F600317160
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223699; cv=none; b=P46qxp4PNvlYNe1RxHDHsjqYRn+w05sl0bKz78+vNrVXRL9S3PeYRtAl7vWXQNnbanIjl9lGsSY+AFiUipHM17Tp/G5Rv1JNUDwnHjYoxrXLScEOGU5mdPfvuRstVyVCCA24QSXc1c+0M8GIf2PMII9Lf4AAN7IxqSC+JcFSNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223699; c=relaxed/simple;
	bh=qkkNXg8SORBJx4yNPcKd2O3V2nNnyEmd9wSwLv2f9wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/QctGUXxcjprXYyCzGQY/+0L/rWKCUZab9hzBIik4wd/GsRLTjCrwAw4J7rUiSm1Gfz70tA4BORfMVpeRVCLkSr5zUX4nEjI4d2fx4tDz+588jKNYGPLXT4Psy9taJXH5azq8xgqkfLKtBm+YA0l6vFYUVeVE7A+M5Nfg+dDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdZ+71Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB98CC4CEF7;
	Fri,  3 Apr 2026 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223698;
	bh=qkkNXg8SORBJx4yNPcKd2O3V2nNnyEmd9wSwLv2f9wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdZ+71BlBuJBkHPFuJPR6nXGwZZqPOBsU3OcYWzeTcyGOjU6ATCkjXxE/XGGMn6hS
	 X2AYVKn/Y2nE5BTJt7w0kKLVutj/6XVKcWGB+fZkZPhljlvbpVi3hiSDu3meamTv9k
	 cw9a3vE11fgJFYl1K6D0H33Lnvvfnv9KXimwLtvYZ58BLDdzSelkqtESNUETcLEvhW
	 9UiO0PYYWfZ9WwqlC7SoPxA7BDaDs4qhXo/W+ujybjqkjjrjLLCQhbv1o0Ph6CpMZA
	 imUjval8xBSFm4HFe2pwmTxLQJktnOcYRHZlFlJT+a8sYSq3hmH54TNyE89GuKuJ0j
	 ynGXbCfXnoIdg==
Date: Fri, 3 Apr 2026 14:41:35 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: use int instead of u32 for error code
 variables
Message-ID: <20260403134135.GF113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-9-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-9-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275053-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 32F28394A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:43AM +0100, Aleksandr Loktionov wrote:
> The variables used to store return values of kernel and driver functions
> throughout the ixgbe driver are declared as u32 in several places.  Such
> functions return negative errno values on error (e.g. -EIO, -EFAULT),
> which are sign-extended negative integers.  Storing them in an unsigned
> u32 silently wraps the value: -EIO (0xFFFFFFF7) stored in u32 becomes a
> large positive number, so any "if (status)" truthiness check still works
> by accident, but comparisons against specific negative error codes or
> propagation up the call stack would produce wrong results.
> 
> In the Linux kernel, u32 is reserved for fixed-width quantities used in
> hardware interfaces or protocol structures.  Using it for generic error
> codes misleads reviewers into thinking the value is hardware-constrained.
> 
> Change all such local variables from u32 to int driver-wide: one in
> ixgbe_main.c (ixgbe_resume), three in ixgbe_phy.c
> (ixgbe_identify_phy_generic, ixgbe_tn_check_overtemp,
> ixgbe_set_copper_phy_power), and six in ixgbe_x550.c
> (ixgbe_check_link_t_X550em, ixgbe_get_lasi_ext_t_x550em,
> ixgbe_enable_lasi_ext_t_x550em, ixgbe_handle_lasi_ext_t_x550em,
> ixgbe_ext_phy_t_x550em_get_link, ixgbe_setup_internal_phy_t_x550em).
> 
> No functional change.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Nice cleanup, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

