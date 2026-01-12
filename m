Return-Path: <netdev+bounces-249000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716DD12803
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160253062E21
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D52C21F3;
	Mon, 12 Jan 2026 12:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42050097B;
	Mon, 12 Jan 2026 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220354; cv=none; b=QTkIMGs+pXC1LHqTHO3z3b54j47za/pikdAp4mhN5vzqtPXxGnmCDjOvQQRAw/3tSzTNrcPNddGU0GioUrk3PQYOaD07Mc9fm13yfo5UsExRBF7GMmuwIDjtnvDNZqE9n+YvITLs1BrVsQce6T5DcmKnqvEmDsCcTZZ6ROF6w/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220354; c=relaxed/simple;
	bh=f176uhvnzHjDcIFTtZkG62x2hA1xrFwC2EJlPHHW+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDI2GC5aX9oJzadvvT0aS9XRJIiNRf1W+8jMQ9QxtGGDVm8/Tpm5TLVswKGmNKGshPEE2UPgoYcDtyZmaix7YjL5qWljozW3Ond9ZrXPnvxDx+eawrQowvdbYpnmwVmnKmouEOClED7gOMBBQuFWVzM5pW2V2HeTtyinOIxrRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfGsw-000000005aH-2dK0;
	Mon, 12 Jan 2026 12:19:02 +0000
Date: Mon, 12 Jan 2026 12:18:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII
 slew rate configuration
Message-ID: <aWTmsnY_qidct1fT@makrotopia.org>
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
 <20260107090019.2257867-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107090019.2257867-3-alexander.sverdlin@siemens.com>

On Wed, Jan 07, 2026 at 10:00:17AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced maxlinear,slew-rate-txc and
> maxlinear,slew-rate-txd device tree properties to configure R(G)MII
> interface pins' slew rate. It might be used to reduce the radiated
> emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

