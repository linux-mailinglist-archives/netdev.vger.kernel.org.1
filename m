Return-Path: <netdev+bounces-43981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF5E7D5BA9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6DCB2106A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482B3D967;
	Tue, 24 Oct 2023 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQLv97Go"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835073D386
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:40:21 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58A10E3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-357c8dbac0eso11511595ab.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698176417; x=1698781217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK7HYXOmQjB7hEtR++TIYejmFfYC8wV5bUXlKm+PDXs=;
        b=MQLv97Gov7YK5Hngw4v6fAyBzQmXyq1w8+mp7F3q7w7uHO/zAvwt60y12RUxViOpmj
         O+cBBNRXVBTOeuj0dGdmPbxhfqDMtAN7XL4s+0yCSidLO5F51rIIUGKcyMCtXKT2lSMQ
         rKIBjiAvju9bdCdJuneCPFDGkJMUb2fVVlqIYp5Ls3Ds9IOuqL0ouDGNvmA/UsXp7njJ
         OLfFBmPClkiUnyUiCgfkbn7IGvsY2TywmwNtRLUkTdB68D1S64729PQK077whO5Vvlaw
         oxJgtFhujtE8pggE+wT3hykGKAhD6mIec1+Q8sBwHO4/LNVyBsTyhGlwugYr7/lak2rt
         MK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176417; x=1698781217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK7HYXOmQjB7hEtR++TIYejmFfYC8wV5bUXlKm+PDXs=;
        b=QKNV3vdVFNFNh/jCnSUv1iUrYdhkoUM7jTihhsJb3FVjnm29TocMACiowpzYvcqgvK
         DscRuUbOPoxhQPtQoegLyPprQcxvIbxlGxecUIcUeohfwZtI2RSKmy523bXeEicRVbFx
         9V9P0zbAZW05rN54vg6qiNKCkeC2lyjjUEi3ghOvOjgRGPat08lNHgku2mUfSpSsPv9Q
         RG6iZfZIWFYaGQUE+OnDzqGHYQ72sMaCUhXBxy8c65zxxTC3031B7XarqziYxceVOhn2
         LJSs61qYXzjoGtVZq26LRitvBC4O/rrthK23jPjbhpib5zZ6d4vy7MTiUPChW1F0cvPx
         v3Rg==
X-Gm-Message-State: AOJu0YwU+XNxmrWt5wg62SxXP8KAf0ZoOdoZlAXUs7xbKsruZbh1i0iy
	Q24flrc4l75yFfWs7TrFFnpNnKUk/3k=
X-Google-Smtp-Source: AGHT+IFGNEQ3FFAKx5mAokh5oZct5W/vgxXJSCkwCHwOYyZe8c6gyj94BCbNgEi5O103fU3KDlh34A==
X-Received: by 2002:a92:2a02:0:b0:357:f3ad:8925 with SMTP id r2-20020a922a02000000b00357f3ad8925mr1177172ile.14.1698176417296;
        Tue, 24 Oct 2023 12:40:17 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id s7-20020a056e02216700b00357ca1ed25esm2294486ilv.80.2023.10.24.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:40:16 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH resend 4/4] Documentation: networking: explain what happens if temp_prefered_lft is too small or too large
Date: Tue, 24 Oct 2023 13:40:04 -0600
Message-ID: <20231024194010.99995-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024194010.99995-1-alexhenrie24@gmail.com>
References: <20230829054623.104293-1-alexhenrie24@gmail.com>
 <20231024194010.99995-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f200382858da..d919380b1729 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2478,7 +2478,11 @@ temp_valid_lft - INTEGER
 	Default: 172800 (2 days)
 
 temp_prefered_lft - INTEGER
-	Preferred lifetime (in seconds) for temporary addresses.
+	Preferred lifetime (in seconds) for temporary addresses. If
+	temp_prefered_lft is less than the minimum required lifetime (typically
+	5 seconds), the preferred lifetime is the minimum required. If
+	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
+	is temp_valid_lft.
 
 	Default: 86400 (1 day)
 
-- 
2.42.0


