Return-Path: <netdev+bounces-208452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B6B0B794
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 20:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0515C1896146
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B252221720;
	Sun, 20 Jul 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nakgIs+7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BC1F4622;
	Sun, 20 Jul 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753035035; cv=none; b=OkxZfSDNUBiwCthqeEFBLbHk7sAwWzpHWybDiByJjBHxHNi9eK7FifIAKJvdtpUqbSU5SSOmF+toU9aJh7Lenf8Mk93yyDIhlI7hfrAU7N+xRzR1em36Qc3rBju6BM9SGQBDW8/4IEJ495fpYdDa/FW84kC8ai9l2kroEKMgclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753035035; c=relaxed/simple;
	bh=PGUb1ZK7qBD5Fjetq5T2619HhLGe9Yczo89Xz4gWD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9bS6q14Xk3issb8WChDXlU7na7ewt0KseDc7QVe1T8I7Tnmq7INFBqg7cvTW4Y5Nju0spOkx1DIuHg5NpfdKpNvOf1Cv0iTWJgvv8mniN0IFqBZ5ig7qCFiHY3BbcvirmlUebrRnMnXkrmETOV1FfgNMhOsbkdeQ/PVztoTuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nakgIs+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D034EC4CEE7;
	Sun, 20 Jul 2025 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753035034;
	bh=PGUb1ZK7qBD5Fjetq5T2619HhLGe9Yczo89Xz4gWD0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nakgIs+7sEf/9w5mmZwkamBa2VPyvy7EQhB0lDiXvvJAcS7ygRuWE3ddyJj57p5ce
	 wAFK2zyJieZ5uYjhJ5klL83r3138S1jOKj2JyOC1TtdZcIuY7azLwQjgcQFLTth5Bp
	 t4d1gtmoVFIF4EKwRZA7DyuIto5AaQvi7ubvhsih+wrYHCd5Bhn26eS8XIf7Vklm8w
	 uQcN5O1DIq3q6JqgZcZbUFHSJQTJcAurL/nW6itrvR0ORJukdePRFDLGA7nLDiDaNS
	 Ws+QM+m5HO491pWAY+0CkHJJ3B23cnL7IuscSylZhZXGBE+Eohg3L4KiwJpfcvU5N6
	 PH3+kUyRBnVLQ==
Date: Sun, 20 Jul 2025 19:10:29 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next PatchV2 1/4] Octeontx2-af: Add programmed macaddr to
 RVU pfvf
Message-ID: <20250720181029.GY2459@horms.kernel.org>
References: <20250720163638.1560323-1-hkelam@marvell.com>
 <20250720163638.1560323-2-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720163638.1560323-2-hkelam@marvell.com>

On Sun, Jul 20, 2025 at 10:06:35PM +0530, Hariprasad Kelam wrote:
> Octeontx2/CN10k MAC block supports DMAC filters. DMAC filters
> can be installed on the interface through ethtool.
> 
> When a user installs a DMAC filter, the interface's MAC address
> is implicitly added to the filter list. To ensure consistency,
> this MAC address must be kept in sync with the pfvf->mac_addr field,
> which is used to install MAC-based NPC rules.
> 
> This patch updates the pfvf->mac_addr field with the programmed MAC
> address and also enables VF interfaces to install DMAC filters.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v2 * Use  ether_addr_copy instead of memcpy

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

