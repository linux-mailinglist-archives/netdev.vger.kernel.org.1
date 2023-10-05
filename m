Return-Path: <netdev+bounces-38264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18447B9DF5
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4FF361C209E7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5131273C3;
	Thu,  5 Oct 2023 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZrE38V/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173D266D0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:58:54 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3239EE7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:58:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so8611115e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696514285; x=1697119085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbV1aUniv7FDwoYe4l9QjP2aDA1u/O0qniF8u91BDus=;
        b=pZrE38V/8z8QcVKvZoFHf9jCSpU3SPDoj1toEPUHTKaxcyzxQg8HngyjXDQfifmtI4
         eNT8EEh6tZyPDu3KWaR7tDH2/qyezYGAw0Q0N2NQnY4AYb696fLFQ/J5srNnY5n3S2Hp
         9CDcJRd7bJAx3Cq6C7NZd4QRTwViH4gmEkt03F3QGERB1Gl7M1Kk29xJOEFSRgokOVAq
         5db2kL7hiPyjfubPVx4Qp8bC0sieI6gy30HTFrFVFMyGDYCwTHzcEdO//SFhtBM8z1Ck
         ljdVEsO8mElBTB2XQhRGaqLBRLw4rNCkxUOoyCt8LFM4FX8DP9hO2l9C3X7JLnysd2NC
         QnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514285; x=1697119085;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbV1aUniv7FDwoYe4l9QjP2aDA1u/O0qniF8u91BDus=;
        b=ZUOa/rhFgB/MaJK6ZnXUYp9qZTOdG9bZXglz0MrCMCfJ58tojpYQ0UnBMNI9FGHv0s
         RACan15cdZ5mSNWK0cKrfBAkBT+fzRhzynX18+mrgoQpLRWkftISfqGDUCs/babyWsjr
         gnljGSkUJjk5WYIHOF9vGLTI9q1tcVXG0fCtdrH58ilaZChXVK9pSV4YBYB4Ch8jOPut
         w1i7TuiRW/9JiQYL/0qmzeY+E7D98YhEkhUYtwf5d5VYuGQilRFCuLMkS3mPUto9HVDj
         BwMuPVQHo2U7CA2y6X4fk4hdJXujh7qMdRQwNaTBKYgytGzwdtATFCorP6WWvUoW51iH
         IUVA==
X-Gm-Message-State: AOJu0Yw71CKrrJoIPFpBqEqBHQB/gyHSqr24dpH9JcsfrzF+hhSm6uPU
	8YdZHEpslV7qVtHgJvxHNhZGfA==
X-Google-Smtp-Source: AGHT+IE/iWnwqmpAF4wqaA6W5GsdMwBdfNIcUdBB5OSIxRFtjMweSLN1TdvH9Iybz2DfnfNeSgB9KA==
X-Received: by 2002:a5d:538e:0:b0:317:6a7c:6e07 with SMTP id d14-20020a5d538e000000b003176a7c6e07mr4788087wrv.32.1696514284749;
        Thu, 05 Oct 2023 06:58:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d594e000000b0030ae53550f5sm1858644wri.51.2023.10.05.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:58:04 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:58:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next 2/2] ixgbe: fix end of loop test in
 ixgbe_set_vf_macvlan()
Message-ID: <34603f41-1d51-48df-9bca-a28fd5b27a53@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The list iterator in a list_for_each_entry() loop can never be NULL.
If the loop exits without hitting a break then the iterator points
to an offset off the list head and dereferencing it is an out of
bounds access.

Before we transitioned to using list_for_each_entry() loops, then
it was possible for "entry" to be NULL and the comments mention
this.  I have updated the comments to match the new code.

Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 4c6e2a485d8e..a703ba975205 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -639,6 +639,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
 	struct vf_macvlans *entry;
+	bool found = false;
 	int retval = 0;
 
 	if (index <= 1) {
@@ -660,22 +661,22 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 	if (!index)
 		return 0;
 
-	entry = NULL;
-
 	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
-		if (entry->free)
+		if (entry->free) {
+			found = true;
 			break;
+		}
 	}
 
 	/*
 	 * If we traversed the entire list and didn't find a free entry
-	 * then we're out of space on the RAR table.  Also entry may
-	 * be NULL because the original memory allocation for the list
-	 * failed, which is not fatal but does mean we can't support
-	 * VF requests for MACVLAN because we couldn't allocate
-	 * memory for the list management required.
+	 * then we're out of space on the RAR table.  It's also possible
+	 * for the &adapter->vf_mvs.l list to be empty because the original
+	 * memory allocation for the list failed, which is not fatal but does
+	 * mean we can't support VF requests for MACVLAN because we couldn't
+	 * allocate memory for the list management required.
 	 */
-	if (!entry || !entry->free)
+	if (!found)
 		return -ENOSPC;
 
 	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
-- 
2.39.2


