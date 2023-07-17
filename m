Return-Path: <netdev+bounces-18374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E12756AAC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709632811E6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9BAD5A;
	Mon, 17 Jul 2023 17:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75F1FD7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:33:22 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9B1A8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:33:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb1baf55f5so25535385ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689615188; x=1692207188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeWuCmha6APgZv6+hobvCKzwBEwJFoiNN32Wr0uk5YY=;
        b=kE8SmMe6kjeLaSa9DyQvMZnTjCw1EmF9zfvtckMfrUsGO75jMvO7TGBQqtk8J6AmC5
         WQlR4T6WYRkl9GIeXfMxV1g82AxThAPry2vOvs/IYtYR1Q9l0hY+27Y/J4yMGA/Pptti
         eXNsHrLv/cdU+5rahuFOCipfhkTd5YoCXwALHmW4PQSqKVSFiaqY/4zYOyKpvqHWYhor
         MRQ1L28C7a55mI7BDjUBKHJNZSJyYBVBiYcHsIoLmsKqkxxlmT+sq/Paznp+0IIg2bSk
         hamu5d2h/YdFzHKaOI67P4rsSBZgWz/EnCUqmUdKIfyaBsUUXkTCcqXNegx+gbajSxOw
         RcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615188; x=1692207188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeWuCmha6APgZv6+hobvCKzwBEwJFoiNN32Wr0uk5YY=;
        b=IBjmKiYRrahSTkzZD9aD3D+r5OzDYr+ZSnxR9zUKlwuuC3WiKPtP4IM/240e8eSDN1
         enA7XQwzlc98LsLT99d1p83h4rE8WCRlSdJTE0j2tZ5uQpQZufvfPKShOKXt52NudLxC
         ZqjyBFj46Fg8yyZpGssJa0Jw2kT0v8Wanl0GFMMho1818Nk0l2i8Vje2uZexYyPjj2xj
         qRc1T5kxLeOgvTrNc8PrDq5+ciyaXBzrERl9gDAjl4fFKCHdKEhIO+csHJLPbzDDdMPx
         idGSlDBfWZwBUK+EkV+bGETzAbkQRiZgN0WCpyqCignZVE54UtReyX64HOTXLabk0yZe
         3MEg==
X-Gm-Message-State: ABy/qLZ6TkEDPSc2Rum4YZ9qo7qthSs3/FYGZzF+sc7drVp8HpCQDkoH
	mhYwOmktKkTyq8cXx2tU5G6zs9p5Po4=
X-Google-Smtp-Source: APBJJlFsjAwrIlrZ3ko279VzQfu1pPi6irZxbbFAuKXiIHsrZ/Ogj8++V4uFqZ7yxVPQnWEPtS5JRw==
X-Received: by 2002:a17:902:d490:b0:1b2:fa8:d9c9 with SMTP id c16-20020a170902d49000b001b20fa8d9c9mr15941127plg.49.1689615188512;
        Mon, 17 Jul 2023 10:33:08 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba10:d3ab:43ff:46b1:930b])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001bb0eebd90asm134318plb.245.2023.07.17.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:33:07 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next] mailmap: Add entry for old intel email
Date: Mon, 17 Jul 2023 10:33:06 -0700
Message-Id: <20230717173306.38407-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
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

Fix old email to avoid bouncing email from net/drivers and older
netdev work. Anyways my @intel email hasn't been active for years.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 1bce47a7f2ce..549e1c1ffe73 100644
--- a/.mailmap
+++ b/.mailmap
@@ -241,6 +241,7 @@ Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
+John Fastabend <john.fastabend@gmail.com> <john.r.fastabend@intel.com>
 John Keeping <john@keeping.me.uk> <john@metanate.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
-- 
2.33.0


