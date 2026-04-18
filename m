Return-Path: <netdev+bounces-279497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLFEKkd542lhHQEAu9opvQ
	(envelope-from <netdev+bounces-279497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:29:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D32421172
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85C5301BF4E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45876361DDE;
	Sat, 18 Apr 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0NaPH65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C353612EC
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776515328; cv=none; b=GRjUa6O6PNYPLgxMhMV1HU1FASrEE1eiq1LEEIibIr+51crO6567p8m10TMEI3g09CPOrwSbzdQ/hDgu7f0tgs5TuayIHXzZ7VPNw2pjTsm4EaVaNFbjzEXG7UCk6qLkK9/18zPLvhpzkIxEBrWkBQ6u03B2tUylui+BtMAo7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776515328; c=relaxed/simple;
	bh=rCG4Rh/heETZ9U5/libATa8KrgxSzbUI5XQZax8lu+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf/lxyxMDYxdDfFRgGw3d5Kq5mec4rfja1doMUfmGKKab3BrsMQ/r+EQRwRt9oO8p74MqOzfoUDfVMWhL6ecsD8XXfALsefQ1EcAQLiIvXboXKaco/29LhuZ6BXH9IsVpPafb8/9t9sVEA2IUptNSmz+I1/22G/kJJ17nil/4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0NaPH65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8945C19424;
	Sat, 18 Apr 2026 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776515328;
	bh=rCG4Rh/heETZ9U5/libATa8KrgxSzbUI5XQZax8lu+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0NaPH65AwtUCCw3BS6vhQ3tyaMHgvpdM07vZb3PdDWcmO2/ztvJuAI3PNnUHX6Xz
	 dqpZFHTBXg6LUSyMedWfb78jN3McatGLnev0Eg805z+aG4h37YJQkuHtpiUK15g75D
	 uzpY0tz/HgZar2/YTl3zBqvaG6AXRZFnIWFZNk4V/4tleQ6ICGcwSdp4InkJzW7B6X
	 sTdAqbbhUO4boWjJb50Ft75W8h8/P2dS36k1frywkcVOQfv76LTEgcYQNDdaHwUdUy
	 8lpuw3EYKNyR+Nn/LtTgU/Y9r1uNio/z9RctEhBJlTnaJlQxHccsvE45SwFPHAUGFG
	 MdMXQHgTvV67w==
Date: Sat, 18 Apr 2026 13:28:44 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 3/6] ixgbe: call ixgbe_setup_fc() before
 fc_enable() after NVM update
Message-ID: <20260418122844.GD280379@horms.kernel.org>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
 <20260415142841.3222399-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415142841.3222399-4-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279497-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 00D32421172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:28:38PM +0200, Aleksandr Loktionov wrote:
> During an NVM update the PHY reset clears the Technology Ability Field
> (IEEE 802.3 clause 37 register 7.10) back to hardware defaults.  When
> the driver subsequently calls only hw->mac.ops.fc_enable() the SRRCTL
> register is recalculated from stale autonegotiated capability bits,
> which the MDD (Malicious Driver Detect) logic treats as an invalid
> change and halts traffic on the PF.
> 
> Fix by calling ixgbe_setup_fc() immediately before fc_enable() in
> ixgbe_watchdog_update_link() so that flow-control autoneg and the PHY
> registers are re-programmed in the correct order after any reset.
> 
> Skip setup_fc() on backplane links: on 82599 backplane interfaces
> setup_fc() resolves to prot_autoc_write() ->
> ixgbe_reset_pipeline_82599() which toggles IXGBE_AUTOC_AN_RESTART.
> Calling it unconditionally on link-up creates an infinite link-flap
> loop because each AN-restart triggers another link-up event.  Guard
> with a get_media_type() check and skip setup_fc() when the media type
> is ixgbe_media_type_backplane; fc_enable() is still called.
> 
> Also handle the failure path: if setup_fc() returns an error its output
> is invalid and calling fc_enable() on the unchanged hardware state would
> repeat the exact MDD-triggering condition the fix is meant to prevent.
> Skip fc_enable() in that case while still calling
> ixgbe_set_rx_drop_en() which configures the independent RX-drop
> behaviour.
> 
> Fixes: 93c52dd0033b ("ixgbe: Merge watchdog functionality into service task")
> Suggested-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2 -> v3:
>  - Skip setup_fc() for ixgbe_media_type_backplane: unconditional call on
>    82599 backplane links triggers prot_autoc_write() ->
>    ixgbe_reset_pipeline_82599() -> IXGBE_AUTOC_AN_RESTART, causing an
>    infinite link-flap loop (Simon Horman).

Reviewed-by: Simon Horman <horms@kernel.org>

(Unsurprisingly) Sashiko has a number of things to say about this patchset.
But I believe they can all be analysed as part of follow-up work: no need
to block progress of this patchset IMHO.

