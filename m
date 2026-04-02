Return-Path: <netdev+bounces-274736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMUbCb30zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:59:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFF38EF01
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7492302C575
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3B3D8126;
	Thu,  2 Apr 2026 22:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98493D810B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170556; cv=none; b=dIrHh5mq09t2YTOzFCMSyGRtVMM3nz1yCmPExcLiM4XSGsrv2MoQjFChfoSur2peVAlsTN/zc0WcK/37xBXX2I507vQtcxUdW9uk2sYWi2bBMjblVzWKD+drs7DnkLo67KwQGvnb3ztw4CH+iBkpDbHe1FocHjD0SePXDs1S94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170556; c=relaxed/simple;
	bh=7agcID+ySkwOLFuvBjLuRjL4T4Ma62zWtNttPYQBqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPwVbq9BUYsC2YmrqnxhWpy26y6kmWML2FhT6xHqfhxArZS/XWr0Otb7cfvIbpH7RqmUKvrJGUQ+wApALhFNs+ovaORe6BidBsV+YqZ2+52hDNVpWkVssn+0DBkMBhUFw1pZpAlqcWnkjo3RG9QwMCG73Up5m6s1+L+/4853Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1368845eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170550; x=1775775350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Mcthf9PSGLAlzs0G4RaVyspim1e6cd9lq42Dbltqbc=;
        b=UzudDRx+ffN4oCBenEBJMdhzoNcuhrQnBeUWU+QJ3F17PXpiwBZYTb+T1wrebBuSIf
         JsjIj8EbYZi17R6ObXiTTe44H7UaxZ4oFfrFX99Ul2xro7ORSZMvqMdOfyzsnJOa8rpr
         zGcMHsI1CWlsWYjSteBbpMeznnAzWaHxW582qP03hsP8sazSi+m9qqqHx8dpk6/dlFbk
         ESH/gmmau6m6CzsQTcRYgrptEYt0S/r7KdbQzE5twb3BQG1skFM8Hef8KHSp+ugM5bP1
         HKkw7VyBBQZgUFu4MAXbTehJi2QlGgwv01GDLGMtrfg/DJeBLJy2ENs2ZtSpzIuY5v2F
         w2Bg==
X-Gm-Message-State: AOJu0YwYBQQS6NJqjypmWKNyHZADlB+OXnwIs39cyLYfyJbvCZdk6O/4
	QCgIOqqjV22DhJvszLRuq2igA/A3wQwjW8ENrrqSKY5OMHeMfWPk6r6fAJki
X-Gm-Gg: AeBDiestx2NqYh4uIE121mTlb96sv1LorY0L7hJ2Vld8bx8Kxa/C1JzdZcWELXwqT0i
	yEzUf4UPCE1kdavAfn9mknOC0HOZbILZWHD0Zn2XwHIgyNlHV9+XUHLGjLyRl7KaSxOTHl+wbqI
	4J8gqcd1XOA+8SwAX0I9N/a4bcfKTul5KyF3cDP8a57nqRmsORmsC1oEoJOvSYiF90bzIZBB3iB
	DYLKxftHHnhvcR/D5LD3SlkKlPrGo0I+HxkzYKszLjkCKgr4OvLNFJUN8XK3fie0E52BJjpgy4+
	+fsBnJxlKPudQ3BjhcqISJ8djpxZ3VJBvIwpIjRuRKpudD7wT/162fOMwUGWOzGXKtOBL8hq3pm
	wWfrepC0cQT1sVbsvyWCDulhld565+l1EimMoR6CzyBtGIY+n0CE7LjQRNh1sQCAbLLmTJ+cFYw
	I0bSpb0bSyLoOpOIimLf7rz1T3Be5G2/M+RQG6xYFVvf/dekP95ryUy7v76gpyaEDyGfOfLM1J5
	E0YnTDgc4IH3g/nPg==
X-Received: by 2002:a05:7300:5b88:b0:2be:2f62:8bb6 with SMTP id 5a478bee46e88-2cbfc46144fmr572288eec.30.1775170550125;
        Thu, 02 Apr 2026 15:55:50 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d331sm3734648eec.13.2026.04.02.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:49 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 13/14] selftests: net: add team_bridge_macvlan rx_mode test
Date: Thu,  2 Apr 2026 15:55:34 -0700
Message-ID: <20260402225535.4124525-14-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-274736-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 43EFF38EF01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/config       |  3 ++
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..38611ea11c6b 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,9 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
+CONFIG_NET_TEAM_MODE_LOADBALANCE=y
 CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5a5ff88321d5..c499953d4885 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -23,6 +23,7 @@ ALL_TESTS="
 	kci_test_encap
 	kci_test_macsec
 	kci_test_macsec_vlan
+	kci_test_team_bridge_macvlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -636,6 +637,49 @@ kci_test_macsec_vlan()
 	end_test "PASS: macsec_vlan"
 }
 
+# Test ndo_change_rx_flags call from dev_uc_add under addr_list_lock spinlock.
+# When we are flipping the promisc, make sure it runs on the work queue.
+#
+# https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
+# With (more conventional) macvlan instead of macsec.
+# macvlan -> bridge -> team -> dummy
+kci_test_team_bridge_macvlan()
+{
+	local vlan="test_macv1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local dummy="test_dummy1"
+	local ret=0
+
+	run_cmd ip link add $team type team
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: team_bridge_macvlan: can't add team interface"
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add $dummy type dummy
+	run_cmd ip link set $dummy master $team
+	run_cmd ip link set $team up
+	run_cmd ip link add $bridge type bridge vlan_filtering 1
+	run_cmd ip link set $bridge up
+	run_cmd ip link set $team master $bridge
+	run_cmd ip link add link $bridge name $vlan \
+		address 00:aa:bb:cc:dd:ee type macvlan mode bridge
+	run_cmd ip link set $vlan up
+
+	run_cmd ip link del $vlan
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+	run_cmd ip link del $dummy
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: team_bridge_macvlan"
+		return 1
+	fi
+
+	end_test "PASS: team_bridge_macvlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.53.0


