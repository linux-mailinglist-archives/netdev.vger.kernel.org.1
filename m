Return-Path: <netdev+bounces-30464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A017877E6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4012728167F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3412B99;
	Thu, 24 Aug 2023 18:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A11726
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:33:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9519BE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692901980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MENyLQ2N3cu7YkwE8woYh2Uz3htsa5ND2UWg2HZ3684=;
	b=eJEVUrKeVqYPwtbjOlO90zC2Qhco+5IVPJL86FSR/bY9Y0O72xsFAAdQSDqrDfeVLuKffi
	Lgt3DOpmwuMXB/ltrZGITuJEm5cxMjwFw+RbeXCby03/82epp8OupA3toErassdFKKfqeW
	Vv8RWKUwjOs4reM9TerWLSl9fgRHOYE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-h-fjbkKwPSaOFFR-4NQ-rg-1; Thu, 24 Aug 2023 14:32:58 -0400
X-MC-Unique: h-fjbkKwPSaOFFR-4NQ-rg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-79983fb0afaso46740241.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901977; x=1693506777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MENyLQ2N3cu7YkwE8woYh2Uz3htsa5ND2UWg2HZ3684=;
        b=j7afiqNW9UP2t7oTmqH2NEyVjFKQls0GPGjGFUavoLoPo7RMy+09OeUhCLolQfwBuE
         1bVPsBrxB54rAGuU8XrOXJkBzuvw3rZOiqzjprV22z/Y67+RUnXfIrw/qzRtLYlnSQCj
         bSIW6VYOYkd0D6HcWDdXXVWBf4x8WXRd09NsKRHgL/6GKufOSo5qRed9s6WliBMNPO3j
         ZeZ35iya7PVfdDgaaBATE+mmpGCE+j/GOBUuAQAeJIsLT+Q0nD+0wGmlLaYJX551gvcA
         saXFKvGSnIY2hBskpPJZv9qiW3xEX1W/0FVfBga8Kyy8mMcZZrqJjRBmkxDHj4H6e48L
         /qJA==
X-Gm-Message-State: AOJu0YyRwBcl3mFS2xxgW3rv/7iarud7evyGwBHZLpD5ZyUuA+92CYST
	x/sXMg0xrxRvLphMMmf2EJXqMpwqerCcMJDHwiYGmh+aMuKHA2tKGf9na17tjKEnArNltSn74Lt
	yao2+fXDrZsqt0ulD
X-Received: by 2002:a67:e403:0:b0:44e:8874:585a with SMTP id d3-20020a67e403000000b0044e8874585amr4528624vsf.27.1692901977580;
        Thu, 24 Aug 2023 11:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMO96NWiKDcYXf5IRr9AXBP8x7ijYPK4xRhHHkKJy0v9wR6V9lgxekYM8Ssryo0WjBBvQqQ==
X-Received: by 2002:a67:e403:0:b0:44e:8874:585a with SMTP id d3-20020a67e403000000b0044e8874585amr4528610vsf.27.1692901977351;
        Thu, 24 Aug 2023 11:32:57 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:56 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next 0/7] net: stmmac: Improve default addend/subsecond
 increment readability
Date: Thu, 24 Aug 2023 13:32:51 -0500
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOi52QC/x3MwQ6CMAwA0F8hPdtkbororxgPoyvaRApZByEh/
 LuLx3d5OxhnYYNHs0PmVUwmrTifGqBP1DejpGrwzgfX+QtaGcdIaEtvTJMmFCWkL0ddZgzuGu4
 3ail2CWoxZx5k+/dPUC6ovBV4HccPlXRkO3gAAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series aims to improve the readability of the calculations
for the default addend and subsecond increment values.

I recently had to understand what the hardware did by reading this code,
and it took me longer than I care to admit. These patches aim to make it
more self explanatory.

Suggestions to further improve this are very welcomed.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (7):
      net: stmmac: Use consistent variable name for subsecond increment
      net: stmmac: Use NSEC_PER_SEC for hwtstamp calculations
      net: stmmac: Precede entire addend calculation with its comment
      net: stmmac: Remove a pointless cast
      net: stmmac: Correct addend typo
      net: stmmac: Fix comment about default addend calculation
      net: stmmac: Make PTP reference clock references more clear

 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  5 +++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 14 +++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 22 ++++++++++++----------
 3 files changed, 22 insertions(+), 19 deletions(-)
---
base-commit: 9f6708a668186dc5b38532fc1d1ff2f5311722d6
change-id: 20230824-stmmac-subsecond-inc-cleanup-305397c6ca8d

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


