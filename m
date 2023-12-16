Return-Path: <netdev+bounces-58276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C45815B65
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9546F1F23520
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC931321AC;
	Sat, 16 Dec 2023 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLb4vos1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C65321AD;
	Sat, 16 Dec 2023 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3363eba94ebso1460508f8f.3;
        Sat, 16 Dec 2023 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702755815; x=1703360615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCmkrZfjoxLFm+4nqoSbVgLwqbupCRvqqsqwf2McxGQ=;
        b=JLb4vos1J5IcClDggkmmJLyCFObNoQ3N5HH13AVIUenBzeMUge53u0X5fRu7ohPrdV
         zrxh2gM1qNZaDsUK2SBMHf/6h+3LANhEUIxTEp6f8mob6gB73VkwXyUDXAL2GXeZxam5
         coEh/RZFHuSP2mlYip74H+vNjKSqOG1OG4erKBKIp3ynx5At6SpXtuhqqqZndupOmztC
         4JJYjY6Gw7C+spjGhNuhl/jKK9K9o21gPK2QvbQsGm0+DmcZzZI67KiSzRZ+ep2GK+q8
         HZXybzJ8O+5/E8twxXXvzqcw8+7R67Et0o+2G8fWIhWyyqzg3QdzIimPKcK3g1WZrzfZ
         dnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755815; x=1703360615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCmkrZfjoxLFm+4nqoSbVgLwqbupCRvqqsqwf2McxGQ=;
        b=pDPX0l6cEEQnseJLB71UCjo4Xws328QQl6JZN9Yues8Mv00w01qGzQCQwLu9OZpJp/
         x71AdQjdJpIXriSlvmBghxH1Sc2U6kh3es7nG0uLTnABH0z2W380RkpEgcvgVnF7iCfc
         CArCsylAGf32Hl55m/nQybBCejtlTmvqSOGhhXxGz7/s4c5yxirVkjO4adroVMNLFqIa
         lyWjWPe53wZw1Piu8QTxu3vHRZDtlUQGimeywCeTGhFzIOCF3RrZDpipx5XrP5NrJ9DX
         jmwdF2Mfqw3S44vhbeYWQ26iSlbzAfzlkVqnzhDZByLwkA7lSq4z2Eg3NYaTnYfK/mQo
         IhIA==
X-Gm-Message-State: AOJu0YwraePZJRty001AlU751x58DN++ob/e6np4IuQDQMQAvRTPeqy6
	Yrb17OybWKf3ZWSlfqfUe2A=
X-Google-Smtp-Source: AGHT+IEfhn0+BXu1pgYXx1zCrSVrpn/Nh8liJ85zWRvJGZh9fCT+0KbESW76eQRK+9ccxXnl+rqD2w==
X-Received: by 2002:a05:6000:196a:b0:334:b160:86f4 with SMTP id da10-20020a056000196a00b00334b16086f4mr3061404wrb.163.1702755815336;
        Sat, 16 Dec 2023 11:43:35 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm2781953eda.59.2023.12.16.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:43:34 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next 0/2] Add en8811h phy driver and devicetree binding doc
Date: Sat, 16 Dec 2023 20:43:16 +0100
Message-ID: <20231216194321.18928-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Airoha EN8811H 2.5 Gigabit PHY.

The phy supports 100/1000/2500 Mbps with auto negotiotion only.

The driver uses two firmware files, which are added to linux-firmware already.

This patch series adds the driver and the devicetree binding documentation.

Eric Woudstra (2):
  Add en8811h bindings documentation yaml
  Add the Airoha EN8811H PHY driver

 .../bindings/net/airoha,en8811h.yaml          |   42 +
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_en8811h.c                 | 1044 +++++++++++++++++
 4 files changed, 1092 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
 create mode 100644 drivers/net/phy/air_en8811h.c

-- 
2.42.1


