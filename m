Return-Path: <netdev+bounces-28290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D967977EE8D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427AF281D31
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDE382;
	Thu, 17 Aug 2023 01:10:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869C379
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:10:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5519E;
	Wed, 16 Aug 2023 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/pJUdBLfXj1B1WDyDQ15fjlR4oyo4SwgeP26Ydj270w=; b=2TZ1PDpWONs0F//wBvAFXMUo/H
	S1wMLOokmyY8Y5P+rXMVAWI+ckbpzdLQfgOcG4BN1Q96Twa05pziZdb6rT/+fFWUGqbUsMvvwajLF
	OFMWuHfxoldRaas9wxUhbUUervBtKJPe5+//6TY3LtjQ55hFrPXzKqCpvSAVdySIJ4cU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWRWc-004Kis-8m; Thu, 17 Aug 2023 03:10:10 +0200
Date: Thu, 17 Aug 2023 03:10:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Message-ID: <bb3262ba-e820-49e1-ab38-2fa40ecd2701@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-2-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 04:52:16PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac-mdio will provide an
> interface for managing both the internal and external PHYs.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Your Signed-off-by: should come last.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

