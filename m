Return-Path: <netdev+bounces-133830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502B9972C7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB5282848
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038901E1023;
	Wed,  9 Oct 2024 17:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198B1E1048
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493983; cv=none; b=cfWiE/ixBBujbGFP2rrr9P+QIajKeFAPiDLibd9gEJW5OcPVOJdzyUDHDAqt63kJfVn7ZPol089AAkRmF/Q4NhakVG8vs/hiLBPkZUwPihldBdEhmD982VtYDDkBIR9LIINOvZ18ipm6C4PL+3LHS0bjjR7q756uhATelJE14aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493983; c=relaxed/simple;
	bh=mV9UoZwzfuVfwKmqPyxPseIAACaJanldLJEFOK///Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPzWwypiHcDCezaDqkMLRLxxfElscCMQuWEcbF5tdMQgs3zwXChE2FcI2LxSFsxABfPWS+Xy21u0o5mGJOjexfQPqiRz7JAS6F4T6SuWAqnqQdtC6KQoNG9TucQeTFn2tEQcK7cUprBhFv18ZhFE9VI0DhynN1PEA5tgxBnQ3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso887965a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493981; x=1729098781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvyMY50m8Nk1mFDuJT9KU9oDV3vqLtu9+15otB+40qE=;
        b=LjNQfmjSvtSZxBIzTykp+RnL6YQ57Mh1V9DCcQmIJprw1giYzY+u++3IXRWUazqI+l
         5mGlrLBaip5+aL7HqqIszyv/HDaP0Fh4GJCvbv4MQhWHNVdzet7QU8wQX0FLz92tyDP5
         I9IUYAp5QMb0HeJKepZeaB2D7GMVbvQWNcv465RZhfF9rZPic6JFV0gQQi2DCBcWUUBX
         dxNTk0PqbwiCkcbjokMFJXxJiMfPdHoKYu57H8GAZStTn1wMKxpgaLJBnZ/Nbp0S71ET
         22V8ZsMN0jaD/J1XNMy8OeLlw7Qn4LvJU94GjDjTYp5W0b//NlafrkBoIAeY1ZbmBj70
         6aXg==
X-Gm-Message-State: AOJu0YyD2ZmctX1BXChVmYyMzexoUg4azHJ6WKttiBoXK3brL4jHJeVs
	TKxjjcozdiqD5ewQUsf+Zgu8C1NTI2odL02asyeZKKvSZGGXP1Wu1kJh
X-Google-Smtp-Source: AGHT+IGjRwTf8gO4ua+9tEu36aTSEZgpSVrkwsFxP88Jg2+gAPOEnStbpP5HOawmq3pD1MvoLBZLYA==
X-Received: by 2002:a17:90a:9c6:b0:2e0:7e80:2011 with SMTP id 98e67ed59e1d1-2e2c81ba38fmr504722a91.16.1728493981539;
        Wed, 09 Oct 2024 10:13:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f681d7e2sm8749802a12.21.2024.10.09.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Wed,  9 Oct 2024 10:12:47 -0700
Message-ID: <20241009171252.2328284-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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
index 9415dbd2f577..e53207045728 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -205,13 +205,18 @@ void validate_buffer(void *line, size_t size)
 
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


