Return-Path: <netdev+bounces-38267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7B7B9DFE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C9E98281FA2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA73273EB;
	Thu,  5 Oct 2023 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXHKOdEK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B426E36
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:00:08 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC11347F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:57:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so9525665e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696514245; x=1697119045; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AooGTYUy452CMDPClrlTisOX8k1qSdGixxMstg0I9q0=;
        b=RXHKOdEK900FcuhVBywDk8NW2QQyrPnVZzSGHaCppaXF0yqIKMULLollDslbMvc0W2
         FcMBed8lKnDktsfnD+TmkWNtV0Aqs3C6gDFTvaaj4HWE/OxmUB60K/wMv05dmX9jcBC+
         a2qTcHku8g5tAt40GYteCXkgQZpauuTQmPCU7bYYprUZpxtH4t1VMoxWl4Hnp4TnkNVl
         nQ1ky6ZjrZGCNKP5N3V6Dixagr5IDmdZ9FMy/k2vEYKTgy3C5xfS5/S7XG5JFyKrCtN3
         71syKa/+TeN/zF1lD7/x7OsBB6tcO905CWXQtRFxGY1g8WHTChIJqjnxxu0dshJvllM8
         jvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514245; x=1697119045;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AooGTYUy452CMDPClrlTisOX8k1qSdGixxMstg0I9q0=;
        b=fYVWFiNJRCXmg3/loRAn9W6PHL/96fPdnUAT6MziFQ6Zx4/CGX6I3/4H8KpRs9lQ3p
         kakyZhUc0C5Hg9JaKY9L2j9qDg7LsJGCyBuNvSDKZ5slsaJ6+16WV8Z7DeKJlqoHq8wP
         PSOt1UsyQCJub0fIT2F+gUVs44y31n6Sw0s7aYE7zof3ORcswomRf/HvjcvsKGnPR5xV
         0q4QNiUXFLKMk15etoRFa4/3YxiUheWxDyaNh3evmPCqR/79dyLbsb9GpUkzId2A4i4G
         MFlezW5YbA7impo3cDGCTogZn1wvhF5RYCsBRC1aw+hvUtrrnPB6Kvn4zKQe1HB/Ls0c
         LEgw==
X-Gm-Message-State: AOJu0Yza0KoOOsy68BvsdeKM/IPl3an1utaQHl+qkJrE0Eff6kdUGfj+
	K9NVYieJ3IMui0N1GVVvaBNGiQ==
X-Google-Smtp-Source: AGHT+IGEGxGJ8wEps7sHxei6GOKIWpDvnRrTfQ/aBGCmZAYI2aBq2ytwW6bqUoWdRMnKb5xGjvnu4Q==
X-Received: by 2002:a5d:45c8:0:b0:317:dd94:ed38 with SMTP id b8-20020a5d45c8000000b00317dd94ed38mr4875974wrs.42.1696514244730;
        Thu, 05 Oct 2023 06:57:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q13-20020adff78d000000b0032415213a6fsm1861805wrp.87.2023.10.05.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:57:24 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:57:21 +0300
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
Subject: [PATCH net-next 1/2] igb: Fix an end of loop test
Message-ID: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we exit a list_for_each_entry() without hitting a break statement,
the list iterator isn't NULL, it just point to an offset off the
list_head.  In that situation, it wouldn't be too surprising for
entry->free to be true and we end up corrupting memory.

The way to test for these is to just set a flag.

Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2ac9dffd0bf8..c45b1e7cde58 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7857,7 +7857,8 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
-	struct vf_mac_filter *entry = NULL;
+	struct vf_mac_filter *entry;
+	bool found = false;
 	int ret = 0;
 
 	if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
@@ -7888,11 +7889,13 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	case E1000_VF_MAC_FILTER_ADD:
 		/* try to find empty slot in the list */
 		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
-			if (entry->free)
+			if (entry->free) {
+				found = true;
 				break;
+			}
 		}
 
-		if (entry && entry->free) {
+		if (found) {
 			entry->free = false;
 			entry->vf = vf;
 			ether_addr_copy(entry->vf_mac, addr);
-- 
2.39.2


