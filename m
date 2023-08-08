Return-Path: <netdev+bounces-25538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5356C774793
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838401C2100D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2C15AE3;
	Tue,  8 Aug 2023 19:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F4174E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:14:07 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8D20369
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:01:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31768ce2e81so5193728f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521313; x=1692126113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5eZZaGHIEmrXbC9ihksQt3JILJFBUT+nlFqhiJDUhc=;
        b=muJ2RZc6gE0q3bGIwoIacuVABoVWK1CMCcBShpoMNUuEJhpwGIedGh84k3KWQXkcSQ
         RMOgk3Y2SwhXBxNA3KeTuC7lhATwI8rMM+6BwrcS+H0581gU3Nuv2OFu+wzKq/pQVbF6
         dPGc6qAYPwgCyYsBzxU8MjoBqTqLXKJJ13y0E3oAvkaQOTiP4H3Hv6RdzjTNWpAdVw7f
         PJO4N/IJt9f84KKXuYKrmX5u2/GyV9Q1CD+srEeJcD4CeA+f3Qzsv51u/02SkPicKs3m
         AaGnhf+SQsawiw19Wie75ujVygE+1VaeO2ak/l8+wpjZ0/JQansfY8oshOs4wKgGBddb
         tXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521313; x=1692126113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5eZZaGHIEmrXbC9ihksQt3JILJFBUT+nlFqhiJDUhc=;
        b=GUxrQjjwX+HcbR/w4DCRK/qhsnidiKPJAxqdFP17j6aiPs/qQb1EdXdUF43PZLe17g
         wUNsYoxmEdpeacocpQDyD4KUAD+viibxhAgSoD2HHSnHF1y0AreF72t8nyabsSRn59Nx
         IHZodZDUcxEOM3YvKxsQXp3FkBPteUCh5DosDkuiqa3zYj8jMr6Nx7Veh2IeBC9qANVf
         HBC0UmtjR5TlTQ8PVQAfL8atAzkDM9P9UiOVkClLzrA18bDofSJlDauuJubeGe2NWwxe
         sc9YEx1jVf7A2QkWzzCLq61aaHy05jhSh6ktlaAB5pTFmTXCfIxg1gt1yNuF5CLYxrjY
         3K+Q==
X-Gm-Message-State: AOJu0Yw+OXCoUojh8fGCOUIaJdS1HzQ7Vj/rYaR370Q3PjZ7PmqPLW/p
	12ugnkrZiYoXStzOEXcq4b7qkQ==
X-Google-Smtp-Source: AGHT+IHRc2Pztk2xm858gOk9xLjmtIGThyo0DvxdqNVanOdxVDhdsD3uekaaPNOBa8lgyHxda+kpTA==
X-Received: by 2002:a5d:4d83:0:b0:314:2e77:afec with SMTP id b3-20020a5d4d83000000b003142e77afecmr269542wru.57.1691521312330;
        Tue, 08 Aug 2023 12:01:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/8] arm64: dts: qcom: enable EMAC1 on sa8775p
Date: Tue,  8 Aug 2023 21:01:36 +0200
Message-Id: <20230808190144.19999-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series contains changes required to enable EMAC1 on sa8775p-ride.
This iteration no longer depends on any changes to the stmmac driver to
be functional. It turns out I was mistaken in thinking that the two
MACs' MDIO masters share the MDIO clock and data lines. In reality, only
one MAC is connected to an MDIO bus and it controlls PHYs for both MAC0
and MAC1. The MDIO master on MAC1 is not connected to anything.

v1 -> v2:
- remove pin functions for MDIO signals and don't assign them to MAC1
- add a delay after asserting the PHY's reset signal, not only when it's
  released
- remove the entire concept of shared-mdio property
- add aliases for ethernet nodes in order to avoid MDIO bus name
  conflicts in stmmac

Bartosz Golaszewski (8):
  arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
  arm64: dts: qcom: sa8775p: add a node for EMAC1
  arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
  arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the
    PHY
  arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
  arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
  arm64: dts: qcom: sa8775p-ride: add an alias for ethernet0
  arm64: dts: qcom: sa8775p-ride: enable EMAC1

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 98 +++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 43 ++++++++++
 2 files changed, 135 insertions(+), 6 deletions(-)

-- 
2.39.2


