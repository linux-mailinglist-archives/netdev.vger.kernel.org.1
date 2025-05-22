Return-Path: <netdev+bounces-192684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECAAC0D2F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457B69E56B1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345511A317A;
	Thu, 22 May 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmc/chWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104741EA80
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921721; cv=none; b=UWjn5pq0q+Oe3ckXXqtXa/MoX0LU0GJk1iBIoYKfk4uExcQq4U5kBpl3zbohY0yPDbt+893tlTxZZHY9ImUZdduB6l0NGqh85XzNipmuJsAvJ4fwj87OweLWfkM81XDgxNPxzc/anlcz6KEjZezkL16Zj6riuyoog+aC73BzsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921721; c=relaxed/simple;
	bh=xPVPJPDU9wpwhb6wXhxg8TZYODtzniGKx7XYTwgsd3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+W4yEXut7czHTXPhU6RsiXMx/af1wI9zEsvYhcg1g0P8jvUW5GYwdVs5TL3JYWecivdkgybTfHqWmI0aNg8TCCXEYzDeC4wDNLMnxeB86AXbu6Da6Mh+DY45KmmzRJEp5Bl2QoB3y0MA7+905I9VF9hOyFf/xOFgcGKDx9tbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmc/chWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E036C4CEE4;
	Thu, 22 May 2025 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921720;
	bh=xPVPJPDU9wpwhb6wXhxg8TZYODtzniGKx7XYTwgsd3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmc/chWXnA2FQb2GzXOWaNgCeC+APRSsP754PvPCQFbZXnbbGrwOrLvtVvcUSQ5XF
	 Q3Y77kOfNt3LwXSvaxHJAWOZCRFXlju9ZUznRb8OmRvCRHUYYMbuWcgi4zSydtShtO
	 hF9vhkTbNMe7V2eVi/NZE7/u4q0FHnoytI6KdNBtFfA8/7gFeANup7H3B+xvGL+CnB
	 rclAha70yCY4pjOytYHNbi3w2PMN+W1xHTv3/WnVqI5fD4GxEBsIF9hajmFk65MLZ9
	 uglEkuJRq5urgvGFXGt9pXHntg3VMEMbz1bx3LYWL/QUkxAM5DZ4OOyCRI4l2GO5Wg
	 zusPPFA90nfvQ==
Date: Thu, 22 May 2025 14:48:37 +0100
From: Simon Horman <horms@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next] i40e: add link_down_events statistic
Message-ID: <20250522134837.GG365796@horms.kernel.org>
References: <20250521142332.449045-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521142332.449045-1-dawid.osuchowski@linux.intel.com>

On Wed, May 21, 2025 at 04:23:32PM +0200, Dawid Osuchowski wrote:
> Introduce a link_down_events counter to the i40e driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
> 
> The value is exposed via ethtool's get_link_ext_stats() interface.
> 
> Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
> Based on series [1] from Martyna where this was implemented for ixgbe
> and ice drivers.
> 
> [1] https://lore.kernel.org/netdev/20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com/

Reviewed-by: Simon Horman <horms@kernel.org>


