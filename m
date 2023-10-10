Return-Path: <netdev+bounces-39637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690307C0388
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2211D280FA1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1F225DF;
	Tue, 10 Oct 2023 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyYt3GSJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2884225A6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:36:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92076B4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:36:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a538026d1so1606427276.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696962961; x=1697567761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k901dfXyM6A6d2qq6am+50364PkFHEr+c7kfdKStNUQ=;
        b=VyYt3GSJRC+KPciiNpKgNaL7H+JTLWlAoXylNPYzekcPF2YrMI89LiyPoKiU3H0vGS
         fEqlesRBSJX73kOQutSKKP53CpsNg2jZni3Fw5ohW3tIshmyXdaz+5ZWEWukSw1MiIyB
         Kj6BQvVhX7QTbulveqQRVOIm+IEWPcMWZznMI+lKtg1EeXcAhhUaA5xGJjUQhxyeZJsg
         RErsSbSi2EftJJvEiQKa8kphSlT5wxRrRUkLIs0DfVdr3nnE37a2j/N7iuRGSzWD+ICr
         tTg0B6mdUba7CrYICJD127rQFFmp7B+VpwzxjdezdvTj3qYx4LXgbDKm5/fzbaHHujMz
         BQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962961; x=1697567761;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k901dfXyM6A6d2qq6am+50364PkFHEr+c7kfdKStNUQ=;
        b=hQupj85e5+cbLFF9Bv8KuMxd+WPZNn94kNGbooJx+R7DPRZKA+Ca5j+C4xuEisg29e
         5I28POKmRIx6w7qFWybhpuvnVc8ImaET4Pi1xOsW7giYHoltyzQxfqt8W0yBs3rQxRXZ
         Wqk8iAdyksvcTMgiO5Xi5oUtRg7JaXL0VyO9p0IVVC4Ch5FNHPsdDij4eGDd5vJLbtH/
         6eBzeoYbwRmqcuISxCZl+UEJbtgSGXGqoWJ2sMzn0PMlkiKly51T7YCoDdfl2hSidpyt
         3bbTtEZQzxp7CpD/HqMlaZJXfTWVKNVXebjo6WoF5Ka5vwfPeZhM5A7Fl2w550NvAfYH
         jAzw==
X-Gm-Message-State: AOJu0Yzt3jTPKrxkanixSNK/T3EyRDF1kKlhaSIZTGv7nuX6ScqcmZwA
	kQuFTqfr/ZH/zMVp1MayZgenOamT17DMwIDZ+g==
X-Google-Smtp-Source: AGHT+IHRvXP3D2yikYaUvE4s+9nvsVr680udJwA/tB2Qv9aTLY6TMIvkkLg6HQyVoI8EkajRQ+bYP1jPBJ2n/sIb9g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:fc18:0:b0:d85:ae1e:f696 with SMTP
 id v24-20020a25fc18000000b00d85ae1ef696mr336777ybd.0.1696962960761; Tue, 10
 Oct 2023 11:36:00 -0700 (PDT)
Date: Tue, 10 Oct 2023 18:35:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI6ZJWUC/yWNywrCMBBFf6XM2oFJVXz8ioiEzNUOaCyTUJTSf
 zfq5nDP5p6ZCtxQ6NjN5Jis2DM3CauO0hDzDWzanHrp10GCcKme0/hmdZvghTMqow7w77BccWc EEfnz8oiWOXHcbFV1f4Dojtr36Lja69c9nZflA5vSlniHAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696962959; l=2137;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XyZq4bqOiJO85kzWF8DwIoZ3ewao6X+shiHLyqLJcIY=; b=pCu5HtRudfioqViLz3TXwRZEp/DFrJMOIQ2kVRk6uzxbBv73fPuiJSNSllaodomHC/EO4TpVc
 wLOlN0mORyDC692XBwLhgkNojIGyVvU3rLYgwEKmdsQ9KnFfg3RKcJD
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com>
Subject: [PATCH] e1000: replace deprecated strncpy with strscpy
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

We can see that netdev->name is expected to be NUL-terminated based on
it's usage with format strings:
|       pr_info("%s NIC Link is Down\n",
|               netdev->name);

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

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
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index da6e303ad99b..1d1e93686af2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1014,7 +1014,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 	netif_napi_add(netdev, &adapter->napi, e1000_clean);
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	adapter->bd_number = cards_found;
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-a45ddd89e0d7

Best regards,
--
Justin Stitt <justinstitt@google.com>


