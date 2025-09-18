Return-Path: <netdev+bounces-224482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF80B856BC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3B21C83303
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDF1F09A5;
	Thu, 18 Sep 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnoPnP/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09F1C4A2D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207644; cv=none; b=ka4AXGxsNKIFMKrEqgg0RokBfuHL2tmxcYA0fWuYPvMnk3RJ458FSgmiKQye+u+ihg5A+L1YiRLxSlnNWHBRLMuxYLHe5+thqax9aIn7JTdeyjaMvfWgFw92ffF+dVrMz0S76qQh7QmtLtC5vLG+0YK1gSyV4Oxreg7jWdgoeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207644; c=relaxed/simple;
	bh=UQJx9wcC3Y5/RVnetstb3CtyPqehRBaZAkfGjE1g9q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEMfBHaukXtlihph6I3ZmJKBbpiR458f8UbHjDzJPqIxEDIsmf/2oKtjgJ3U0qpdImWajxY+ZikGNMTDvQn49lE2E5VmISq0bjAovVAmbR8hL3VPBktuTKWiIEIoZlqZ4Yo8cil8DjTxdgmIPBKBEhhsJj3uUuZ5tuJ9tBBO1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnoPnP/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7478C4CEE7;
	Thu, 18 Sep 2025 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207643;
	bh=UQJx9wcC3Y5/RVnetstb3CtyPqehRBaZAkfGjE1g9q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnoPnP/woT7o9942piukwLLP+g/cYYfsmmqlQvljTgFvEBJ2vX9RsDBKgRRTyBOww
	 5XCy7Lryd3KlSPKFYnhhT9s7aPrmBrYX5MM/F/MbIceaFUx8oi4ssesUgt9E02WzKq
	 5WWKXz9PK8PGMmqNfvKx50rthdgA9ETgeeOalqhdkMnzfAz7YettyFAcZm4sGIGbMQ
	 1L7YGT/6zCZEh7ypxAtEeHVnMgYAjAUfN/PEO2wRgEGMzg7DIh3ex0CfYs04HoJ5Z/
	 b5zbON5cfzZC4TsUr3IBuDbqXOEeRFFcPNhxTB9Ql8QYk4KDnA0uSxr1oBbDHNsQEX
	 uXtL1c5wX7tUA==
Date: Thu, 18 Sep 2025 16:00:39 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix PPE_IP_PROTO_CHK register
 definitions
Message-ID: <20250918150039.GW394836@horms.kernel.org>
References: <20250918-ppe_ip_proto_chk_ipv4_mask-fix-v1-1-df36da1b954c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-ppe_ip_proto_chk_ipv4_mask-fix-v1-1-df36da1b954c@kernel.org>

On Thu, Sep 18, 2025 at 08:59:41AM +0200, Lorenzo Bianconi wrote:
> Fix typo in PPE_IP_PROTO_CHK_IPV4_MASK and PPE_IP_PROTO_CHK_IPV6_MASK
> register mask definitions. This is not a real problem since this
> register is not actually used in the current codebase.
> 
> Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


