Return-Path: <netdev+bounces-23527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023DF76C5E9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D0D281746
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7B185B;
	Wed,  2 Aug 2023 06:56:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB721111
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:56:36 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1EC1AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:56:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so9158074a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=l4+MfpYfZRWgAvFL59TuqxRwKN3tBGtKvfwKpSyrfRyu+7nwyMrx9ILWQWLNKf32OG
         FUtfn0xMrlGBtubo2AdyaBgxbz2yLFhQXM/dIbwDT/RowOhLwejXUk3a/OlXPawY5N+p
         q/29IRT5KSR7Jq9s0cXptycUP7XEvN+vQfND0VLUFtzxxdAADqQX27UQya7N42KpLk/Z
         rmrSsGjxpCjOlqn8F5+O9sEZMWHFFjAD46FGdFdfOtVQQWaKvWdzuE1MKSbfi98fD4cw
         +sziTQw3Q1keXmQGtd+7cgMIQ8MQg+GQZ3ttgek9Jl563UPAC+VsLBy6lZCbDaYcJ/yA
         b3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=WA3Uc6bwlEF0e7F+VSWPXlUfVEeEa+c1C4/LOWF85+3JkvxkOkqvahUBnFyO+eRwZl
         wF0JMBjYG7m8url1uM4VVWejVyX33RZ0W9q2ZFRQK3lwd9STxMcCFYlBtTJl9lSd7d67
         HqzRivk5wWWaZKLb4IHt/Xr17mTRs6MDYNkoCsta8vFN/V80Ft5TMTLlPRVyK+6VB0yD
         zp/nDZnWSGxSDqA+xIk75cM7NqPK2w0UTKLeAgsaxTiR8Au/L1zaO7929qSdGhd7uuVz
         zp4yIwjL2D5WjHryiRWWD9ugjKvD9LCM6ghRVJNF2ll2c6RhEXWXb937zoSVfgj4Kz4N
         81eg==
X-Gm-Message-State: ABy/qLZvy9JJTQ/iAzfmBY1IT4gWbtFa9dy8EQt9Y/drpabMLdxfTMsb
	gyB4GBOlkvMfJov7FM7ygfyMGw==
X-Google-Smtp-Source: APBJJlGi5fmP0zp7K4DR2MMoxvj+mltvijlg3OwvuFffod4okhkoMLCJtNXJIomfMjOXylY05fNUEg==
X-Received: by 2002:a17:907:1dca:b0:997:beca:f9db with SMTP id og10-20020a1709071dca00b00997becaf9dbmr4051637ejc.54.1690959391375;
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/2] Add WCN3988 Bluetooth support for Fairphone 4
Date: Wed, 02 Aug 2023 08:56:27 +0200
Message-Id: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABv+yWQC/32NQQ7CIBQFr9KwFvMLaLEr72FcAP0VkgoNtETT9
 O7SLk10OZO8eQtJGB0m0lYLiZhdcsEX4IeKGKv8A6nrChMGjINgNe1HQfUw4xTCZKnmZwUoG30
 xkpSNVgmpjsobW1Z+HoYix4i9e+0nt3th69IU4nv/zPVmf+VzTYGC4IBcNQiKXXvl4miDx6MJT
 7LVMvtbYKXAO5QCupOQHL8L67p+AI7Xl8cFAQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in the btqca/hci_qca driver for the WCN3988 and add it to
the sm7225 Fairphone 4 devicetree.

Devicetree patches go via Qualcomm tree, the rest via their respective
trees.

--
Previously with the RFC version I've had problems before with Bluetooth
scanning failing like the following:

  [bluetooth]# scan on
  Failed to start discovery: org.bluez.Error.InProgress

  [  202.371374] Bluetooth: hci0: Opcode 0x200b failed: -16

This appears to only happen with driver built-in (=y) when the supported
local commands list doesn't get updated in the Bluetooth core and
use_ext_scan() returning false. I'll try to submit this separately since
this now works well enough with =m. But in both cases (=y, =m) it's
behaving a bit weirdly before (re-)setting the MAC address with "sudo
btmgmt public-addr fo:oo:ba:ar"

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Drop applied patches and resend
- Link to v2: https://lore.kernel.org/r/20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com

Changes in v2:
- Add pinctrl & 'tlmm 64' irq to uart node
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230421-fp4-bluetooth-v1-0-0430e3a7e0a2@fairphone.com

---
Luca Weiss (2):
      dt-bindings: net: qualcomm: Add WCN3988
      Bluetooth: btqca: Add WCN3988 support

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          |  2 ++
 drivers/bluetooth/btqca.c                                   | 13 +++++++++++--
 drivers/bluetooth/btqca.h                                   | 12 ++++++++++--
 drivers/bluetooth/hci_qca.c                                 | 12 ++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)
---
base-commit: 7093f04e534f48181e5d5fccbcf99c37ab96929a
change-id: 20230421-fp4-bluetooth-b36a0e87b9c8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


