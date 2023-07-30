Return-Path: <netdev+bounces-22657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A01768940
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579B31C209DC
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1983168B7;
	Sun, 30 Jul 2023 23:15:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9B3D75
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:15:01 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBBE52
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 16:15:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9aadde448so3341322a34.0
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690758900; x=1691363700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQqHt2uxSiFtz5bvMHZ0lEIjoZsbVYU5ay8C1vE7uws=;
        b=I9YTzw1mLNgntSZUV8B1BAha2qtbMMvmRl65nC+Sy6n9PTk+HZ9u05IGG0C3v+Q/PS
         tO7bAFEcXhyEO76eJCkMoLUiTrs25DC/1pYzw4h15vhQ7lTrQ459+flWzmA70QeRLBu4
         iIrU3bU7eFWfm5X7o4jfkTubFZ/mn4AMn2ZuZ75C8ekoSy5Q4FN+0QhIBvYHbweoPhqg
         nir4CEqXqdvNbPPwlbMvtfkQYQeqvwW/Llb2SV7b8Qi4aWgh448pRUQOlXzoK6fBRdNF
         y5TPF/w5Ummrki4JYFNn4VdDHJ72dKtmGVk0OFsaOqgzQGqJ51aB0LSIIrLOcwzJnxIm
         6VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690758900; x=1691363700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQqHt2uxSiFtz5bvMHZ0lEIjoZsbVYU5ay8C1vE7uws=;
        b=bOryadLwVRGYICDeovw4D+oxXGCFnrLl3sd/Cg8jc8pKK6P+LszcqkEWCGmJkC+NZI
         nma+5xLGxcWbbd7bALIKNe3OeUQXhHSKVUZNkXZAAYbTdUWrhGUHK2yq1fTAR47YUGhR
         lf1G7bDhWQSUb6zP8shDZ0AmXvlekn5igwlkaQ0RK4VRaSzH0sHBCsVknOUvIUiT13LZ
         OTV/K56jMtfzJovPNqGxfHXWwS1LJO+oA6uC0oHFA2QXglWU/R5LLAKSW/BYvxldfPhd
         VWqSioslZByLAEDLTISlKDcyMK3n398aEoJFW0Kz8geDMWzm93ax3cDQd0CLs/VIT4+T
         8dBQ==
X-Gm-Message-State: ABy/qLaST6z4lAHkoODTsrWJ+bhotu772oFiEsQMve5EJLo3+tCSPP4x
	p2jOoeHr2b+UrkUxR/xzV/Yk6RAzKB9dcA==
X-Google-Smtp-Source: APBJJlFvXrPhfGB6V8m/F6oHt5/sxi7GjM+YN0/fVNHwFOFmb8Cyv1Wdzr3HOP1BVPMZvniCsJP+6w==
X-Received: by 2002:a05:6870:f589:b0:1ba:dbbd:31cf with SMTP id eh9-20020a056870f58900b001badbbd31cfmr8759888oab.7.1690758899652;
        Sun, 30 Jul 2023 16:14:59 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0066a4e561beesm6560867pfm.173.2023.07.30.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 16:14:59 -0700 (PDT)
From: Atul Raut <rauji.raut@gmail.com>
To: avem@davemloft.net
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	rafal@milecki.pl,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] net/macmace: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date: Sun, 30 Jul 2023 16:14:42 -0700
Message-Id: <20230730231442.15003-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since zero-length arrays are deprecated, we are replacing
them with C99 flexible-array members. As a result, instead
of declaring a zero-length array, use the new
DECLARE_FLEX_ARRAY() helper macro.

This fixes warnings such as:
./drivers/net/ethernet/apple/macmace.c:80:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/ethernet/apple/macmace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index 8fcaf1639920..8775c3234e91 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -77,7 +77,7 @@ struct mace_frame {
 	u8	pad4;
 	u32	pad5;
 	u32	pad6;
-	u8	data[1];
+	DECLARE_FLEX_ARRAY(u8, data);
 	/* And frame continues.. */
 };
 
-- 
2.34.1


