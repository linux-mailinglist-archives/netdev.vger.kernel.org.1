Return-Path: <netdev+bounces-57773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97068140CB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787661F22F2C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64063B3;
	Fri, 15 Dec 2023 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVABXgOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39A6AA7
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d3846fac9so1171795ab.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702612233; x=1703217033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uOKBBoilpdDW/I1En40Jw0ZBPzf42DMJ93AEyaszfI=;
        b=QVABXgOYLNL4Iepck7ceSdRCl6p7dqOvr/iK6Ld28U3ykwOUza8HK/p3ZAomEghykl
         /Y61v/tFZzB71m5VmP9LHjwi8wfQy3zm8cVhP3GpM09Aa74mnRi29Msm9j4ALxaj58hW
         cX6ZmhqSPJ14+RxZ4t01bc7ckt+HpTsdZOgozjqLn8dsFrMQnLZGJMT5eOtR2Mh2bcMe
         OYkYmHF9SYxYMeFgsIueQz8Ek36uO4Op9eXU6vGCbSLK5trY/tnqjHOsLkrd2l+ioZH2
         z7pH0P8PpmiRWPzpeMYEY/IB3RppmSVlzbqP6QqRnZT4ImuNq8tIfOKRnXLfSxwqA2E6
         h14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702612233; x=1703217033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uOKBBoilpdDW/I1En40Jw0ZBPzf42DMJ93AEyaszfI=;
        b=agL9UXt2M/t/JCakmnHtMD3AnvmOKc2++1NcFM4yMx9tBVP0tEfOamIKdYUHmvLkOq
         4tBXctLvO40XuM5l0upcQnZX9h6N/6JYGevLh13EhnzpppRq51fEkLewxnhc6og+hgKA
         yfpjRZIjMDYGbUoDyQwBUhCyAAti3Ru+5UqtrMk1wCK4LofJdRmkeweEzDFl7j3+4WJt
         qWScKX1CFPMyE2Y/E4ncyklvB6CUtpAmttzO6/Wxpp7XXaAttud6GUPEd0yhYnFaibF6
         idI3VN+HB/RcIHfRHn1YQ68WW0gHcIc0de6zafi4yqkFE4RFjDCFLhW+eROuiPJVF7SF
         ylaA==
X-Gm-Message-State: AOJu0YzNdavG8XuTel1XLHFxIzgPUkJ7MJujDXh7m4oM4ddgDV0RuJul
	zSz8EhOzamtdvgDv/kHDZjE9EMhJY19TiT8nJzs=
X-Google-Smtp-Source: AGHT+IGr6oWbasUQwVOLTW7raSHVBiARrwOOeeB4xBNAMH7TUiW2cuhSZ9h3dCa8/WIBy1J2SNcC5w==
X-Received: by 2002:a05:6e02:1a89:b0:35f:87c1:1071 with SMTP id k9-20020a056e021a8900b0035f87c11071mr1472217ilv.46.1702612233448;
        Thu, 14 Dec 2023 19:50:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d06ca51be3sm13124483plf.88.2023.12.14.19.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:50:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/3] netlink: specs: use exact-len for IPv6 addr
Date: Fri, 15 Dec 2023 11:50:09 +0800
Message-ID: <20231215035009.498049-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215035009.498049-1-liuhangbin@gmail.com>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should use the exact-len instead of min-len for IPv6 address.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/fou.yaml   | 4 ++--
 Documentation/netlink/specs/mptcp.yaml | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 0af5ab842c04..d472fd5055bd 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -52,7 +52,7 @@ attribute-sets:
         name: local_v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer_v4
         type: u32
@@ -60,7 +60,7 @@ attribute-sets:
         name: peer_v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer_port
         type: u16
diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
index 49f90cfb4698..2f694b79c3a7 100644
--- a/Documentation/netlink/specs/mptcp.yaml
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -223,7 +223,7 @@ attribute-sets:
         name: saddr6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: daddr4
         type: u32
@@ -232,7 +232,7 @@ attribute-sets:
         name: daddr6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: sport
         type: u16
-- 
2.43.0


