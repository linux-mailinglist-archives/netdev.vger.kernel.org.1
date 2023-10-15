Return-Path: <netdev+bounces-41090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48A7C9999
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 16:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D0281858
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D0748D;
	Sun, 15 Oct 2023 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6yPekSb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172C11702
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 14:32:17 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2BC5
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 07:32:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee40de8so743454266b.1
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697380334; x=1697985134; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZqABTyUG8txZt8tEC79iuMajtb611J+ACZcHmeDQ3Y=;
        b=R6yPekSbrkzDvrQZ+HJFN3VKRLv5Z7l0kWaHwualUahsgkTibIXQiC5ihj5F1PBCFQ
         FQysMNZknofWmPgUjG59JeVVc0cXnMNmpiFeGXQm5Jg5yjRYE62W6qa42itEkGi6tVgQ
         Kovrs0ckSScUW1IhUyyLrYRxBVGbaclrmVYtkorccobYX4XWB1VjUIuT/LOOMytiXP2r
         /W2iTL1V+zgEATMxrZd5i9JOjkuUZ50kKDSvAIwQ7PR1q7zBk/aSiz9J7RMW632FKDHR
         6ySzn80NGJmxqN12Z3r/+g+3SRKuXwI0S+5ZM4w+rtgupIFSbuBJo+4qOI4hQh2s2tn6
         +wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697380334; x=1697985134;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZqABTyUG8txZt8tEC79iuMajtb611J+ACZcHmeDQ3Y=;
        b=efh5xmVi04f4UJUVhsU9eBIuFY+LTYjjCsHxwn4kkbKIcc/9kPEbg6NSL8OfjMLvCa
         oU3o/VLSmrdMY0U1G4ZnXRgly2mhzkzLHu4+7ak8ACln3bHxq5EiXVFkrw5QlgMoyZyb
         c6eeTvgf3w0zWtWLyUCYZnu7uey7lm2Oke3vAi6hHVQ7JW1FFI9zy5yofU+GyheHLUYa
         gXhE+552XPNFAZ+abdWhguiyDRBorVX4IrPLgQRD+sGO9QYakQJnJ27ygoPhrykZ6Mdc
         9vz8FetyZrqASZJf82qxvg4n5lIkb1lczVUcIVwy5X/HVLH+sIscNtKlm6vUMo+igzci
         RdEg==
X-Gm-Message-State: AOJu0YxKZO2gz0v2x1LGvSdSEXEjKM7uN7xB1+YIhaFtVqq2aA1g2s+H
	vQTCh9K8kCPlhJojgdxYIfz2VnV72RA=
X-Google-Smtp-Source: AGHT+IEx0cVqPgPp/zPNXv0t5MifUYA4HZG+zg+spaCfUZaMalPaCuZXg7BBu65dwZdL0vWaDozzfQ==
X-Received: by 2002:a17:907:801:b0:9ba:8ed:ea58 with SMTP id wv1-20020a170907080100b009ba08edea58mr4998702ejb.30.1697380333754;
        Sun, 15 Oct 2023 07:32:13 -0700 (PDT)
Received: from [10.139.141.58] ([146.70.193.10])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b009ae587ce133sm2367769eja.188.2023.10.15.07.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:32:13 -0700 (PDT)
Message-ID: <7be84294-b02e-4280-89fb-cf222fbf0239@gmail.com>
Date: Sun, 15 Oct 2023 16:32:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
From: Maxim Petrov <mmrmaximuzz@gmail.com>
Subject: [PATCH iproute] ip: fix memory leak in 'ip maddr show'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In `read_dev_mcast`, the list of ma_info is allocated, but not cleared
after use. Free the list in the end to make valgrind happy.

Detected by valgrind: "valgrind ./ip/ip maddr show"

Signed-off-by: Maxim Petrov <mmrmaximuzz@gmail.com>
---
 ip/ipmaddr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 176f6ab7..2418b303 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -79,6 +79,16 @@ static void maddr_ins(struct ma_info **lst, struct ma_info *m)
 	*lst = m;
 }
 
+static void maddr_clear(struct ma_info *lst)
+{
+	struct ma_info *mp;
+
+	while ((mp = lst) != NULL) {
+		lst = mp->next;
+		free(mp);
+	}
+}
+
 static void read_dev_mcast(struct ma_info **result_p)
 {
 	char buf[256];
@@ -286,6 +296,7 @@ static int multiaddr_list(int argc, char **argv)
 	if (!filter.family || filter.family == AF_INET6)
 		read_igmp6(&list);
 	print_mlist(stdout, list);
+	maddr_clear(list);
 	return 0;
 }
 
-- 
2.30.2

