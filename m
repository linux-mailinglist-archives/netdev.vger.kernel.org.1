Return-Path: <netdev+bounces-24684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB07710AC
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E22820F5
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F79C2E7;
	Sat,  5 Aug 2023 16:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C910F2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 16:55:39 +0000 (UTC)
Received: from out-110.mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763AA420A
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 09:55:36 -0700 (PDT)
Date: Sun, 6 Aug 2023 02:51:53 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1691254534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYiFCAoB7u7dk9JF+5uYfQo9xx6aksS21sN43dAesb0=;
	b=JrgfMyBOF+ZiXCAmC60LBYPR24oFRCx33u0KZKY303F1zTsxaeJJ7iEE6sA7OWwJCUtxVw
	A4UvLxWn95TKqI4CkmGVAhWOqcAk4CvjbA6aGNLXTBYeY5prTGoIAKBqUNZfh8PsTWAhSx
	mkMIlM80OTxepI54dfk4DvO/fhfio2g2w6Zzi5o65Zgb64BkrnRxk/0vcwiQ5WIdKQu7ws
	UkUlMgbKObQ9hReGcP3QkIQBOowRV6faBzQyCP3EDy5F73PN6SkeTDX0F52E6eStUZpU+6
	lQWwk6FI39d1N9Wuz7kOXLbqbOsByN6rNvid4pDiwRHmDYcOJf+RggI/enu0Ew==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
	samuel@sholland.org, wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZM5-Ke-59o0R5AtY@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805164052.669184-1-bigunclemax@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> Hi John, Jernej
> Should we also keep a pinctrl nodes itself in alphabetical order?
> I mean placing a CAN nodes before `clk_pg11_pin` node?
> Looks like the other nodes sorted in this way...

Good catch. Now that you mention it, the device tree nodes are sorted
by memory order too! These should be after i2c3.

It looks like I might need to do a patch to re-order those too.

> Cheers,
> Maksim

John.

