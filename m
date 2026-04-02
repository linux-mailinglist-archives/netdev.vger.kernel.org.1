Return-Path: <netdev+bounces-274737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJy9A6r0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6673738EEF2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087F5306824A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCB3DEFE1;
	Thu,  2 Apr 2026 22:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEB3D6CCE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170558; cv=none; b=R12UZYYJBckvs4IRjmE4V1oBp85xsDx/2hORSnjAU4SRwwiy2baOCHMCkUhkNqJ8skkSkMRtkvHMmCJidphAaAO94dPSx+1Em5Ny7SESNqCBvN22XO4VOT7mZTUxbIs6NhifkI5PaELUUMZBR4QKX1YSzUD7qVFPJLrjjFrSt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170558; c=relaxed/simple;
	bh=k/3sbpt2eNknMH23oP8xz8SSUBFNLF64+N5JA8TOB4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjgTvmtcx39FF3dTDlFOXSYKrD2myhJQfFfePG6pIgJ20nNVZy8dZK+7txCGyL374h4GFqYR9T7nRO+0LUbRVd9vy8GqJ3q6/p2qZzMsA96uXQ+JRO3hntm5/Yd5U3P1ol45aCRbQgMXj9ltRW089iUfQ30V/wWyo3bpZejI0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2153810eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170551; x=1775775351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTy14OCBgTmafJlMKuLv4J4RSF3bm1JCEeeYuKUNpns=;
        b=f4iWJ2CWSZJWfUMs3OGVor3n8Jym7/zTgLRsOiqxKgM5ICkXTPUaKFbA0T79azudjn
         9rffBFYGrha2F/+hr0kNadHVZP3a5AZ7vwgKjyc+0fat8DMxVkU14FlEcHdKHAYc+o2V
         DE9YZgpwtZUaP2Zxx8tAA/mv1sChbaD4GJRNx6ayZIMBMMt/IKBlFkvdSPbeKUO5imKB
         YgZ0FV6atQt+JkmPtAOB/55+ofx8wIrylry1aNczSDLsder9oqnGvAI9/8/FnpqAEUN+
         Brn4nQh1BIgJomCEV5/ex9kSnvqu4VBv8ayA0L0yc1A8xmB0e6s3n1NoAoA+vOB3fRJT
         RNcg==
X-Gm-Message-State: AOJu0YxLkwPwHLcwNwO/VHWFlYTBTLrVVWZFB3BnTPG4cSyyuG7MQhOn
	tJPkJiRr2rrchETQYK/jOVBBM8zzz/tTBJ+Z/h3mPcjFxmxClEBq0oHaQ648
X-Gm-Gg: AeBDieseXtp0kTyE9VuC3P4eLEPXwXeCuEpGuDctEVVstYWYxjvzf+advwLW/cWZ+1h
	2Qviu2wpi9Tz39UGLNIRVVR90Z2wk3hIQm3R6k2cakqTcZv6QCWQTrIxL+gRqPfHZkJXQoTJ+4N
	m0NyFzUZ5btNrUarR2x5aaaExiBvUmQiUVqXLf8akhfIfdiIbFxlAy9hQgTOicEpy986ZDlBi75
	9RxxnhecOUHEe3NBzzHbSxRHwQpRCJS4nlM4NoTlX4m68QYJSJsIR6Ybi5AthosMOQ7FbOEE8Ay
	qe++GCE+AwzGGStdReMsBqrPgb/+6LVyhIzA5TR4uqZfJQ7fpqGrySuKPmsFEd53sja3zxPgabJ
	8Zba4p8YAzfzMuV9qzycLGI9Fx6m+aJQh6iWas2+CebVGNTelJoXui4+I8rpGayZ6cLir4ImH65
	aSaYqluwzDKtH3V4ZkwBmUrjQmthewoSUBDcJ1c4E6KLnd7fxsJ+mpMvee+8VH7q5MuwTzvliY4
	hCD1TGEX4bLqPNDiQ==
X-Received: by 2002:a05:7300:dc88:b0:2b7:b7e7:9025 with SMTP id 5a478bee46e88-2cbfcb5580fmr559881eec.31.1775170551306;
        Thu, 02 Apr 2026 15:55:51 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b2b1sm3879548eec.18.2026.04.02.15.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:50 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCH net-next v5 14/14] selftests: net: use ip commands instead of teamd in team rx_mode test
Date: Thu,  2 Apr 2026 15:55:35 -0700
Message-ID: <20260402225535.4124525-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274737-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid,resnulli.us:email,jvosburgh.net:email]
X-Rspamd-Queue-Id: 6673738EEF2
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


