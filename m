Return-Path: <netdev+bounces-24625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BEA770E2D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917A5282571
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FC1FA5;
	Sat,  5 Aug 2023 06:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE5180
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:46:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F3E72;
	Fri,  4 Aug 2023 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MzuIUE4dAyNI/9puD5m3erQkj7sXAAK5ZQfiS6oDIQg=; b=gl2caWxRTz/6U4PiMCjjKpXfyA
	asb3CKqwHiqMAZFcUF7H+1AkB/UglMSdMob/zzh44cD762TRYkuaPBwgMUC0m+M43H+OVZ1qz7bQP
	jrwCl7AFqMfGbzsE01/SMEjqOJpxuDhr3RSzjcs9r2zX4hPYm0xrRGH3RlOf2alSdPKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qSB2i-003AWH-HG; Sat, 05 Aug 2023 08:45:40 +0200
Date: Sat, 5 Aug 2023 08:45:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"Verdun, Jean-Marie" <verdun@hpe.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <61c541c9-be30-4a43-aa85-53816d5848f9@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
 <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
 <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 08:55:58PM +0000, Hawkins, Nick wrote:
> Greetings Andrew,
> 
> For some reason I do not see your replies for v1 of this patch or
> the mdio driver on lore.kernel. Apologies as I did not intend to
> not address your previous review comments. My mistake.
> 
> >> +static int umac_int_phy_init(struct umac_priv *umac)
> >> +{
> >> + struct phy_device *phy_dev = umac->int_phy_dev;
> >> + unsigned int value;
> >> +
> >> + value = phy_read(phy_dev, 0);
> >> + if (value & 0x4000)
> >> + pr_info("Internal PHY loopback is enabled - clearing\n");
> 
> > How is the PHY getting into loopback mode? The MAC driver should never
> > touch the PHY, because you have no idea what the PHY actually is,
> > unless it is internal. 
> 
> It would only be in loopback mode if it was previously configured
> that way. I will remove it. The PHY is internal to the ASIC 
> and is always the same. Given that information is it acceptable

Hi Nick

So what you call a PHY is probably a PCS. Please look at the API used
in driver/net/pcs/. The real PHYs are external.

Given that this is a BMC, you probably have lots of i2c busses. So you
can support an SFP on the SERDES. So it would be better if you used
the phylink interface, not phylib. This should also solve your
interface mode switching.

    Andrew

