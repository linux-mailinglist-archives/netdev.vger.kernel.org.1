Return-Path: <netdev+bounces-235361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 978CCC2F38F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32D4B4E2CBB
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716718FDDE;
	Tue,  4 Nov 2025 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PGBKiwpN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D3A932;
	Tue,  4 Nov 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228875; cv=none; b=iteMtnZQUa+qi0wAOvx3W8izuEDfpt3lAVjwvLNpLppYiTc5+6klnFEGRB73L8geT8O9D5Zx9LYFt076lpxbjVu46Pd/CgMkhMfaNQvtjW2tbPuuGnKlH43KlMQrq3RE+ITIRzHk1rWRjowEmR4VgelizrgaOkEKnxFG4fPcAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228875; c=relaxed/simple;
	bh=lx96qL89DOI9EKJjX9OYd1ablMS5BvfT5Wf/2+dyRQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM8dwa6umhb7wCXOpKvYYyJIirIzVNdf9GgEPK95p6DIxJVbNMgNriXXEwoQz2IJKX6Bx6PcZahfD4lh7VV5C5mewvohB6aEPJnxAwRZBertOUp8ZpMABQTWTySJMAyXessCtSmajPcm4S3qcjhNLwoYp29EkXIFtNx2LZr8pkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PGBKiwpN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=H7yiL8lrVrCfercd8VJZOnrUXZAUWNvskegvwzX0TS8=; b=PG
	BKiwpNTDxXNwoYGTDvFE3lrCCRZd1UYwXofw9p2eTl1WFLNSSB0kueGwtnx4PvWmvcXoW/D7rzGSj
	qDSskFz/1KZAATFLTXQJib441VDLxzDE1khI9Awb7wadi72KgsXdA9XArEoUf+6JTK8VKfui8G9if
	F1JOS4G5pPjeFDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG8E6-00Cqwu-4D; Tue, 04 Nov 2025 05:00:58 +0100
Date: Tue, 4 Nov 2025 05:00:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 3/4] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <afdd366b-8bf0-40a4-ae02-dfc2ff79011f@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:18PM +0800, Jacky Chou wrote:
> This change sets the rx-internal-delay-ps and tx-internal-delay-ps
> properties to control the RGMII signal delay.
> The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
> internal delay on the PHY and disable the corresponding delay
> on the MAC.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 28 +++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index de83c0eb1d6e..a65568e637bd 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -121,44 +121,64 @@ ethphy3: ethernet-phy@0 {
>  };
>  
>  &mac0 {
> +	compatible = "aspeed,ast2600-mac01", "aspeed,ast2600-mac", "faraday,ftgmac100";

Is it really compatible to aspeed,ast2600-mac? If a driver binds to
that, not aspeed,ast2600-mac01, doesn't that imply the bootloader
delays are still in use, so phy-mode will be wrong?

I think you should only list aspeed,ast2600-mac01. If somebody uses
this DT blob on an old kernel, then you won't get an ethernet
interface, rather than a not working ethernet interface, which is
probably preferable.

	Andrew

