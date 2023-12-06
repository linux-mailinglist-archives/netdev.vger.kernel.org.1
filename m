Return-Path: <netdev+bounces-54481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C13408073D4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6262DB20DC0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D8405F5;
	Wed,  6 Dec 2023 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W1kYYAU2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84318F;
	Wed,  6 Dec 2023 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pMiL+/ow71FTD3BCAhVuJftaiVNCNI0dN54qUi2P3UI=; b=W1kYYAU2y57RHQIGZEqwWcr8yd
	Gf2cmk1GKOrPXxPx0EISnelP3xCXYin4UvP9ZQMXd/lU8MvR+bv+P81bkKtJmyEldG4bA/LtvF07T
	AVaBlbAgO/gyDpLThqPFiIOelOU4AHixOIF9L95zFkVxpR36zlmmbJCITyYOx1LYCpdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAtzf-002Dl2-HB; Wed, 06 Dec 2023 16:39:23 +0100
Date: Wed, 6 Dec 2023 16:39:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v7 2/2] net: dsa: microchip: add property to
 select internal RMII reference clock
Message-ID: <2ce63acd-576d-479f-847a-9528c915d64f@lunn.ch>
References: <cover.1701770394.git.ante.knezic@helmholz.de>
 <c309c907d7e1dd34dcc782e23ec0344aeadf2955.1701770394.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c309c907d7e1dd34dcc782e23ec0344aeadf2955.1701770394.git.ante.knezic@helmholz.de>

On Tue, Dec 05, 2023 at 11:03:39AM +0100, Ante Knezic wrote:
> Microchip KSZ8863/KSZ8873 have the ability to select between internal
> and external RMII reference clock. By default, reference clock
> needs to be provided via REFCLKI_3 pin. If required, device can be
> setup to provide RMII clock internally so that REFCLKI_3 pin can be
> left unconnected.
> Add a new "microchip,rmii-clk-internal" property which will set
> RMII clock reference to internal. If property is not set, reference
> clock needs to be provided externally.
> 
> While at it, move the ksz8795_cpu_interface_select() to
> ksz8_config_cpu_port() to get a cleaner call path for cpu port.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

