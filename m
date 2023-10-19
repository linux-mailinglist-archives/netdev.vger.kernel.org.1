Return-Path: <netdev+bounces-42776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A37D0147
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6281C20AF4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4238DDB;
	Thu, 19 Oct 2023 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlxO7jfJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8C354EC
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 18:21:25 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36112121
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:21:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so7725758276.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697739683; x=1698344483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d4Js1cGoVd6Is4II9UaSATIKgACWkFcGE+hiHb+zhb4=;
        b=UlxO7jfJT7LrfqoagBtOhuJDKklt5UatDzxoL19uExnG3cHnbhVlAteA8K+lq02Oak
         dWEfb5nmtOerLFmeSsKEkQag+GAyLAycW9koeRTLFwOEbvIQRHLcY4wAly7fJoAmBk1L
         Y7C3fOlOdIXERSKauJTLIvPRvu0hKm7itahJNkLNu39jtxbL1yEunOBXMJbZBCm99yPK
         +JZmI6xScf3C7E4CXYZBnWj7fUBGNSyaHk0sN5uk2I5WmAJwxfrQfSoGmt+C/MNtNHZs
         cl1adaMhd5QgbswD6DIPUXRI2DaHdgPX370WE7OhwZf9uDvCX/Ctb4puB+id2KI07K76
         Y1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739683; x=1698344483;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4Js1cGoVd6Is4II9UaSATIKgACWkFcGE+hiHb+zhb4=;
        b=pVAxv3WsfP0JwGIEhe9j+j1kWq51J9e2XWJeuDubPd2kwGpmAaDwB93TsceeTglJWQ
         YGAzJ4UovgYawCdiqN5LN5TRTq1+CqS8TRnLZcjvLgKHPBbZikmaIiVUULFIMXLthXhc
         PKnScNSzPJs1ukbHO6evO21yTP3l2MM2VxEoIFCAZHNYEf7jX51H0dZbHHu8+rFvmKLf
         YrOZh9OoE2kdPHFcO5jB42DU6RvisJv2uCkoO+1jlpTu12EpQIB1AM5z7QuQInM/85Ck
         c3M5TiocsRTLoi8e6SH+n/xDKFc6vbIE7bSPnuIJWfKVVRl46R+PZlK1f2wo4H7HpVoU
         6zmA==
X-Gm-Message-State: AOJu0YwkWjp1zMljuB80N6Cg9yjtM/y2gPyfI/PsV4VQIX5cBH3WEhAz
	GFQ1g/KL+lRHDWmSXgDI8FulfVfW1QRXxidEQQ==
X-Google-Smtp-Source: AGHT+IFlXICmJcfbDSmoO7A7EUA6iVEF74betNl2k852/gxnaf3TEuSWEbGfjZQ7BNIH7NpUBEkFg+ungfm4ArnZtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ec02:0:b0:d9a:3dac:6c1a with SMTP
 id j2-20020a25ec02000000b00d9a3dac6c1amr73575ybh.11.1697739683357; Thu, 19
 Oct 2023 11:21:23 -0700 (PDT)
Date: Thu, 19 Oct 2023 18:21:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKFzMWUC/52NSwqDMBRFt1Iy7iv5iJaOuo8iEuIzBjSRlxAr4
 t4bXUJn99zBOTuLSA4je912RphddMEXkPcbM6P2FsH1hZnkUgkunhATebNs0JPLSBE8JlhX7YG
 WOdrunJ1JNIEBNdSSaz30StasCBfCwX2v2KctPLqYAm1XO4vz/SuTBQioUFVKNlw1Sr9tCHbCh wkza4/j+AHiV2SL5QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697739682; l=2821;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fmlQfhWbiCM67LS2nuJX0KI/1NzFMdegLgKJe+cta+Q=; b=wDUtP3Ror/d2KFXBRlN9RT2CDGzEW5TDMAgY6ZpEV6DYbx7hZuns1er9Wb2wR7lXEPmqCtncN
 RTkxhUuMmpTDTdSDV0A6ncnIw87LXyDFbMHjm6T7oMQfm5T/3jQHUTh
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v2-1-ecf9b5a39430@google.com>
Subject: [PATCH v2] net: wwan: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Stephan Gerhold <stephan@gerhold.net>, Loic Poulain <loic.poulain@linaro.org>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>
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

Since chinfo is initialized as such (just above the strscpy()):

|       struct rpmsg_channel_info chinfo = {
|               .src = rpwwan->rpdev->src,
|               .dst = RPMSG_ADDR_ANY,
|       };

... we know other members are zero-initialized. This means no
NUL-padding is required (as any NUL-byte assignments are redundant).

Considering the above, a suitable replacement is `strscpy` due to the
fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes in v2:
- clarify chinfo _is_ zero-init'd in commit msg (thanks Stephan)
- use strscpy instead (thanks Kees, Stephan)
- Link to v1: https://lore.kernel.org/r/20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com
---
Note: found with grep
Note: build-tested only

I've rolled Kees' RB into this patch from v1 as it matches his previous
review.
---
 drivers/net/wwan/rpmsg_wwan_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
index 86b60aadfa11..26756ff0e44d 100644
--- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
+++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
@@ -37,7 +37,7 @@ static int rpmsg_wwan_ctrl_start(struct wwan_port *port)
 		.dst = RPMSG_ADDR_ANY,
 	};
 
-	strncpy(chinfo.name, rpwwan->rpdev->id.name, RPMSG_NAME_SIZE);
+	strscpy(chinfo.name, rpwwan->rpdev->id.name, sizeof(chinfo.name));
 	rpwwan->ept = rpmsg_create_ept(rpwwan->rpdev, rpmsg_wwan_ctrl_callback,
 				       rpwwan, chinfo);
 	if (!rpwwan->ept)

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-3f620aafd326

Best regards,
--
Justin Stitt <justinstitt@google.com>


