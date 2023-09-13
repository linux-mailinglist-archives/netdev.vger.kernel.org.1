Return-Path: <netdev+bounces-33548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8AE79E7CE
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE395281873
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F41EA8D;
	Wed, 13 Sep 2023 12:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AA1EA7B
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:21:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F84419A8;
	Wed, 13 Sep 2023 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C88EaPpz1JUt7qhf5O9Mf2RtZDNF9WHaoaKYScXNd6U=; b=k5bTlDIryh2JT4ws18Mt2N4Tyy
	A6wAUMQit8x9l+GsHEZ9y5E6ApaEBEBggE3HPgE8LHSSiVsMYQAjsYjWkXyhCE4IXDuvybplf4sDv
	nh8p2f3m+EFOFd92AaN72C08gGaFZOa3xA2eEr5seRXHxJXaPV6ddNKr65Lcv9PIlabE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgOry-006Ivv-8q; Wed, 13 Sep 2023 14:21:22 +0200
Date: Wed, 13 Sep 2023 14:21:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <80505eac-2d81-4047-973f-f8a208ac773c@lunn.ch>
References: <20230913091011.2808202-1-danishanwar@ti.com>
 <20230913091011.2808202-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913091011.2808202-2-danishanwar@ti.com>

On Wed, Sep 13, 2023 at 02:40:10PM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation at
> that port.
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

