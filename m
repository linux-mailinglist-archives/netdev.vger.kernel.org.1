Return-Path: <netdev+bounces-26112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C1776DAA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF10C281E4E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B92645;
	Thu, 10 Aug 2023 01:54:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8877634
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:54:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8BAC;
	Wed,  9 Aug 2023 18:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+Uvpko4AXQ3Dc2fSBgpFtDF7WOkjn07EwVSIhk49kcQ=; b=aYrRf6uncyZQNqPf3SFA08CC4W
	/hum2tGKxT5u4jIs3PpuWL6UeHaJg5zF7Al2MKIaOy7IQS8xOlM6/3d0+hZaxihDUQ35+I4Tfs6T7
	BpZ4xBHNoM3UJF6Xaf9zqSH+4VMPrvBhAE86P8ymUaeGBs0mbeKnkIDmdLFA0aAjU42g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTusm-003dTR-4l; Thu, 10 Aug 2023 03:54:36 +0200
Date: Thu, 10 Aug 2023 03:54:36 +0200
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
Message-ID: <e50fe51e-5a81-4aa2-9f77-4314dc578f84@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
 <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
 <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
 <61c541c9-be30-4a43-aa85-53816d5848f9@lunn.ch>
 <DB60B268-85DA-43A2-A20F-52D684473348@hpe.com>
 <06d1bc6a-0584-4d62-a2f4-61a42f236b3c@lunn.ch>
 <DM4PR84MB19277DFEB543CF29AB3D58608812A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB19277DFEB543CF29AB3D58608812A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> After discussing with the ASIC team:
> The vendor IP in our ASIC performs a parallel GMII to serial SGMII

Which vendor ? Is it the Synopsys DesignWare XPCS? If so, take a look
at drivers/net/pcs/pcs-xpcs.c. You will want to use that code.

If it is a different vendor, you can probably still use bits of that
code to implement a driver for the vendor IP.

	Andrew

