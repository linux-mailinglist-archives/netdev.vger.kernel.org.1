Return-Path: <netdev+bounces-277607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEmxOTZ+2WmjqAgAu9opvQ
	(envelope-from <netdev+bounces-277607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E43DD4E4
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907123023511
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804C78F4F;
	Fri, 10 Apr 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="NpVxgzRC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550E340260
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861277; cv=none; b=ouPr0WplxeXNAmYfNEqwg993rgcAei8Em9plWK75NH0qxCCNVHFmcuHcVlE66NvCPcG9DxVptCu4lkRB3BRXLUdevG/V1m755RBa/rDadzk1TaVlCsvQFxs4VWXe+fLfn953J1T+ch+yC0DeWwhFbsVoLhiv4XDZuVJQYNsjObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861277; c=relaxed/simple;
	bh=1Lj8jTJZzO9AHNbL1S4fODooVoiEkCjCfVab5Xuzajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtFBJtXVBWOzuC39D7fIOoHlDLF8qy9hlaYVegk50jK61qiEj84QhM0SIUHtdQ0RndWDYKj8DMR3odTwG0fGkKfpruyYdTJQjxSiL05nSgL8+N0YbBvp0JiZ/0Ssv/h/0Dqc/4BEmCwE2Q0gLdmlJ5UdWGlAKHuaXCfi5bCMqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=NpVxgzRC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae146b604so18377945ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775861275; x=1776466075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/T4NAyBpXXt7e0KqwcEtqR1+BSMPN7JhX0W6/18kQU=;
        b=NpVxgzRCMyP/M8JvAYG3INllH6pv0khxoyNle1EyVpBB11/4bNqR+5tdicohQ6JcJ3
         yrtZNyAd9UR9PweUVsEjhAdVOlzGScjhLhV/xm9MfQ38yI7URQ3XqodPKbCWLMdzxJVq
         LJ1CwErP9qPc+QTiZCQqDXFNTGxVKWFWwd+lObNk5zE234JgHUogAEjFoO0Ok6B4ksxx
         FoYhjJpg2Dz0EZH6N+cfPCKZFHh/MhWlcKDamwEVCxxG8aywr1DAq8zi9ZzjwFmU1HBB
         QuQ0cbO2ceg9UAxM+NZSVOAPWQ3jI4/LhUZh4cykPPINT8LQshE5eHDRvNdWglYNQNOL
         7GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861275; x=1776466075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/T4NAyBpXXt7e0KqwcEtqR1+BSMPN7JhX0W6/18kQU=;
        b=fWUnU6XFf5ED+ZzmLMd0CucD9op9Iv9j9vwmwdktoQZxObWGpR07MJ91euxCp/Eky4
         N2YRpm6s+dhLd2TyD3vSjBKTK0gNrTz+ZF4cpvJ6t0tGI0rWl7oeLyONn69rDEod4gbP
         zNEMFDbVJQvDzHqv+9KcLi0+s2N8zXEZVEBgUMtI921Q/EasFRxbxA7dBjDdFOIW+wWD
         lolL2D30awtA5X3DxCil2X3y6WQb533cOSzCNQZEImCpK2pFZfoyVGtn/pSqFRgXuyDf
         rwZbyhJ2LINq3T1nGBFWmCvvITOb4YoNke32YwU2zUFupM+LSb9qzBcNGGrCIRKSHxcj
         yAMw==
X-Gm-Message-State: AOJu0YzkrtbApPPPnWie3xCyixt8K8wADJmCGhEqRJuEPeqFrYhGhpuE
	bwiu08TWmixhq28itmFru36kT1rZpZSLzgc+ICQTidbWhzsyegonywF0k4pOgLNCq+IrnJPKkP5
	IAQkN
X-Gm-Gg: AeBDiev8t+2BsakC8Z+RjMIjQNj/2qy5pU84vQXLZ9nlOE2DzF56v2TW+cz99W/HOXy
	Io/z29tBoahIt2Xvaf7Y6s0iVBbLle1WkIA0Hsl1msap3q0HKYUXWSGKdqt6oenCVKLQrgZgkrA
	mvZiMagj5VSbXLT64bv4kBa/TTvTZKf+RidPno0qW61TedAtnyoAvMzVkl45hd3TH1oJM4ONW8K
	3t6xDsYlcvdR56mLXUZ9F3iiuPg+Dl+vuvkmd3jntiTqPYey36O7qGFiEkhbH+3Sp7X1u5xpF+l
	sTi5m6zh1YFFdhOeT5rA/mlUQtXHvCNZCIMtCm8Keshb/G5OOmsvatFvxQgUSgFGV77+dj0t4ve
	uM2g7h+1luxwpTa4P2DWY/i//TobBcO2dKuDUa7jMqgA2c/N31NIEow7PB/BqEGRp2irb+RK3QS
	JiX6hOTDbhw7dwDkmaqW5iMqPE1AUaNE19umJd2SpxMKI=
X-Received: by 2002:a17:902:cf08:b0:2b2:6df1:1108 with SMTP id d9443c01a7336-2b2d59a34bcmr51388205ad.15.1775861275440;
        Fri, 10 Apr 2026 15:47:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f099d6sm51025295ad.50.2026.04.10.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:47:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute 2/2] json_writer: fix builtin test code
Date: Fri, 10 Apr 2026 15:47:45 -0700
Message-ID: <20260410224745.93416-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410224745.93416-1-stephen@networkplumber.org>
References: <20260410224745.93416-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277607-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4F4E43DD4E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The code under #ifdef was not generating valid JSON
and it is missing test for control characters.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/json_writer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/json_writer.c b/lib/json_writer.c
index 7202621e..d4a1c72b 100644
--- a/lib/json_writer.c
+++ b/lib/json_writer.c
@@ -369,7 +369,7 @@ int main(int argc, char **argv)
 	jsonw_null_field(wr, "my_null");
 
 	jsonw_name(wr, "special chars");
-	jsonw_start_array(wr);
+	jsonw_start_object(wr);
 	jsonw_string_field(wr, "slash", "/");
 	jsonw_string_field(wr, "newline", "\n");
 	jsonw_string_field(wr, "tab", "\t");
@@ -377,7 +377,14 @@ int main(int argc, char **argv)
 	jsonw_string_field(wr, "quote", "\"");
 	jsonw_string_field(wr, "tick", "\'");
 	jsonw_string_field(wr, "backslash", "\\");
-	jsonw_end_array(wr);
+	jsonw_end_object(wr);
+
+	jsonw_name(wr, "control chars");
+	jsonw_start_object(wr);
+	jsonw_string_field(wr, "bell", "\a");
+	jsonw_string_field(wr, "esc", "\033");
+	jsonw_string_field(wr, "del", "\177");
+	jsonw_end_object(wr);
 
 	jsonw_end_object(wr);
 
-- 
2.53.0


