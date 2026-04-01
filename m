Return-Path: <netdev+bounces-273821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHKEM6VzzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7F37377F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6BCB30E4509
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724E29994B;
	Wed,  1 Apr 2026 01:19:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0656283FD9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006373; cv=none; b=YXu9yJmNsxrj7LrOqWfXxPSlIxGDZWBpD77e5d4bHaZadLKpIne13Qkw/7j54V0/IG7DbQg50Tf3LjNMge4LkZATTYSu+hz4fqgya5NFlOwHrVSBPIWq/JGnbW1he9BxyxKteNVvJCxQp2vNXPm8FdHKaFJ/wcxwM8L5Pm2QDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006373; c=relaxed/simple;
	bh=k/3sbpt2eNknMH23oP8xz8SSUBFNLF64+N5JA8TOB4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx4kHaKtrilK7VF+WQF9nJD8ldAzxkTqpRc2RsOTbi62HOKjcFB7bIprPsHsSXMNYrXLdxE8+qFqL+VDdsxFddp/LzWPgk+b9FgFrMe5Pw/B068lENMHWL5yB1xOA9eR3x4eoetsD98Jbokv0UFDLMPuvp7zcKCQtVRQNCDUlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so1529167eec.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006371; x=1775611171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTy14OCBgTmafJlMKuLv4J4RSF3bm1JCEeeYuKUNpns=;
        b=Zs47o3hVVP4C7cJZClkiQXlDZXjoM28/ySAE5CVNvkqIQ+0SKprYKYMWzUzhRYjamv
         Sb+pk/pLzu9Nv+xua7vMcUAQ29/QSlqh5+/CjzOngf3Ra69H2826zlCBTa9LThiUzsbE
         Q412n/3glvCFWX07XRT+4VQ2axTg/AfTaUUVHRaB6JzrIlWrcACZnKDGcfWzs1tWi1+U
         ECYegi4ZnMZ1brOpnN1yQxsH9DB7NnzGmPInnfFXdHrTdfOojdU8JZqKy0hcSsHyQ8o1
         zVGCX9f6bs4TuzYbuY6gfl6LOfSYAY+6Gn7KD31moGUr1CUW2UPVJZ51AZEbWA4bfY8J
         YwQg==
X-Gm-Message-State: AOJu0YwGeQ3b9RVdxtVbM0UnhQoNZ4/Fu7NB9mTkD/1ROCpHlw3J97EE
	TfvvSKqeLA1fEZqSUVpl+mvw91AU0l0uq2DeVeqJ1hvpwy0xeioFRk+8Jnv0
X-Gm-Gg: ATEYQzxHoM8b8sIX7GxWY+Es74zw3iNCx+3hUGzTqhv9V+YlEAXc/GVGMN7cjRAD9Gp
	6TBE9ypYXJhpUNvY3dqVU4Aq7QZVi4qaKNU1BPnwJyIn6813uuPYnfIZDBxayVAl0U6Qbd9uWZi
	CXVLkUjGGazJYI1bB85JIpm26tnsSWGiWv9xS/EPXJNUvBZK1v3cEiwtAhIeH+2hna9v9zuStKD
	8PP2myCtJ7Dy5Un47QFM0CHBu3hMQOo9GLr35st4Ri8UXodUbj5uGfP26qK342FW26RVN/wZha2
	J/W5ihq6hhgQBNPVn800Ineik4bGQc5VDPAQ/d+e5ufexU9Qa4xDj8hv1sZyXiv0nU7HDttbohP
	60AJaML1decyRyx5ZlRlCGSf+3+gqrEswjk/atJbIpk35uscy8u2UFLg7h8mGFvJNdwhMMoasW/
	9AG1l8gcLe4vElVCAqDnfpFe46+qF26jIx6MoWq9yaUcqFxVqd427PbIJXrixEK7nx5mf/RDL0F
	wE47FMoQbrrE4nUMG/JcueF9zSE
X-Received: by 2002:a05:7300:5707:b0:2c8:bf0d:74ec with SMTP id 5a478bee46e88-2c93098638bmr934571eec.4.1775006370704;
        Tue, 31 Mar 2026 18:19:30 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2721sm10761725eec.14.2026.03.31.18.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCH net-next v4 14/14] selftests: net: use ip commands instead of teamd in team rx_mode test
Date: Tue, 31 Mar 2026 18:19:14 -0700
Message-ID: <20260401011914.1716692-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401011914.1716692-1-sdf@fomichev.me>
References: <20260401011914.1716692-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273821-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49D7F37377F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace teamd daemon usage with ip link commands for team device
setup. teamd -d daemonizes and returns to the shell before port
addition completes, creating a race: the test may create the macvlan
(and check for its address on a slave) before teamd has finished
adding ports. This makes the test inherently dependent on scheduling
timing.

Using ip commands makes port addition synchronous, removing the race
and making the test deterministic.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/bonding/lag_lib.sh    | 17 +++--------------
 .../drivers/net/team/dev_addr_lists.sh          |  2 --
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index bf9bcd1b5ec0..f2e43b6c4c81 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -23,20 +23,9 @@ test_LAG_cleanup()
 		ip link set dev dummy2 master "$name"
 	elif [ "$driver" = "team" ]; then
 		name="team0"
-		teamd -d -c '
-			{
-				"device": "'"$name"'",
-				"runner": {
-					"name": "'"$mode"'"
-				},
-				"ports": {
-					"dummy1":
-						{},
-					"dummy2":
-						{}
-				}
-			}
-		'
+		ip link add "$name" type team
+		ip link set dev dummy1 master "$name"
+		ip link set dev dummy2 master "$name"
 		ip link set dev "$name" up
 	else
 		check_err 1
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index b1ec7755b783..26469f3be022 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -42,8 +42,6 @@ team_cleanup()
 }
 
 
-require_command teamd
-
 trap cleanup EXIT
 
 tests_run
-- 
2.53.0


