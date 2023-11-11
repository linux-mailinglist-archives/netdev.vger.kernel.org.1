Return-Path: <netdev+bounces-47208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11327E8CF0
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4814D280DCC
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E71DA5E;
	Sat, 11 Nov 2023 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmjflY8E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9621DA50
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 21:57:09 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9AF30CF
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:08 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b9a7357553so2496200a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739827; x=1700344627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3YDIzElOEbm+1U0CMdVyjVhLFB7ElIPgBqfCTKvIZk=;
        b=NmjflY8ESsm0CjqOgQezEgaD15aeqZAZOBWV0VUBDmYqQRWLIAAU08897NLjbJXPd9
         atmxM8Dd+HjoGNf9PH4pOWAKsmFBUDExIrXZRlnS7d2LkaJ/ZSWDd9xXvizK+yrpH/cA
         QfqYsWbjb2yLNngNkUhXqbZcfLGEgOcZNBD0aKN4e7CVtyDfWYlVZ+DEIRZnQ5ZMR4hH
         t7/bFfqQBV1kTjPoVGkWMVnfa46p/bD9U3GkOKAhN0VADPu3AnTJ5KBOzyg0W2rC/GqX
         o+qbianJKPrL16cbW3rHEORDyIlMoP4BbbnUD6ZWiDj79XjIQNREtQi3MEMYbR74cLnp
         O+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739827; x=1700344627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3YDIzElOEbm+1U0CMdVyjVhLFB7ElIPgBqfCTKvIZk=;
        b=TjTWGLi1BbYO96ixfWuKRZ6BpedC08ZTc2ysT3g8CzwGHqoKInRriSHLkccULgtr64
         me5pA2KmT6h45TrVQ5dePbno/y+HYgO2tcWyL6f4hoNAReRQU0vwWFnRBPH8Z+NMfB1i
         IUUSrtBTq+Tz1YoBxA1sA1vLrr2zGOQiSnxSqWMSHUR4uoauJf4Ah9K/JfAaxiMz/EG3
         aLyGQx5x5NLFoMK9nsnXVcJG9EjOBK4MJe54tsQ+1MVaDTovf9ILQps+O4dfp4ABiMwI
         0DGTXzuUQgU59NzNKweTcTNSl3Q3sdoIFyRb3iKsxKt1zyfHfN8olOOS73telIznp233
         ygIg==
X-Gm-Message-State: AOJu0Yzup1VlYpXaCcuBGV+w5PREuRQy3PyeHqoWbheLRtHaS5jzRzmC
	2TmbsZpyHLkr7gzFjU/Zf6y1VSKv34ICPg==
X-Google-Smtp-Source: AGHT+IFvrmm443om4s58lPTlAtk7UQgF9L9hB+jxNxqMLpjQy8tKHqJVUdJF9QYVMFT6tuG1cPAjuA==
X-Received: by 2002:a17:903:124b:b0:1cc:3f10:4175 with SMTP id u11-20020a170903124b00b001cc3f104175mr3710303plh.28.1699739826877;
        Sat, 11 Nov 2023 13:57:06 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:06 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com
Subject: [RFC net-next 0/5] refactor realtek switches and add reset controller
Date: Sat, 11 Nov 2023 18:51:03 -0300
Message-ID: <20231111215647.4966-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series might be a bit too hefty, and I'm thinking of splitting it into two series. It all began as a patch to add reset-controller as a way to reset the switch, but the duplicated code for both sparked a discussion about a shared code base, which led to what you get here. This driver will be used in some devices with tight resources, both in storage and RAM.

The current driver has two interface modules (SMI and MDIO) and two family/variant modules (RTL8365MB and RTL8366RB). The interface modules are independent and can be loaded only when necessary. But, they refer to symbols from both variant modules, which means they have to be loaded together or disabled at build time. It's a simple approach but doesn't scale well over time, especially if you add more switch variants (like RTL8366B). Also, it's unlikely there'll ever be a device using switches from different families simultaneously. The variant modules are much larger than the interface modules, so it makes sense to load only the needed code.

The first part involves reworking the Realtek DSA switch code. It introduces a common module shared by all existing interfaces (SMI or MDIO) and switch family modules (RTL8365MB and RTL8366RB). This module will mainly have parts of the probe code common to both interfaces, but more bits from variants might move over in the future. This common module is also a way for variant modules to register themselves for interface modules. The idea came from how DSA requests tag modules at runtime when necessary.

The second part is about the original reset controller code, along with the first two binding patches. It'll only affect the new common module.

This series was tested with RTL8366RB using SMI and RTL8367S (rtl8365mb) with MDIO. Both seemed to work as expected.

Checkpatch is flagging some long function declarations (realtek_common_probe and realtek_variant_get). I checked existing kernel code and noticed differe

Regards,

Luiz



