Return-Path: <netdev+bounces-285335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKlLFbyU/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4814E94F8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AEE30686FB
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20D3F9F27;
	Thu,  7 May 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LsBAqdKf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nZO3DErO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LsBAqdKf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nZO3DErO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AF3EB7E5
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160527; cv=none; b=djTuQM9zgZDoyi6EvN3DBOTjkQ/+ZqrYt0NcpDU6iWBGmj/vOFUIYPgnxAMRWFm+8C+mW27z7umpFg1voVthPACQeTlS/wDuKhfPD2/nEb9CwYsl2C8RVMnedtf3uDfHhRRn1OXNfKgMSTzD6faENgqv7BuxDZyoyKBvB2UIWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160527; c=relaxed/simple;
	bh=xoRzczstH8+FsGG7i75t2z/jmfGj5UewfUUSOee2QZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2k+eQl6LJcq9BYvdP/e/HwGRHOkrOX0Br/L1ZKz4PdJKw33h+0QYQcyx2kCJMeCvoCsB8fxuC2h4gKi6su+7qq/sGmxHcxyRY40rvVLNShpuH81L+UJ2lsMwmDmW+/SAQX4Rr9aiMw1nbmUAWh0kCCD+57FH+kCMasPOarsDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LsBAqdKf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nZO3DErO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LsBAqdKf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nZO3DErO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A21976BDF6;
	Thu,  7 May 2026 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778160513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9mbyS9qoa8mR+MvrwsXX94w+0qs5WmlqiGoNWsdFGM=;
	b=LsBAqdKf9mqGuoRqCiWNxKKwwuP1sm2L660efeH3xibrftEzFpt/pWJiZDdyCDm48l2rs8
	9OxY4Tf3aWN36DNcHopP5MTai0bicCeRYlgCqJlNZODId/u2btw2lJKeT2ue+tMeu4Wgxe
	cM3Dh/PKpVWZWWAWgkMaP4rrou+65KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778160513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9mbyS9qoa8mR+MvrwsXX94w+0qs5WmlqiGoNWsdFGM=;
	b=nZO3DErOqwfTGtJdhie4P0EN0zBwo/pJaVL+UxaszxxgidYsPiD5WHt21VZ/KEdX6tzQIL
	Ukvv/HNoeuV2wODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778160513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9mbyS9qoa8mR+MvrwsXX94w+0qs5WmlqiGoNWsdFGM=;
	b=LsBAqdKf9mqGuoRqCiWNxKKwwuP1sm2L660efeH3xibrftEzFpt/pWJiZDdyCDm48l2rs8
	9OxY4Tf3aWN36DNcHopP5MTai0bicCeRYlgCqJlNZODId/u2btw2lJKeT2ue+tMeu4Wgxe
	cM3Dh/PKpVWZWWAWgkMaP4rrou+65KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778160513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9mbyS9qoa8mR+MvrwsXX94w+0qs5WmlqiGoNWsdFGM=;
	b=nZO3DErOqwfTGtJdhie4P0EN0zBwo/pJaVL+UxaszxxgidYsPiD5WHt21VZ/KEdX6tzQIL
	Ukvv/HNoeuV2wODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159AD593A7;
	Thu,  7 May 2026 13:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CeHAoGT/GlAdgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 07 May 2026 13:28:33 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net v3] selftests: fib_tests: add temporary IPv6 address renewal test
Date: Thu,  7 May 2026 15:28:28 +0200
Message-ID: <20260507132828.3923-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507132828.3923-1-fmancera@suse.de>
References: <20260507132828.3923-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Queue-Id: AF4814E94F8
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a test to check that temporary IPv6 address is regenerated properly
after the base prefix is deprecated and restored.

Fib6 temporary address renewal test
    TEST: IPv6 temporary address cleanly deprecated and regenerated     [ OK ]

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjusted the sleep so there is enough time for the issue to trigger,
added cleanup at the end
v3: no changes
---
 tools/testing/selftests/net/fib_tests.sh | 59 +++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index af64f93bb2e1..8f10de0eb985 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       ipv4_mpath_balance_preferred fib6_ra_to_static"
+       ipv4_mpath_balance_preferred fib6_ra_to_static fib6_temp_addr_renewal"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1611,6 +1611,62 @@ fib6_ra_to_static()
 	cleanup &> /dev/null
 }
 
+fib6_temp_addr_renewal() {
+	setup
+
+	echo
+	echo "Fib6 temporary address renewal test"
+	set -e
+
+	# ra6 is required for the test. (ipv6toolkit)
+	if [ ! -x "$(command -v ra6)" ]; then
+	    echo "SKIP: ra6 not found."
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	# Create a pair of veth devices to send a RA message from one
+	# device to another.
+	$IP link add veth1 type veth peer name veth2
+	$IP link set dev veth1 up
+	$IP link set dev veth2 up
+
+	# Make veth1 ready to receive RA messages.
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra=2
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.use_tempaddr=2
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.temp_prefered_lft=15
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.max_desync_factor=0
+
+	# Send a RA message with a prefix from veth2.
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
+	sleep 3
+
+	# Deprecate it
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#0 -e
+	sleep 3
+
+	# Restore it
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
+
+	ret=1
+	for i in $(seq 1 25); do
+		sleep 1
+		num_dep="$($IP -6 addr | grep -c "temporary deprecated" || true)"
+		num_tot="$($IP -6 addr | grep -c "temporary" || true)"
+
+		if [ "$num_dep" -eq 1 ] && [ "$num_tot" -ge 2 ]; then
+			ret=0
+			break
+		fi
+	done
+	log_test "$ret" 0 "IPv6 temporary address cleanly deprecated and regenerated"
+
+	set +e
+
+	cleanup &> /dev/null
+}
+
 # add route for a prefix, flushing any existing routes first
 # expected to be the first step of a test
 add_route()
@@ -3002,6 +3058,7 @@ do
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
+	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.53.0


