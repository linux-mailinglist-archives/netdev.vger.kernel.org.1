Return-Path: <netdev+bounces-17640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647837527DF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D701C212DF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D71F173;
	Thu, 13 Jul 2023 15:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC61F163
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:59:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98D1BEB;
	Thu, 13 Jul 2023 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kbRaRAb0JOL2/28VqRGpCqPBtBaSf/qjgEEPz4Ozblw=; b=0YXzfhdXgCkaLlwHWfhq7w7NBW
	B2yrKFup3FthFeXz+uny9omFu8uiDopmfNCRlhggOeUmyNdYrKGpvg0BFkhNVzp4j+/EijFlqpEDw
	yQT2CMGgWn0IUnANOuPuAnvUVnW5lUC6888a0ba4McrU1KWCPA+LVlSPS+Bo6KLGYF7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJyip-001Gmy-Eb; Thu, 13 Jul 2023 17:59:15 +0200
Date: Thu, 13 Jul 2023 17:59:15 +0200
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
Message-ID: <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +examples:
> > +  - |
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        phy: ethernet-phy@0 {
> > +            reg = <0>;
> > +        };
> 
> Drop this node, quite obvious.

Dumb question. Isn't it needed since it is referenced by phy-handle =
<&phy> below. Without it, the fragment is not valid DT and so the
checking tools will fail?

> > +        gmiitorgmii@8 {
> > +            compatible = "xlnx,gmii-to-rgmii-1.0";
> > +            reg = <8>;
> > +            phy-handle = <&phy>;
> > +        };
> > +    };

	Andrew

