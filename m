Return-Path: <netdev+bounces-63498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45282D77B
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 11:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9044BB20C2E
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281A6105;
	Mon, 15 Jan 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JthXMycC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4D2BAFA
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 10:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F97EC433C7;
	Mon, 15 Jan 2024 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705315021;
	bh=AlH6m7R+pm2ANeZNg+yynW5ldbUyIDy0PRzHaQ7Crjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JthXMycCwnQoGXYaQeJSQ30+M/hffZh9vt3N41WuJWUUkEFSgFOT7PTyIYLbRlgJ0
	 VYRWtKjG3boPbR2OyMb5JGdGkMoPGpxafGwjZ0cZJRbVYPwXkF67q8t6W8aQQ8np1l
	 lsJgBKAYeUt1JvgtT2PpTGdowKdsHTYsYXbUsLMFMhZUcEuJkNi6aAIGUqGYilJ22T
	 i64bYnHXcj8Yln7aP06wd/6DKjAJviXVP+UKoFJOYqBKnyLmF5ghwf1mhAyi6aGbHV
	 gIDKVSNEEWcWDN5/UDt5w/Pprhgs6QY/TQchReb8aojIkNq0h/C/NTnAiFDtLkovvj
	 6bMCOIcw7saBw==
Date: Mon, 15 Jan 2024 10:36:57 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 iwl-next 3/6] ice: rename verify_cached to
 has_ready_bitmap
Message-ID: <20240115103657.GM392144@kernel.org>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-4-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108124717.1845481-4-karol.kolacinski@intel.com>

On Mon, Jan 08, 2024 at 01:47:14PM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The tx->verify_cached flag is used to inform the Tx timestamp tracking
> code whether it needs to verify the cached Tx timestamp value against
> a previous captured value. This is necessary on E810 hardware which does
> not have a Tx timestamp ready bitmap.
> 
> In addition, we currently rely on the fact that the
> ice_get_phy_tx_tstamp_ready() function returns all 1s for E810 hardware.
> Instead of introducing a brand new flag, rename and verify_cached to
> has_ready_bitmap, inverting the relevant checks.

From the above I understand what this patch does.
But not why this change is desirable.
I think it would be useful to state that.

Also, perhaps it just me, but it seems that
renaming verify_cached and weeding out assumptions
about the return value of ice_get_phy_tx_tstamp_ready()
are separate, albeit related changes:
I might have gone for two patches instead of one.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

...

