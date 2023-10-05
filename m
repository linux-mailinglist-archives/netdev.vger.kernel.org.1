Return-Path: <netdev+bounces-38432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA17BAE33
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7BBC8281E6F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BB42BE6;
	Thu,  5 Oct 2023 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/xvbDfx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9741E37
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 21:55:09 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6595
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:55:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8997e79faeso2311233276.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696542907; x=1697147707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15N1cZsxfmEbv2x0hxsW9ZXAdYEMZDd2ct4HcMI5LaA=;
        b=t/xvbDfxHrSLeKTjuoFd34jmqVuNPi5stRvxijdXe65BY87jpk4/+tYPoC0i0fdoS6
         SGbJF7g3BTrAOoz3C6ftD7wwP7nlZd6T4kXuWZwO8g5eb8QmT5Fr21gTyGJErqfrjGOa
         wZvmcmw00Oq8p//67yQqCbi42V1W1KKYjw2aqtzCWvAhz4J1yI8sdqjn5ZvvWSOOufvK
         A6AR6jEtdqnFBq0Fm8neFYixKuo28W5Vccv5olkTEYpCcTC6PWC/Ot22fNNC6iH/z8GS
         S7/lNMAJYlAVpXKQt8kkTGIkzYl/0j4WKeR3MPAKw73qEvCOnDHa/0IAuUdDQ21Df4cX
         cL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696542907; x=1697147707;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15N1cZsxfmEbv2x0hxsW9ZXAdYEMZDd2ct4HcMI5LaA=;
        b=c/oz0LafM2Xbb/ZsUQNvHOxC0aKZOq0jga+AHLOhBcSPucqo+WIlYCQvxW0myNRI+2
         UmyE4kfEtCeWMXS287M4SE7O5Af2zd+n8Tf3O1sFw8X5YkRxkGWVxL0TWrtNfJtRQmS3
         OnzUefCAPAvztpdXaNfXlyXDK2fRGNqNOi4Nf6xTV+8LcJ/Z+bHfQ2Z5U5wEp0XFAV3m
         GFc3KNQgFFj1QR0QUKVJtZTVa+j8aRlB8VT27dTD2YY/DIJBUtqRUlBWxp/zAHFw+/ZW
         j0XTbmrvanFgVFfg8fnP5EXiGiuEewsHA84fZDJTH2Sx4vRPciAKh4f5BNWF21PXynjw
         CDsA==
X-Gm-Message-State: AOJu0YwWQgGKfrfr0amCjczuoLRJVIndGPML4wPvsywGnM7BEW7XNh7A
	R2XYzzmbIRKVOUdx6nckRDYclVedC2/OkcM3/A==
X-Google-Smtp-Source: AGHT+IH5kmRWTxHnbOHdcVuA+Thho6voAhFH0EXqlEnU/rGEgIjyx1taDbBJdWNEnWATXo/uaqRozazszc/sPEmxyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dcd0:0:b0:d7b:89af:b153 with SMTP
 id y199-20020a25dcd0000000b00d7b89afb153mr86513ybe.5.1696542907205; Thu, 05
 Oct 2023 14:55:07 -0700 (PDT)
Date: Thu, 05 Oct 2023 21:55:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALkwH2UC/x2NQQ7CIBAAv9Ls2U0oWE39ijFNC1u7iQIulGia/
 l30NnOZ2SCRMCW4NBsIFU4cfJX20IBdRn8nZFcdtNKmVarDlMXb+EEnXEgSespIeSH5gR0Lr09 88Gtlx6FCGMo8CEW0OGnTnc7TUfemh9qPQjO//+/rbd+/cdJAXYsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696542906; l=1813;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=C3xl2J3v8gwUN0HU8+dA4WXLs/v1+iBpCZbkeacUwtw=; b=KPY5MJEWqGL5WHVZsLvPbRYVOUHno7nU5umJO/gm3OQgFouMAf3NVUYZm4NefBHbah92WVVAO
 tojH7L8NeE7AtbzYIPVMs+OSU1U+HvhZRhzdhy4pfuZYpecxKULJA3f
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
Subject: [PATCH] liquidio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, 
	Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

NUL-padding is not required as rep_cfg is memset to 0:
|       memset(&rep_cfg, 0, sizeof(rep_cfg));

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 600de587d7a9..aa6c0dfb6f1c 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -638,7 +638,8 @@ lio_vf_rep_netdev_event(struct notifier_block *nb,
 	memset(&rep_cfg, 0, sizeof(rep_cfg));
 	rep_cfg.req_type = LIO_VF_REP_REQ_DEVNAME;
 	rep_cfg.ifidx = vf_rep->ifidx;
-	strncpy(rep_cfg.rep_name.name, ndev->name, LIO_IF_NAME_SIZE);
+	strscpy(rep_cfg.rep_name.name, ndev->name,
+		sizeof(rep_cfg.rep_name.name));
 
 	ret = lio_vf_rep_send_soft_command(oct, &rep_cfg,
 					   sizeof(rep_cfg), NULL, 0);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-b23567b42939

Best regards,
--
Justin Stitt <justinstitt@google.com>


