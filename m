Return-Path: <netdev+bounces-17686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B560752B00
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1442814E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E11F935;
	Thu, 13 Jul 2023 19:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436A20FBF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAAD1989;
	Thu, 13 Jul 2023 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9OIrt/LgsHugPSDybSGY5Tydet8PUGjuftpAsOzUygI=; b=SF2KSfyiyKBIjg1pTzJBc8Wq8R
	P0fq1t2LK8VL3lH2LxoUt/4IIMfRRoEvMerYDo8Bc3m7Yk4nwboPghuHQYY0XZZi7E4qYVJwJIwkN
	to7BbbeeDX8S+G9GyRY0CZrCZFmwgeoWWkN11DI7OmFVC/sHsK39eOwIC2pDDC8uNoLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qK20q-001Hfz-32; Thu, 13 Jul 2023 21:30:04 +0200
Date: Thu, 13 Jul 2023 21:30:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Message-ID: <cd0fb281-b621-4d6b-be94-be6095e35328@lunn.ch>
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
 <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
 <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:53:34PM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 17:59, Andrew Lunn wrote:
> >>> +examples:
> >>> +  - |
> >>> +    mdio {
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +        phy: ethernet-phy@0 {
> >>> +            reg = <0>;
> >>> +        };
> >>
> >> Drop this node, quite obvious.
> > 
> > Dumb question. Isn't it needed since it is referenced by phy-handle =
> > <&phy> below. Without it, the fragment is not valid DT and so the
> > checking tools will fail?
> 
> No, because the example is compiled with silencing missing phandles.

Ah, thanks.

This is a rather odd device, there is no other like it in mainline, so
i think having that PHY is useful, even if you think it is obvious
what is going on here.

     Andrew

