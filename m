Return-Path: <netdev+bounces-24683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9F77109D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CF21C20A81
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182EC2E4;
	Sat,  5 Aug 2023 16:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3044A92A
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 16:40:59 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4D10F8;
	Sat,  5 Aug 2023 09:40:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso48272821fa.0;
        Sat, 05 Aug 2023 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691253656; x=1691858456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbgbFpQ5CS8b/Xg24dFI86ayyuiWeSuGucCXchMse2g=;
        b=c+FKwgy+65CRVJA5AJKwke6ZlNOixLM+hZxnft7Tzni9BU8by5Ye/LJcjR2gGI6vVK
         AHGnHGrb5hekJ/uzdt0KNvCkW/nIvxG5CKbhjdSLRSnJfPPZcg7Yo7wyY2feKGSRzDcF
         4vHsPI8W3cK+xasc0WDwMnBcjIdQWfaKbJ+P7/tlZl3XxnNKDbo+hXD/v4ydPa0ICFX1
         0FMnzqNmLlT79FGtHkN+D4l6mViOFIgdZ+4QKFHsmxsQF3tkVS6grXUNICMJ0GjnW5VS
         S9YsACtc/SdqXBxoQAZuGqoO+iF88NgFGMZgX3YP4lLXqyoT1vurhqKpHsEYSEBlrp8C
         IAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691253656; x=1691858456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbgbFpQ5CS8b/Xg24dFI86ayyuiWeSuGucCXchMse2g=;
        b=KmJOFlf79AlzzPW4X9dOY9skq7FM+Trq3KXmPmkfAdts2m4OYyAuvoSnF6lz3C0MG7
         EW4C7ZBZZuzH6ZfaQYRuwPxx90cB+UMuwDv1o/h33S+0nv1rxSjrEbBmvhmkjC8qPytJ
         AVD6HK9aJHWQhdZ3tK9JomskT3/9uFLBedEpFT8kaoJoSdBtAIIPcQai3RZ/IOjR1iJP
         PSDo5cXAEkJGYRSU1wrjB5/ZObKL1af8E7VInog0ItmP6f8wws+GKLqCiPyEDFNfRNuG
         Za8rOaMBc44RaRW4BLCkJoZt6m+R5NA705pzhP/owfMrBwZWfTqEu2Cg8OEXCppd3aBs
         BGTg==
X-Gm-Message-State: AOJu0Yw6ZKSv0NtbT5Lr9JwQYoCSPmRmF3Oezjf05MIxikS4Ncv1BVQb
	MOHf1s78qv5mYiS4LnqXCP4=
X-Google-Smtp-Source: AGHT+IGAyWnZC1HC2zk0RuQ75eTsYcDjPBSvhuYz3lE2Z9xqqgVdLPS76IkbuMZuD9syyfUlKS6iew==
X-Received: by 2002:a2e:9c9a:0:b0:2b9:ecab:d921 with SMTP id x26-20020a2e9c9a000000b002b9ecabd921mr3847745lji.18.1691253656345;
        Sat, 05 Aug 2023 09:40:56 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c214300b003fe407ca05bsm6762335wml.37.2023.08.05.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:40:55 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: contact@jookia.org
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	jernej.skrabec@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh+dt@kernel.org,
	samuel@sholland.org,
	wens@csie.org,
	wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date: Sat,  5 Aug 2023 19:40:52 +0300
Message-Id: <20230805164052.669184-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721221552.1973203-4-contact@jookia.org>
References: <20230721221552.1973203-4-contact@jookia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi John, Jernej

On Sat, Jul 22, 2023 at 08:15:51AM +1000, John Watts wrote:
> ...
> @@ -131,6 +131,18 @@ uart3_pb_pins: uart3-pb-pins {
> 				pins = "PB6", "PB7";
> 				function = "uart3";
> 			};
> +
> +			/omit-if-no-ref/
> +			can0_pins: can0-pins {
> +				pins = "PB2", "PB3";
> +				function = "can0";
> +			};
> +
> +			/omit-if-no-ref/
> +			can1_pins: can1-pins {
> +				pins = "PB4", "PB5";
> +				function = "can1";
> +			};
> ...

Should we also keep a pinctrl nodes itself in alphabetical order?
I mean placing a CAN nodes before `clk_pg11_pin` node?
Looks like the other nodes sorted in this way...

Cheers,
Maksim

