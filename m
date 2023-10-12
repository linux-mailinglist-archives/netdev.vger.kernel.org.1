Return-Path: <netdev+bounces-40544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C147C7A04
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90527B207C4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1863D02A;
	Thu, 12 Oct 2023 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="haLxILlF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1013D000
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:59:02 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F6A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:59:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d1fa1c787so1001314a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697151540; x=1697756340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/CRFtRwpVlS5luvbrJv++4tTTIuIyrVZAbJWpNViCw=;
        b=haLxILlFZ6x56A5BvUPbPI2I+CJC7x19Eg2w4c3ZTpqr9t6U+Q0ANyNzRvIEuodQRU
         APTY6JrVe6KtdUe/i/pVCeNFDQ7MaD035ucfyNMTCTnbSzj/tOW/14pYBUlfOAlsVk+Y
         jRIlgssNezs3yZNrJC70Pi03l89qOW73RGBigi2vhuyABJ7FUsBC/VMjj+J7Y3yXmcUE
         sWaPfYVMjVHlswzbQjfWedGc9DicmCmJ/yC2kcRzsPlgjQjcv1aXtvffkMFewKKjowD0
         pZ4x4Q/EYmvumEcP5wXjviEbItj+F/v3clYk7j2gjzdIWUTpnJU+qB7ZLZ/BWjEi5JjJ
         kKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151540; x=1697756340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/CRFtRwpVlS5luvbrJv++4tTTIuIyrVZAbJWpNViCw=;
        b=qyzzDz8tKqsUm0M2fDHI4T0P/bMSjn/jxbGNj47LnOLamY863xYrTV2fOL4czDAhat
         biBxm2VLg27Oaj46+MtbAm01bJnkjjLnCVOCN+WLvPC0l26lEfhKw9bPEbsQSAUvE9zd
         HHDI54Ga2F//HCIHr3ARlmXhpxum9pHIiB7O6dMktYugcSjm7QR7qxeTi3JILoGs1hj+
         pTn9JWHkCKubeB9kTJFx69pCy5SxW3HuFzWd2nqJLooE0LCZrsycbinujtLpQFOYRjST
         3PKXh9Xyt3RCmfeelgM3AL5j5ltRiEg4SxdtfY4cUaEX8SwvmgDGmpujUNKd69O+oQR6
         m0gg==
X-Gm-Message-State: AOJu0Yxb85tfeEyk+JoZr7DwM7zpGeoPaHc6tvQd0LBzIhkPhm3DhEog
	kJWsjt5UepLhM9T4aQKOAAx29A==
X-Google-Smtp-Source: AGHT+IH0a4JDpa1my2VpfWZ9GTLo2T3egbKtnSAQQrbYSE4MMe84mYGgNWGiLU/AYDwWhtGRbM5+/Q==
X-Received: by 2002:a17:90a:c405:b0:27d:3c7c:be84 with SMTP id i5-20020a17090ac40500b0027d3c7cbe84mr28413pjt.30.1697151540387;
        Thu, 12 Oct 2023 15:59:00 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001c62c9d7289sm2514200plh.104.2023.10.12.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:59:00 -0700 (PDT)
Date: Thu, 12 Oct 2023 15:58:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-imx@nxp.com,
 netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <20231012155857.6fd51380@hermes.local>
In-Reply-To: <8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
References: <20231012193410.3d1812cf@xps-13>
	<8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 22:46:09 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > //192.168.1.1 is my host, so the below lines are from the board:
> > # iperf3 -c 192.168.1.1 -u -b100M
> > [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/826=
03 (0.57%)  receiver
> > # iperf3 -c 192.168.1.1 -u -b90M
> > [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163/7=
7688 (16%)  receiver
> > # iperf3 -c 192.168.1.1 -u -b80M
> > [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937/6=
9055 (30%)  receiver =20
>=20
> Have you tried playing with =E2=80=90=E2=80=90pacing=E2=80=90timer ?
>=20
> Maybe iperf is producing a big bursts of packets and then silence for
> a while. The burst is overflowing a buffer somewhere? Smooth the flow
> and it might work better?
>=20
>   Andrew
>=20

Please post the basic system info.
Like kernel dmesg log.
All network statistics including ethtool.
Any special qdisc or firewall configuration.

Likely a hardware or driver bug that is doing something wrong
when a lot of packets are received.

