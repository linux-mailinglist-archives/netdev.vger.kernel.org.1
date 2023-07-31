Return-Path: <netdev+bounces-22667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB85768A11
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E86281435
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 02:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAA380;
	Mon, 31 Jul 2023 02:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347C363
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:38:38 +0000 (UTC)
Received: from out-101.mta0.migadu.com (out-101.mta0.migadu.com [IPv6:2001:41d0:1004:224b::65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCDD10C1;
	Sun, 30 Jul 2023 19:38:32 -0700 (PDT)
Date: Mon, 31 Jul 2023 12:38:11 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1690771110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhF9ae7sVYEWGeArURaJEEMWDyQUH8VQmSu9vlqpWUA=;
	b=lNBX0bXbxeY9vD+BAGHVD8mrDp7jZly7tcuxIl86W6Tk15NffKhfYUGVxQ4Pu3VVr2OaqY
	fYh9+ijpTWSOw231yBjByzsvlM+YCFXiSemJQLdrkI7AKYEo6t7sdq80c+VMRNVw3OEt0A
	V9Bhrg/9c+yX2v31W8Kl5Bauewq8w0lARWc+KhyOKQd83PYAdXwL4prtOIwuTvgeb26NP1
	rDQUkmOrwe/hUFCUix/OhV+HmjgO8Wcm4Gw0mogQ20CVRgkGB9tGowGzdiarkTAWGqc2UK
	gY1cL2IRGmJHn2lCUkxuzFxqjSqpRGLAvaDthZKEASMhLcdVcY2P7/iNHFZu8g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-sunxi@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZMcek2NnEqtmE5OS@titan>
References: <20230721221552.1973203-2-contact@jookia.org>
 <20230721221552.1973203-4-contact@jookia.org>
 <ZLzwaQlS-l_KKpUX@titan>
 <5694691.DvuYhMxLoT@jernej-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5694691.DvuYhMxLoT@jernej-laptop>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 12:03:59AM +0200, Jernej Škrabec wrote:
> Yes, that's usually how it's done.
> 
> > 
> > I see this happening in sun4i-a10.dtsi for instance, but it also seems like
> > it could become a problem when it comes to re-using the dtsi for newer chip
> > variants.
> 
> Properties can be either rewritten or deleted further down, so don't worry 
> about that.
> 
> Best regards,
> Jernej
> 
> > 
> > John.

Thanks for the feedback, I've sent a patch to address this.

John.

