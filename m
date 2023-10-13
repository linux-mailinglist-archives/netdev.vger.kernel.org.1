Return-Path: <netdev+bounces-40816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E57C8AF4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BAF1C20B05
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF721371;
	Fri, 13 Oct 2023 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="MAlztth3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1611B285
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:25:41 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B82910C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:25:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c8a6aa0cd1so18726875ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697214339; x=1697819139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGsIQtn1kUOEPH/EyvUO5nXHmKVACT2hdgnYK7YYsf8=;
        b=MAlztth3RyslyF84xmcY5tfcU2AGBZQz5P3EreddPRY/Q5C5UVWkRn2zTXN5lWaJTX
         YHHlD4QJJ8S9yWL6lpmTOEUgIa2Q5SU4F6xj6nr5njiu6hPsPutyRulJNSwI9HcS6J55
         GJ/rqR6wp7Qc4BFqW6ZxwqvFH0Cl1cUKTem6DKFJS6HTgsQXy/OPNoBWPoUv4HOOpgo0
         UMe+XYg0Y3yuPP8V9Rtk6fUlNWQb3WSmeNygsKBoH0X6L/ovV7GknJaS4NV5CdyZCPfP
         MbODyDAz7pfHuYXMFxKF4xgj+K8Q9EAfkLnw5Tp9Aricbo4/PtLpsGQCL5HzE2HWb/ca
         AGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214339; x=1697819139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGsIQtn1kUOEPH/EyvUO5nXHmKVACT2hdgnYK7YYsf8=;
        b=AFm3sd9g9rx+QbF1Egj4gSsRmvNy8UMJv4aZsFvfKiH3KTnhkcYAMqG8CIRhwwf4qQ
         rjQRwbwVfxkamPXU3qi3u+WqAwh5TILY4XZCn/NJGVXeoWmvoDyT9RYsNI2XIyrgh8NZ
         NLMW6NvZa/pYGSjwS29MXn4hPE/x1CmMGdo+mD0jWScMGxnaMMyiP6j1fABe2AVTIthT
         8N08trsFYb8mmIBpQiM6VmmWd0Am0WB4UQRdtMX+XCVqpBfFaSoblIAdzRl9rBsWvu04
         +k/qRTwJaAz113BMNv1Ja4rBUmWd1oICZ78HVsbSytvmPqejArmDCilMY/aLpdpA/oYC
         zILg==
X-Gm-Message-State: AOJu0YxND2ntfJ471/ob96nhO1XGv95iintwBNn63pxHuLlOGx168pZT
	TeiQRZSTAHk8COsT4kSMyMlDMg==
X-Google-Smtp-Source: AGHT+IHpc/Tkf9Pt5e2oD3IFVvwS6bTXm6J3mOQbVyXxjR0oCfbQQ1e+XvWpuSp0soQAKko2C1ScUg==
X-Received: by 2002:a17:902:d2d1:b0:1ca:220:ce42 with SMTP id n17-20020a170902d2d100b001ca0220ce42mr2271443plc.37.1697214338684;
        Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b001c3721897fcsm4025457plo.277.2023.10.13.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:25:38 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:25:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "open list:ARM/Mediatek SoC
 support" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231013092536.09183d47@hermes.local>
In-Reply-To: <20231012231029.tqz3e5dnlvbmcmja@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-2-florian.fainelli@broadcom.com>
	<20231011222026.4181654-2-florian.fainelli@broadcom.com>
	<20231012231029.tqz3e5dnlvbmcmja@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Is there going to be a corresponding change to iproute2 devlink?

