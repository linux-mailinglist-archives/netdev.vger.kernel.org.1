Return-Path: <netdev+bounces-86747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F78A025A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468ED28213C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEA184103;
	Wed, 10 Apr 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GTipCHqt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ffn0NArA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sxxjHmIb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="51yqni8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1F181D03
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785859; cv=none; b=mciMrCnVAV13lrEg0cGjgsvZW49hJ8QcZ4JSE4EiCe6dTjQ2oTNAclGBnwvYeQQNb/we7MqSVVX1Ll8yCfET10HrrtCyUBJGWTNRGZHHSLjXIKmHmO3yiIri5bMHOCMafWfeOW0lsa152iiWR0jCN7W4b6W8xkaR2Imr6QAx7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785859; c=relaxed/simple;
	bh=7ymCZ5Oei6TbD2JuimG4lGlxjl4zIQIE9kk/hIzNH1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCQrKMuZoLWKfN1Y5lPe5um9TVBQa/riGozqmy07BpQ3qrq9qa8dNeUYyT/drL+5Wg+k6eTyv7PKnb2PJQTspnc9UYLqQ8B8vBt19YgC95Zhexzu1Tw4BDx+QBZpcQT/OTtiq0KM8VIInyFwDcpUEwgk3c+ExKTNmV8Vcy2lLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GTipCHqt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ffn0NArA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sxxjHmIb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=51yqni8W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0102A336DE;
	Wed, 10 Apr 2024 21:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712785855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBDPPI0/nra4JHZ7RWCn3DsawmCuFxkyTUODXz7F5lU=;
	b=GTipCHqts4Jhwa2ohWZ+STPv5wQ3nolpsRN6aSMW2BJq2TP2GRk6zD3+l2XNnFEsDn63Ok
	jGQ6XoVOWuRaU3YKys4N01ky5je6nHvorKpmr9azltC7Bn16NAtSTxZR/FOQRE2Uxq13A4
	uR4nK6cmanqFz3QWh442+AUCVZsrfVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712785855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBDPPI0/nra4JHZ7RWCn3DsawmCuFxkyTUODXz7F5lU=;
	b=ffn0NArADpiXiZzKjhrtRfRvIWvmNU2st40Y7n7FiNlfqSFYTcDseXzoPr8ZE2Lhm+Czej
	5F+HKxRh7182E4Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sxxjHmIb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=51yqni8W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712785854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBDPPI0/nra4JHZ7RWCn3DsawmCuFxkyTUODXz7F5lU=;
	b=sxxjHmIbb6fvASQSIIOb5Iw/Ff5Xe/Yzl3mINvuEk3cUDFQttVoA2QHv+dAwH8AH8B+Jqy
	uypoGf6r5jYuA6y4QWtRdgsWXUKeCj0G8CN/KMgnuNmcqwJCWUCCVhodk+xLOd5sTi2P5f
	fwSjT7NfCrK2RKzHPeU3oEM4Gp56x1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712785854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBDPPI0/nra4JHZ7RWCn3DsawmCuFxkyTUODXz7F5lU=;
	b=51yqni8WHpU95GgBaYD97csTWZKFJDaoXf8BoG7rK085tB+TGyDlxDU6C10zgSGAAaaGq9
	Mz0hJGwUBS3f7OAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A185013691;
	Wed, 10 Apr 2024 21:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cfRpIL0JF2aDGAAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 10 Apr 2024 21:50:53 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH v2] udp: Avoid call to compute_score on multiple sites
Date: Wed, 10 Apr 2024 17:50:47 -0400
Message-ID: <20240410215047.21462-1-krisman@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,isovalent.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0102A336DE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.51

We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
sockets are present").  The failing tests were those that would spawn
UDP sockets per-cpu on systems that have a high number of cpus.

Unsurprisingly, it is not caused by the extra re-scoring of the reused
socket, but due to the compiler no longer inlining compute_score, once
it has the extra call site in udp4_lib_lookup2.  This is augmented by
the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.

We could just explicitly inline it, but compute_score() is quite a large
function, around 300b.  Inlining in two sites would almost double
udp4_lib_lookup2, which is a silly thing to do just to workaround a
mitigation.  Instead, this patch shuffles the code a bit to avoid the
multiple calls to compute_score.  Since it is a static function used in
one spot, the compiler can safely fold it in, as it did before, without
increasing the text size.

With this patch applied I ran my original iperf3 testcases.  The failing
cases all looked like this (ipv4):
	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2

where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
tree. harmean == harmonic mean; CV == coefficient of variation.

ipv4:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)

ipv6:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)

This restores the performance we had before the change above with this
benchmark.  We obviously don't expect any real impact when mitigations
are disabled, but just to be sure it also doesn't regresses:

mitigations=off ipv4:
                 1G                10G                  MAX
	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)

Cc: Lorenz Bauer <lmb@isovalent.com>
Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
Changes since v1:
(me)
  - recollected performance data after changes below only for the
  mitigations enabled case.
(suggested by Willem de Bruijn)
  - Drop __always_inline in compute_score
  - Simplify logic by replacing third struct sock pointer with bool
  - Fix typo in commit message
  - Don't explicitly break out of loop after rescore
---
 net/ipv4/udp.c | 18 +++++++++++++-----
 net/ipv6/udp.c | 17 +++++++++++++----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f..a13ef8e06093 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool rescore = false;
 
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+rescore:
+		score = compute_score((rescore ? result : sk), net, saddr,
+				      sport, daddr, hnum, dif, sdif);
+		rescore = false;
 		if (score > badness) {
 			badness = score;
 
@@ -456,9 +459,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(result, net, saddr, sport,
-						daddr, hnum, dif, sdif);
-
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7c1e6469d091..7a55c050de2b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -168,12 +168,15 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool rescore = false;
 
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+rescore:
+		score = compute_score((rescore ? result : sk), net, saddr,
+				      sport, daddr, hnum, dif, sdif);
+		rescore = false;
 		if (score > badness) {
 			badness = score;
 
@@ -197,8 +200,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(sk, net, saddr, sport,
-						daddr, hnum, dif, sdif);
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
-- 
2.44.0


