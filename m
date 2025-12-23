Return-Path: <netdev+bounces-245869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C621CD9AFA
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734A0304B736
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC40342C95;
	Tue, 23 Dec 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Xw7y1j5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF3279DC3;
	Tue, 23 Dec 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500505; cv=none; b=mdFeY4+4BHHhVhRkEo6SVbkU1I5B9CrqoaYt+9roby8TqSOlU1nBVELNivbP7M67tvYWocV0pjkmFCniYxq29BtM4iF9hCp9+LkJg3h1pRGsn3CHOCD/BoLzdha+b5LaGiohHLmaDo/vei5dP1mRi0eoWKVwivxrasbc2c/VJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500505; c=relaxed/simple;
	bh=8jIovo0juQRJpjcY4ldFSWb8SZItlmTOWhMrG7AQNYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAWM5thWRTUvJ+WJdk95ftv48f5SjmxxWbycyoxI0DQnkJuU1j14UPcxKnRgjEMPzml8fTgX0eV3DMZpAJ1Iqc0ou/hbFVeJb4ebMyuuaXeErOM+ar9QVMggZqcmeu2Bv415/XWyw50N5vBssqqxsnSP+yUnZIQ0KwRUvSg4RQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Xw7y1j5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4KIS28ARys93FO1ek97neKaWYgYIjKtlf0LE867Pzfc=; b=2Xw7y1j5usAu4zilmTY6yJAgfu
	06nLGlF/3GqPop+AHaAP2XXaXdfOTJ+Z5yz21KTMP3kpGnBTqcfw8RYCZO5z/h24apEKJdwJ06N5U
	V75DX7LjL2Gf967u5ngVQQ697stfcuBdmKP+rmjk00XjIQu7o1QM1klkls3QUbHu5YVY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vY3TV-000JF7-4k; Tue, 23 Dec 2025 15:34:57 +0100
Date: Tue, 23 Dec 2025 15:34:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <0376a133-44a7-40e8-be7d-0d04d33c0ec7@lunn.ch>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223133446.22401-2-eichest@gmail.com>

> +examples:
> +  - |
> +    ethernet {

This should be an mdio node, not an ethernet node.

     Andrew

