Return-Path: <netdev+bounces-62189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790682616C
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 21:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7464A283057
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9342E579;
	Sat,  6 Jan 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtmmDXwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA7F4E7
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso6360691fa.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704571831; x=1705176631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpJzmZ2WPQTSDYCdCFtmOhKa3kFmNdrH649wYncpyfU=;
        b=XtmmDXwULAY+piH3hmFzzuyUjZEeUK9+3PqanS0ZpG7OSEt//6sLNi5nQi2+BpGLNT
         1knDXIiWNersUpC6HzBwPAhPHzvrQIrKaKYcLIBxtHf8M0eChXPcyuKOzRL3fRu+VhII
         KiEtf649LN1BcDaT59paO65jgAWzfqSDuThGQ3/8DaJ8++3RBwAqCUN/jWQGSooLrKKd
         KZ7MPIhVO+Srh8t03V52IBuSUN/UZiSFUDWtrJtZWLHz0eSkMUu/ODysoIMwh49kydBG
         cJ+r/EHy5Hx2mvusX+3Wmdp0Y+/TXoVTTApD7Ho6iycYGBB1Lat2b0LlI0b40y6qWYfg
         musQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704571831; x=1705176631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpJzmZ2WPQTSDYCdCFtmOhKa3kFmNdrH649wYncpyfU=;
        b=A8yIDKfBiw/Bz56Rpc29yGSdjxmtPlNJp8lQ3ljvJ+nA0ruy2doS4IhjZbUaYObn4P
         +tFVAE67NsUm7nw2Zh6YtBn+3TbQSry4BkfKTKVL6lBZZbx9Cg/janTzSPFXdcN2daBY
         md9epCMGWoBMh++svYibxLIeYDgjUcgoLhpeMt79y/DH3gBJsaTGHYAn2wSH/Wstiqo+
         FFxMtT3MRTj1CRqFME5lEy8mBkxlbyBApRuIIgS+8hBwpYN1cqR5Wx9NVT1CuDAxkoCh
         duGRKRqBWObqxEGN6/IuqqC4xJkFxNf3b3RsFKH5XObNTBVQWl4PBoUZQsyJqLd7g8Mu
         SRzw==
X-Gm-Message-State: AOJu0YxYJmyWnRPfjb96OYjspSygbZX3/RripN3lCwAWrJEILX4IE08J
	4IXlucxGztjc5+9PadqZ85M=
X-Google-Smtp-Source: AGHT+IGwFxCM0PZvy/Ifow1Ovk5EdpTBecGcleWOgCqA6P/ayft2dZ8CWC5sGpgDnQuwv4jzheyDHg==
X-Received: by 2002:a05:651c:1a25:b0:2cc:72af:7cfb with SMTP id by37-20020a05651c1a2500b002cc72af7cfbmr576047ljb.26.1704571831179;
        Sat, 06 Jan 2024 12:10:31 -0800 (PST)
Received: from localhost.localdomain (89-109-48-156.dynamic.mts-nn.ru. [89.109.48.156])
        by smtp.gmail.com with ESMTPSA id k7-20020a2e8887000000b002ccec0a2368sm759180lji.12.2024.01.06.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 12:10:30 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ifstat: Add NULL pointer check for result of ll_index_to_name()
Date: Sat,  6 Jan 2024 23:10:10 +0300
Message-Id: <20240106201010.29461-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result of ll_index_to_name() function do not being checked for NULL
pointer before using in strdup() function.
Add intermediate variable `name` for result of ll_index_to_name()
function. Function result -1 when `name` is NULL.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 misc/ifstat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..e6c38812 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -129,7 +129,12 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 		abort();
 
 	n->ifindex = ifsm->ifindex;
-	n->name = strdup(ll_index_to_name(ifsm->ifindex));
+	
+	const char* name = ll_index_to_name(ifsm->ifindex);
+	if (name == NULL) {
+		return -1;
+	}
+	n->name = strdup(name);
 
 	if (sub_type == NO_SUB_TYPE) {
 		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
-- 
2.34.1


