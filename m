Return-Path: <netdev+bounces-27471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1E77C1B7
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23E3281165
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C7D533;
	Mon, 14 Aug 2023 20:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4832CA6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:50:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94216D1;
	Mon, 14 Aug 2023 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MPxBPxk/6whyuKd1EnfaVdyqlAAyqc57wPgDj6Jze98=; b=UCCUSLk6P7eEey+NxqftQuWAFX
	agh5ViUvNJ/a7JoqPwY6JN1Tg4hEQpy9pp1vHT4e3ZmdHLtGcNJfDzxE5pfGRvQyIgmwjlanwaOHb
	ZoNFf74XzvLG2E4kR8gNWGhS45H8VMMPX8ZeDv3kjG1dYmhri+JK3oYziFbJtMlH+F38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVeVv-0045aI-Bm; Mon, 14 Aug 2023 22:50:11 +0200
Date: Mon, 14 Aug 2023 22:50:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sriranjani P <sriranjani.p@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com,
	pankaj.dubey@samsung.com, swathi.ks@samsung.com,
	ravi.patel@samsung.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jayati Sahu <jayati.sahu@samsung.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Message-ID: <323e6d03-f205-4078-a722-dd67c66e7805@lunn.ch>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
 <20230814112539.70453-4-sriranjani.p@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814112539.70453-4-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +&ethernet_0 {
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};

A fixed link on its own is pretty unusual. Normally it is combined
with an Ethernet switch. What is the link peer here?

     Andrew

