Return-Path: <netdev+bounces-14468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59080741C8A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7A280D2A
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF2125C8;
	Wed, 28 Jun 2023 23:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A2125B2
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:22 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E6132
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7e6512973so740585ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995500; x=1690587500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPxDzV2U0MOwg+eeMRAAwSywoUmy+F8a1T+Z+8dx3g8=;
        b=mArH7AYssuifz4tpljmqlUJMxJTqnLR7Wfc0uFutrsVp5JqDq6pxMIwh+g/PKpc9Da
         0KCkGyGwRpPFNbgCOY8ru5r7R34Hc5mbxuRpokGN1Wp5VGp4kwrwP46a38tLy1l/s/Dr
         9g/1N56ArqYARZTLww/TfdXOYgAY76fmGC2gS3KOnJisyZGUXdQr4leTMRBYXCL9qfq9
         JNq5RY0DB5FKizOBlRyjaXbp1woHODGY4hpusv6R6lxpDgKZYgV1KOv1jAzvm1tIzsPo
         g5SeVaPD+uxgAZPXwGuFP4SZyhhkmr7byZstc+LbPqpUd6bKf/dhVfFsCAtwcktKKdNk
         lGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995500; x=1690587500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPxDzV2U0MOwg+eeMRAAwSywoUmy+F8a1T+Z+8dx3g8=;
        b=L1oktPO0/ufx8Nu6NpGPPNS2GFvQgfo7rGb1dpZ7pMDP/jV4ZvwI/B776vyW3g9cMk
         waI4AQbOTtoMrv9JTptw1GXBBOPBbNAjNIyWpRz52bSJbzuhe9JU82L93GC1Ilk4jfs1
         lJnSdnBtUoRsI3w6Sfd9pdEfH7SbrAJMMtBXusvyW3NjUys6IARIX/NkgqIBHz5zliw6
         wjUnPDZMqmPlbCy8ADrT5NO0ezILnXw7D1PUWt69YJKQvecIy6/mEo3dKjpwrH/DvYCr
         CHTg7Mc+R2NeXO/YyS8+MLEbLSdxyCV2TIIbe+YSyn5Nb1x3rRlCEg7g9vEc5RZWRM6Z
         6mrQ==
X-Gm-Message-State: AC+VfDxzR7b9E0F5gKv/dk48Cpfim1rrBqT86RIGJZewPY1Io7TCZTN0
	Pl2YIPIXbjFYBew0YyYNE3jdXssvRLjWq7JX8nhWbw==
X-Google-Smtp-Source: ACHHUZ4hpzw6lDhH4nn4itYicOklFyc/g/ajDdlXNbJQJdK01SyTztafYGFDlovydCpFjJ9AkdIllw==
X-Received: by 2002:a17:902:c40d:b0:1b5:5bf2:b7e2 with SMTP id k13-20020a170902c40d00b001b55bf2b7e2mr12244291plk.6.1687995500264;
        Wed, 28 Jun 2023 16:38:20 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 4/5] ct: check for invalid proto
Date: Wed, 28 Jun 2023 16:38:12 -0700
Message-Id: <20230628233813.6564-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628233813.6564-1-stephen@networkplumber.org>
References: <20230628233813.6564-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously since proto was __u8 an invalid proto would
be allowed.  Gcc warns about never true conditional
since __u8 can never be negative.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tc/m_ct.c b/tc/m_ct.c
index 3e2491b3d192..8c471489778a 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -161,7 +161,8 @@ static int ct_parse_mark(char *str, struct nlmsghdr *n)
 static int ct_parse_helper(char *str, struct nlmsghdr *n)
 {
 	char f[32], p[32], name[32];
-	__u8 family, proto;
+	__u8 family;
+	int proto;
 
 	if (strlen(str) >= 32 ||
 	    sscanf(str, "%[^-]-%[^-]-%[^-]", f, p, name) != 3)
@@ -172,6 +173,7 @@ static int ct_parse_helper(char *str, struct nlmsghdr *n)
 		family = AF_INET6;
 	else
 		return -1;
+
 	proto = inet_proto_a2n(p);
 	if (proto < 0)
 		return -1;
-- 
2.39.2


