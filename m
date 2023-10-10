Return-Path: <netdev+bounces-39575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46E7BFE99
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF4828150E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABB24C66;
	Tue, 10 Oct 2023 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ngCOHN8v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A324C60;
	Tue, 10 Oct 2023 13:57:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AF99;
	Tue, 10 Oct 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fnkd1aij7Tpc2L+QxXML50n+8ixS5invGoodurLeWlU=; b=ngCOHN8v9MKAiT7mihTGC+tYRD
	QYIdeaZOHdujS3q+ZWzzSpAAbysLySouhqwNJLonOb0A+VsrjcKoZXXGowyP+vJ2zSzfZq5ZFLx1R
	nQCk/5liQePtbmDPa16MOpNFgsXN4m+6JduYZfCOTAuzkNtfgX/mt6z3sPYkLJsQzBJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qqDEs-001Fhr-T4; Tue, 10 Oct 2023 15:57:34 +0200
Date: Tue, 10 Oct 2023 15:57:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: UNGLinuxDriver@microchip.com, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <5348ffc3-a514-4d61-85f9-56910aa94d44@lunn.ch>
References: <6a366c3a-49e7-42a4-83b2-ef98e7df0896@lunn.ch>
 <20231010134139.17180-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010134139.17180-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 03:41:39PM +0200, Ante Knezic wrote:
> On Tue, 10 Oct 2023 15:25:44 +0200, Andrew Lunn wrote:
> >> +  microchip,rmii-clk-internal:
> >> +    $ref: /schemas/types.yaml#/definitions/flag
> >> +    description:
> >> +      Set if the RMII reference clock should be provided internally. Applies only
> >> +      to KSZ88X3 devices.
> >
> >It would be good to define what happens when
> >microchip,rmii-clk-internal is not present. Looking at the code, you
> >leave it unchanged. Is that what we want, or do we want to force it to
> >external?
> >
> >	Andrew
> 
> Default register setting is to use external RMII clock (which is btw only 
> available option for other KSZ devices - as far as I am aware) so I guess 
> theres no need to force it to external clock?

We just need to watch out for a bootloader setting it. Or is it really
guaranteed to be false, because the DSA driver always does a device reset,
removing all existing configuration?

I prefer it is unambiguously documented what not having the property
means.

	Andrew



