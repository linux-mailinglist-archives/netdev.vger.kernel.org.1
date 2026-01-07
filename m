Return-Path: <netdev+bounces-247761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5016CFE0DA
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24C4307DE92
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FDC33C1B7;
	Wed,  7 Jan 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3MuUiTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18E33554F;
	Wed,  7 Jan 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792915; cv=none; b=t3Pe/H5j94zsIdK9j3L5z1PhWY5KyOgQbrpIu3XlQ1VlfQGKfDB7OvoM1wn2UVU/itbRCdYtw5ft48jideieZSCouZ3DUKPqZUduPLm8k1vq8ky+Sse0wUZIUi0ZXR2H4PrmLVfxQQmnONABfUad7Yx+Z7SwB+RR7VmUTN4lmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792915; c=relaxed/simple;
	bh=tuOxz+2km4OAM2kYT3YnfTTUjzyZ3rQep8bFqqLQo/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3duBt/0Qx/UJZoTLt0rV+eL2vC/mYd4tQ+56zUNWRPlPcKgVktp6gwiJG2caT+BLNNvYuCzAYh/XfP/x9TBv6/gHxkkJ8EA66wES27amiEYs7WZUW+mOg6O7Utz4NwOPGVJvSsZzmuAanFIXWwIScUYeeuGmYtx221To7MgMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3MuUiTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B44C4CEF7;
	Wed,  7 Jan 2026 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767792915;
	bh=tuOxz+2km4OAM2kYT3YnfTTUjzyZ3rQep8bFqqLQo/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3MuUiTF4qIyHi7ref8Gsr+U3ir/y/lus8o0rUFOH0jrq1LMRtfo4VTwskoIeBjHe
	 AZiVz9GxFH7j8jbdgoJWiRwniaguCAUdFrouwc6XHChvdsLKKB49wnnEw6fZe476Fh
	 zFpIvNUwWcobNitNWgCskLTwnv4ldoUd0Xjszvc3s7BTLzMRb3pOTGSmxWDbcdsReJ
	 oObiDCZnKAcHJn9Wb54Kl4d+2K/PHqE4j2U/cxqAWGqha4LXylEkrjXBdTHIscfOjP
	 VZMNp4QCHQ5n5fQiRCGCGeHVoHIDsqHlQU3z2VVK+6apyrA7Bpm7sVdI39ANDAzFZF
	 KvREPu8kz/KzA==
Date: Wed, 7 Jan 2026 13:35:11 +0000
From: Simon Horman <horms@kernel.org>
To: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
Subject: Re: [PATCH v2] net: mediatek: add null pointer check for hardware
 offloading
Message-ID: <20260107133511.GA345651@kernel.org>
References: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>

On Sat, Jan 03, 2026 at 01:50:08AM +0100, Sebastian Roland Wolf wrote:
> From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
> 
> Add a null pointer check to prevent kernel crashes when hardware
> offloading is active on MediaTek devices.
> 
> In some edge cases, the ethernet pointer or its associated netdev
> element can be NULL. Checking these pointers before access is
> mandatory to avoid segmentation faults and kernel oops.
> 
> This improves the robustness of the validation check for mtk_eth
> ingress devices introduced in commit 73cfd947dbdb ("net: mediatek:
> add support for ingress traffic offloading").
> 
> Fixes: 73cfd947dbdb ("net: mediatek: add support for ingress traffic offloading")
> net: mediatek: Add null pointer check to prevent crashes with active hardware offloading.

Hi Sebastian,

I agree that the cited hash is a good commit to reference, but
I think the Fixes line has been mangled. A correct tag for that hash is:

Fixes: 73cfd947dbdb ("net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices")

Also, please no blank line here, between the Fixes line and your Signed-off by.

> 
> Signed-off-by: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>

...

