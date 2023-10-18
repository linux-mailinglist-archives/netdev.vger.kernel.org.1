Return-Path: <netdev+bounces-42435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1697CEB07
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FB31C20BAC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022F3DFEF;
	Wed, 18 Oct 2023 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpD9nXDr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDA1A737
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 22:14:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D87118
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:14:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af69a4baso112005617b3.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697667296; x=1698272096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PlQsMleo8ndyb1BkvS8psG/NpipwSb1Ibvd6wvaptgE=;
        b=rpD9nXDr8ZV4X1Zjrx1Lpkbi8PcVhM+FAsPQEkE/bgGqvJdPH1dZ/7vggwFyV7nhEA
         X8bQ+c4ABe5Lv0Lx4UdVxd3dONLa3xGFTYGjnsytjjaPuWHDgsSwaDQqOqxNYmUHL3E8
         fd6cI8mvnnYu0l+EvsSOxOG18UhCTsNL6jB/fhq9pjPCpnyyxwUQHxSZ87gnNTZIS6r+
         iRqmgKZXyA5v+lImVMteIruljC+BI0JQ11H/uZKwoOFulZPDL9CV4UpMWYejLAO+vAfZ
         /dHi5bk0o61IOex9EqNmqWyAwgpM35REgb1kPuw72D9Xa/TL/git7S9ZvXE7Ceui1EnK
         6sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667296; x=1698272096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlQsMleo8ndyb1BkvS8psG/NpipwSb1Ibvd6wvaptgE=;
        b=Fe5DKH7Toiex4/y+qid3Gqk2EfJFJheLvsfte1ua88zoJsjiJhNaffHMzANNzmk771
         waWBZLfMdU1xcRSPZgQ9p9RMDpqAhpWqKAGatNnYtC8VMsWKn0IijCilVk3T3kdQA3G6
         O0Tm05+lqrZWR4ZpJJh4Lsj4a9SaJ8c4aB8q0oyqr+m/ayanM2PL2/dSXtp86hfMuRXq
         cb3zjcwZKTAu/pENER4YotMx9MnieGlq0C3WzH5d42slzf1oukc5+xyxsx7AAkoY28/8
         R7RBKE7VbWtQmpnIuffib53UGwXAA//29wVvkpwX1xbxBmeGy22OTK+zFMRI4zxTM2Cm
         1DyA==
X-Gm-Message-State: AOJu0YwJyFJO30vn6DI6zr/YCxU4pN7+YyOlHsFCFW/NSnziCST468Kx
	ypvWwNExqxlyimjjiM5sqZq2lWmjPPLiesfP4Q==
X-Google-Smtp-Source: AGHT+IFCGhabYMIAAC6XiL9TzzjSCY6BQgj3jImjG5X7Fcyl/tbrVb3NWUepotJZi0+qdYwrlX/ZrUxtd4WudCjg7Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d9d2:0:b0:5a7:be10:461d with SMTP
 id b201-20020a0dd9d2000000b005a7be10461dmr15636ywe.2.1697667295839; Wed, 18
 Oct 2023 15:14:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:14:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN5YMGUC/x2NywrCMBAAf6Xs2YU8oIi/IlJCsqkLGsNuaJXSf
 2/qbeYys4GSMCnchg2EFlb+lC72MkB8hjITcuoOzjhvjb2iNimx/jAJLySKhRquaygo9a3zdOI Um7wwos+jMyHk5N0IPViFMn//s/tj3w8hAG6ffAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697667294; l=2364;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+RiFAuTFDYeSx5+FsqkeyVgCujTXIxMDn3P2javi3XY=; b=123OWlCw+sopcVGOlRvo8H8eZ3pupMbwmZbCt7KUM82cnX6fdX3BK+EJUTP0xC4c1b3gbO3IB
 1w6u2cozf6AB/MUjQvfMIuLfOn9l4T+IXmXkdkHqvfMcPANOo65c801
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
Subject: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Stephan Gerhold <stephan@gerhold.net>, Loic Poulain <loic.poulain@linaro.org>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect chinfo.name to be NUL-terminated based on its use with format
strings and sprintf:
rpmsg/rpmsg_char.c
165:            dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
368:    return sprintf(buf, "%s\n", eptdev->chinfo.name);

... and with strcmp():
|  static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
|  						    rpmsg_rx_cb_t cb,
|  						    void *priv,
|  						    struct rpmsg_channel_info
|  									chinfo)
|  ...
|  const char *name = chinfo.name;
|  ...
|  		if (!strcmp(channel->name, name))

Moreover, as chinfo is not kzalloc'd, let's opt to NUL-pad the
destination buffer

Similar change to:
Commit 766279a8f85d ("rpmsg: qcom: glink: replace strncpy() with strscpy_pad()")
and
Commit 08de420a8014 ("rpmsg: glink: Replace strncpy() with strscpy_pad()")

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wwan/rpmsg_wwan_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
index 86b60aadfa11..39f5e780c478 100644
--- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
+++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
@@ -37,7 +37,7 @@ static int rpmsg_wwan_ctrl_start(struct wwan_port *port)
 		.dst = RPMSG_ADDR_ANY,
 	};
 
-	strncpy(chinfo.name, rpwwan->rpdev->id.name, RPMSG_NAME_SIZE);
+	strscpy_pad(chinfo.name, rpwwan->rpdev->id.name, sizeof(chinfo.name));
 	rpwwan->ept = rpmsg_create_ept(rpwwan->rpdev, rpmsg_wwan_ctrl_callback,
 				       rpwwan, chinfo);
 	if (!rpwwan->ept)

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-3f620aafd326

Best regards,
--
Justin Stitt <justinstitt@google.com>


