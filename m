Return-Path: <netdev+bounces-24696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DC7713C5
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 08:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5196F1C20982
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477131FAF;
	Sun,  6 Aug 2023 06:35:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5111C26
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 06:35:46 +0000 (UTC)
Received: from out-101.mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E61FD3
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 23:35:43 -0700 (PDT)
Date: Sun, 6 Aug 2023 16:33:45 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1691303741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QcmFk87OSOnLQz2aC/rzCVz9SI5NqtxQgcc/xuSFnA=;
	b=LO2GkUBlLmae2f6NePMseHTBEkOx1tEX3Yh/67CHOPK6ihrmJRjULSCAwvj14677WkG0qT
	7COuiuLJW7wr4nYYQa+EzPAzxWSUxZ7vga+KLjBqeqkm0pttUvzjLNMUgzghEmohDlhhei
	YdJxam8rOiLsBK8F5Rt7wAPHwc3zQYeicMhrWYj+/04OMt+2YzWvs+v8vP1900mSbuNMUa
	F4mt7aFnA/RuP2aAi8FI26v7Havt2VjuUy73zzQrgyY6JWvsWCAT5TX9IZjc7VLorDKy3f
	/YgmTjXbgrgtHZy87OmgUAOxHnEFQZ965CsSdbYcurOl89yc4rtzvg8NPK0VIA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Maksim Kiselev <bigunclemax@gmail.com>, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev, mkl@pengutronix.de,
	netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh+dt@kernel.org, samuel@sholland.org,
	wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZM8-yfRVscYjxp2p@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com>
 <ZM5-Ke-59o0R5AtY@titan>
 <2690764.mvXUDI8C0e@jernej-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2690764.mvXUDI8C0e@jernej-laptop>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 05, 2023 at 07:49:51PM +0200, Jernej Škrabec wrote:
> Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> > On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > > Hi John, Jernej
> > > Should we also keep a pinctrl nodes itself in alphabetical order?
> > > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > > Looks like the other nodes sorted in this way...
> > 
> > Good catch. Now that you mention it, the device tree nodes are sorted
> > by memory order too! These should be after i2c3.
> > 
> > It looks like I might need to do a patch to re-order those too.
> 
> It would be better if DT patches are dropped from netdev tree and then post 
> new versions.
> 
> Best regards,
> Jernej

Agreed. Is there a way to request that? Or will the maintainer just read this?

John.

