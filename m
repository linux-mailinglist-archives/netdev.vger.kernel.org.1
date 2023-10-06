Return-Path: <netdev+bounces-38647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA057BBDD9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE2928208D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A9328A6;
	Fri,  6 Oct 2023 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLpyrw5+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BF2AB3B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 17:33:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF57C6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:33:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a20c7295bbso20032457b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696613636; x=1697218436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i3eyr1ScPVkM7UblKqU4I0ckQ7RDfTsWrFSesSv3dOk=;
        b=wLpyrw5+wg/vZUBAob3uIgK+vFlIPDSSCfHug+EIcEwkW2+yFsR1xZ0S5BJP4BSTK6
         qvEBtYeNgS9+BdxHK30w5ECuWwqPUhfJyMWoy2poVdjc/L4tZlGz6vgePEX8os2CoRv/
         Iwur8NetZghIB31qKi1wj+bLdPliltGbG69gXeNGQu1aEZeSNu46XyIRXYLjvH6b0Bje
         iB71BZZgjAOpBqP7kNgaCgaSjevJUG5PE2fWhKInma6S3OUhHoX2/2+KOtrishoC0P3N
         H23Uv5HPRsaNOzxdHSiOWmXGmZ0og35r37hA1ypDyzKPOUtjaZdVl8QjRwsqz/kceP/V
         BEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696613636; x=1697218436;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3eyr1ScPVkM7UblKqU4I0ckQ7RDfTsWrFSesSv3dOk=;
        b=Sh4uaxWAxeG87GfEB2K86JN27pNtO6dDbSlXe7z/DCJeetTa6h8WxknyqQlmjEF3DV
         cwgoVZrtdh31eJN5l3QYwNX+RqRfy5ULGqXMyhv3PyBHVlcnJ8Pfvbm1Jeq+a0ytq0my
         /+h9neNbzKYVjbKC0vjz/+Gl9d0/HQ3gRDDEHAJ2dHuPKnmzKCCdPfPEp9bKwF7KcTOY
         pqYYk+LlhZf1k/1akXfdBN28RaH/Rlg7MPCE/GfyUH9Rm5NMj6m4dOjyudLMa2cUwqXP
         4Gbir8MWNTu5Qjbcva0BPr184ch7vOsQRvAaJr/szVTKaVCgaD1EzWHoRfqzT3nywii2
         otYg==
X-Gm-Message-State: AOJu0YxX66Ylza/VKQhM3sa5oEOfixt+iF+caOCUnbgbaaJ0BbcRA3wb
	L6zXU63M9gMfNYk/BNVi8e1YmlLUq/LI1Q==
X-Google-Smtp-Source: AGHT+IEtevGE2WYXT52LwRNKXYwr0VJfvatoNg01o4o323Lh9z9x8n/N+/QbpeDPpiSzPqQtOtFEMfp3OTOqEg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7e06:0:b0:58c:e8da:4d1a with SMTP id
 o6-20020a817e06000000b0058ce8da4d1amr139702ywn.2.1696613636565; Fri, 06 Oct
 2023 10:33:56 -0700 (PDT)
Date: Fri,  6 Oct 2023 17:33:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006173355.2254983-1-edumazet@google.com>
Subject: [PATCH net] net: refine debug info in skb_checksum_help()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot uses panic_on_warn.

This means that the skb_dump() I added in the blamed commit are
not even called.

Rewrite this so that we get the needed skb dump before syzbot crashes.

Fixes: eeee4b77dc52 ("net: add more debug info in skb_checksum_help()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38b663f050410b9f7bcd32dd781951..5aaf5753d4e46c7c4b67b00daadeda9784708dfe 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3292,15 +3292,19 @@ int skb_checksum_help(struct sk_buff *skb)
 
 	offset = skb_checksum_start_offset(skb);
 	ret = -EINVAL;
-	if (WARN_ON_ONCE(offset >= skb_headlen(skb))) {
+	if (unlikely(offset >= skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
+			  offset, skb_headlen(skb));
 		goto out;
 	}
 	csum = skb_checksum(skb, offset, skb->len - offset, 0);
 
 	offset += skb->csum_offset;
-	if (WARN_ON_ONCE(offset + sizeof(__sum16) > skb_headlen(skb))) {
+	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
+			  offset + sizeof(__sum16), skb_headlen(skb));
 		goto out;
 	}
 	ret = skb_ensure_writable(skb, offset + sizeof(__sum16));
-- 
2.42.0.609.gbb76f46606-goog


