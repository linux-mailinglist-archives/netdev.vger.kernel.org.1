Return-Path: <netdev+bounces-274997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKTcIGylz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288F393B67
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D2C430338AB
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5F3BA24D;
	Fri,  3 Apr 2026 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVFf1yAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BA3B9D83;
	Fri,  3 Apr 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215805; cv=none; b=QK4G0p0oywmyXshHAjCL5n+cTKXW4CuX1m4rshrtZ9mhOJAs1T/Dizqo3Gx71k/3UU7lqv0oyTorkiu3/k+mdLRmzOZl21tllRM1IjhsuvzPR05Nasztj48JaoH9EtBua6syl7kbQmargu43x5UMsV9SHEkV58y5pxpzRhz78ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215805; c=relaxed/simple;
	bh=1U9CpO9IcrE/wfz3Fu40rYUyicZz0UNASAZJ2T7Ehuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTro4J1vKCgRfg+vMTdT5hJKbCyhLMlW0oXanLBjk9DdvYDPjzJ7IlR7yOmipwEAx/mdOJszrxzWfTjKml+ipehKGIpBha2H/bHPtiVLql8Ce50VjrotQ6Zz/N8OGOnsUXGDp8EiohJGA5K0B9JBRvg4nn87cguAPfNGs+C5hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVFf1yAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F98C19424;
	Fri,  3 Apr 2026 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215804;
	bh=1U9CpO9IcrE/wfz3Fu40rYUyicZz0UNASAZJ2T7Ehuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aVFf1yAt5k/OC59vcjG9JlziHFdaDVCxx6un69QFmitMawRWREhh73WlTv6ed+Hw7
	 KNB5/WiW84ZOCcTc5od64yr2o4yYPRivDYEqsLWl/8AqHY/Cg17SqdNs67Ojocu2zf
	 WpEingwxH3owJf1QiBe5ulO6KYyMTICtOyt4Nvo9qiXMvwaPIOF0j9q5UxS/GQPdFw
	 hX28v83AL98BLiu9Fv0M0+3rKFTrYMhrMkfj+Uf5IX+exIm7UL0tJAr2M+oR7tiBJ+
	 CNVfphEKv92BUwqyow18vgCPC8y+Ee9NOVOyyikbNQjzJkU74U2k9hooUbRcCq85/Y
	 CA32Am9WehC5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:29:31 +0200
Subject: [PATCH net-next 5/5] selftests: mptcp: join: recreate signal endp
 with same ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-5-b0b33bea3fed@kernel.org>
References: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1U9CpO9IcrE/wfz3Fu40rYUyicZz0UNASAZJ2T7Ehuo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1lrfYSni3+RQ57JF56DGrU++2ef2F1/T/ekYLHP+
 od8B/Ybd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzETZHhf3ne+nVLDmiLn/bM
 fMjKL+v4PqeiwTTlpO/ctw/jbxb84GFkOKcg/1bSz8RgEoOzrxd7963UVZ/0b/de+XjlaNbfV3b
 hfAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274997-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3288F393B67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In this "delete re-add signal" MPTCP Join subtest, the endpoint linked
to the initial subflow is removed, but readded once with different ID.

It appears that there was an issue when reusing the same ID, recently
fixed by commit d191101dee25 ("mptcp: pm: in-kernel: always set ID as
avail when rm endp"). The test then now reuses the same ID the first
time, but continue to use another one (88) the second time.

This should then cover more cases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/615
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a3144d7298a5..beec41f6662a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4343,13 +4343,13 @@ endpoint_tests()
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
 
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		wait_mpj 4
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
-		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2

-- 
2.53.0


