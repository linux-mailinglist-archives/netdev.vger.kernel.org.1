Return-Path: <netdev+bounces-283686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGJ2NnfI92nQmAIAu9opvQ
	(envelope-from <netdev+bounces-283686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:13:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3464B7A91
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D25FB30053D5
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF13ACEEB;
	Sun,  3 May 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Io95VhSx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tyLMLcKU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Io95VhSx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tyLMLcKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282A370D6D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846377; cv=none; b=rZM8TkGGJR+lHnmZd3UoliXrzgUOWUc/Q/sZsOcUiOWtXmXAI1D7X+7GwKxGrG+lPLiQWP7xlOODj21viGMDA0LnvNRvaYJjyGKXbE9a6p/Q1HkhCjsTIaUwpWb9bPGVtiluJG1E44nje/tprXNxLWAcTwMbQAt6rexLwsbZ9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846377; c=relaxed/simple;
	bh=1mf3tkl8qWKbkeqF5RRpeyrpELdMLqU8OYYZzq5+rL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQEq7rgL/48wQJb+hTdihwAarc2Z0f5KI/B9hYz6FutmZb7Hq3fFzfOZILFufajUBQjx1Egj0FwPO4nswuv3cH9XJg7tSK+LIMVEZDkesm6kall3Vrux2Qpc32rkejj8UP4DGgMYYCo5e3PyEmUQdm5sjlGkPvB0pNmFkImncA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Io95VhSx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tyLMLcKU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Io95VhSx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tyLMLcKU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F7AF5C393;
	Sun,  3 May 2026 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777846374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huoKVWsTKeHYGBOjUnA95QGOFj5UB8vjB5w/jEXmfKg=;
	b=Io95VhSxTKmj6KKUxuF6WnSpUWg61Z+vQF3SXLWvg7GBKBu1XAd/Hso+hJoYv4ZjYZopBK
	O4lz6pGPqisnJ99bc3wjSdBsC8O3eOmbMAjsGqJyPsKxaJIkkrjjp25N6Acdklc22UL/to
	mvr9slmRMxZXMVlS9grYUzLfZo9qShY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777846374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huoKVWsTKeHYGBOjUnA95QGOFj5UB8vjB5w/jEXmfKg=;
	b=tyLMLcKUV3EPzd+ixjt9uj2Oj+7Ya74ZaZR08oijB1q+UB2BCyrKUbUwAeWq0dHZ9KY29w
	PSv18nN4oJO0KPCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Io95VhSx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tyLMLcKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777846374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huoKVWsTKeHYGBOjUnA95QGOFj5UB8vjB5w/jEXmfKg=;
	b=Io95VhSxTKmj6KKUxuF6WnSpUWg61Z+vQF3SXLWvg7GBKBu1XAd/Hso+hJoYv4ZjYZopBK
	O4lz6pGPqisnJ99bc3wjSdBsC8O3eOmbMAjsGqJyPsKxaJIkkrjjp25N6Acdklc22UL/to
	mvr9slmRMxZXMVlS9grYUzLfZo9qShY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777846374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huoKVWsTKeHYGBOjUnA95QGOFj5UB8vjB5w/jEXmfKg=;
	b=tyLMLcKUV3EPzd+ixjt9uj2Oj+7Ya74ZaZR08oijB1q+UB2BCyrKUbUwAeWq0dHZ9KY29w
	PSv18nN4oJO0KPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CFF593A3;
	Sun,  3 May 2026 22:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cDGmMGXI92kabwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 03 May 2026 22:12:53 +0000
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
Subject: [PATCH 2/2 net] selftests: fib_tests: add temporary IPv6 address renewal test
Date: Mon,  4 May 2026 00:11:41 +0200
Message-ID: <20260503221139.3742-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503221139.3742-3-fmancera@suse.de>
References: <20260503221139.3742-3-fmancera@suse.de>
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
X-Rspamd-Queue-Id: 3D3464B7A91
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-283686-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add a test to check that temporary IPv6 address is regenerated properly
after the base prefix is deprecated and restored.

Fib6 temporary address renewal test
    TEST: IPv6 temporary address cleanly deprecated and regenerated     [ OK ]

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 tools/testing/selftests/net/fib_tests.sh | 55 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index af64f93bb2e1..6a6e545cb40d 100755
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
@@ -1611,6 +1611,58 @@ fib6_ra_to_static()
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
+	sleep 2
+
+	# Deprecate it
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#0 -e
+	sleep 2
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
+}
+
 # add route for a prefix, flushing any existing routes first
 # expected to be the first step of a test
 add_route()
@@ -3002,6 +3054,7 @@ do
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
+	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.53.0


