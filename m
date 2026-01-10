Return-Path: <netdev+bounces-248756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68872D0DEBC
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4E8301BE8D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF201F9F7A;
	Sat, 10 Jan 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfdRZxiX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BFF4FA;
	Sat, 10 Jan 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085544; cv=none; b=pQw+cu0TDJYzWY1E1E2XktwOrCdPzupj6T7oOlMDLxhE3CN7ZbChkhYAW1t0TiA6sud/hqICIsBXyyIpnoMH4NRYIyhMziie4Ei8/vJLPV6zDoMF2tx5wlJhF889UJcVQnuq39z8vms/+/qV9XEmbn6EqB3ag/Cu9/pFIHY1vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085544; c=relaxed/simple;
	bh=vzmIB2/sPGd6nZF0era5jqw5ShloStfOHDF/3c4u9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pouwlTzU0GMHr6/U7Ns45SsqLk4dREVZvIZ/N5Vpqj6ZguOyrcTS7urgJg0e0WyenIqFsArXK9vupYyvr9UL1hI4ohr48xjF688xBSQEMJz/03RTB4BT8X7qzKdOnJcaWtXWoSEF25slQx21inKUh4Ox/Mw23Sfh9RXuf6UCgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfdRZxiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41784C4CEF1;
	Sat, 10 Jan 2026 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085544;
	bh=vzmIB2/sPGd6nZF0era5jqw5ShloStfOHDF/3c4u9+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfdRZxiXfrd13MnBGPODIU8z71lyeX3RXILm4x6Lny2fWkz5s4UnJQmlTcvJgJhcZ
	 bCJBrIhb263qgDK3zLdp3oBH/+6rJ8Ni6gHOgwb2NXtDMYnIIDYi+wEm733zLCBygx
	 FZznw1yAJQQCB/9dXNQL/5KDXIaDOerGstHKIa0h1HUBbpXaudAY6TxXtWGs5DE6xn
	 c3x8ffpEC9cvPiAhMvymeLypzJgsckf9GYX4bvAjg5d9WmH0xrqqj7DvBWdd28SrJX
	 SlXIDV1NGy/xSRBV5n2p3K4kihNJYj6BkT94000M6H9VRUIHFbB3NH4GYDF7Frtu/9
	 /0/Mfq3btD3zA==
Date: Sat, 10 Jan 2026 14:52:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 05/13] octeontx2-af: npc: cn20k: Allocate
 default MCAM indexes
Message-ID: <20260110145223.368bd5ea@kernel.org>
In-Reply-To: <20260109054828.1822307-6-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:18:20 +0530 Ratheesh Kannoth wrote:
> Reserving MCAM entries in the AF driver for installing default MCAM
> entries is not an efficient allocation method, as it results in
> significant wastage of entries. This patch allocates MCAM indexes for
> promiscuous, multicast, broadcast, and unicast traffic in descending
> order of indexes (from lower to higher priority) when the NIX LF is
> attached to the PF/VF.

Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:115 Enum value 'NPC_DFT_RULE_MAX_ID' not described in enum 'npc_dft_rule_id'
Warning: drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h:115 Enum value 'NPC_DFT_RULE_MAX_ID' not described in enum 'npc_dft_rule_id'

You can use the

	/* private: */

comment/label to mark off "misc" enum entries that don't need a doc

