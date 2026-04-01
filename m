Return-Path: <netdev+bounces-273820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFiQE5tzzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EE373770
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F64C30DE8B6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB32D5C83;
	Wed,  1 Apr 2026 01:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9229994B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006371; cv=none; b=OmK2sPuuo9AW2vfc143idMQaDKQPJHbMMbo3LZtzboLj2WimKfIVmbhJzxPRrsOskU/nqV7gGHaN6xtVI60qWAwN32TKi9xmci1W3ZB6C7RfBN2XYCuw94+QiOxC9VbBUcbR4wXZbUtUAfkONQXETVRi7neKpZxeHe7gjl3k2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006371; c=relaxed/simple;
	bh=7agcID+ySkwOLFuvBjLuRjL4T4Ma62zWtNttPYQBqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5Kq1q3vNNaCVfzM7TPGWW2f6GfM5Jwa8szYTSH0o9vkYhGkaHhUGfjcM+qcp93/sT34r+17BBVzs4+BiQW2Zmkf62q/D5MltPzjddlTB//v2wUujnOy9T2nGATlQjLqBKzGH7SSnzrhzupb0QO8uWBGkq2sIRgoUzSANttaKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128ebee22caso935055c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006370; x=1775611170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Mcthf9PSGLAlzs0G4RaVyspim1e6cd9lq42Dbltqbc=;
        b=HOc9UtkbzrrRUjxJ5GNn06kua5tZr/zbtgpC/X74vO3GkMNtvjHuMv7KNpn1W5jYgV
         cxbVxiXCW+RnCuu66hvsihqO+9gtn6h94Ed1+WH1SsdO2mlcCMNEF7KThuCR3G3K/erK
         F+n8Yc+guYxU0R9yz9er1CC6NKR/xu0UNS6YkC4MkkOe3Gj62K0EnB1JyRvFsRrKXRu/
         5kXsMSXP8OZ0txiJVTFgxigODx42bgziuOwOPI7Z2hu4NpDbkRE5OHXUk5CqJaFUMGkd
         78b8fo+WecIc9AsFbtmYScoY2H0dsEEvOFWvy08+mgnY7I4XEKRviEySlASp4Ozl4SET
         Ju6Q==
X-Gm-Message-State: AOJu0Ywpf7lFOcZRHa6wHBYKUCDNrb6B52JFZrzIXAlnWvoDnZ4nE5Z2
	HjBaBppBPfLGaCp2N05aDcpWsUatXnSL1yhqrPjP4eyisW4vagWmvytVGSFK
X-Gm-Gg: ATEYQzwYIABoPiv9BCx9pE371J+7qJQXDQ/WO8GHKIFlyy1UuvCAAoKMW6VBaQpg2Wo
	8khDpjnzgJmpnlj8Ng06wcgLp/dzgm7tfZ6iM66jt+2ERKU2WKWCIrUX4CXiIQrvllzPbhLYmGG
	NpQ2PYG3fYz+htcdWjVnmsXd1IQlYMu3uC/0+AkWwsN4Ar+pGXyS2nqFUquUOE6i0+je3vFspzh
	nln7z4j3d3RNMvSvpXnR/OlOuzaG58R/LugURNTcK0KF2Yt5ydu35nTB3UVKMHuLujlkPdERCvO
	B1iyrHHm85YBoMh1DyCZJcdlwVN24pQF3z7k0FMsNxZ+HuE8JXHJrSJX30q/A8cNhOtiGwCFNTd
	RCH8GXo7msaCUhvfD6XLrV2K4Ty+tM2R3QYXtBMEcxKSDr3POCnCpw853sDzNkiJMyHaiHa7ve6
	QQvSxh9CSt5rBKdSUcqKprT+gFlwM7Pt05BsjX0oDyWnW8X1Q9H05ZVE3pH3sBo3aDPqCUsaey+
	16yYoefxcvAWK7vuA==
X-Received: by 2002:a05:7022:23a5:b0:128:d4be:743d with SMTP id a92af1059eb24-12be6557817mr1057526c88.21.1775006369403;
        Tue, 31 Mar 2026 18:19:29 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm12615523c88.0.2026.03.31.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:29 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 13/14] selftests: net: add team_bridge_macvlan rx_mode test
Date: Tue, 31 Mar 2026 18:19:13 -0700
Message-ID: <20260401011914.1716692-14-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-273820-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.331];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B99EE373770
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


