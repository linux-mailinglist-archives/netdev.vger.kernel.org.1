Return-Path: <netdev+bounces-261318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAHoBmM3oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:06:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E61A5900
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2BE30D3EEF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74A37B3F0;
	Thu, 26 Feb 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7Y8D6AY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rlGKHnkK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7Y8D6AY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rlGKHnkK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1D364026
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107386; cv=none; b=YODprfhLswQ0RlA533IErqtOmilNljS09gT8gbwRt6GUQ9TQiPgNHwzPW+olkiCU/uYBkSv2cr2S53Zd2YPAN4xreRkxC96dchfo7tvoLIeveQfuKYei1nXTUi9vBl8GmTzuk0rGFzGnO+rqAk45QGWBq/RsA1KAlCpi4bGqEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107386; c=relaxed/simple;
	bh=BsB+oEPzvEnbOuwAtJ69eebytdrFzUZWsWhC2mPRS30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avwco8Qrxu2QsdN6/HfpumnNNTuD/nrwTc4U7SXPiO2EutEQVDqMjD5Sd0dkV8fVj/tqh27b5jVP/Hw0VBUgWFQwjamgOnkfDm5qFzOWV2GoiPvSr4w2aGM16EDcQjXSJecTPnuWkpm2vIKfgFMyVBVj8qxW4zTtsJABBkMcSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7Y8D6AY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rlGKHnkK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7Y8D6AY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rlGKHnkK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF5201F43B;
	Thu, 26 Feb 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772107379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lKApDUyIFUIzliUqleBEaoniXopBT8Tn71tpN6GHZTc=;
	b=Q7Y8D6AYioQe/Q+SHsI57k2dXfbMtSTyskyVEwf91C76t/RrZ7IlJ/PCS8hVxhxb171QFh
	N7meD+y+Z143zELHzXVxF8xewVjAxYCBFWymhA6ONLhCt9TJL/iOvcv7tnkKN4D2D528G2
	XUiUBponmxcfTJVVBGQpPIAHBpkp51E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772107379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lKApDUyIFUIzliUqleBEaoniXopBT8Tn71tpN6GHZTc=;
	b=rlGKHnkK5aRxOwb+DwcEaJ6BTVUgK1ota7rJSiMPq2QnKMvxZGjHydUS7Ik1Zm2cPJLg7r
	gx6boKJDsJYdwBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772107379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lKApDUyIFUIzliUqleBEaoniXopBT8Tn71tpN6GHZTc=;
	b=Q7Y8D6AYioQe/Q+SHsI57k2dXfbMtSTyskyVEwf91C76t/RrZ7IlJ/PCS8hVxhxb171QFh
	N7meD+y+Z143zELHzXVxF8xewVjAxYCBFWymhA6ONLhCt9TJL/iOvcv7tnkKN4D2D528G2
	XUiUBponmxcfTJVVBGQpPIAHBpkp51E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772107379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lKApDUyIFUIzliUqleBEaoniXopBT8Tn71tpN6GHZTc=;
	b=rlGKHnkK5aRxOwb+DwcEaJ6BTVUgK1ota7rJSiMPq2QnKMvxZGjHydUS7Ik1Zm2cPJLg7r
	gx6boKJDsJYdwBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 510053EA62;
	Thu, 26 Feb 2026 12:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPPKEHM2oGktfQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 12:02:59 +0000
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
Subject: [PATCH net-next v2] selftests: net: add ipv6 RA route to ECMP merge test
Date: Thu, 26 Feb 2026 13:02:37 +0100
Message-ID: <20260226120237.5352-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 806E61A5900
X-Rspamd-Action: no action

As commit bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when
clearing RTF_ADDRCONF") pointed out, RA routes are not elegible for ECMP
merging.

Add a test scenario mixing RA and static routes with gateway to check
that they are not getting merged.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: added CONFIG_IPV6_ROUTE_INFO to the config
---
 tools/testing/selftests/net/config       |  1 +
 tools/testing/selftests/net/fib_tests.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cd49b7dfe216..69e22bde0fdb 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -43,6 +43,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c5694cc4ddd2..1262ee1ea09b 100755
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


