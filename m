Return-Path: <netdev+bounces-36923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BCF7B248A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 20:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 127BB1C20AC5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D050513D6;
	Thu, 28 Sep 2023 18:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E3513AB;
	Thu, 28 Sep 2023 18:00:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19D1A1;
	Thu, 28 Sep 2023 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Kii1aeNG97UODm5w9OWMw3tlJL4IA97qoMR/+Jykp0=; b=YL+mCeE+l4aSztqVURlp6Oe9tW
	9wz/zf8bdKx1SmykX3JGV4+xErRhLTmZxwbrCFg2bohsYD3/Ho2lAJM7vqv/HI1l0sLdHWV2DDUft
	0IxTbDc1gNd3Krr6uFGboheaDK4bkRXYqqVEN0rz6RWh5DxqqAT1CGXpvAhv64d1uSKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qlvJ8-007lhB-Ft; Thu, 28 Sep 2023 20:00:14 +0200
Date: Thu, 28 Sep 2023 20:00:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Series to deliver Ethernets for STM32MP13
Message-ID: <b44859a8-14a8-4100-a249-ca1d615fecdf@lunn.ch>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-1-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 05:15:00PM +0200, Christophe Roullier wrote:

You sent v2 at "Thu, 28 Sep 2023 14:24:15 +0200"

The netdev FAQ

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

says:

don't repost your patches within one 24h period

There is a danger you ignore comments made on version N-1 because you
post version N too fast. It can also waste reviewer time.

     Andrew

