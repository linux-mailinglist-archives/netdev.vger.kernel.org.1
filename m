Return-Path: <netdev+bounces-243296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 465DBC9CA91
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAC64E392B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A411EB5CE;
	Tue,  2 Dec 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBhdLZyU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435D1FDA
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700576; cv=none; b=HOPzOYT4LtPBNsaeaIuT7Q0lNQxkdyQysT8UzGKZcMQ0aZwN8DnirYcquP7hNwQIUCf40eenNgJlAeoRidN/36IdOCh0dkyIM9VUXA2f7yuU3Nfv+ng9T2TErKXD3m9CGGF+/bMgAP+cVuvRMbVyPZrUkhbW3ONF/TD//9pUOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700576; c=relaxed/simple;
	bh=yQgqsiygSaMJpkmvOUK9aemziX5h+9PzpA/FfdGF87g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngdIpYCSFGr3+UWjKFH4pp4ZUsYrsvO0B/bLKid/2ofNCYV/YbDOduMcDwKg2eu0VimRlQpk6zj3zAchHIuyiPjK/txZLGNzxugY6W2y9LTUxXIaWs0UdND2wgAEtTinbC6ghtxB+de7etY15zKRlpH9X3pzK4KIpx4PqdOHIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBhdLZyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B6C4CEF1;
	Tue,  2 Dec 2025 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700576;
	bh=yQgqsiygSaMJpkmvOUK9aemziX5h+9PzpA/FfdGF87g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBhdLZyUIJxX3qFGn+1p1zfpDXi4JrkXnRLoyId49gMS1/SXmjPkJ4Nnf57igtPaH
	 I/olXQCHfoPjw5pbnNrA0Fond5qVj9DcisoZwGzX7EsvBR8Vh5gGq6Ho2AC9equBid
	 LhdQXl6tKAGIM5bORYZl57dWUqhhXKRymnNSD7T7yvnMdJmX+LhWzAeq5UAeoJJpd9
	 hpN7EA8ftOaRejC1KTKy4Dh9ICoj3AbTlIeReLheXhBiS6ZDoRaRPJwkVft/SvrfjX
	 xQBeel4PJQezO/vuZcR276e3+jk/bKwCT8NMXWTVDTCOHRAKiQsExMuXbpjY/M2+XX
	 Hn+rvqc6JI4pQ==
Date: Tue, 2 Dec 2025 10:36:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 2694439648@qq.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 hailong.fan@siengine.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Modify the judgment condition of
 "tx_avail" from 1 to 2
Message-ID: <20251202103614.6a185bf6@kernel.org>
In-Reply-To: <tencent_4A0CBC92B9B22C699AC2890E139565FCB306@qq.com>
References: <tencent_4A0CBC92B9B22C699AC2890E139565FCB306@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 15:43:59 +0800 2694439648@qq.com wrote:
> -	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
> +	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 2))) {

Also, if there isn't a comment already somewhere - it's worth
documenting what the + 2 stands for. head buffer + vlan + frags ?

