Return-Path: <netdev+bounces-39737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C67C43F9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967F3281D87
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14570354FB;
	Tue, 10 Oct 2023 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZRIPoU/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5E354E9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:27:16 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712C411A
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bcbb95b2so20484287b3.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976833; x=1697581633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=no1ezg/K8vqwwloDW/HES3GQ/s3OFKPTQdEopkcO670=;
        b=FZRIPoU/5pyurTfWB44iov5PlLXp0nMz2I91ArGg4OatGvo4ZrfNWd07ZzMHqKEh4J
         UCqkHtmo94DawsR6BVhuBEX3yvm7bt/+4EydQpUuQ6pNLcj91UxGl40WuSvjWM5deAxT
         rBaTgzWJF5eerWbKNphefA5PZZzImy/GfO2GPsdK/nnOuKPvTBJo/1RnEIhvKKm/r1sP
         kiIe08mA4Gd49L+mLYCoA4R9rddnFbMW9hAfFLqnAWEWlYlfmUgES6ssQlV9LcJJWvMT
         3XXb24CdcLv/zetSrjRbZLZiPv60N3r+4Fx/Wys/9xyNS/mUc+AvLPF1eiLhPMP+KIHM
         +o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976833; x=1697581633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no1ezg/K8vqwwloDW/HES3GQ/s3OFKPTQdEopkcO670=;
        b=FXcArd8Fb5gsmCo5n0prfx1EQKB8aUV+ZmD8KM2RGXcmr6xNb8aAc743AcnvZql/Ny
         m90jLx4Gr63JuSvVRTGccSppGU5R0rqWUuCLLAEmXDZmMU0jlmdRJTGGL9Vp7pq7EJ3R
         vTaT39E/2+iD6y5GzjwCYAXlO0KTxdcEnorRn40TOZGfIjODcw94rT0Mwv+Ap6Mzt4l9
         yldf3ZMp6zLq8Q2EgUDV6/6Y9dCDgmrbyS9aSI8INzU3KKeJ1pbta7CzC/pJytLbz8/b
         Hoh8j+2sw8Pkir+rOd/+ClhWJBkUCRcXzbtORCWIxetUd+8Or04Pp1rLWid7KIBqz183
         OXHA==
X-Gm-Message-State: AOJu0Yx/cycaofM6fB84MFv+s+THaxv3x1kcI6TvXX95MBvNmFOrut6U
	hs/iKlyCZ5dk3tYZu59gTG5JUVf2CotJNUQ9KQ==
X-Google-Smtp-Source: AGHT+IGbG6IYsWKztc9eojIXUzVD3Isy/9hlxzBlyjEVNI0A4VM2MItv3Gt9eZ20f/xkZ1g/F2q2V2ckLAz9494wcg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3290:0:b0:d9a:5b63:a682 with SMTP
 id y138-20020a253290000000b00d9a5b63a682mr53542yby.13.1696976833634; Tue, 10
 Oct 2023 15:27:13 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:26:59 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=1977;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=l7ud0vzH9yZbaC9lpRM0yEoQEtXO/RLFBqfqu9zutis=; b=jQcCLbxmGWObHnArcKoYj2/zN6/Nnp7Y3bIItQSofJOQ0w5NrEaAgjJZ8R6E+xsT14D0zxpeI
 a7KQJh8W8O7AWC0AJvaq/NMmrGf75By+asp4Xl/fMav25g/6JTazc+A
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-6-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 6/7] igbvf: replace deprecated strncpy with strscpy
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

We expect netdev->name to be NUL-terminated based on its usage with
`strlen` and format strings:
|       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
|               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name);

Moreover, we do not need NUL-padding as netdev is already
zero-allocated:
|       netdev = alloc_etherdev(sizeof(struct igbvf_adapter));
...
alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
alloc_netdev_mqs() ...
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
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 7ff2752dd763..fd712585af27 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2785,7 +2785,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	igbvf_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	adapter->bd_number = cards_found++;
 

-- 
2.42.0.609.gbb76f46606-goog


