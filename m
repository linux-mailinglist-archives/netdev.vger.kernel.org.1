Return-Path: <netdev+bounces-267443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P7BOdwHtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7CF283386
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 477FC304D241
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0A37F72B;
	Fri, 13 Mar 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWbi5m7F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gMItvD1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWbi5m7F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gMItvD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2034216C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406122; cv=none; b=W6r1i+6o4WLOslIRpbmBCE4fxva6SodgeetEChjEoQRzyzQmWBd76EcACDi492PZNfR+Ejgwj2L1VUOSqBOaDVhX7jZ8glz7SiPMoTAPCdLKdrZWwtZrPKDilW/US7d/Uzw6unCrHQWxk4412lX4I9zi1TMgtqFMImoTt08ZvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406122; c=relaxed/simple;
	bh=79NxmM+MkB1TRN1x7LdwDBd2mAtRT5MtMtXj1hldAyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYTGIalwvm6nra9pr155XETekN9Gcp+bOouqtN9XS1LmbryWaXTc+DYJFp41lYo6WNCe8PhtxVoGkpTysQtIseLpT6yRID/C9mgpRvPQNndFbm9xhtvSZM+rPIVB0FT4NkVH5UxNJ/BQNS+Ex+EMn/LzDf2h0uiZ3ikxSF+1Rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWbi5m7F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gMItvD1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWbi5m7F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/gMItvD1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C454F5BD15;
	Fri, 13 Mar 2026 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773406118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eMkWZ1dQnPzBx9E00xU6bbEorgylJXE6cy6xk7cFZT0=;
	b=ZWbi5m7FlzCT9NYvWaZeixzTYmPS+0karceJoFpHnxpTHJ1Khs5/QLI2Z5wIHAVqd5Dif2
	ZmlbhqBBXzm6H8l1OghgA0m65xiNALAngHK2UGBfCOyUbJYxr2YzLvKGz/4jVpebHbo7fp
	vL2ozYYDVyzbBBVgdfLY6ow4EtcZLyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773406118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eMkWZ1dQnPzBx9E00xU6bbEorgylJXE6cy6xk7cFZT0=;
	b=/gMItvD1IMkkpVKbbYc+u104npKOnYhmSVklqk3dRWpZ73SvmMLKxKNpH4l5vDY8Tjcyr0
	PAe21pVfFvNQUqDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZWbi5m7F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/gMItvD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773406118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eMkWZ1dQnPzBx9E00xU6bbEorgylJXE6cy6xk7cFZT0=;
	b=ZWbi5m7FlzCT9NYvWaZeixzTYmPS+0karceJoFpHnxpTHJ1Khs5/QLI2Z5wIHAVqd5Dif2
	ZmlbhqBBXzm6H8l1OghgA0m65xiNALAngHK2UGBfCOyUbJYxr2YzLvKGz/4jVpebHbo7fp
	vL2ozYYDVyzbBBVgdfLY6ow4EtcZLyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773406118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eMkWZ1dQnPzBx9E00xU6bbEorgylJXE6cy6xk7cFZT0=;
	b=/gMItvD1IMkkpVKbbYc+u104npKOnYhmSVklqk3dRWpZ73SvmMLKxKNpH4l5vDY8Tjcyr0
	PAe21pVfFvNQUqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3262240521;
	Fri, 13 Mar 2026 12:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WeEmCaYHtGk6WQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 13 Mar 2026 12:48:38 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next v3] selftests: net: add ipv6 RA route to ECMP merge test
Date: Fri, 13 Mar 2026 13:48:27 +0100
Message-ID: <20260313124827.3945-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 4E7CF283386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As commit bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when
clearing RTF_ADDRCONF") pointed out, RA routes are not elegible for ECMP
merging.

Add a test scenario mixing RA and static routes with gateway to check
that they are not getting merged.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: added CONFIG_IPV6_ROUTE_INFO to the config
v3: added CONFIG_IPV6_ROUTER_PREF to the config, tested with virtme-ng
---
 tools/testing/selftests/net/config       |  2 ++
 tools/testing/selftests/net/fib_tests.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cd49b7dfe216..2a390cae41bf 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -43,6 +43,8 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 439461080c60..05dadc3f55b1 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -1534,6 +1534,23 @@ fib6_ra_to_static()
 
 	log_test $ret 0 "ipv6 promote RA route to static"
 
+	# Prepare for RA route with gateway
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra_rt_info_max_plen=64
+
+	# Add initial route to cause ECMP merging
+	$IP -6 route add 2001:12::/64 via fe80::dead:beef dev veth1
+
+	$NS_EXEC ra6 -i veth2 -d 2001:10::1 -R 2001:12::/64#1#120
+
+	# Routes are not merged as RA routes are not elegible for ECMP
+	check_rt_num 2 "$($IP -6 route list | grep -c "2001:12::/64 via")"
+
+	$IP -6 route append 2001:12::/64 via fe80::dead:feeb dev veth1
+
+	check_rt_num 2 "$($IP -6 route list | grep -c "nexthop via")"
+
+	log_test "$ret" 0 "ipv6 RA route with nexthop do not merge into ECMP with static"
+
 	set +e
 
 	cleanup &> /dev/null
-- 
2.53.0


