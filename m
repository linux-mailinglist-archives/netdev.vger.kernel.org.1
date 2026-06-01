Return-Path: <netdev+bounces-293551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I+J6DCkYHWrtVgkAu9opvQ
	(envelope-from <netdev+bounces-293551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252B619A96
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBE62300E01B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AB3403F3;
	Mon,  1 Jun 2026 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2Eiwdxn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E22339861;
	Mon,  1 Jun 2026 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291522; cv=none; b=cZZtrTHSUeyIrY+kBer3WOY8p2Iq27aRql1rvEmQbk/roRsmcVk4eqbSpbp+Oj9YA8YyJejmzHkIs1g6VW/rsysLCJNdEYLIFNATdZumps9QM/jzFqCBJidyerVJ7bAL3TCVgOjJgcp94X1xPwdSjIn2IqFrBxewb9TKtukRny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291522; c=relaxed/simple;
	bh=9DWzG4MqvnbfffxHxIao0Il/rNYmDxD1jYc/ee7W/GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py8ROWn6+EaGaksFt+q65aVm/VL1Y9q9x8uWO644ggjkywLbwj9roQZ1KY4XoRyb8XFj0Qeu6SasKHZMG4LBYO5F13qTnj+ZKTLAKBgb6SlA2GnELManuvDWFG9wggO5Ff2BpVrBgOax/f6bbnns0XFBKok1EdU8+pkdzVI++sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2Eiwdxn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2861F00893;
	Mon,  1 Jun 2026 05:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291520;
	bh=gW5vkNJ/C6DwDC9a9I8rYyU9QwK6sEUGGymq0Yf8CxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d2EiwdxnaqX0MyC+Nh3ZL0jdc5584Zxt1xLE3a/d/ZmVArmHiLfW5uNlVYD0BlJIO
	 KZINUgTiX9JaMOus/pSuOhPGQtB+zhtOdqCRsg+E+mCdZBjEghFvTgtCEzx2WAiXqR
	 8dFOS9UfdFeCCk3mr4MQiosLhKOyBHQ6PoiGKi3TBkKzdvlY04WKVuAMaR/aJ3W1+N
	 uwLyNH4zOSgzakwLGNRE7CccvZcdUsCaSnASAmCdZLWIuzgWM3TAeE06rd3gvgoJ/D
	 h16+tiV73KoI5uS4/xs6qxNH9vUYF6gbdYorjpDLZb4Vila+w41pvVCN6531E4zuol
	 bevim+o183UPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:16 +1000
Subject: [PATCH net-next 09/11] selftests: mptcp: connect: test name in
 pcap file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-9-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9DWzG4MqvnbfffxHxIao0Il/rNYmDxD1jYc/ee7W/GQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReTWiVWw6IBpxOCt1kw0hrUmhzVF+y3kaAGi
 zWXaCKKTOCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkwAKCRD2t4JPQmmg
 c00vD/425UlEM6COX9ZDL2V/+GBk4wXgHRFKbQ9llAvolqJJJ0PVmRZA791483c+7lWBrfT0uPk
 7ToeHH/eFZ3s5ByblUZbv62w95DNkAtCE3K2T20lOcs3uZO9IieCW53lxw4VSYjRXE2b9ySeQbA
 7lAMnj4ynOYgIrgsxDDv3r01Z0ncSfCes/+Sms+zlsxIoBwzn0xj3tzHhmRPWrjwojcWIzo2KbV
 8WVUDESgy2Jeyyp8BZwld7YXfWxSXK2kaNxnx+G+pMRGY6dIp3cs+hAPLbPxWd/CR2F5jDJQTcl
 4y+aLumw4nPNoDwNPMvDdmEV/jJSws7PGY9QWbSEW7Cn81BEeAKn9Rzhe6ebX3laUA+ewcreM93
 kD9oQxNOBRYSSLSzB730JxS08TWeknDXiW6jxqdLvOyDOwUA0Bnu4RnWBGy+nrWDLR1P1IdYVLM
 WUom35T2GmfCYTFaLpu1RktfSpxi4AXG4lBW7LkSMFspUEdVUSL0LrcTSdeuHg2kZy9KvJJKwY2
 XlnSwt0S/ozQtM5sZjV+NYRU6B447wOtLSRBYQ7FXQFEOmCcQsSnj+1jsgijWDEc7CwrgSQUJQl
 1czTsUlHl4T9b/cp9gPRu2p6xBCYlq9HcE1zC9LpYPOJicGpJ/clDNi8AqefvbmvCu1eD6mULIj
 FES3Js2tgMkNlPA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293551-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1252B619A96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even if the pcap prefix is printed in the test, it is clearer if this
prefix also include the test name: mptcp_connect.

With this, it is easily possible to find out which pcap was produced by
which test, and easily delete the right ones.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index d158678fa6ab..5befd8584a4d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -212,8 +212,8 @@ if $checksum; then
 fi
 
 if $capture; then
-	rndh="${ns1:4}"
-	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+	capprefix="mptcp_connect-${ns1:4}"
+	mptcp_lib_pr_info "pcap will have this prefix: ${capprefix}-"
 fi
 
 set_ethtool_flags() {
@@ -372,7 +372,7 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		local capfile="${rndh}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
+		local capfile="${capprefix}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
 		ip netns exec ${listener_ns} tcpdump ${capopt} \

-- 
2.53.0


