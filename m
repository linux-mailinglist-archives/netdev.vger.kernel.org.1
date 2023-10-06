Return-Path: <netdev+bounces-38584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEB7BB821
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D51C209A2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEA1D6A3;
	Fri,  6 Oct 2023 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whq36riF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D021CA93
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:53:15 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002D10C
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:53:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406618d0992so20129955e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696596792; x=1697201592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/pNLEjZCjhbSTGsvbxxkYZuso1BbyFnQkUqlrstOic=;
        b=whq36riFa+y1V/nRmDGPi8nsUFQCtUhy92GzIyq6onQS11sdUq29oz6/7APMkcDE1C
         Ilhv21ZQvsFZ/1LEOSsBA3vrqBzASqVZGsbmwuGMuSDv9Eqh59h+FVfyCQp0KIB3Wxd7
         daZZu8Ki+7ClVYpbjk2iIs1InlOkOBhHDFIgVKIkZ06cPQMUfSGIS0txJcBNGub2eanC
         G0Vt9EUgJCEOFc4xVr0P1ngKL0JxYD2dmhaR4abp94qDUt2tZPAe8fXvFRoxVXAk/BhZ
         ZiIEyFvZsxjFMYykYi59XiwE4PsEEl9H1D2MwS94HDlN0rlkxmSOUBg+7Eqdz0gpxbho
         neHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596792; x=1697201592;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/pNLEjZCjhbSTGsvbxxkYZuso1BbyFnQkUqlrstOic=;
        b=e6Rqxoty0mrePVSyE0wGqH5UqygMCUlBxDDBxhYmmcImnajhBvfZxaYMJQ8dtLnFVs
         44TyyhKkZm0jWJ8AM6tiiPqQAYBK9mR92K39fFvpizOLOWmyefmUcEtyowqqtTXjq35i
         tIUyMPwoT7uGVtu3D4Y2Xuq2zDXjGsdyMibveTpFQyr4dGkuGzFW+MwKypzHAJ1EQHZN
         t/ISgmEU9ugceRKcz7HfRGXooAkUKWZl8rsQ9XeOwW6DZRfiVn4FHZreLYaKAOShh3nP
         m3TnLeTnnp6KbiEH95eLgcDJbuDCJgsJdcw0L8SSoML6bf2VM8XxU9V08+RH9saxvTGG
         89qA==
X-Gm-Message-State: AOJu0Ywio2K5ie4SG37nGl4wq2E8LaTDRUVtAyPJLdYN9A4UYiYq3Esx
	AyjJ7oH+jujO9ZyKFciH8uOVzw==
X-Google-Smtp-Source: AGHT+IFV5ma+vFvWKPuinROG/8U8XkA/Z+MG4UB0zyFovn/dAHerT6RzI8EcZV01tcRCF6pJsXNwtg==
X-Received: by 2002:a05:600c:2a4e:b0:404:732b:674f with SMTP id x14-20020a05600c2a4e00b00404732b674fmr7828883wme.34.1696596792244;
        Fri, 06 Oct 2023 05:53:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm3690460wmi.20.2023.10.06.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:53:12 -0700 (PDT)
Date: Fri, 6 Oct 2023 15:53:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net v2] ixgbe: fix crash with empty VF macvlan list
Message-ID: <ZSADNdIw8zFx1xw2@kadam>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The adapter->vf_mvs.l list needs to be initialized even if the list is
empty.  Otherwise it will lead to crashes.

Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Use the correct fixes tag.  Thanks, Simon.

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

