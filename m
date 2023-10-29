Return-Path: <netdev+bounces-45110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085B7DAEDA
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95032B20BFE
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83223111A9;
	Sun, 29 Oct 2023 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O4z6s+bS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE31118B;
	Sun, 29 Oct 2023 22:50:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE82C5;
	Sun, 29 Oct 2023 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mItQr9Lnr2C07koQ7ptJcY2nYrj1Tv7N3viIjaS79mo=; b=O4z6s+bSQrfPzDDmeay9WJaB3d
	6DyWIwTIhL7JZOJeso/nzNcfcqgwCRchXJOb28e+/nsHaW9AG4w2iw0aYs/b//6B7COSqtYePpmZE
	ejpmJpVx3mLK0a39nksWbIFKIj6n6mS3qFBR1PKPntGjDw4R8tVaHA3jZWq87tDvjXtE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxEbw-000T7f-KV; Sun, 29 Oct 2023 23:50:24 +0100
Date: Sun, 29 Oct 2023 23:50:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable
 gmac and setup phy
Message-ID: <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
 <f379a507-c3c1-4872-9e4f-f521b86f44d4@lunn.ch>
 <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>

On Mon, Oct 30, 2023 at 12:41:23AM +0200, Cristian Ciocaltea wrote:
> On 10/29/23 20:45, Andrew Lunn wrote:
> > On Sun, Oct 29, 2023 at 06:27:11AM +0200, Cristian Ciocaltea wrote:
> >> The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
> >> RGMII-ID, but requires manual adjustment of the RX internal delay to
> >> work properly.
> >>
> >> The default RX delay provided by the driver is 1.95 ns, which proves to
> >> be too high. Applying a 50% reduction seems to mitigate the issue.
> > 
> > I'm not so happy this cannot be explained. You are potentially heading
> > into horrible backwards compatibility problems with old DT blobs and
> > new kernels once this is explained and fixed.
> 
> It seems the visionfive-v2 board also required setting some delays, but
> unfortunately no details were provided:
> 
> 0104340a67b1 ("riscv: dts: starfive: visionfive 2: Add configuration of
> mac and phy")

That board also uses a YT8531 PHY. Its possible this is somehow to do
with the PHY. Which is why testing with the Microchip PHY is
important. That should answer the question is it a SoC or a PHY
problem.

	Andrew

