Return-Path: <netdev+bounces-192683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C148AC0D31
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743FE7B63CE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA528C019;
	Thu, 22 May 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuHvhda7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518528B7FB
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921697; cv=none; b=nkB6/MQwTq7yRFCtI3hJc7Pw4E7P28LrtZ4zMt4wV9fif3Y7NldtFJ3qBfvJTIjaPR9bywsgceUjOEXSmuwbAFXQAnPqvV83TIjyEiSYY2AeUo4HN9A0ciM2lB0tIZqvXrww+QTu6PrhirsKh4cOoU3IxFd8dgo0QXQJ5gKCOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921697; c=relaxed/simple;
	bh=oRQssJFq6WL3IUU0+bRbfoFe0owE+3DHbiglnFcMLXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCZWdLSnWNTP+EJ77TAKzlS/cF4LTcwYRDbeY3cIly0Ksa+P4apjwb3KP8oTMIe3+nsxl/b1IRbbEr6fciuKX8hxMfuNIk60mt6GmE1yQyiNwhiho6oGQ+4RRhsArA6PojkQUqDcsYRa3a8b1PScQrRwE7w7LHYpJ/gH41a71ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuHvhda7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70708C4CEE4;
	Thu, 22 May 2025 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921697;
	bh=oRQssJFq6WL3IUU0+bRbfoFe0owE+3DHbiglnFcMLXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuHvhda7S7G8xWj5eAbmWzIblusLsDhmfvLeVbmydW6w1kRhC086wX+kTMBUxe64P
	 Qo2O7xj18z8qfOsB8Fzklf0sMDcuAcY/cvBU8TE3jL0asrKxvsco8WmiCqimEy9LxE
	 JG/+LSaY2AXzWDw2RLXvt5yJkaWYRlhunwaHga6k+9mPDYdD+si0U8ZdTo1rd/r5I7
	 +g/sXyxr+yPcKwop7Jv9i+i2IIBx2im+T+fUUH5ibhof9kZRTR7ztuKQDETBs20y05
	 fATxF2gynNkOSywaVWpoB/Q1h9XEkTvv4h5Dwqf9cJi6CJT72sc7mCjAcsCVBxLfFh
	 /CLIBjA39989Q==
Date: Thu, 22 May 2025 14:48:13 +0100
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kuba@kernel.org, dawid.osuchowski@linux.intel.com,
	pmenzel@molgen.mpg.de, Kory Maincent <kory.maincent@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v4 2/2] ixgbe: add link_down_events statistic
Message-ID: <20250522134813.GF365796@horms.kernel.org>
References: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
 <20250515105011.1310692-3-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515105011.1310692-3-martyna.szapar-mudlaw@linux.intel.com>

On Thu, May 15, 2025 at 12:50:10PM +0200, Martyna Szapar-Mudlaw wrote:
> Introduce a link_down_events counter to the ixgbe driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
> 
> The value is exposed via ethtool's get_link_ext_stats() interface.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


