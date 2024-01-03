Return-Path: <netdev+bounces-61153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31517822B72
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E0FB212E0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2518C07;
	Wed,  3 Jan 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="U7wWs6zC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333918B0D
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso7099524e87.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1704278072; x=1704882872; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yu/eTviUFcbo04DZ+MS3O/ASGANopqkpkpouiOn+0k=;
        b=U7wWs6zCQqh7wwfLzp0ufyjt1BtLurrnJtZSL40UdaueXmLx4zhhnc815iiomAfXpF
         2BPYELfV0RJmDXkW+T0aUOD86bCM4nUicGEc0D/oSXtXynqThjb6MJLlTCIJj6b09OhG
         L5VvGCxga000Rwpoeo1HmqQntGnJai2J/613M3DVsMGgFbODid5oZFkicFLYQ1yCmFCt
         +H6YPpXmt5IH3bnaXBXHrSOKvtIRGj/V2c0TzaayUOVwW4LU9msR7Yc8ETKH9vrXi0t6
         AaqPWwYLINEjDfLHaju6JjYg50y/kSAQ6ctowcs4oS7h7kKHQ4ptJAdmvwybgz57KpB1
         LHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278072; x=1704882872;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yu/eTviUFcbo04DZ+MS3O/ASGANopqkpkpouiOn+0k=;
        b=fEaJhCLR3uvjpOyaPMyn9lX9/LsZ/S5SzH4BlMebxR2Cq0JFARgziY/+zLPcFvxkX3
         N7b9sCh9Gfi5yfXKotFQP/KcS1IQ9NW2wEi1N7ll28TlY4UsA1yIy1reSnzP6tW+/Y7j
         3obj+lNV9P1yz9Doox3VO3E+lvSxxkoVNJywgQJeUCt+L0fqTJ+ntsSncToRJVlBlHIr
         DWEETmr/e4hk5sxUKMx4F0Kvb8T188yCb5N6TjKgDKopPyWX+S0ZmeE4/dESdNm98ce8
         m4KwL0joGwVTUG4RF7/vxmFMWXFOWZpedmp7eKRb8/YsvtLX5fE/LtR7MQMJaZCj8rUC
         FJ9A==
X-Gm-Message-State: AOJu0YyAiUVRovViEBpjJD7DTViD6CkBB/4FarcOO7sQJzEq+zl054TX
	W15tBzcS2VXV1kWMf/1JN9byPSLo7of/1w==
X-Google-Smtp-Source: AGHT+IH/wyPfTPbdM8cjBa7w2+DTa+3alT1ICJH3KagkRZHU/khaCqJJmgVLcKjcquOCGfUkY/8nUA==
X-Received: by 2002:a05:6512:ba6:b0:50e:7be8:46f6 with SMTP id b38-20020a0565120ba600b0050e7be846f6mr8076222lfv.83.1704278072562;
        Wed, 03 Jan 2024 02:34:32 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id p14-20020a05651238ce00b0050e5ae6243dsm3867924lft.295.2024.01.03.02.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:34:31 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: Add LED support for 6393X
Date: Wed,  3 Jan 2024 11:33:49 +0100
Message-Id: <20240103103351.1188835-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series adds support for the port LEDs on 6393X (Amethyst).

First, add the generic infrastructure needed by all chips. The idea is
that adding support for more chips in the future will only require
adding a new implementation of mv88e6xxx_led_ops.

Then, provide the first concrete implementation for 6393X.

Tobias Waldekranz (2):
  net: dsa: mv88e6xxx: Add LED infrastructure
  net: dsa: mv88e6xxx: Add LED support for 6393X

 drivers/net/dsa/mv88e6xxx/Makefile |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |   6 +
 drivers/net/dsa/mv88e6xxx/chip.h   |   4 +
 drivers/net/dsa/mv88e6xxx/leds.c   | 422 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/leds.h   |  14 +
 drivers/net/dsa/mv88e6xxx/port.c   |  33 +++
 drivers/net/dsa/mv88e6xxx/port.h   |   7 +
 7 files changed, 487 insertions(+)
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.h

-- 
2.34.1


