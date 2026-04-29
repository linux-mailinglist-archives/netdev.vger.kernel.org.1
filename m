Return-Path: <netdev+bounces-282427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI4KNNwi8mlmoQEAu9opvQ
	(envelope-from <netdev+bounces-282427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B20496CB3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FB4B308D7C4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906337DEA3;
	Wed, 29 Apr 2026 15:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E037CD2A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475895; cv=none; b=CGab95rIeBWdLSLkNzc3y/CsPU1aS5s7V81bfv+pIdcJP+PQ2lgGvPGIWDkhx4QR3rFFY2DyKdoKK2LUDXCeuiLY/ACmSKP2maFgKVsvXIRlHVAONRkQzJtjlRM7Y8IZ0xJB9RqJDwl7bxjtRrB3RPpj/jtDLRRWbkXZy3oxYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475895; c=relaxed/simple;
	bh=SCCuZca09OdAS3knl33zqAdII8RwnJ+xs+WR0FRDVV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjPjkVOc23QszWUqdCM9N0QckxeABBovk5wDOsK5rAldqRRRvapeKCQU6izFFhWEcTGYON9pbglQE74qlz2bFfKRSWRKTXJdRbDdLYIjCLfEYfW1YMSkNZB57+qD0J4O/ojM7eGQGccu6ERrV6Yh6Ismgurf3m1ku+gddPg+8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43cfd832155so9311523f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475891; x=1778080691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJJfrQeEaqhpRK/hzlkX5+ypxVhHeghBlozgM+ehlX8=;
        b=AIYTvmOEW05a60V0eo0faMrkNh141bZao2bWdFIplLjeQT8Q6UaXTNPdTUcLXQRxGZ
         ozz0ZmJCA73oWtfN6SJu+quoVd8uHKWBdUKfGgSFE3tfdiMFoG27sOcb4Kz6K1QVTjEO
         CqpbXJFARLn7pqJu7CEBwLoadrnp2sNj36gsraqHLQhQhj7Gtiqvn1jL9TqouKM/+AHB
         2UOpl/Ix46TTBAx9ackF8CjIj0pwPywG6pe0TorQ1DyZauDNbA6H2Rp7hYUyClJ1AJnO
         nasggBgOcMqQmx1oq66gYPRN6OqPgX8iLHv0NmSell4zWmEid34CMUges7teIZ9sZvem
         Qqdw==
X-Gm-Message-State: AOJu0YzBt6/nHqHYrDkGrsdcx9vlGbxW7gvULndz2lAW0wix3E9xKorS
	slDhdBzZbg+CprH9AQxWblAIFTjiP8iocOVtFaFk+KsD76vBti/0SiSrYUiAWX5Ggjg=
X-Gm-Gg: AeBDievBx2G1iZ9jRtH2Kcsei59fukrE+YLBY8WGyFvMKt40v2EXu3smX54iv7qgfry
	iqpabSUiQl7Gyfw0hcrh5N1S/HBr+zkR+lmtljs6jXnuMkHCx/55K/lGzfTMzoqw9pkUHSKGESA
	u0e5NsYZGdeV5hRzqOd4EV8Ac7/7/UcYSr3w4djf2qcuKPlrV3KZ9kZLGaTmIe+0/ziTmNTBEbL
	mrEYLHk3rh2bNIOWlKbG0SzhxACzefKkpJOVhEaqNC98Y/1CQYoimZHpgiaW0lEUxdWi8BHK4em
	ArPD4IxVNwcTeku2xQvmvKlw3GCEOsUbsj7ZDdDij2gx9gUAeuIKHqf6U/NczxjxEQz2XGmgBfl
	Rhn3BTWOa+jjBmIoA8WLhEYjTkL1SGrrbT0+3kR5zhYH5PCVgMsR5wRUpuKqkwv1blqyFmmItl3
	t70tCd1KsQxuJTIxVn2rn2hIonEWQa1FbzoEvAhl3VbncKE7V4Ui7Q01EH9s9fak5uf7OZ+g==
X-Received: by 2002:a05:600c:4fcd:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-48a77af0507mr126951365e9.10.1777475890388;
        Wed, 29 Apr 2026 08:18:10 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm32358165e9.3.2026.04.29.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:09 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 2/2] selftests: openvswitch: add tests for tunnel vport refcounting
Date: Wed, 29 Apr 2026 17:16:37 +0200
Message-ID: <20260429151756.4157670-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429151756.4157670-1-i.maximets@ovn.org>
References: <20260429151756.4157670-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69B20496CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282427-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.567];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

