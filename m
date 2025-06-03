Return-Path: <netdev+bounces-194722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4420DACC22A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA4C16E367
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8C281351;
	Tue,  3 Jun 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK+Q+eSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055D28134A
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939328; cv=none; b=CIp1wbfVBd7U+KTavnUcVUvtyoDmA2+zaJfhqkK2mFl5svdPKr2olQUpuxPJpnMWtUFE49XQ+/9XVUdpCfkgrFeYtzpeMxgdUn5lAerhsYG8CuvPyplnzrIujaQ4os3R0laEJPHbsvaBEpEwDsAL+G8zldlHRC+KSNlMct99uqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939328; c=relaxed/simple;
	bh=9tfANha6a9cLbuywVtathmjriGf6aKTnwRXDdHPWXds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBTERo7aj9bIvHQ1GxPHAdTHlyPy4eI/YjqRFOYhS1Av7KafA6D9AZc3JH7+EXDLPZs4Ibo65iBZyrwavo46NnsOvoZEbec1HaPUxOuJXXqeHsp8J7oFH30IqXeUWXxC18VbslysfYH5Iwo9QxmOgQwD3kSC1335nl14P/JwISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK+Q+eSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F7C4CEF4;
	Tue,  3 Jun 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748939328;
	bh=9tfANha6a9cLbuywVtathmjriGf6aKTnwRXDdHPWXds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RK+Q+eSsjSbQkRTbEQ15KxYVJMJxELkjQOKT1e0zexauBo4KdwGTn27KaIQq3vum0
	 vgCqbAHC8ZLuc7ghMTWiAmvbLfOpA1YGAJcFXiHxG+1ZqnKUmXG8ZC+flfUIbfxefA
	 DgKVh8oD6Hrh9WPg+AF/FoD6PcKk3MjIaDrNO6xp0WUZYzJY79iq1y6EIGDcO7qPx4
	 GK5D54DG4B3tpl9YHkiVYq6V6sgvsEi/8vk3iy2QAZRvpnivUbn4v3Fqtq8lp+tKpd
	 dOrVtYID9vBnq0I0y2E26IBfRK4sqg6aahfGwHARviDoypw7SRbltSSKS7WcG7PCQb
	 pq4RDg590E14w==
Date: Tue, 3 Jun 2025 09:28:44 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: airoha: Initialize PPE UPDMEM source-mac
 table
Message-ID: <20250603082844.GA1484967@horms.kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
 <20250602-airoha-flowtable-ipv6-fix-v2-1-3287f8b55214@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-1-3287f8b55214@kernel.org>

On Mon, Jun 02, 2025 at 12:55:37PM +0200, Lorenzo Bianconi wrote:
> UPDMEM source-mac table is a key-value map used to store devices mac
> addresses according to the port identifier. UPDMEM source mac table is
> used during IPv6 traffic hw acceleration since PPE entries, for space
> constraints, do not contain the full source mac address but just the
> identifier in the UPDMEM source-mac table.
> Configure UPDMEM source-mac table with device mac addresses and set
> the source-mac ID field for PPE IPv6 entries in order to select the
> proper device mac address as source mac for L3 IPv6 hw accelerated traffic.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


