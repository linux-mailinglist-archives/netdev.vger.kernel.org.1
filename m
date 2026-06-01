Return-Path: <netdev+bounces-293553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAg5GfYYHWrtVgkAu9opvQ
	(envelope-from <netdev+bounces-293553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D17A619B27
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1CDC3024896
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49C33D4E8;
	Mon,  1 Jun 2026 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmxrRJ8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEB32ABCD;
	Mon,  1 Jun 2026 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291530; cv=none; b=ihxqfc66oPXcdHRjl9sSkLOL2Rbxe6YLmTRs5LWLuJasBos8OfKCBj00tCdB4Qzb5uMkc56QUfdGyJ1k9FMHJpIvyNgt2/kAI9oYJq3ss4Ia1ObD7Z8XDCaX/xDEC8s58O2/mANf3EaMYxDJRSIuqBrD/ROOaB9F9aXGWxvuAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291530; c=relaxed/simple;
	bh=EiMZs2Sj7GeMUFETXfuoemuuMtoO87StFk8Crr3cmxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gmbf4cCezDw3m1XDK2Ess8B8FxKlwP1NgLk1S9dGjmuQv+lpjUx1VslnpVbosJuSl59lTxb0OEwKjLaib3YjNYJoUEg390YEfoEO+wE6IhvYI2sRBiORrxSHBR/y6o0FnxjIjTOa4kXPOnwDg06gDg6Dnlsp0K5T8A12xGy4gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmxrRJ8K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D031F00893;
	Mon,  1 Jun 2026 05:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291529;
	bh=7Z9XT0MMfLHkChXCdfot4uAPLLhV28bVyUYj6AsXbrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nmxrRJ8Kacrkn1QYEGOwyQuXfPyTrmkpaGLJHXuLv1AwtYE1NglDs6xogIOKUlqCl
	 emU9Na0cPgjq2Lj51zXWPiJwLNeel6zlLyVtu6+8K+FOf3yHmLLzDqymgZBuM1wIOL
	 adQDnIPAJiCS3KebhAaZA6W69ARwSp4riGWA9t9RR6CLuo58NfWF+QLd6MdQXbnAVu
	 NeNuo6lR3o9oElPXuA68xTtKYhtfCvMqZCpSwFQvLLaBwZ3I5c8l+xZQbq2R04jjua
	 C3EZHD3pKOJCaWOZ6n13LuVdRPdjEjiTYU0/qYjWxN75Dpj5aHDJwsBRRwMa27Xnss
	 R0JLRYVApKuIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:18 +1000
Subject: [PATCH net-next 11/11] selftests: mptcp: pcap: drop most of the
 payload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-11-4fc25dfef62e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EiMZs2Sj7GeMUFETXfuoemuuMtoO87StFk8Crr3cmxY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReT/E3i69Y9c5t8bGKYawQeHnJNgq/uFUe02
 AvrqX09Iu+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkwAKCRD2t4JPQmmg
 c0heEADuCFdazGaU0f8a3MFngIlV9WSjoWn0BnY7cosDt9nYN4CamdJw6OXSp/CX9b9ytjOkPyY
 /xr1mC5TDrYksqHIW6zagcA+lK2sVq1k3hEQhkY76grBSIBK94rd+G4f/+HfFlMef2j1K9I0jpl
 cMU2CfoWHcS+l/QqNJE5c907n3LKTRR6xdRojC3xdabezHtscNRgD3fh63nqJiru6V0yQeJ5Pr/
 X770d6CB3XW5MB3Ubs+LP6CLdjd4d6WCRCD/+b/xkwAaVk7O01xutLiA95OcNaXH/6wxM64Wf2t
 rIZjRMfHC9Y6ki/2+AyY8Q+6Ts73l4yeRYbo39QtY7FNfPBPQRriFl4qGCFZm0KMSt5P4E1vNiV
 +2HXhcIuYUZrlpz4p35j3xrU1COoK1gbACNXTK0FpKgp0+Jz22ppnj+amIeyqMQrkVJo0or74S5
 s4gx38bt0e2MCJ9U42zppsULP/umWMUA/HJoNryHWNyvrwvV7S+zijnuqiRcbFMpiDockbVnm3A
 qBF8jtrVfl0MklIjthf/pJLHa3gTWJDWrwf/Viock8uUAKeN4dBMqvZobT6t3dC0vlEWSQ4lxnW
 NDls0xJTAYdyw5HuT0Qx5MQaC7P4Xy2B8DoTPtpA/4sWbsnl91oXVkCOSlF+ohw58ACLuYD6d2C
 1gtTx1AyWCTbSPg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293553-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6D17A619B27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Limit the size of each captured packet to 108B (IPv4 only) or 128B (a
mix of v4 and v6): this should drop most of the payload that is
generally not needed when debugging an issue.

8 bytes are left in this payload, to be able to inspect the beginning,
just in case.

Please also note that generally, this payload is usually mostly filled
with 0, except at the end. This reduces the .pcap sizes, and reduce IO
usage, which helps debugging issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5befd8584a4d..7a2a851fa0ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -373,7 +373,7 @@ do_transfer()
 		fi
 
 		local capfile="${capprefix}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
-		local capopt="-i any -s 65535 -B 32768 ${capuser}"
+		local capopt="-i any -s 128 -B 32768 ${capuser}"
 
 		ip netns exec ${listener_ns} tcpdump ${capopt} \
 			-w "${capfile}-listener.pcap" >> "${capout}" 2>&1 &
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82c0f7df3be2..600eddb1796f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -971,7 +971,7 @@ cond_start_capture()
 		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
 
 		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		ip netns exec "$ns" tcpdump -i any -s 128 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
 		cappid=$!
 
 		sleep 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d723261bdc62..3ea3d1efe32e 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -149,7 +149,7 @@ do_transfer()
 		fi
 
 		local capfile="${capprefix}-${port}"
-		local capopt="-i any -s 65535 -B 32768 ${capuser}"
+		local capopt="-i any -s 108 -B 32768 ${capuser}"
 
 		ip netns exec ${ns3}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &
 		local cappid_listener=$!

-- 
2.53.0


