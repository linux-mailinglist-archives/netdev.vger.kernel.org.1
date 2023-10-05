Return-Path: <netdev+bounces-38263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652D87B9DEA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 48276B20843
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109E26E20;
	Thu,  5 Oct 2023 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCazjyMT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7381266D0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:57:36 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791D2755B
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:57:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so9413475e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696514226; x=1697119026; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIDUUDyPCMDnmf6dgpyyTfj6uNBxPsdSSFa0JLZBazw=;
        b=lCazjyMTJzIespSvCCMrWe3Xzr0lRGcJ3t0VvohDnyzfrci/2V54iBYcMhzui1tANx
         XeWEHijdBumD7/ZLLR/JQrP0t0516N0yrVmwZKGUgypW+JEVt6qavbfgDhASN7ZLB/Pu
         8Ucm430cVWVnkwyRpywxCIP1rsOMuP66TQ7d8Pem1x25E1WS10p1nMHEPrzKFYLawQQA
         tx7rSFtzGmr9kgNXcdDbHd36zqbyhvljVmYfqix42po9Zhv+Zv/t5yjP+TfmpKDNgduF
         J5ef/2t9eeWc8N1LqjF3RNw3iWtag8Vu0qby240Fuea5EGIbgZmtm9HQYmQrIxnu1Ms2
         eraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514226; x=1697119026;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIDUUDyPCMDnmf6dgpyyTfj6uNBxPsdSSFa0JLZBazw=;
        b=VdrPQ7z4gdJ1jxFP/orGDbIzzmS13nIuf9OVo6cObv/5S8ywmzD8lH0CkwG6y1f5aI
         /KwtILy+Mud8+n9UxcQeoHdjZC8UuQ2uAP1P+IkzXtPSZ7/Lp0aiOiEZCVBotu3dbXdz
         wSWPa3zdapykbzYFSvvwhee+ISPq8zKsfV6XLseU7SYcxJBMrnt4Iq07AYnCY/0UzJ8P
         S+LGXxOA3GgILBU2udGVyaUgwOCKYlVwpHkv16rMc7PuST0CeGCdsWziJIfbSksasM4p
         k8Lghn4SvjB5mfOIqWptq36cBfPXgu1+l9bcOAjMAIJcTZ18aBmLCF/Z7DoiDxLDpoHP
         wyLg==
X-Gm-Message-State: AOJu0YwPWeEpFsy4JkIo1PATd5JgX6pUi/49Nj+fWnvUNuwIGICbo6CG
	SmWnuqrwA6BGneRXF6gEuNAOVw==
X-Google-Smtp-Source: AGHT+IH+50km3L9x7FNGDdpi8jFVFT/mSqPZ1f1vTJoCUCMCRuejoPXyRAO7AbAoq0zfWgzr9nEAVw==
X-Received: by 2002:a05:600c:211:b0:401:bf56:8ba6 with SMTP id 17-20020a05600c021100b00401bf568ba6mr5087166wmi.28.1696514226615;
        Thu, 05 Oct 2023 06:57:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0040684abb623sm3774428wms.24.2023.10.05.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:57:06 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:57:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Rose <gregory.v.rose@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] ixgbe: fix crash with empty VF macvlan list
Message-ID: <3cee09b8-4c49-4a39-b889-75c0798dfe1c@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The adapter->vf_mvs.l list needs to be initialized even if the list is
empty.  Otherwise it will lead to crashes.

Fixes: c6bda30a06d9 ("ixgbe: Reconfigure SR-IOV Init")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index a703ba975205..9cfdfa8a4355 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	struct vf_macvlans *mv_list;
 	int num_vf_macvlans, i;
 
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&adapter->vf_mvs.l);
+
 	num_vf_macvlans = hw->mac.num_rar_entries -
 			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
 	if (!num_vf_macvlans)
@@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
 	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
 			  GFP_KERNEL);
 	if (mv_list) {
-		/* Initialize list of VF macvlans */
-		INIT_LIST_HEAD(&adapter->vf_mvs.l);
 		for (i = 0; i < num_vf_macvlans; i++) {
 			mv_list[i].vf = -1;
 			mv_list[i].free = true;
-- 
2.39.2


