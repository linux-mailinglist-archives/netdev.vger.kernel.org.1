Return-Path: <netdev+bounces-249845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB512D1F1BF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2524A3005312
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54265399038;
	Wed, 14 Jan 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fq1qUXRP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94D396B8D;
	Wed, 14 Jan 2026 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398136; cv=none; b=fnSEuK/6pvxSVwugQmBmew/Rfzn5i1btechj0KvPLnrr7mwaeg6JkVdkn1L2M2/K2Qxm5JLkcsAfA3DJVU1qTNaE6vn9iQ89MMaYoFlKEjdMFNCFE5Brt0x20/SRRzBpgPfsBmPxD/6gi8xwc6aI9ake63lV7ePYWuWxNCEI+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398136; c=relaxed/simple;
	bh=J1xBRG2kVmiS/zEzuCkxNADcT+f7sRa8mBXKoDtzuxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1cOCpDVijEzWd8iFNstPMBhrz98buRILtCdJCHY5vfoXIhGV2OpdmEXXsvoL7G06dS26YXRHv0jWGkQZ3iLcaRBGrdFHhI1At0UdG9xf8nPrv+Dc70lzYFhkk43uwv8G7a/QCAd67IwifyBZGGCrQp56i3fS5g79HQ5hL5TEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fq1qUXRP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Us8hYZnuasadB1sOZ9DIsFfGFG79Scw4y0lqD9auY08=; b=Fq1qUXRP2kvT/ra8RFoCLBxr14
	xZKyrZPMCEukORHnl76fEDjs1fQ0aYsSgt2+lfvYAoW/vhat5dHNcAPI6pxYBfhi7v1MB8dFYy3Ix
	z7pRm9jqJoUjtoLDrUl+eQezCSHwIc2wsYF9vgMHozxBBCN7VnlVSazNodu33TS37voM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg18G-002nVf-4K; Wed, 14 Jan 2026 14:41:56 +0100
Date: Wed, 14 Jan 2026 14:41:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII
 slew rate configuration
Message-ID: <a153a5d8-d8dc-47d4-9ed6-f4149e09fce4@lunn.ch>
References: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
 <20260114104509.618984-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114104509.618984-3-alexander.sverdlin@siemens.com>

On Wed, Jan 14, 2026 at 11:45:04AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced maxlinear,slew-rate-txc and
> maxlinear,slew-rate-txd device tree properties to configure R(G)MII
> interface pins' slew rate. It might be used to reduce the radiated
> emissions.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

