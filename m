Return-Path: <netdev+bounces-51311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4F7FA10D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F3D1F20620
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F42E632;
	Mon, 27 Nov 2023 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NZkV9Olf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E08E;
	Mon, 27 Nov 2023 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JXdr956Iretu3y/Ma2B3JghS9ObBnt1CPoKuAApnoLg=; b=NZ
	kV9OlfNYngKjrO2DJgO0Tyf3Y1ZVNgqMtA1wN/oLDE8Z0FbIcLt1pM2KADK6T6OPkELJXPD34CnEh
	C9QMua6EWvRACi+tg89CUQI5khgSxmf0d5LegBJoubWtctBOLqtcs4lD0wh9ojUewpNvoUxZ8yjYb
	KyZqdgV9gms4O1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7bdz-001LPJ-6P; Mon, 27 Nov 2023 14:27:23 +0100
Date: Mon, 27 Nov 2023 14:27:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n_N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: microchip_t1s: refactor reset functionality
Message-ID: <3d45c394-7b3d-4dbb-b85e-9fadea8ba1b0@lunn.ch>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-2-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127104045.96722-2-ramon.nordin.rodriguez@ferroamp.se>

On Mon, Nov 27, 2023 at 11:40:43AM +0100, Ramón N.Rodriguez wrote:
> From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
> 
> This commit moves the reset functionality for lan867x from the revb1
> init function to a separate function. The intention with this minor
> refactor is to prepare for adding support for lan867x rev C1.
> 
> Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

