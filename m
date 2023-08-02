Return-Path: <netdev+bounces-23810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759276DAE7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 00:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1631C213AE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00D10956;
	Wed,  2 Aug 2023 22:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB802652
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 22:45:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D0211D;
	Wed,  2 Aug 2023 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ix3a9yf3fHxLeT3pYuganMa5/XPMIrlvEjCMvsiWSK8=; b=JhSsihtW33zcyhIQsXuUG67lSY
	p4eEAJI66OVpUycbwBmEPLPi/kAAoASFnTTDo66kC5YRNyWGB2KkZK7xP/WRGl06nPEg7+22NgTPy
	k7/b31OThAOE53wsme+xF5Ky3YMDzZr70Y91F/MmYHJtoP9Gw1OMneeE3xAT1qAAckTE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qRKas-002vh1-74; Thu, 03 Aug 2023 00:45:26 +0200
Date: Thu, 3 Aug 2023 00:45:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <e2acdfe5-5583-4375-a213-d9fcfa468466@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +  mdio:
> +    $ref: mdio.yaml#
> +    unevaluatedProperties: false

Why do you have these properties? The MDIO bus masters are devices of
there own, with their own binding. They cannot be part of the Ethernet
device as well.

      Andrew

