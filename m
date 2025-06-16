Return-Path: <netdev+bounces-198161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB575ADB73C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D87A12EC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC32868B3;
	Mon, 16 Jun 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyrmHN1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0B21C174
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092207; cv=none; b=OL0Br+ZvIhu5s2RsAKsWoodee0WrlFtsvi5lZJD0LKeml5YBe9EADrJ621ltwdFfTE3ByQt4FO2x4tR2ObR2asWeUzPNQGmF/d5ErSNuQiforSQWbbMEcSjKtlCxRqFX496yRuctp5EQMyyBrzvVNVr0XkaUEHc+bG7/oFhiiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092207; c=relaxed/simple;
	bh=vgKHpIin0g9uK+ECZ8DMrKXid3Ki24jEuiHE83QJT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekeP6sUGxdZrBQtk8sZ9vn9PHyzYD5zy2YgAm+bzlaZwBBtL+tSmt6P0p8bhCbdxwVA4OJB31RZwC9ZHCZybAAsJLa51tXc7Kl8ojXoiiYQVlq23HfYrepEoueG2rHMBGHLiWujWaKXfer7IGPnBDcZA62gySjfd5bYi45aH1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyrmHN1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC899C4CEEA;
	Mon, 16 Jun 2025 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750092206;
	bh=vgKHpIin0g9uK+ECZ8DMrKXid3Ki24jEuiHE83QJT/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyrmHN1PY/IDHQIPV4xvG4X4qZNHhmrYs8nSvy1/puhkpIkaUuwi6mmuN/uQqdcj6
	 3g9s5HDJQfphHob0LMaFN5vjPW1mw/uON1YQh5ZeIs6lytBUWTUwhGEtLd7AkCQwvm
	 b/+UhCLWxr6qOGDpdw4VDZmttbLtuLUe9G5h+O5yGQS4Pe083ZPhxsKHlhNg6KZR+s
	 Ok6LcTc9sLwy1E7+ZzEseaJmmCudJYMsYh+ONmxjkvQiAiY9/M8jkcMk7qjYAPoaV7
	 TqWbaL540Pi7SgwkPpWQH5dX51moq7+gDFL5xUz3Yr1TQt5m7ZimFElSjrDLzveLGa
	 wDWhmQ8Rv2FxQ==
Date: Mon, 16 Jun 2025 17:43:22 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
Message-ID: <20250616164322.GB4794@horms.kernel.org>
References: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>

On Mon, Jun 16, 2025 at 12:27:06PM +0200, Lorenzo Bianconi wrote:
> airoha_ppe_foe_get_entry routine can return NULL, so check the returned
> pointer is not NULL in airoha_ppe_foe_flow_l2_entry_update()
> 
> Fixes: b81e0f2b58be3 ("net: airoha: Add FLOW_CLS_STATS callback support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


