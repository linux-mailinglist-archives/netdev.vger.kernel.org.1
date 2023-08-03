Return-Path: <netdev+bounces-23937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC076E36E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFED0282054
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F0D507;
	Thu,  3 Aug 2023 08:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04B7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:45:41 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D62103
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:45:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-316feb137a7so621494f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691052337; x=1691657137;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPa9htGpiuI88ff5WUiZx6PDVgHTuHk6lBPw5ohsQrE=;
        b=iQtKPYyIyijAQEZXG8sS3v+UioIsnM10x5V8AfNOi143sbdJ5YaY/fkAuGgnpYujMR
         TEFMmjE/V1jlg100vQscP3xPDrSpi3Ei/QbnxGUnpsaYXTALydWbg7T9mT7oZIzL+Fgy
         sZ4m8K1aOJVN6NpqkZGlUkKnqejc2v5Y0gzKCnnsNXi5qtbsy3q8l1aI+LHGQCKGG9uC
         crpm/Pl+UwuEA6tsAUZrKMGzfSNynfOnSouZtvWjNp1CCt0h+Z79Bihq5kkwZxA5XP++
         1EoXsa1xQg1U4GS/gNO2rpsDcSHd82r5eQGyw+b4KKbJKrTY/+7jz3a8fY/zvGDLcwWs
         ISsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052337; x=1691657137;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPa9htGpiuI88ff5WUiZx6PDVgHTuHk6lBPw5ohsQrE=;
        b=Hl36GOa2mkreCTkjA107/qc++ctPWzs6wrcvxpDZZRcIKcJmbCDLiKi+rwMgaNoigj
         W64T05VEuUm8Gq6Ldt8asq2eBOOLmPx1fTDQ9qITCGkQ+8gf0qy5ZDOq4ZFZ5U5DXMZS
         ohvBKgDXW2k2kYUsU++J7u6bITwO7WCb8BqGXaeLngefw0JHNpVk0aLqlA1UVttJMtGb
         MXQ7l1DvCtKJ+dWchh3BIX8fOfygzHcHRsF1hZ3DRCWKNIKyUC1JJBEOx5Z2B0eOGkC+
         ce/mn/efMuj549IzbsxNnjzogikyNuBPlo/VCH8grjGQXBNB3cb258kjM/abKYWCgMbJ
         1oRg==
X-Gm-Message-State: ABy/qLb3lutY39914QldEnhOphx7OXsQVga86F8zDH8AfOfk2fQ71MGX
	mbSibyzVhK9XnQgIVy4b4+sKwQ==
X-Google-Smtp-Source: APBJJlES0Xlr2MrJWA51aN+2lsiZe+u4CUHNXP1A/0+zTvskMAO250OGxQ+v/nB4BX/XxbeFxrmgmw==
X-Received: by 2002:a05:6000:104f:b0:314:38e4:2596 with SMTP id c15-20020a056000104f00b0031438e42596mr7084284wrx.49.1691052337341;
        Thu, 03 Aug 2023 01:45:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v9-20020adfe4c9000000b00314374145e0sm11895052wrm.67.2023.08.03.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:45:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] bluetooth: qca: enable WCN7850 support
Date: Thu, 03 Aug 2023 10:45:25 +0200
Message-Id: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVpy2QC/42NTQ6DIBgFr2JY92v4Veyq92i6QAQlUTCgpo3x7
 kV33bmcl7yZDSUTnUnoUWwomtUlF3wGdiuQ7pXvDLg2M6KYMlxSDHOYnIY0SiEwLFOao1EjNDO
 0VnOGha014SjfG5UMNFF53WeBX4Yhj1M01n3O3uuduXdpDvF75ldyrBdKKwEMvKJSlNxKWdHn4
 LyK4R5ihw7rSq+aaDbVssGYs5YRxf9M+77/AGQ1//kgAQAA
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QvoRFcZDs6o9TpNJhRcOO+q/4iGgVp6r0X2pKqGwQss=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBky2kuaalQYq+GyOGhBC5dzBopgjJeWqj6s3nph5/j
 SJdvoJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMtpLgAKCRB33NvayMhJ0YVtD/
 0S3YIoi65pepoxmM4BNp7wpxX2Vem04ne3cGBDCEdXwlhXM3I+Y7XC/JrFDZoszlc41WS7829pdw9n
 qCdfAzPHzQCXkRcjOTVxdMurgb6lL+utjUNFE2XZCkePbe0fXQmLkWCxN8FKbN4RhAXNl7x3rssDsl
 U+N6Y9WQ0tGHhSAIA7UjoDEPhNir7DKT2wIckC9S8iMDtz305/nBMUF9mQuJRRg3rd1dRhDU16JDT2
 RYCbeSsXxtnf3jGfQo3NurddIKG0A0Ph0QwvI3q743nKgtW62RxoTEj6JmgEghHMoZRvACHOOy+pwc
 IeBSqe7LIztwIHHCsb3qEJK/mph9vJ3FNmXgS8IyqS2dRRR4r2X3XVzjTE9fHeN4zYMk1HqQ8fLNgr
 F/sdKPjzfo41cLWpPilvSfjJkV0BMUb7VQ0uYQ2268m33RXvcASfMmn7VGwHNyOk4CE0J6eZqZrVvK
 rsVo2vy+7e7xmAgbS5FOafvRqgcErnWOBnvp8ETVxhIbwi3iG82KijkA+dcQbd4GAM2bwgjhq+0E5U
 TBoID9lY7D3Hxinl+/K5EOH+55qwlzaiHC47ZFtsZ7rQ4pinuagYcXQ0/xRpM+mJoPsL8MK05QTVJf
 8+TfAjwhbR80bFwg03jrKSiEp8BL5nGz+DpU2Ulc/u89IBObTFJi0mM8w4gQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Rebased on next-20230803 (including WCN3988 changes)
- Dropped DT patches to be sent in a separate serie
- Link to v2: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org

Changes in v2:
- Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
- Add bindings reviewed-by
- Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org

---
Neil Armstrong (3):
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      bluetooth: qca: use switch case for soc type behavior
      bluetooth: qca: add support for WCN7850

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  23 ++
 drivers/bluetooth/btqca.c                          |  97 +++++---
 drivers/bluetooth/btqca.h                          |  37 +--
 drivers/bluetooth/hci_qca.c                        | 264 ++++++++++++++++-----
 4 files changed, 300 insertions(+), 121 deletions(-)
---
base-commit: fb4327106e5250ee360d0d8b056c1eef7eeb9a98
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


