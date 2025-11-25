Return-Path: <netdev+bounces-241481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EFC84698
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D30CA34545F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471E1DF75B;
	Tue, 25 Nov 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHUsFJK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F397CA4E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065795; cv=none; b=kASYz7HEgpepCjk5lnjgS5SErSmDD1Q5rIk95bWrRlN8+ssWnVLkUviN9gDqnXM3rOEto+4jbkAHAP3tPsHaUjjc8Y+KszmZDDR5UQfyngrh1bkuAGJqR6y89np7C8HaGXqpV/oU+5p6w7adGrVIY027I4TzvxZwcoEkvtlpXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065795; c=relaxed/simple;
	bh=7E9Z3qVoq+7y8LsemeRstJN9txhp8hp5rPn+YXZEZ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsvq0utNfbL8KjKMK8dPldz9KJSXdG2x3jddDbLst87UULJcwv82Qo+lEm4YVEdclqlGpmIlGlI0dtWWJvqrfO5lSZbXq2ckPlP5F7Fbt/d7o6SgCWK7PlBRNiNGLz+0hF1OFr2pxmSlc+bL4ZB1Topuvw4KZYlIaNAIXjtQTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHUsFJK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DA6C4CEF1;
	Tue, 25 Nov 2025 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065794;
	bh=7E9Z3qVoq+7y8LsemeRstJN9txhp8hp5rPn+YXZEZ7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHUsFJK0FOB2Rk0SKdN7vFe+USWSskei3ELRJ0LnIo6BxrL3WGUw4ALkDQthb7ePT
	 L3ge5lhLDsOJdQ3vehsxLMqh+hhwAQEBV45+suPUVIA9EwkidBuSSUFZvpgampmO76
	 RjvmUGcbMjaM4OpwDoklT6xKbBD6D2vwi60pjJQ5pxjoCntRnrC85/+IWGP9HR8f9T
	 OjJ+0665pc9yb4spxBoQi0pOfm6q8d9WyuJhUN94w3b+wmeWK37bak1zg7NJMeACkz
	 htzWkTymrHR79fifxPe5KihV8Peg3iqaeO0nf9UwpGgvXktJ+Ar8kY4Xvbxe2UkPld
	 1lVpMdH9fU+bg==
Date: Tue, 25 Nov 2025 10:16:31 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 3/6] ice: remove ice_q_stats struct and use
 struct_group
Message-ID: <aSWB_yLwW-DKvuc_@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-3-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-3-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:43PM -0800, Jacob Keller wrote:
> The ice_qp_reset_stats function resets the stats for all rings on a VSI. It
> currently behaves differently for Tx and Rx rings. For Rx rings, it only
> clears the rx_stats which do not include the pkt and byte counts. For Tx
> rings and XDP rings, it clears only the pkt and byte counts.
> 
> We could add extra memset calls to cover both the stats and relevant
> tx/rx stats fields. Instead, lets convert stats into a struct_group which
> contains both the pkts and bytes fields as well as the Tx or Rx stats, and
> remove the ice_q_stats structure entirely.
> 
> The only remaining user of ice_q_stats is the ice_q_stats_len function in
> ice_ethtool.c, which just counts the number of fields. Replace this with a
> simple multiplication by 2. I find this to be simpler to reason about than
> relying on knowing the layout of the ice_q_stats structure.
> 
> Now that the stats field of the ice_ring_stats covers all of the statistic
> values, the ice_qp_reset_stats function will properly zero out all of the
> fields.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

I agree this is both more consistent and cleaner.

I do feel there might be a yet cleaner way to handle things
in place of multiplication by 2. But I can't think of such
a way at this time.

Reviewed-by: Simon Horman <horms@kernel.org>

