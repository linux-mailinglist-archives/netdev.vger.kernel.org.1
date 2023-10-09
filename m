Return-Path: <netdev+bounces-39258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EC7BE88C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C70B2819E7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5138DE1;
	Mon,  9 Oct 2023 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT+JLvte"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D838BBD
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:45:36 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E184A3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:45:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8153284d6eso6431910276.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696873534; x=1697478334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJMcbXJ00xamkrBTzx3uHhqhQOKa6l6LGEaEK6gyhss=;
        b=KT+JLvtewnJlVx6OvCmKEA4L4q4pZMBpxbZ5bWzJJ+d0KoCUK9OFXYGqzs6N6uB9bw
         nLzQhLLIACr+UiTRwAsQ2exQ7cOmYKaDC1K4SqcWohJ37Djq8yhwTxDYxuaXzfEegBT5
         BT77cwyfVO32xjMahyf4P+aRMZwmTjkkZogYVRADWyjuDKFc7YOfcsSONslVNkK/boz3
         NKWj67Kon4tFohtbn8FRoTxo4RsebK7flcdQB0Z1nQX+oft23DSsjnEp2Pa70Cipekgu
         V2p0vumlHZR5Raal+1QL9MYZdiPi+DBZ3l0iF4Np/YPXhImCWSyjd0Y1dFlD0GnqCcRU
         drjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873534; x=1697478334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJMcbXJ00xamkrBTzx3uHhqhQOKa6l6LGEaEK6gyhss=;
        b=FXl2Sv/cOEvdp7927f2XLDcfSkCgL1GdVsklx3xPEAi3w8llenOyqlskoM4pQ1wZQ6
         P0Nx/aLzm/NWrTHXcpwTneaXv8Hqb1aVMivsFM0pU0TJeyynASpgllJjNQN9zpwjldIr
         +EgrfZfkxK+6odyp07j0SBR+NsHykuwktnH03tjXm1QXG2/k1VP7LtZtnM0ng47+mces
         S9XQp11sRuNsOc3WypGiajIhUyzf4itJadmJFmx1Fr/uCHu2qK2CZ9nGdz1y66G4MYfd
         xzL3cuRiJzc4uRPF4qvk28A+3F8jihmMBTLgMM53q2pC9w4F9z/A9ZdYsN015Yd48pgO
         OIPw==
X-Gm-Message-State: AOJu0YzoP8W3YVznTnfiPNpk1pv66tWETxywk/8vL/TZcBeHSPnZHTIB
	jvN0vxi6aLLvq13i6EgXM75UWiiRUFc0UGf24w==
X-Google-Smtp-Source: AGHT+IE7tymghJNtFEP71xug6O+7lVPRG/C/uX+9/uLwO7gBurZa8Tx5PJcoZPGZvI6LvbYRAVT1+k6vnPTSDu2QdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:870c:0:b0:d9a:3a25:36df with SMTP
 id a12-20020a25870c000000b00d9a3a2536dfmr30004ybl.8.1696873534723; Mon, 09
 Oct 2023 10:45:34 -0700 (PDT)
Date: Mon, 09 Oct 2023 17:45:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADw8JGUC/6WOTQrCMBSEryJZ+yQ/WKIr7yFF0uSlDWhSXkKwl
 N7dtFdwN98s5puVZaSAmd1PKyOsIYcUG8jzidnJxBEhuMZMcqkE51fIhaKdF3AUKlKGiAWwTEh
 7GChZ4xCGaGDw5hWSBQud9kLdus4rrVkbngl9+B7SZ994CrkkWo4PVeztX7oqQIB23ikupDLeP saUxjdebPqwftu2H8zbCaf1AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696873533; l=2189;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rM6KAt4nKSyIu5CIGMNGinHf3GlvjCeWH2JRJ+yYScw=; b=ya5WEHsKhKCZkEYwZpdgLyCPQhj6xLpDZPA5Qoa8ZjOcAvJXnXWyQJeSdlHbEnKh5PRgBQqhc
 LK7JbgGgbHhA8Za1Q1yBDoVGJwxeVsoaMSXxxhjeEN/x057SZY0u9ui
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
Subject: [PATCH v2] bna: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
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

bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
`manufacturer`.

Another implementation of bfa_ioc_get_adapter_manufacturer() from
drivers/scsi/bfa/bfa_ioc.c uses memset + strscpy:
|	void
|	bfa_ioc_get_adapter_manufacturer(struct bfa_ioc_s *ioc, char *manufacturer)
|	{
|		memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
|			strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
|	}

Let's use `strscpy_pad` to eliminate some redundant work while still
NUL-terminating and NUL-padding the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- don't use sizeof on ptr (thanks Kees)
- strscpy -> strscpy_pad (thanks Kees)
- change subject line + commit msg to reflect above
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v1-1-8dfd30123afc@google.com
---
Note: build-tested only.
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index b07522ac3e74..9c80ab07a735 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2839,7 +2839,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, char *optrom_ver)
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strscpy_pad(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
 
 static void

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-68f13966f388

Best regards,
--
Justin Stitt <justinstitt@google.com>


