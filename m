Return-Path: <netdev+bounces-136299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61549A141D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A24283C91
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC242178E2;
	Wed, 16 Oct 2024 20:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FB20E03C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110873; cv=none; b=MHghIYaOB78aYjfJc20TvWKHfYoJycAxUSdAo56s98cAAvOeMOWZLz5zLU9wRhbj95Ipv2pI9YtDmChSTFM1ZRQhPRYCdxTq83ay1IlMKwIO973Dy2pp4uJ8AEKmP7SHHNz+rgc6lrE1z8hw7BK32TzIW85EnVZ4Us69+sfh5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110873; c=relaxed/simple;
	bh=3mX7i+o9PdCgDsWAnoDuKyaOYjyn7a/RR0oQs9D2jbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXzyYORY8gSSjcWLT0MVJaNV1dW/687Df/tuM9oVNsSTJ2DgcB7jAJFE5JBx635O709VYvqgM/SU0t2NUNHjzxZoiCx629B3cPUa8spBYkptVkpM2uKE0A6NGGKXxxHm1WqDRokRcBkvdIhWw6aWKMAb73M+Agugf+IkArJcCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7edf2872so10974885ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110872; x=1729715672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmAPVeQtxKlas4UeQ/0q6EGku8blOEVAdXtysxUboDI=;
        b=JMsfjCEGtoox4cDxHMa3MGqwA/+apE8z4qMrCPlvl3V5lU6XfI/IUS9TyhhuLjYCq/
         X4pGwEERs4P0PA+v4buO+71EtSH3gYJr80UcskumNZTbZYaz9wZqhb5wNG+BYL1iholD
         TPN8iJi0SAAlo3zIjMxzWIeMQhygOPmSLNpkzqHqVShoM/LncTc9UklSYAiWL1G0dmga
         bLxPOocvJ8dfVpHry0BH9GN7FOe2vLy99Gayjmk1G26j772Qzhqlsxv+ZQjXKw0cIm+g
         tusS4jO5ppmkVct8vJpyz0bD8lFVvZ/UTJStxHcGW0iSYFhjHG5p3MCJeGEMfwGv4V0p
         fxFw==
X-Gm-Message-State: AOJu0YwI3pTYwLKxeem4AwC51twzSA1WFdp1AzfGAPKCBRJfWft9W3xa
	mexp0lU6durVeY5f+rXROypsdMHmt6iyQJVzY/OMdmI7YSpVI5q6DXYn/xM=
X-Google-Smtp-Source: AGHT+IHEdMpapW8H4ORDO1Dd3NnXR5yLQ9O8IoRmk3Ft3MLPEXI0n5eD0UUiq+mnOtTdNi9omrLkJw==
X-Received: by 2002:a17:902:dad0:b0:20b:7373:67a6 with SMTP id d9443c01a7336-20d4793a99emr11822815ad.18.1729110871600;
        Wed, 16 Oct 2024 13:34:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d3f8sm32556315ad.80.2024.10.16.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:31 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Wed, 16 Oct 2024 13:34:17 -0700
Message-ID: <20241016203422.1071021-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index e420d5d513c8..f67ec0dbaa9b 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -217,13 +217,18 @@ void validate_buffer(void *line, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	/* Depending on the NIC, toggling ntuple off and on might not
+	 * be allowed. Additionally, attempting to delete existing filters
+	 * will fail if no filters are present. Therefore, do not enforce
+	 * the exit status.
+	 */
+
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.47.0


