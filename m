Return-Path: <netdev+bounces-185959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99499A9C51F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78264A064C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87B238D2B;
	Fri, 25 Apr 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdlX7sD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852417AE1D;
	Fri, 25 Apr 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576455; cv=none; b=KNNosAq0hAe+4lzSzmH52bTuHmnUieXrYs9MOyay+dbw0tI4nfZltEnnFBSJmPDWoGM4WnJVXG8CIsVOiXJ8gFBquZ+836nwxLyVVAFYENNREgv5O31as+cOda9sdHEQFs+lR4QUE+nFwxeEwApmmmvg5DVgztrAwksF2OWT4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576455; c=relaxed/simple;
	bh=jcAtdlYTfa1RC2cu9dSkGODwfuS/DqnkQIJyB/0DwRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsUpWkT1KyAKUEHZpvDCnELfILnTVVTPQr35Ii5i2WPSbZ0AtKoAMAcwPH6tpS/JZ0NCT3gZyzu2aX8WyYMoT3etSkpfLLXVZAzNQIYN4WvDMB4sTSh6dOJTy48n7lTFIphB+z/PVn4BPJnBzhRk7V7aym1DnSJg74RwmX6EIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdlX7sD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8471C4CEEB;
	Fri, 25 Apr 2025 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745576454;
	bh=jcAtdlYTfa1RC2cu9dSkGODwfuS/DqnkQIJyB/0DwRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdlX7sD02k7fzLbQiCInydO04W7vNrrsSFK46wdHTBwTPZqMbEB24s9kLeSGsLHmI
	 m2ALbZgzluFz8vkpMwt1JsUjPJCkkDzWfFnmE3QoazXWQALiM8lMu8iPbnmPR2bte0
	 0hilI4WmcaAphIiYWf4Ilnj32DR9ln6y53qULzVIz3J4rCkimtfGXhZfb3NMnxy2HI
	 cqDbc7MJKHXc7jIPAQ1k8eK7ImF7jevVYdOYqnCMJdIxsV/HXWDR5MAGtUR8c6TDPS
	 7agCVTMwigx5V92d4pFvMyu8mfk9IXs6PCqLKQjeUcLz7g6DO2kfL4kQ7QKF+deZ1J
	 xKQ6HeRgQxMpQ==
Date: Fri, 25 Apr 2025 11:20:50 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: annotate RCU release in
 attach()
Message-ID: <20250425102050.GO3042781@horms.kernel.org>
References: <20250423150811.456205-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423150811.456205-2-johannes@sipsolutions.net>

On Wed, Apr 23, 2025 at 05:08:08PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are some sparse warnings in wifi, and it seems that
> it's actually possible to annotate a function pointer with
> __releases(), making the sparse warnings go away. In a way
> that also serves as documentation that rcu_read_unlock()
> must be called in the attach method, so add that annotation.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Thinking out loud:

* Without this patch I see the following, but with this patch I do not.

  .../mt7915/mmio.c:636:5: warning: context imbalance in 'mt7915_mmio_wed_init' - wrong count at exit
  .../mt7996/mmio.c:302:5: warning: context imbalance in 'mt7996_mmio_wed_init' - wrong count at exit

* The only implementation of this callback I found is mtk_wed_attach
  which is already annotated as __releases(RCU);

* The only caller of this callback I could find is mtk_wed_device_attach()
  which takes rcu_read_unlock(). And the the callback needs to release it
  to avoid imbalance.

