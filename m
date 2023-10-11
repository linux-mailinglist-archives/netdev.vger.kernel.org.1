Return-Path: <netdev+bounces-40150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725727C5F51
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B9D1C2097F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FB2232C;
	Wed, 11 Oct 2023 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsL7rKbs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD51BDF8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:48:42 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC7A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:48:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a61f7aaf8so347424276.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697060920; x=1697665720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fmgja0bLa+jteMFhSajUsHxegsUDbMvKhEZglRqt45Q=;
        b=wsL7rKbs/MulTCGq7SLJxQqpb+ep5Soiu+13mphubbPnPScNBdl4FUKSdjQNnLGZsd
         JxE+cMV2D/PELRJTwMJna7YWX1QtrIxpUBb/ZZUn60pokcKtxREydkv69xLgZdRtDjRa
         rmy4XCKskBB0ZY80ZA18i9vXWwS51ZAPRQPjJJDiqdtimvb09w+FMsWiVMG1lbwVFlqf
         a3it/hR317J48b2nwFksgweF1h+PqcsjCRATItiS7TAM2gSbTWgVMLzaaAq/ail5JRxg
         fKErnlMz5RTtH7GBfo6Nv5JSH5FnqyQgWLIJZmchCtfTTApDBnCKn9F5BfGZ8+dLjhlo
         C14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060920; x=1697665720;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmgja0bLa+jteMFhSajUsHxegsUDbMvKhEZglRqt45Q=;
        b=OIbWqBnwXJipTXw48Ijhp2wFEKkdT/cSzYI6FYPRrVNZOxHOnkhYZFsu3n7cSMzt5W
         x5iyOSs0TGgwgDbe8jFc7n5qQBzCvw7sDtaQOkP1BoRIIWKeuziUpOIcvttSi6ZJL3o8
         kjskizI9aB40rOCCnPTS7g+vF4YjWBHtxnpkoGjdT9fcfRo6i89DIdUZRvpvtlIMKo4N
         257K2OllJGk+4cPPBdj8Z+E6n8iSj/wltKfDE0MDVLNjcA/la20CQ4LXwmPbeT+rTYvo
         TYo8E/YC2UODRFugqGdVu4rwubs/JSRbYoyVSO9vUoFXZGBWKFQFvGsH2CCiNA/IAPuL
         uhiw==
X-Gm-Message-State: AOJu0YwBluTSAZHGKweAMB2Y4FMDNhe+YxSWzG8IQt3/33ZTc2cx2cN/
	TXf3frYpIAKRTe1wtfcw83jEoFTqw1VelVQztw==
X-Google-Smtp-Source: AGHT+IGJoTG4b7zDPCsibXJpxnlw6jNvBvSJLdFkY2BSvTdOPSvUCRCdC6zVI4G66sLlVvOY3vTtDT7UkI8II5FbKQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:870c:0:b0:d9a:3a25:36df with SMTP
 id a12-20020a25870c000000b00d9a3a2536dfmr177263ybl.8.1697060920492; Wed, 11
 Oct 2023 14:48:40 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:48:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADcYJ2UC/x2OQQrCMBBFr1Jm7UAnRSxeRUR0MrFZOAmTtCild
 zft4sF7q/9XKGJRCly7FUyWWGLSFnTqgKenvgWjbw2udwP1RFiqKecfeouLWEGVilInsV0aljR 9BDXkHU52+MOkpNlYkJFGcq9xOF8Ce2g72STE7/Hhdt+2P37e/baTAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697060919; l=2791;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=d1CwcSoXBknLIhkv+OR1VBIGF8nQz/k16YwYlTdC9Ds=; b=OX8CmXZpnCy8ywuesrOENMy2j4fqvuDPmBTZziT688Z17/BOW8xmijt701YYwPkN1Ws6XyooM
 RgXZMOR098sC456O0B2+zgQidajVjXgp6fBUqs2vZ/7XEhUvTT2W3s/
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
Subject: [PATCH] nfp: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Louis Peens <louis.peens@corigine.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect res->name to be NUL-terminated based on its usage with format
strings:
|       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
|               NFP_CPP_ID_TARGET_of(res->cpp_id),
|               NFP_CPP_ID_ACTION_of(res->cpp_id),
|               NFP_CPP_ID_TOKEN_of(res->cpp_id),
|               res->start, res->end,
|               res->name ? " " : "",
|               res->name ? res->name : "");
... and with strcmp()
|       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {

Moreover, NUL-padding is not required as `res` is already
zero-allocated:
|       res = kzalloc(sizeof(*res), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) rather than (dest, src, SOME_LEN).

Typically the pattern of 1) allocate memory for string, 2) copy string
into freshly-allocated memory is a candidate for kmemdup_nul() but in
this case we are allocating the entirety of the `res` struct and that
should stay as is. As mentioned above, simple 1:1 replacement of strncpy
-> strscpy :)

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
index ce7492a6a98f..279ea0b56955 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
@@ -159,7 +159,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp, const char *name)
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(res->name, name, NFP_RESOURCE_ENTRY_NAME_SZ);
+	strscpy(res->name, name, sizeof(res->name));
 
 	dev_mutex = nfp_cpp_mutex_alloc(cpp, NFP_RESOURCE_TBL_TARGET,
 					NFP_RESOURCE_TBL_BASE,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-1812b8357fcd

Best regards,
--
Justin Stitt <justinstitt@google.com>


