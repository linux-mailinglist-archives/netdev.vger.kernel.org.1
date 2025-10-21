Return-Path: <netdev+bounces-231269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E944BF6BFC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313D518C6E6C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A057337B8B;
	Tue, 21 Oct 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tCid0iwf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97183370EB;
	Tue, 21 Oct 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053063; cv=none; b=lK8rEdE7XmsYjcRqRRo/h7jsGmHRyQXHpHbtOotvoDYq2LrcJAOg0Jz8HoasODtTFyS8nWYZg6IhJ9d9m6P3j0CCvrR4P7QZD674T8pIHdfG3qZt/6AvZU/H0x564HiWLb9mqgakFvpgr5jd7c6UHl3GjdtFZORIp+gmObRTDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053063; c=relaxed/simple;
	bh=S+JBlEuUoutO6nIhz1j6pwR1DVQjlcD3ljLAQ1XBfzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT7xudy9X0R6beGZtFL+id6k/oJBt7D72lMDR8RhTlpRkf07nmGbKdYIK1zOwo5X3Z7J+9rbJetNpYVaOblJa0QKeneNyB3n3a3ihgAXDie7Jc/l8G/ofJaGBdL1U1uNn0xi/Po5UAdWuuBc2j9UpfUawphnO6IWmDKhcQ0oSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tCid0iwf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lrri0Cr907MtkmIMRNvGQLSiTljN+gHtzJCG/I8kPio=; b=tCid0iwf/AFzkWpFd1rVfmh9cZ
	rbLedkbcdoi2qFkY/hIHLMUpWUrmKSkHhLrRMnMIcRWNswesBPIW268Ox6uVHCLA7luCH3EmUhAZW
	BfAzJRx8EH8M11GQRCoR/anPDKXOjY5rCueHUbRVy8FN89ZSX6Tsktdfj8pxpyN8UFV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBCLQ-00BdZh-5j; Tue, 21 Oct 2025 15:24:08 +0200
Date: Tue, 21 Oct 2025 15:24:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, gerhard@engleder-embedded.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for non PTP
 SKUs for lan8814
Message-ID: <f1fb532d-b0e0-4d61-a415-8e224cefcb26@lunn.ch>
References: <20251021070726.3690685-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021070726.3690685-1-horatiu.vultur@microchip.com>

On Tue, Oct 21, 2025 at 09:07:26AM +0200, Horatiu Vultur wrote:
> The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
> disabled. All these SKUs have the same value in the register 2 and 3.
> Meaning that we can't differentiate them based on device id, therefore
> check the SKU register and based on this allow or not to create a PTP
> device.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

