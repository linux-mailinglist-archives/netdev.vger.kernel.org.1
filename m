Return-Path: <netdev+bounces-47444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1867EA50F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27583280E96
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097C241F2;
	Mon, 13 Nov 2023 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ad/aWVQ5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC582231B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 20:51:13 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CBD57
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:51:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40859c464daso39805735e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699908670; x=1700513470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvrGvFOPBp1VS132BZ8MbaZ9ElcVPLuXsdcm4yp0Wog=;
        b=Ad/aWVQ5eZ2LN0QD3hHMs4TONOjUDTEZJ4rxiYEu+pL1g9DxcJb2Y14Cm/ST3KJG69
         Khvd4wUvjyPStyiN3q3/dqb1wrrwIjSz3dBzL/fqNFG9/SUL0iMqf+rjg6lxnESZE+k4
         3H9UpizuLsRnrj7rldT1Blsru2xPxlj2AAiz6qvLgka+qouNDqv2DpDChRYUjkNqGm4I
         AkjazzxUSPQojqYAo5TApHOY2Y3ylLi5VQuKT6omquGpPVgPhqHnXe/958WEgEVD3gvc
         yQwvKVmuxGxjLFOLPwURlYyb1Y9HIZCR7u/OsAfl/24eHepXnndy2B0DRvUVV7E3UMVw
         i4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908670; x=1700513470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvrGvFOPBp1VS132BZ8MbaZ9ElcVPLuXsdcm4yp0Wog=;
        b=qbBhZFU+qMnFDc1WRHE42JACp5wcc49rfo/QD9jW0vkitTQJ36SbxaWk6aLl6IwTs3
         lPQd+2Etptm3hFquHpKkyG+OQeo6Lhhdt9nyVMWqQLSXIOUnkvqCX/V3htrVU2P/gCrk
         rc8TL+2MnFn3jQOvtWx04VZmd5Fb6vtaU54p370V+ENFr2mxTkF5sgxwIdv98MOAl27k
         5LpTAA7bNphMe9XUWQJmGgXwcr/lj3t5dWcrAr5uotnPL65tHu/fKJvISLS9WPTRjQou
         mcz9mwealExgaP1EdqFYvr/4Y56zNfO2ENXMf2x06Kjsi5mnZZS9GPYG8u0ZBo5pv98r
         sHLQ==
X-Gm-Message-State: AOJu0Yx4OkzZPH2XjlwZQiidu0iZ9c+o7ZWsutyJXmmOvPSXjP10JOPB
	PP/o9UDSB33UxIcoxgriCU5eQg==
X-Google-Smtp-Source: AGHT+IG59UF5+7vlQRedNR9pMLJkOZkBzIexuJ9FkwfCBxG9z1gYTAE6SxeEuFjALwO4Bh/rrDDz+g==
X-Received: by 2002:a05:600c:4f4f:b0:405:39b4:3145 with SMTP id m15-20020a05600c4f4f00b0040539b43145mr6335121wmq.2.1699908669876;
        Mon, 13 Nov 2023 12:51:09 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b003feea62440bsm9237703wmb.43.2023.11.13.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:51:09 -0800 (PST)
Date: Mon, 13 Nov 2023 21:51:08 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20231113205108.d3r3igce43cpmotk@blmsp>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
 <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
 <33102cbb65e24c5c17eda06ce9ac912a91f8d03c.camel@geanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33102cbb65e24c5c17eda06ce9ac912a91f8d03c.camel@geanix.com>

On Mon, Nov 13, 2023 at 02:31:20PM +0100, Martin Hundebøll wrote:
> On Mon, 2023-11-13 at 14:30 +0100, Marc Kleine-Budde wrote:
> > On 13.11.2023 14:25:37, Martin Hundebøll wrote:
> > > On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> > > > Hi Marc, Simon, Martin and everyone,
> > > > 
> > > > v6 is a rebase on v6.6. As there was a conflicting change merged
> > > > for
> > > > v6.6 which introduced irq polling, I had to modify the patches
> > > > that
> > > > touch the hrtimer.
> > > > 
> > > > @Simon: I removed a couple of your reviewed-by tags because of
> > > > the
> > > > changes.
> > > > 
> > > > @Martin: as the functionality changed, I did not apply your
> > > > Tested-by
> > > > tag as I may have introduced new bugs with the changes.
> > > > 
> > > > The series implements many small and bigger throughput
> > > > improvements
> > > > and
> > > > adds rx/tx coalescing at the end.
> > > > 
> > > > Based on v6.6-rc2. Also available at
> > > > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.6?ref_type=heads
> > > 
> > > For the whole series:
> > > Tested-by: Martin Hundebøll <martin@geanix.com>
> > 
> > On which hardware? On an mmio mapped m_can or the tcan4x5x?
> 
> tcan4x5x on a custom iMX6UL.
> 
> Sorry for mentioning it.

Thanks for testing!

Also I was able to get my hands on an am62 board and could test the
series on a mmio mapped m_can (in loopback mode). I didn't notice any
issues.

Best,
Markus