There were a few issues found with the tunnel vport types around the
vport destruction code.  Add some basic tests, so at least we know that
they can be properly added and removed without obvious issues.

The test creates OVS datapath, adds a non-LWT tunnel port, makes sure
they are created, and then removes the datapath and waits for all the
ports to be gone.

The dpctl script had a few bugs in the none-lwt tunnel creation code,
so fixing them as well to make the testing possible:
- The type of the --lwt option changed in order to properly disable it.
- Removed byte order conversion for the port numbers, as the value
  supposed to be in the host order.
- Added missing 'gre' choice for the tunnel type.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 37 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 10 ++---
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed53..3cdd953f68132 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -26,6 +26,7 @@ tests="
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
+	tunnel_refcount				ovs: test tunnel vport reference cleanup
 	drop_reason				drop: test drop reasons are emitted
 	psample					psample: Sampling packets with psample"
 
@@ -830,6 +831,42 @@ test_tunnel_metadata() {
 	return 0
 }
 
+test_tunnel_refcount() {
+	sbxname="test_tunnel_refcount"
+	sbx_add "${sbxname}" || return 1
+
+	ovs_sbx "${sbxname}" ip netns add trefns || return 1
+	on_exit "ovs_sbx ${sbxname} ip netns del trefns"
+
+	for tun_type in gre vxlan geneve; do
+		info "testing ${tun_type} tunnel vport refcount"
+
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			add-dp dp-${tun_type} || return 1
+
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			add-if --no-lwt -t ${tun_type} \
+			dp-${tun_type} ovs-${tun_type}0 || return 1
+
+		ovs_wait ip -netns trefns link show \
+			ovs-${tun_type}0 >/dev/null 2>&1 || return 1
+
+		info "deleting dp - may hang if reference counting is broken"
+		ovs_sbx "${sbxname}" ip netns exec trefns \
+			python3 $ovs_base/ovs-dpctl.py \
+			del-dp dp-${tun_type} &
+
+		dev_removed() {
+			! ip -netns trefns link show "$1" >/dev/null 2>&1
+		}
+		ovs_wait dev_removed dp-${tun_type} || return 1
+		ovs_wait dev_removed ovs-${tun_type}0 || return 1
+	done
+	return 0
+}
+
 run_test() {
 	(
 	tname="$1"
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 848f61fdcee09..196813f476434 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2069,7 +2069,7 @@ class OvsVport(GenericNetlinkSocket):
         elif vport_type == "internal":
             return OvsVport.OVS_VPORT_TYPE_INTERNAL
         elif vport_type == "gre":
-            return OvsVport.OVS_VPORT_TYPE_INTERNAL
+            return OvsVport.OVS_VPORT_TYPE_GRE
         elif vport_type == "vxlan":
             return OvsVport.OVS_VPORT_TYPE_VXLAN
         elif vport_type == "geneve":
@@ -2131,7 +2131,7 @@ class OvsVport(GenericNetlinkSocket):
                 if not lwt:
                     vportopt = OvsVport.ovs_vport_msg.vportopts()
                     vportopt["attrs"].append(
-                        ["OVS_TUNNEL_ATTR_DST_PORT", socket.htons(dport)]
+                        ["OVS_TUNNEL_ATTR_DST_PORT", dport]
                     )
                     msg["attrs"].append(
                         ["OVS_VPORT_ATTR_OPTIONS", vportopt]
@@ -2563,7 +2563,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
             if vpo:
                 dpo = vpo.get_attr("OVS_TUNNEL_ATTR_DST_PORT")
                 if dpo:
-                    opts += " tnl-dport:%s" % socket.ntohs(dpo)
+                    opts += " tnl-dport:%s" % dpo
             print(
                 "  port %d: %s (%s%s)"
                 % (
@@ -2632,7 +2632,7 @@ def main(argv):
         "--ptype",
         type=str,
         default="netdev",
-        choices=["netdev", "internal", "geneve", "vxlan"],
+        choices=["netdev", "internal", "gre", "geneve", "vxlan"],
         help="Interface type (default netdev)",
     )
     addifcmd.add_argument(
@@ -2645,7 +2645,7 @@ def main(argv):
     addifcmd.add_argument(
         "-l",
         "--lwt",
-        type=bool,
+        action=argparse.BooleanOptionalAction,
         default=True,
         help="Use LWT infrastructure instead of vport (default true)."
     )
-- 
2.53.0


