Return-Path: <netdev+bounces-43375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0DE7D2C31
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F14B20C49
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E14408;
	Mon, 23 Oct 2023 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVXDWHT0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1915BB
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:06:37 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D6A6;
	Mon, 23 Oct 2023 01:06:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-27d8a1aed37so1006501a91.1;
        Mon, 23 Oct 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698048396; x=1698653196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRIXdf5CP5zvIEAZi7GHLHlgb7w/UotV/3iHHaEc8qo=;
        b=TVXDWHT0PvaM8OfkV0TrTCQrxE91NP01J2YxpQjWuPF9Tcz+wpJnVv3dozCz/zGP74
         kv1qXO7WD5rrJjjtHMeahvZtgPTTySKYE18AOHR/aV3Jem/QcnFfdqMg57uiNicfuN7K
         vRxTkDbLiyda5tAs1FADNe1o9mzGLCINTb1q1KoTUQ4Q1/7NzomVys2JA/+v6sIlJ9Z0
         nefdhpGJ7OgoUIfx3d+HHzyV0LK42UHzzxUVWBMX7eBPfUMZHDIUFwITA0eJ2rSRxYXp
         8VCB7f5oTt9C1V1lBmOCTiohex8cjEUjsIxXLHaupr5YFV2Rc5hu2qGRh404QfRoNl86
         UrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048396; x=1698653196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRIXdf5CP5zvIEAZi7GHLHlgb7w/UotV/3iHHaEc8qo=;
        b=dxm+Z++BZ8rhqnOI+8OJG/x4GFCGxNkfYUs8PeOIk8sIuWssqzgVUUQQJRUiL2RKeN
         52u/Wb0sHs3yzdM2tMMS0IMoWo/AHUNd/KffdXJcxJteNmhWJKtOzmWlRywQxM3nGGB4
         wLX7ENhp026bKExGdt9PsMJkmh5j9m+M42xF+AB6Owm0Zn8JXlvnNMHwNpiDhsD/rXyr
         6VRzGLNehkNkMXqWKfuQsPnMrLEH1siYE0Reg0AGF/TqPCKDPJkPEsq0izyB0MeXJisZ
         wEP8A28+5gtisOD4iHwFmCWJUK05ORNtoAZyLPRxxBH4di12I4xHe2lRSR+EM8vftySP
         Q7dg==
X-Gm-Message-State: AOJu0YzNLZ63vwC4smQEYRnwv/dAGmtGb5hl3WCYeXuJdggeoY6LqqZO
	ba45cp5NLggb8Fz+Zjtnt/JBEp4g0xWkHVM8
X-Google-Smtp-Source: AGHT+IGBTbnGthBAJRHZkDEaadnOunpMjviyIJfUVy0JU+Q/OPGx90xydi3/YKHR3zLDSVkRc01qOg==
X-Received: by 2002:a17:903:3313:b0:1c0:bf60:ba82 with SMTP id jk19-20020a170903331300b001c0bf60ba82mr7867245plb.5.1698048395706;
        Mon, 23 Oct 2023 01:06:35 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001c9b8f76a89sm5422634plg.82.2023.10.23.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:06:35 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] net: tls: Fix possible NULL-pointer dereference in tls_decrypt_device() and tls_decrypt_sw()
Date: Mon, 23 Oct 2023 16:06:11 +0800
Message-Id: <20231023080611.19244-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
with msg being NULL. This may lead to null pointer dereferences in
tls_decrypt_device and tls_decrypt_sw.

Fix this by adding a check.

Fixes: dd47ed3620e6 ("tls: rx: factor SW handling out of tls_rx_one_record()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/tls/tls_sw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e9d1e83a859d..411bf148f707 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1612,7 +1612,11 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 	struct strp_msg *rxm;
 	int pad, err;
 
-	err = tls_decrypt_sg(sk, &msg->msg_iter, NULL, darg);
+	if (msg == NULL)
+		err = tls_decrypt_sg(sk, NULL, NULL, darg);
+	else
+		err = tls_decrypt_sg(sk, &msg->msg_iter, NULL, darg);
+
 	if (err < 0) {
 		if (err == -EBADMSG)
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTERROR);
@@ -1686,7 +1690,8 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 		off = rxm->offset + prot->prepend_size;
 		len = rxm->full_len - prot->overhead_size;
 
-		err = skb_copy_datagram_msg(darg->skb, off, msg, len);
+		if (msg != NULL)
+			err = skb_copy_datagram_msg(darg->skb, off, msg, len);
 		if (err)
 			return err;
 	}
-- 
2.34.1


