Return-Path: <netdev+bounces-39732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950FD7C43EF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C031328217A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AC32C86;
	Tue, 10 Oct 2023 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCzWLzIf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACC32C85
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:27:11 +0000 (UTC)
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302CC6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:07 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-57b78a20341so7466305eaf.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976827; x=1697581627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRxxfOpYGYsMYGCPD0LU0Gx9K2SMiFZ6T4X3/eq+2Jo=;
        b=sCzWLzIfbyvEdCcjd9shAkwt7hPStxK53ArHcfgnX2URuIOwrYvwkKjs2ENbrkKMM2
         R/FnDR+TI05cGo+o/Vr1a1wo2ADkb0gieGjV3wViWVQQNRYjZbv38WDQyv8fHFzgG9o2
         Ak07Pse+fp8trMmMT9gfKSH7ePXt+G6eftHgpJAX729MFyX1Wq9hz6tSl07LSAL42jy8
         2VzkDd84qFrQxRktlAz3UO2Z2PxDfWyTnKSzuBmqt9L8SZc5SofmAGBYAkDYi9XZgUT/
         6uCPj8w54u7CHODVfb/e1b/BYT68Srycl6IzLMPF2q3bJMDOmELqdr6gziXZf4c+bko+
         Xq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976827; x=1697581627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRxxfOpYGYsMYGCPD0LU0Gx9K2SMiFZ6T4X3/eq+2Jo=;
        b=q676mXNG4Dob40tx0Lbqhlxy/DwpQ+3ADSxpssuxAH6Xar0dfRp4855QvnH1RfCca3
         vbM6DFKN4N7hB0hyZ5hHUSR92QoSl1PmlWdh9f53gLw5QMpX9S0bRSWF8ei25Q8SWVsn
         rcKC1KG+TyIaxsOaMKR+7wNQUnB75O2VWbVGmc+owrMas0H+OpSq1FKqMyfPYqY42mlZ
         ouhBEg8No1Y8HGiLlVSaPuDZeYvpVpJCO/dl7CwTcdb73UcZOrNNek+g7NYIac6ZMXFU
         3QIBk9BHXl+rEn5gYr9CoHaiRZVzSAeGZnc/SZAPPVIzuQfDOh9ZQ2Qh5ZxCLnfiqEKH
         QFsw==
X-Gm-Message-State: AOJu0YzXhRkmQsxMGySVqI/7VYiFiPUoPRz9vksPJ69RXyGvS0uXJs6x
	FP2YkBW2eaLv/3ehcaobRVH9l7N0sDBhJ/0KRg==
X-Google-Smtp-Source: AGHT+IF7Z0F3Kme/HBMNT7IsdnfUyQ7lDRY4xVZb2ZtGQ3g2V9x0IBedcSSdWdeMcYlxHd4de/rHK0jPUa+aQGw4QA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:9891:b0:1d6:5e45:3bc7 with
 SMTP id eg17-20020a056870989100b001d65e453bc7mr8002308oab.5.1696976826877;
 Tue, 10 Oct 2023 15:27:06 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:26:54 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976824; l=2047;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OWWhQIBafVgfDlqmMd0xlq6kW1ggHRaXB3P7V35piho=; b=VuwZhA1UAIYHpGKXaFjSv1uwbivUM+rFKhtVdtifrMMZE3YsgHH/o4bhCiH0jMRbuplw/zZ5l
 Sq50xVfC9K1BbFHqYK+Q9zMPrzpmcn1bglNfo7vqJwP60dNdZLWRsiu
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-1-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 1/7] e100: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

The "...-1" pattern makes it evident that netdev->name is expected to be
NUL-terminated.

Meanwhile, it seems NUL-padding is not required due to alloc_etherdev
zero-allocating the buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

This is in line with other uses of strscpy on netdev->name:
$ rg "strscpy\(netdev\->name.*pci.*"

drivers/net/ethernet/intel/e1000e/netdev.c
7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/e100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index d3fdc290937f..01f0f12035ca 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2841,7 +2841,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &e100_netdev_ops;
 	netdev->ethtool_ops = &e100_ethtool_ops;
 	netdev->watchdog_timeo = E100_WATCHDOG_PERIOD;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	nic = netdev_priv(netdev);
 	netif_napi_add_weight(netdev, &nic->napi, e100_poll, E100_NAPI_WEIGHT);

-- 
2.42.0.609.gbb76f46606-goog


