Return-Path: <netdev+bounces-24993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E769C7727AA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A087128136B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E78C10976;
	Mon,  7 Aug 2023 14:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48014443A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:26:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00BE10CF;
	Mon,  7 Aug 2023 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CpqEEwNfMg9Nl8avg6ECsYgEqF//t/hCgcHJJMEuTZQ=; b=xuST3q4YWc1nrvYdwDluySms90
	oD74Z7Lr68n7Kd1U0dzeRM0ZHByT64oFUhZx97pnmaBlKv7FxP64EE3Z5m48M6FnIqQOycQs2eoPL
	vaHHf60BM8z15huezOjlpTmFqVbiL10vSowhgsrJWlHKCPwAeezcfl/zxwsP910IpiaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qT1BH-003KOz-TY; Mon, 07 Aug 2023 16:25:59 +0200
Date: Mon, 7 Aug 2023 16:25:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full
 duplex support
Message-ID: <dd0e538a-9369-4682-8eda-753d7cb83fb1@lunn.ch>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-6-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110048.2611456-6-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> @@ -210,6 +210,9 @@ void icssg_config_ipg(struct prueth_emac *emac)
>  	case SPEED_100:
>  		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
>  		break;
> +	case SPEED_10:
> +		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
> +		break;

Since that looks like a typO, you might want to add a comment.

      Adnrew

