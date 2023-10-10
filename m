Return-Path: <netdev+bounces-39735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FE7C43F3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3265282110
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF778354E1;
	Tue, 10 Oct 2023 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEO+sMKt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A032C8D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:27:14 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161FBFF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso8231381276.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976832; x=1697581632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
        b=NEO+sMKtDzsP8gxorptIaos+DmHsjIjrhqDxRsy3hTrzvtOtToRkMNPURCeyMENd1m
         kJxuvWBxzplAlqxue3X7pim5HxPgPjBOX7bWZC5kyW777hvEpFWI5qdchLXSkkn0T3L1
         EuXt89gNgq56/Qm2LzwzF3zS+9UV0+b7klrofE2cOI9Yr1NJimF7BitT8gRlCk6zC36I
         J5IOvuIGujn1RsUvZzpt+1cVYPcCR9xRs0XZPIGSpDZNbZ5Mo9SuB7iZnPIn3xhOLnK2
         8I5ZFTFy3WN0BoJ6IoDf5crQjMsqcxZvfh0EnJIyTykRa7omeVm1fqzK79VrJBd2QO79
         WoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976832; x=1697581632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
        b=Wh73nLC/4r/jC7kCdXh5erg3zdfYgV5t1zx41JDUd92H4wXJOd7s2PYEc1cEDdyCDC
         +04rWzH7Dh4OELY8a6UyWs8ylHSx1on6A8zqgpreIIWmc1lXHl81iQAQxieaXj6zkaAE
         +cy94yE1zMmV9l2uLM84e2svezceu2j1Jwhn1ngOvTBIEc15S3JdkQvrY9L12aiyrAIc
         hvHR5Izbq5SGfDDGK1qT9/nIj8YZIB3NP3t2RP6YO2M+1SoF3i3i0Assvkr0o2ZcOKDO
         8GYj4ullAvHKu759q1ciYrQEKDjhhSAkkAFc48RThqRPl+qS/9QNCHVEHTko6cItKqA2
         C7Ag==
X-Gm-Message-State: AOJu0YwpahcFXRfZufq6aHKSjIn9T5sMa3rzjHAWSzhYrAx5Oqy3MnNY
	UAjtZctGScyPQxH6fw1dihQVks2Ho4hGHOnBAA==
X-Google-Smtp-Source: AGHT+IE90IMRLxbCtK+FWTfBYeHC+U5Cy3qc2KOUif/Mw4hAnclXZq/qXjDbI29Vfn0ZPUuW4ixhfNcK0Pbgbem5bA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ced3:0:b0:d9a:634d:4400 with SMTP
 id x202-20020a25ced3000000b00d9a634d4400mr53292ybe.5.1696976832282; Tue, 10
 Oct 2023 15:27:12 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:26:58 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=2053;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tIBhN0dI5KQV25Dn8IjDZp+7IelZH6PsmdLrTBm66Xc=; b=hRT8DAV5FRqqSXsHAHmPSGPSEQbQBGx13G3GU53NmuUbzuZgGmmwVJqw/B2WprCOy7JOSEs7A
 JUBcK+9dOy2Bis775R/QWrp3y4385KpGI7leBfVy2b+aVrSU/y1pH0a
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-5-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 5/7] igb: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We see that netdev->name is expected to be NUL-terminated based on its
usage with format strings:
|       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
|               q_vector->rx.ring->queue_index);

Furthermore, NUL-padding is not required as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igb_adapter),
|                                  IGB_MAX_TX_QUEUES);
...
alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 76b34cee1da3..9de103bd3ad3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3264,7 +3264,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	igb_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);

-- 
2.42.0.609.gbb76f46606-goog


