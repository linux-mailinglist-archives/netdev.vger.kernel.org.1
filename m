Return-Path: <netdev+bounces-35031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CB7A68C9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41678281495
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718238DF0;
	Tue, 19 Sep 2023 16:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CE3717C;
	Tue, 19 Sep 2023 16:23:31 +0000 (UTC)
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A591FA9;
	Tue, 19 Sep 2023 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
	s=mail; t=1695140606;
	bh=Woe2zlZDrX1NMXrzPvFZV2LgN/Rs7Rh4uAbjBGwpwEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QicWKvOnsh6s2OGtCxWeCVD2r3WVLRbWQo+7+pJ6n4zFlYleKs7BiQC3wMb4ARFV8
	 b5JScBgyEdwiwcLX9F24H9XdTntLnUVnyolpe/94+YNUlHb1f5Zs2c0wVDfIA0JIp0
	 y7ZGkY+g2cnyO5KknbRiEf8B7ESXqCTXorU/X09thC/5x18vYZJXe23TrIg1TwkC84
	 jjn6BEA+8F1dla+Y62uSWWEWZGcj+dwSaX89ZFgRYpHfmCvQu9iNsN8FbbBoGvuIn5
	 FJ5r6WzPO6Vc9dQq5FXuoxNmWoQPaASEXEtdWhugIhDaUpMqCb3QnqtrL7RNbHy+Co
	 wL95Qac8om0mg==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by core.lopingdog.com (Postfix) with ESMTPSA id A4B9744057C;
	Tue, 19 Sep 2023 11:23:22 -0500 (CDT)
Date: Tue, 19 Sep 2023 11:23:21 -0500
From: Jay Monkman <jtm@lopingdog.com>
To: Parthiban.Veerasooran@microchip.com
Cc: Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Michael.Hennerich@analog.com, Ciprian.Regus@analog.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	ada@thorsis.com
Subject: Re: Fwd: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <ZQnK+W1a1zmIFzPu@lopingdog.com>
References: <f6858856-53c4-5eb8-ab52-350aab280735@microchip.com>
 <41b6eb40-117c-cdcf-b986-b6f6cf3f21ca@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b6eb40-117c-cdcf-b986-b6f6cf3f21ca@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>  From my next reply on-wards I will include Michael.Hennerich, Ciprian 
> Regus and Jay Monkman in the "--to" or "--cc" so that we can share our 
> ideas and comments.

Thanks for including me. Can you also include
Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
He is also involved in developing the driver for onsemi's device.


Jay Monkman

