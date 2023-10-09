Return-Path: <netdev+bounces-39358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18A7BEEAC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EA01C20A06
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5273B787;
	Mon,  9 Oct 2023 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwRVFeYE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88F7F7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 23:05:48 +0000 (UTC)
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1790CA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:05:42 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c664c09497so6623705a34.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696892742; x=1697497542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sf7f7SSFEcioOL4lOh7uG5FMec4NdhZBqO0ftggHptY=;
        b=LwRVFeYE/YD3ecpcJUBp5ofm5vl2PimabMq29CWUZNbuDyrvHWIPBsHUbI4/sfsVFj
         Dh5f+pAQX10Az7hZzHBgqjaKqpzG33QfypHaxKIbV9J0Iq0p1jsxh0rg95ZQxbfjCHir
         uggvJjPVkB/5MnVLDLV5UggUbB+CPYZUrKGi+WZjSBE9sXP37Wirymfmh1prk5fdMJQc
         mFddu5tb80h7pqzOoXu/YjziCpSGd4k9ueqUkoweQRmiiFOrmj2V3Mlao7Vvs8HK7XWC
         GVqH1aj++MP6bkUcAxiYET6uRD0AqCgiYHlBjGdxQ/SQ18TFm+OILALK42BkXHPfkSX1
         XI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892742; x=1697497542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sf7f7SSFEcioOL4lOh7uG5FMec4NdhZBqO0ftggHptY=;
        b=DW4Jtff+9NJvjKds99uMV5XgahX/z4z9pLwEtC9WjZFVHb9qc59edaAEBrs4kvPAp8
         H3wPBUOhv3CAq99RJtHmJfjUrbJ0XNUUxUK8IoVJShdOezUO7/B3GIhMcmXn/OWn2s/S
         JrYoLDOkpKl1rQBOzV4hQwL/gpbcuHpj8zWuPOK8NdOhHf8SZ2lzk30NAQS7/akOdPsl
         auCKur4j9xmFs9LomxaUzXWHay2tNgQD0Cwccg18LdtJoAY0QKB6Zb/BJGmGXmOLvJyH
         J3GCm35wJWG/pV4uml74aEBToKm90iBiECYKjITRiTJ+nPIUUzeCKbWpheinaqjxByiZ
         Xo6Q==
X-Gm-Message-State: AOJu0YyVxGm9iEP6qGXkmyvhr3eLt2oLcSVmSQcfGG40bTygmf7m6rBQ
	aLr3m4NZT0y1B/AKli8xSkKDl9D5ejWFMq6BLQ==
X-Google-Smtp-Source: AGHT+IGFgXj6rSXctich+As11kiZfkGnKpf2oXnUdgRc45Epz4XWQpAHX2HulJczcCRybPr4tjMVvrV0XhkuaFFRQw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5a9a:b0:1e1:82c6:33f9 with
 SMTP id dt26-20020a0568705a9a00b001e182c633f9mr7399939oab.6.1696892742303;
 Mon, 09 Oct 2023 16:05:42 -0700 (PDT)
Date: Mon, 09 Oct 2023 23:05:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAESHJGUC/x2NwQrCMBAFf6Xs2YWk8aD+ioiE9K1d0Fh2S6mU/
 rvR28xlZiOHKZwu3UaGRV3ftUk8dFTGXB9gHZpTH/oUQzizz1bL9OHBdIE5V8yMeYT9QAzwkp9 gQbm/slYufDpKSCKSQ4rUupNBdP0/r7d9/wLeKqFqgwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696892741; l=1913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=b46EvaWEvLxv9FsIZoOXRs8eHWo6xtQQKTHMNok8KSk=; b=I1zIPrcYrC6V+htWsXEMmmSTST/RmDVaCy58n10tqsm8+ntpoa4LnmiS37cPkusLtOQ0/Iumf
 omEl4t6dkYhAIRCLgVsvvoMW5H1hqfyd88cYBQN9rR7tOLGSn1wrk55
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
Subject: [PATCH] net: fec: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
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

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Also, while we're here, let's change memcpy() over to ethtool_sprintf()
for consistency.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 77c8e9cfb445..78bddcbfb5d9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2907,12 +2907,10 @@ static void fec_enet_get_strings(struct net_device *netdev,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(fec_stats); i++) {
-			memcpy(data, fec_stats[i].name, ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "%s", fec_stats[i].name);
 		}
 		for (i = 0; i < ARRAY_SIZE(fec_xdp_stat_strs); i++) {
-			strncpy(data, fec_xdp_stat_strs[i], ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "%s", fec_xdp_stat_strs[i]);
 		}
 		page_pool_ethtool_stats_get_strings(data);
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-84f03fffa031

Best regards,
--
Justin Stitt <justinstitt@google.com>


