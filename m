Return-Path: <netdev+bounces-20278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E875EEAD
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109021C2089A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C14C9D;
	Mon, 24 Jul 2023 09:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BD20FB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:06:49 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A3F198
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:06:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fdea55743eso2647606e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690189604; x=1690794404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWiZQGtEoDd6vYkaCeUUHjlAedCnBQMw8cP5GB7UACs=;
        b=T9je4nDcYplTvk7qGBjMRHyCVdXOwnMahnWtLXKXhBoorgvTE/t5sdwcXUZiBncr6U
         bLqrke6vUMhkeBL6adwaYPqoRzfb7M6Vmm2/Vh7dlQ1lwqgr8m6WPZb0stCWt3q5jbE8
         kAy1+N8x8aEiDHWJF1FclVDmfZFoksV7OJrap7krdYpWSmzBAMXKYX5S3W8OTJBQbgn6
         aTvAktMm7eey+yYsXs1il/63EvZnlg70B6SD8LTUDdW4BMpChes/r/SzVm//lDlbBx8+
         xUG5p+szFz5jJJ/VtJNOFrr0YzY4AnjQEB/M161fAMQJaXgS+XYKlJD+liV3ErxJrtGy
         whnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189604; x=1690794404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWiZQGtEoDd6vYkaCeUUHjlAedCnBQMw8cP5GB7UACs=;
        b=UpyqUxFWN1axegkAbTivvRrH0/Muao+CBAv5KbqpSSBEFIoyjCbK4LzhNiVNP6bZCe
         8uZWa3enCaI72o1DUirtuB0cBFmNwsgH2SNmKIIEBPW5wCoiHLqdXPQMeSMablkLSxz6
         m/Unqwr6Yhlcq10S4b0tnTnhGsNhMZWuRNk2jrFH9Wqk400Xhrno8rOaV1dFws+VWsSV
         apsNAxPR99lU81k89p1MCxBpRarqLmkm/Uleq6yLX5igN9yY/mubQYYl5B45eSaNdsC3
         y8wIw4S34FBJzsYvERdtaODfitts1Dv0py7OrcS5wwUxMEAk4p3JIJXeZ+N2ctBCuqTE
         nsrQ==
X-Gm-Message-State: ABy/qLbp3bXZXTdq5Mmv3LB7v3RQtMC3sDU4nJQWUp/GBDaTcTEjmX8r
	QfcZxQNxoZ/PSn8v79ZS9SMZ1g==
X-Google-Smtp-Source: APBJJlGtZfuY7Kf4FYV4ziuMtTtkHqU8SSVKob/5rCL8zHjE3hyY370Fx8+xNu+OdiqC5x51a1zcgw==
X-Received: by 2002:a05:6512:ac2:b0:4f7:6a40:9fd7 with SMTP id n2-20020a0565120ac200b004f76a409fd7mr5296059lfu.47.1690189604320;
        Mon, 24 Jul 2023 02:06:44 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t18-20020aa7d4d2000000b0051de3c6c5e5sm5824932edr.94.2023.07.24.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:06:43 -0700 (PDT)
Date: Mon, 24 Jul 2023 11:06:42 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v3 6/6] can: tcan4x5x: Add error messages in probe
Message-ID: <20230724090642.o7qzib5onl53nmqc@blmsp>
References: <20230721135009.1120562-1-msp@baylibre.com>
 <20230721135009.1120562-7-msp@baylibre.com>
 <20230724-switch-mulch-3ba56c15997e-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724-switch-mulch-3ba56c15997e-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 10:37:51AM +0200, Marc Kleine-Budde wrote:
> On 21.07.2023 15:50:09, Markus Schneider-Pargmann wrote:
> > To be able to understand issues during probe easier, add error messages
> > if something fails.
> 
> Can you print the error codes as "%pe", ERR_PTR(err)?

Yes, thank you, I will use that instead.

Best,
Markus

> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



