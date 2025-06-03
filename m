Return-Path: <netdev+bounces-194724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F60ACC22C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B383A2F0A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3915280A58;
	Tue,  3 Jun 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBD1Az7v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F123271461
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939399; cv=none; b=jzlBd/RhnjnfGkw20d3brOBRhPdCuQPkXo3ab2niNB4JUbf/gy1DFQDIWHU4g/xRo77p0xdBmEZyiOjPgo2lPWaWYmwwEMofUQcMGGyJC53yLxgKofsZpwi1YOlVFEwp7/1+n1J0zLCOAXuQasl78bN/Oe4XiJWh7UUKfQ78Nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939399; c=relaxed/simple;
	bh=xqHElZcqLYZQ/JxVxlw7t/s7Lb1c4zp+pRSDxtBSLTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq2pqh367Gn6B4vAMlM9nK2hRReJ6iN8yDx/tQWPFecuKC7RJAwxjr1Qmwdc4NyUhN4W2BKyd7wDqVKEfTuZbt9bQlIwm7dEUo2ezVM7zb8LNLfL1+ag0mfjG+aRoez3NqRPJbxX4+eISnvqcE3wraXxaMwISDaZ7u92ElpdSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBD1Az7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757ABC4CEED;
	Tue,  3 Jun 2025 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748939399;
	bh=xqHElZcqLYZQ/JxVxlw7t/s7Lb1c4zp+pRSDxtBSLTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBD1Az7vOdigGWKNr9oj1gqkUQT6+M3bm0wFIxDRcgplIE+XV93xg+diIH9hsnK3g
	 fm4VZNRaVO0gtqSAvuiYZDzd8JWMz6vB8obqtoETvA9mD6rirKMOA6J2Lb4fHcBbIv
	 xw47mhCRlJMZGL6WD5VqLXViKBL5vTEMreDiHKeXpCETLpXrSjFO3EQfOFKe7cV6SX
	 yLxLYtpmSr+obelKNSit0LlxrnxSChdwix6xWKsaP2iWe0gioA1EzoFU3sC6KP2Hjv
	 AvR52y9BvvgHQ8bRyrFuHbP5cYMo6FgNzxsxvNFOLeuyfjDLy2W9WO7xQdC5QOwEpT
	 9PpfOjYOxDGsw==
Date: Tue, 3 Jun 2025 09:29:54 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: airoha: Fix smac_id configuration in
 bridge mode
Message-ID: <20250603082954.GC1484967@horms.kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
 <20250602-airoha-flowtable-ipv6-fix-v2-3-3287f8b55214@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-3-3287f8b55214@kernel.org>

On Mon, Jun 02, 2025 at 12:55:39PM +0200, Lorenzo Bianconi wrote:
> Set PPE entry smac_id field to 0xf in airoha_ppe_foe_commit_subflow_entry
> routine for IPv6 traffic in order to instruct the hw to keep original
> source mac address for IPv6 hw accelerated traffic in bridge mode.
> 
> Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


