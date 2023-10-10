Return-Path: <netdev+bounces-39698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B817C420C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C6428179C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338F225B1;
	Tue, 10 Oct 2023 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yH7JNjCG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815F18C23
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:08:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121D99
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:08:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7a6fd18abso29707477b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696972080; x=1697576880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndlPGfYsR5FrdEZ+vU/Zj3bD+kBDGYy33Ae6WjfGffY=;
        b=yH7JNjCGblBJnpFGem+LJ0XJ46VVdoQ8IFy1TPq5B/CXj96sbF05KjMW8+hD1cSwrj
         LzdCJWSnVCNcZUsPQZB9QArlCV1Niq0YfaXz/j4c8pQWXLQYBswKq8RVblq5N8+d92ZV
         pw+O4IeIVAgmgXigzueKgaTYrX77fiXP4NdAACB+zKPnzUTwhyvwOKI7kgFhd4sG09pQ
         1j2EiCxGFOtc36v//Mv3yOSGyo1TSAL33uTkCWqVH6SZxrkDB1t2feYKL3sXKoUL/zav
         a1smD6ldyJIFYI8MaCrY2aCZY1KAVNFAUPNbSe9u+yfBOX1QQ3cQoTERj55dQvJ2gnv1
         pAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972080; x=1697576880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndlPGfYsR5FrdEZ+vU/Zj3bD+kBDGYy33Ae6WjfGffY=;
        b=aZNQvKAg1UVcHuvWi1u4+4OAux6+qDHZueapUlPNnvdTSGTxNPRRTSOP/XqfdUpKa3
         HJWG2ACcwCpV2rfnED8blVZIny3fSSapaUEhfxPV1HqhF4ZcFSSUWOG7ZDiSJ0iIRJIq
         Vq6oefV3YH8QaN7+oeovzMJW2x+eUe9AG2cr71RYqSTjDzT0le0/4Khe+CA0Ej01nfob
         Jf8GHGqY/23tvBzH9e0HFwwh+lesdYLePuwcdvELyAhNvW6bf4dpNeWw5UD/c4sTdoU3
         e4Db5pYLL9AzAm6gqYUwOvXlK5Sc73TQGsOYg0MsvQgvpIz2Uzb5m9JbkNOdKSoRflwj
         kxLQ==
X-Gm-Message-State: AOJu0YzMUlwBHYI5AeGWTFQafrNN9mjbeaw2Fq/S/20sxgKyHFBdWHi+
	0v6F4tUr5LnrDU1fBGMqmpHgSXw7N4lH//MGNQ==
X-Google-Smtp-Source: AGHT+IHj9mcr3yN9cr0pAbeqwrfthhwiz6e+OtQon8JznMOo9KT/dvFu6WV/L5M0mXZjtD1IJkgEjwfrm/dmYR4P9g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:69d4:0:b0:d9a:58e1:bb52 with SMTP
 id e203-20020a2569d4000000b00d9a58e1bb52mr58171ybc.6.1696972080036; Tue, 10
 Oct 2023 14:08:00 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:07:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC69JWUC/x2N0QrCMBAEf6XcswdJimD9FRFpk217oGe5hKKU/
 rupDwM7LzsbZZgg07XZyLBKlrdW8aeG4tzrBJZUnYILrXfecS6mcflyMllhmRWFUWbYMUQLniz TcPB49aIceQjnDu0YLl1qqf4uhlE+/+btvu8/fpTvp4MAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696972079; l=2221;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=flnqc77MqO1c7xUbgevXQV3iKIfkAbCA1etAFyGMSlA=; b=L1o+advtN54cbFa+xXqTVzRfB3SNNlR/1bgBEQXRIdYE2QN+ozFKD/Z7wyvk6nz8JnPbMksY9
 tQcwMCs+e4lBLETRdzxOSlViiob55aevqxlvK6JogW8Evrv/bSkGeKc
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
Subject: [PATCH] igb: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-b259e3f289d3

Best regards,
--
Justin Stitt <justinstitt@google.com>


