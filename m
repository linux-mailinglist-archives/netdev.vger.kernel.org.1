Return-Path: <netdev+bounces-160082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F83A180C6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0255163935
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9991F4280;
	Tue, 21 Jan 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QriLfz+7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2A16C850;
	Tue, 21 Jan 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472115; cv=none; b=re+4irHE+c+5LeMJPAbSFd24HySVvHH4Wnu993kMtg0uIlStScg91yFSfReL13Np2UY3+T7CLqaVRX28UIXe0FxumweF3UX/tIn0qVnXvb2N77aRDnK5glu9tqAxO5HrtaYAYf5OXtp6GzLl8C//+IWTQkGjZV9x56Eg0IKkxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472115; c=relaxed/simple;
	bh=o6ApC4copduUqxxXB4Va6qgSHlBUjpnWUaermCU7KNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2WkBPTZKLz5nye8ZFyaoQE3OWtOiEYB3AgJz3eCiQPgDGXBNekAV0sw32L0HOdGczZ39QtSPg5C4EofLAWv+vezHyqa/0bjIZjY7SwzV4F3jDbjmEyzwrDsW80u4xplYrTTUKXrqZQU/pFljLKATbzB1bAy65zzXZho8mFYNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QriLfz+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751A9C4CEDF;
	Tue, 21 Jan 2025 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737472112;
	bh=o6ApC4copduUqxxXB4Va6qgSHlBUjpnWUaermCU7KNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QriLfz+7eXDfXCIPDjaTvnKXDBPQB7nNS7KXcdXzs+hE2LQnYAN8DRNyKcGcAuUMo
	 Y9EInKKj8ZaaW4KHmbhPHXh5pFPZ3YPrU0sqlERvOAB8rWOHT4dAjDDBcSnZCP0Mzs
	 9nyTWop2Q/wXN2XZskMl1D85dO65nw5MAyc01umyclLco0dIpnQocz+hCkyCb+TI4O
	 O5Oe6Z+f0lqKrrGfQ741iGddGqKJJpTv7lXbPLFVKe2uxGH3eV+dATjFgwpV+yi5rg
	 dtohm1dfetOyFQ0b647GogJNda6UwQiI2aLIc5JCaAZdmc/IVMOr8Fq20O2AtrUwsY
	 emQE/u1nE3/+w==
Date: Tue, 21 Jan 2025 15:08:28 +0000
From: Simon Horman <horms@kernel.org>
To: Yeking@red54.com
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: the appletalk subsystem no longer uses
 ndo_do_ioctl
Message-ID: <20250121150828.GE324367@kernel.org>
References: <tencent_20DAAA1E396BD1BFBEE79076A81FA1402907@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_20DAAA1E396BD1BFBEE79076A81FA1402907@qq.com>

On Tue, Jan 21, 2025 at 12:40:32PM +0000, Yeking@Red54.com wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> ndo_do_ioctl is no longer used by the appletalk subsystem after commit
> 45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").
> 
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: deferred

