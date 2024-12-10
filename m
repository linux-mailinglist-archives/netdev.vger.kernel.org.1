Return-Path: <netdev+bounces-150463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F59EA4F0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931D4188AABB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65B1C5CB6;
	Tue, 10 Dec 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="svUVIH94"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BE1D89E3;
	Tue, 10 Dec 2024 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796744; cv=none; b=e1OBu1voKR6Zi0VqnXG2ToawoTzYNK9JfE3k4G/VQ+/ahkMa1CGvMyTRR2eQfyB/4rod3zYKWMtwW4DKscJoeUVSzEApl32yDx7FOgtFW+reGlwbqVvF+QY8+3Y/0MZnga7i+TRCO/yLzYR4PUSzI0u0eSUF7npskn6F3MXFezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796744; c=relaxed/simple;
	bh=3oe+kW+81rhk92Q8T6VuCdh3CFJRUA6sivllRxaKECs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4LziVOGkmbQZwwsIie/QkP/m89zw4mwLktLEE4QD5dtOnaY8Aa0I3AOUBnzHwxj/fpWLGDTbMDVA2bnQF9ARr7tW9ooQzjy6kjSv0ctUTSStTdOttWTntOZLqnpv2bQsQoQMo3vKSWb2Z/6iylQLkP35tkCFfE4idNGOWaJY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=svUVIH94; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LhNyKCoYf7g5GFa8lww0Ss6AXMB0IAjxmPxAijXGzEA=; b=svUVIH94NcD8UyyxRttKyhvyTw
	u078WaANVygJT3dl1Ou1DvHZa+kPs8isMsce+uEB3PkV5mv5fAw+taUIz1AkdYGZVN8AHOi86DLbJ
	a6Md6yscS5tgHFEh9TZXGU1zspmGdN5OehXOmzhHeRmnjK9iAok4PZ/EByo9nAkwwcYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpjV-00Fk9k-CB; Tue, 10 Dec 2024 03:12:17 +0100
Date: Tue, 10 Dec 2024 03:12:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 10/11] net: usb: lan78xx: Rename
 lan78xx_phy_wait_not_busy to lan78xx_mdiobus_wait_not_busy
Message-ID: <9d9ebf3c-5cf1-4367-8a1b-0c286c9be44c@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-11-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-11-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:50PM +0100, Oleksij Rempel wrote:
> Rename `lan78xx_phy_wait_not_busy` to `lan78xx_mdiobus_wait_not_busy`
> for clarity and accuracy, as the function operates on the MII bus rather
> than a specific PHY. Update all references to reflect the new name.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

