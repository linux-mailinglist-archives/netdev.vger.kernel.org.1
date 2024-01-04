Return-Path: <netdev+bounces-61397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 855FC8239AE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1508CB238DC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05F7364;
	Thu,  4 Jan 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hFecHG0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DB185E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d4a980fdedso28996225ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 16:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704328311; x=1704933111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fegNStYMSCGXmYVs/XkISS3aeoEL+vQ4L5X3pvkIK70=;
        b=hFecHG0IpV4LdO0h4nBkgVTrnaC43lZit2NE5KXOgTztysWzdhFwgIvOJkWP8jolkJ
         JJ2PpgROa5EjP2K/2LwAjX1W2JK/Jj6IAzpUwc4vfsgbdHBTFXDkRDW9XhtfUV0j3wHY
         poRBxep5oFuqih+yLg2rEBeuWyLbb1j6qCa+GDOY/Zmr9wUU68S+O9X9b48kS1/7Fc+Q
         W60rnb9u/np5nOa4x1+lGCV+tyIB8+14JM48PMhBxK9Kqg8b9zTKQ3BqMJh43yYWbGFr
         9rQJbWauKzGqQbNhBbvNkemBjUWCt1F7u5vBEXkeDK3Nuxaa6Vw+wA1aYENJldy3V0xj
         Ri5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328311; x=1704933111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fegNStYMSCGXmYVs/XkISS3aeoEL+vQ4L5X3pvkIK70=;
        b=qBQqLAUdBAUQxlIrUqQVWX4ediZaZF8QbwEUbw6UhE7OuXrv1G5U1oPjHQAVyEi49F
         9ASUNnDno1LG2SCnxw2oaJ5u2KCfbFDsc1qOmzlFYxsEIhM8urHdBEoblRkxfKJxB9nv
         YdHKdW6bU2ErK0RId/jrKwvrHR62LJ5E1SsERIhtltX1jzllO6s+yrhMSz2Y20HY5A4l
         1+dr0oqysHBylL46vK9ASGu0agzMJSt/WWbvC3E5GNXWzDumlvm8xa0Oy8MztbVNdC7M
         OoyzEuXNwH/vgu1PdERxiir+ZMo95ccwT/xoiWBnGI5uq5u/DAQoKqNikBMuXNnD5UGi
         wVLw==
X-Gm-Message-State: AOJu0Yww/asgS6ngToenEVLXCQ3QjR7t81Z1pY3BeOGb03tOyYlgnaks
	rSh2t3DmgOJvb8oISebNHiaFe4Q3Z3Hs5JkhJ2vCVp3x4ZM=
X-Google-Smtp-Source: AGHT+IELTG60pZkzEbfYEj5V+T5QCPS/WTain5G5+3wnr71HIMfvj/HrIRX0uuYQKtgsZKwuN2Sq/Q==
X-Received: by 2002:a17:902:e74e:b0:1d4:59ab:36b8 with SMTP id p14-20020a170902e74e00b001d459ab36b8mr20513456plf.39.1704328311031;
        Wed, 03 Jan 2024 16:31:51 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902c78300b001d337b8c0b2sm24419002pla.7.2024.01.03.16.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 16:31:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ip: merge duplicate if clauses
Date: Wed,  3 Jan 2024 16:31:28 -0800
Message-ID: <20240104003127.23877-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code that handles brief option had two exactly matching
if (filter == AF_PACKET) clauses; merge them

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipaddress.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 8197709d172e..e536912fc603 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -929,9 +929,7 @@ static int print_linkinfo_brief(FILE *fp, const char *name,
 						   ifi->ifi_type,
 						   b1, sizeof(b1)));
 		}
-	}
 
-	if (filter.family == AF_PACKET) {
 		print_link_flags(fp, ifi->ifi_flags, m_flag);
 		print_string(PRINT_FP, NULL, "%s", "\n");
 	}
-- 
2.43.0


