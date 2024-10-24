Return-Path: <netdev+bounces-138615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE09AE494
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393D81C22667
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D71D5174;
	Thu, 24 Oct 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrHlfL6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB91C9B87
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772010; cv=none; b=ZkyV0NjyQuvjzlci3WfM/OkGSBJvzNA50CJoYwfQ6lC56THZenROgGxE9KkkuOJQ3RO9jbsgEkmdBUD3D0eeh0JQoC4DwvpXwJleB6ZxLj5YOg0VD0vIn6RDkVPia/NAfcIQb1Z6l5pq71sW/8lPmZza4E0lwdXTWsVovp91/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772010; c=relaxed/simple;
	bh=9fa+03V1sKP+x6ThALSZDPwEdBH5CtGmmodPwAscStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAv+LndjWpdhtmusgKPkjwAhlL25A0DkWFCEoTbck/Hq95AMl/oumqDGV8g/ymNE1JX5/bYQaSUy9FtGQJT5UX9XiFHKUZI+qxHLngHTe839M7bIGPzAsVUhwhzISo83SuhxROyH9hA4IJc+X8v5ZdKzRLmedYzScXgZ+YlJYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrHlfL6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA858C4CECD;
	Thu, 24 Oct 2024 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772009;
	bh=9fa+03V1sKP+x6ThALSZDPwEdBH5CtGmmodPwAscStI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrHlfL6sZSykjUq0vNOSjDfd8AL29cHnKb1G4ecpxKd77Gu+L3ekzPhID3Kp2bZYB
	 s4ic0y7EhxwDCT2roiEpELTU/5qBd9SaY8tmEgVaNfiMBaS16ZoYmFvsDtCiiD42Wn
	 M+PyJ7iyfDf2j+rN85QH/aUDDcRZlpOMehjU5JLqP/1hJLbqK7Sem/AoXQ1sTyWVvm
	 nRY+Ps6L6RhXTRYnuYzYwtCZDL9ElSpnFA9ILtUSX0gI9Zbc0699SKbr4GRjRdknpx
	 QHzaV+IzYbqnly6IU4AatDD/ZUtJbuKSrtWlUwu1zBM4qBqSP/ZRR/hZNv+Uf39Iv9
	 kBwkwrUiJxOkQ==
Date: Thu, 24 Oct 2024 13:13:25 +0100
From: Simon Horman <horms@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
Message-ID: <20241024121325.GJ1202098@kernel.org>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023080921.326-2-thunder.leizhen@huawei.com>

On Wed, Oct 23, 2024 at 04:09:20PM +0800, Zhen Lei wrote:
> Fix the incorrect return value check for debugfs_create_dir() and
> debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
> when it fails.
> 
> Commit 4ad23d2368cc ("bna: Remove error checking for
> debugfs_create_dir()") allows the program to continue execution if the
> creation of bnad->port_debugfs_root fails, which causes the atomic count
> bna_debugfs_port_count to be unbalanced. The corresponding error check
> need to be added back.

Hi Zhen Lei,

The documentation for debugfs_create_dir states:

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

Which makes me wonder why we are checking the return value of
debugfs_create_dir() at all. Can't we just take advantage of
it not mattering, to debugfs functions, if the return value
is an error or not?

> Fixes: 4ad23d2368cc ("bna: Remove error checking for debugfs_create_dir()")
> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

...

