Return-Path: <netdev+bounces-302458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RJ3qCqoFQmptywkAu9opvQ
	(envelope-from <netdev+bounces-302458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8D6D6140
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:42:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r1A2HToE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302458-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=hotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0713006B6B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727DF2C324C;
	Mon, 29 Jun 2026 05:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062E1DED5C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:41:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711719; cv=none; b=LYfmtqRRC132uqkTfhELAUYjlvGzqqx5pMrS7gWfi5OP4WcY1oW/WNJ8tLV0wsOpZRNh1Pk99OALxDCS1iwh9jLYi/Z/ffUPv8LcN6qG6LwDtJLPb4M7fNIW+fipTmHNzrbPtoQx/sSrb/SzrvKHk4jHnVdFuoRccmQcyQCarJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711719; c=relaxed/simple;
	bh=uhjBh41DxIo5vLVsU+SIauIddKXQrq5SMv4M/DXGVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLMC12Px/6Nhj3W2AxBKskpFhn+DYzAKRFA2b1cttep/ozlliMSDvkj5hcDPOpvX8RWqRAhIYPT5Xeb9aM53kA2FHuvWx1Gu9AnwSSUhWxVc1zj99GWLd0gm5Mcg6ZTtpxO25hCt5z0PJBZW0QE/zjcpBmLiMB6JO8XtlKxck+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1A2HToE; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38005a36edbso257551a91.1
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782711717; x=1783316517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=70pb87F25LFPf8xlmQiDVTlP75a0hwYXQXDgdivM2Ks=;
        b=r1A2HToE0hgH/V3oMDXammHncfi21fmUeaSMq2iy1AyHs9Jph3SVp79N+ha8hFL2rG
         4RenLsMpe9bxs+nk93J5tjv84WAx/4YylfaIWX2GXv0PZQjW97Ergs3/CFaCc6o5DxUE
         qXzZLyXaKEugJDmmgvlSorZbTXO+vDC1LPyOYX+xxwaMM8QmZg/gmdxjGAe08QEoSyVo
         BH2DkT02zDfFxEz7rlvxVe3kjeHkwwDCydan9vvPSsLWn7BJ6iO26w0+WJwg/iC8t9Hz
         OYn9MRJNirRKbVvsUJUjvz4n6tllqr5JoBVKSIBq7VJA9rtdCvMtcorXsVe09G4QMOwW
         Wo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711717; x=1783316517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70pb87F25LFPf8xlmQiDVTlP75a0hwYXQXDgdivM2Ks=;
        b=GEeQoCc9HvoyoDPzP0fRHunsdrrTU6+tTCnb2rCjmKhp7MUD7HlORczqh2/zschHdk
         XHk8rBfL5j+PvQGDeGCitV5TbFsfa0wEEf0AC8qk1KPH+6TUHNyQVg0p1SOIuW4TexGn
         n2XpQ6Z59R1ZIH4ywJuVAF+A5b8kbercFnTMiB6/T8cqOTRoOAd/GtWdeLzaYK/1HuJx
         gptae2Fl3kn6yPuyJd4CY352VI5eWVFbh54IdoLDJYM/F7VwD11z0jPeBZl1lEzrQ6XE
         DBblQTJgDJJrDSq3hUl2gU02xk+A270ExsJL5rUm13uYteZqNaghzlGRg08IKULmMwsJ
         UH0A==
X-Forwarded-Encrypted: i=1; AHgh+RrSPKxWu0y61FnR1BmExQVS38k6nndeQ0Rn8lN4kyCu/g16hgjh/iOpRs/uCEErCcPlT294MP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uB2i2gT6Nd8KfOA1cqfEabIH/Wks6hhD3+aDo9pFupsWA1Jh
	YVjSKRfBE++o+xZW7qsSqIGmMA4S7yJXkTAkCblBAVgshuxxKpG2A5zB
X-Gm-Gg: AfdE7cnbNkwihmiGSNhcCauqxsTUiJVF/zm+kuGpnu4g7VOu0R9gH+04i6S64WrMLrG
	aL2i5dGFVyMuzWzSn7OSfOdP755ytzYOR6Rs+/cVJdomEo5TzJTRvlj4oMBGo9/caFOG0LJXKIt
	q6vFPv4a+SXekJkXuDrqpRCCGb0wd/UtGQjWWhzQlmHQY1I4vJhFQ6l/rGXYG+HgL3G3LMuhr5g
	d3+FTdvj/R3Bq15WRznTcC9UTAI68jpuKwYAqSxd9rlNWNfXFF0JdiyiJ4os5znAmb8ZrX3ddYX
	aaQo1XCI2801BOnEi7OY7QM0g7/NNhR26noGEh/JvwE0Lk2cTO//yD+Rt64QSZOmNanpZPf8byC
	jPaOsPp5XLamNAAC8IujwvWWWSfoUv7d9MQI81TRqggOtmd6nOhQXsRhmCVfu7a75bo3amIXEiD
	3ZkxbVvxf+3Be3BRPSXvlO/7TaWXy3eu/4h9AyKjc/rf9+mYdENe/h4TVpuk8btnK1PQgm8uvRm
	H0oGO0eFSrsb6x/L+kGtOpjYRzRE9g/B/I=
X-Received: by 2002:a17:90b:3f10:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-37fdb062e8amr4540135a91.21.1782711716828;
        Sun, 28 Jun 2026 22:41:56 -0700 (PDT)
Received: from kirchou-macbookpro2.roam.corp.google.com ([2a00:79e0:2031:7:44f0:f54c:ad99:28ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9992a586csm44739245ad.21.2026.06.28.22.41.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Jun 2026 22:41:56 -0700 (PDT)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org
Cc: thomas.weissschuh@linutronix.de,
	davidgow@google.com,
	geert@linux-m68k.org,
	visitorckw@gmail.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Kir Chou <note351@hotmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH v3] lib/random32: convert selftest to KUnit
Date: Mon, 29 Jun 2026 14:41:42 +0900
Message-ID: <20260629054143.7737-1-note351@hotmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[hotmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302458-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:thomas.weissschuh@linutronix.de,m:davidgow@google.com,m:geert@linux-m68k.org,m:visitorckw@gmail.com,m:brendan.higgins@linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:note351@hotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,google.com,linux-m68k.org,gmail.com,linux.dev,vger.kernel.org,googlegroups.com,hotmail.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74E8D6D6140

This patch converts the existing prandom selftest (lib/random32.c) to use
the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
tests, this file is directly #included into lib/random32.c.

The new test:
- Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/random32.c.
- Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
- Moves the test logic to lib/tests/random32_kunit.c.

v2:
- Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/Kconfig.
- Add const to arrays in lib/tests/random32_kunit.c.

v3:
- Changes from tristate to bool in lib/Kconfig.debug.

This commit is verified by `./tools/testing/kunit/kunit.py run`
with the .kunit/.kunitconfig:

```
CONFIG_KUNIT=y
CONFIG_PRANDOM_KUNIT_TEST=y
```

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Kir Chou <note351@hotmail.com>
---
 lib/Kconfig                |   6 --
 lib/Kconfig.debug          |   9 ++
 lib/random32.c             | 173 +-----------------------------------
 lib/tests/random32_kunit.c | 174 +++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 177 deletions(-)
 create mode 100644 lib/tests/random32_kunit.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924be..5f185e9f1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -156,12 +156,6 @@ config AUDIT_COMPAT_GENERIC
 	depends on AUDIT_GENERIC && AUDIT_ARCH_COMPAT_GENERIC && COMPAT
 	default y
 
-config RANDOM32_SELFTEST
-	bool "PRNG perform self test on init"
-	help
-	  This option enables the 32 bit PRNG library functions to perform a
-	  self test on initialization.
-
 #
 # compression support is select'ed if needed
 #
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fd..ef1600600 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3354,6 +3354,15 @@ config PRIME_NUMBERS_KUNIT_TEST
 
 	  If unsure, say N
 
+config PRANDOM_KUNIT_TEST
+	bool "KUnit test for prandom" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the prandom functions at runtime.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/random32.c b/lib/random32.c
index 24e7acd93..0aab36792 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -126,175 +126,6 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
 
-#ifdef CONFIG_RANDOM32_SELFTEST
-static struct prandom_test1 {
-	u32 seed;
-	u32 result;
-} test1[] = {
-	{ 1U, 3484351685U },
-	{ 2U, 2623130059U },
-	{ 3U, 3125133893U },
-	{ 4U,  984847254U },
-};
-
-static struct prandom_test2 {
-	u32 seed;
-	u32 iteration;
-	u32 result;
-} test2[] = {
-	/* Test cases against taus113 from GSL library. */
-	{  931557656U, 959U, 2975593782U },
-	{ 1339693295U, 876U, 3887776532U },
-	{ 1545556285U, 961U, 1615538833U },
-	{  601730776U, 723U, 1776162651U },
-	{ 1027516047U, 687U,  511983079U },
-	{  416526298U, 700U,  916156552U },
-	{ 1395522032U, 652U, 2222063676U },
-	{  366221443U, 617U, 2992857763U },
-	{ 1539836965U, 714U, 3783265725U },
-	{  556206671U, 994U,  799626459U },
-	{  684907218U, 799U,  367789491U },
-	{ 2121230701U, 931U, 2115467001U },
-	{ 1668516451U, 644U, 3620590685U },
-	{  768046066U, 883U, 2034077390U },
-	{ 1989159136U, 833U, 1195767305U },
-	{  536585145U, 996U, 3577259204U },
-	{ 1008129373U, 642U, 1478080776U },
-	{ 1740775604U, 939U, 1264980372U },
-	{ 1967883163U, 508U,   10734624U },
-	{ 1923019697U, 730U, 3821419629U },
-	{  442079932U, 560U, 3440032343U },
-	{ 1961302714U, 845U,  841962572U },
-	{ 2030205964U, 962U, 1325144227U },
-	{ 1160407529U, 507U,  240940858U },
-	{  635482502U, 779U, 4200489746U },
-	{ 1252788931U, 699U,  867195434U },
-	{ 1961817131U, 719U,  668237657U },
-	{ 1071468216U, 983U,  917876630U },
-	{ 1281848367U, 932U, 1003100039U },
-	{  582537119U, 780U, 1127273778U },
-	{ 1973672777U, 853U, 1071368872U },
-	{ 1896756996U, 762U, 1127851055U },
-	{  847917054U, 500U, 1717499075U },
-	{ 1240520510U, 951U, 2849576657U },
-	{ 1685071682U, 567U, 1961810396U },
-	{ 1516232129U, 557U,    3173877U },
-	{ 1208118903U, 612U, 1613145022U },
-	{ 1817269927U, 693U, 4279122573U },
-	{ 1510091701U, 717U,  638191229U },
-	{  365916850U, 807U,  600424314U },
-	{  399324359U, 702U, 1803598116U },
-	{ 1318480274U, 779U, 2074237022U },
-	{  697758115U, 840U, 1483639402U },
-	{ 1696507773U, 840U,  577415447U },
-	{ 2081979121U, 981U, 3041486449U },
-	{  955646687U, 742U, 3846494357U },
-	{ 1250683506U, 749U,  836419859U },
-	{  595003102U, 534U,  366794109U },
-	{   47485338U, 558U, 3521120834U },
-	{  619433479U, 610U, 3991783875U },
-	{  704096520U, 518U, 4139493852U },
-	{ 1712224984U, 606U, 2393312003U },
-	{ 1318233152U, 922U, 3880361134U },
-	{  855572992U, 761U, 1472974787U },
-	{   64721421U, 703U,  683860550U },
-	{  678931758U, 840U,  380616043U },
-	{  692711973U, 778U, 1382361947U },
-	{  677703619U, 530U, 2826914161U },
-	{   92393223U, 586U, 1522128471U },
-	{ 1222592920U, 743U, 3466726667U },
-	{  358288986U, 695U, 1091956998U },
-	{ 1935056945U, 958U,  514864477U },
-	{  735675993U, 990U, 1294239989U },
-	{ 1560089402U, 897U, 2238551287U },
-	{   70616361U, 829U,   22483098U },
-	{  368234700U, 731U, 2913875084U },
-	{   20221190U, 879U, 1564152970U },
-	{  539444654U, 682U, 1835141259U },
-	{ 1314987297U, 840U, 1801114136U },
-	{ 2019295544U, 645U, 3286438930U },
-	{  469023838U, 716U, 1637918202U },
-	{ 1843754496U, 653U, 2562092152U },
-	{  400672036U, 809U, 4264212785U },
-	{  404722249U, 965U, 2704116999U },
-	{  600702209U, 758U,  584979986U },
-	{  519953954U, 667U, 2574436237U },
-	{ 1658071126U, 694U, 2214569490U },
-	{  420480037U, 749U, 3430010866U },
-	{  690103647U, 969U, 3700758083U },
-	{ 1029424799U, 937U, 3787746841U },
-	{ 2012608669U, 506U, 3362628973U },
-	{ 1535432887U, 998U,   42610943U },
-	{ 1330635533U, 857U, 3040806504U },
-	{ 1223800550U, 539U, 3954229517U },
-	{ 1322411537U, 680U, 3223250324U },
-	{ 1877847898U, 945U, 2915147143U },
-	{ 1646356099U, 874U,  965988280U },
-	{  805687536U, 744U, 4032277920U },
-	{ 1948093210U, 633U, 1346597684U },
-	{  392609744U, 783U, 1636083295U },
-	{  690241304U, 770U, 1201031298U },
-	{ 1360302965U, 696U, 1665394461U },
-	{ 1220090946U, 780U, 1316922812U },
-	{  447092251U, 500U, 3438743375U },
-	{ 1613868791U, 592U,  828546883U },
-	{  523430951U, 548U, 2552392304U },
-	{  726692899U, 810U, 1656872867U },
-	{ 1364340021U, 836U, 3710513486U },
-	{ 1986257729U, 931U,  935013962U },
-	{  407983964U, 921U,  728767059U },
-};
-
-static void prandom_state_selftest_seed(struct rnd_state *state, u32 seed)
-{
-#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
-	state->s1 = __seed(LCG(seed),        2U);
-	state->s2 = __seed(LCG(state->s1),   8U);
-	state->s3 = __seed(LCG(state->s2),  16U);
-	state->s4 = __seed(LCG(state->s3), 128U);
-}
-
-static int __init prandom_state_selftest(void)
-{
-	int i, j, errors = 0, runs = 0;
-	bool error = false;
-
-	for (i = 0; i < ARRAY_SIZE(test1); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test1[i].seed);
-		prandom_warmup(&state);
-
-		if (test1[i].result != prandom_u32_state(&state))
-			error = true;
-	}
-
-	if (error)
-		pr_warn("prandom: seed boundary self test failed\n");
-	else
-		pr_info("prandom: seed boundary self test passed\n");
-
-	for (i = 0; i < ARRAY_SIZE(test2); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test2[i].seed);
-		prandom_warmup(&state);
-
-		for (j = 0; j < test2[i].iteration - 1; j++)
-			prandom_u32_state(&state);
-
-		if (test2[i].result != prandom_u32_state(&state))
-			errors++;
-
-		runs++;
-		cond_resched();
-	}
-
-	if (errors)
-		pr_warn("prandom: %d/%d self tests failed\n", errors, runs);
-	else
-		pr_info("prandom: %d self tests passed\n", runs);
-	return 0;
-}
-core_initcall(prandom_state_selftest);
+#ifdef CONFIG_PRANDOM_KUNIT_TEST
+#include "tests/random32_kunit.c"
 #endif
diff --git a/lib/tests/random32_kunit.c b/lib/tests/random32_kunit.c
new file mode 100644
index 000000000..13c657b00
--- /dev/null
+++ b/lib/tests/random32_kunit.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for random32 functions.
+ */
+
+#include <kunit/test.h>
+
+static const struct prandom_test1 {
+	u32 seed;
+	u32 result;
+} test1[] = {
+	{ 1U, 3484351685U },
+	{ 2U, 2623130059U },
+	{ 3U, 3125133893U },
+	{ 4U,  984847254U },
+};
+
+static const struct prandom_test2 {
+	u32 seed;
+	u32 iteration;
+	u32 result;
+} test2[] = {
+	/* Test cases against taus113 from GSL library. */
+	{  931557656U, 959U, 2975593782U },
+	{ 1339693295U, 876U, 3887776532U },
+	{ 1545556285U, 961U, 1615538833U },
+	{  601730776U, 723U, 1776162651U },
+	{ 1027516047U, 687U,  511983079U },
+	{  416526298U, 700U,  916156552U },
+	{ 1395522032U, 652U, 2222063676U },
+	{  366221443U, 617U, 2992857763U },
+	{ 1539836965U, 714U, 3783265725U },
+	{  556206671U, 994U,  799626459U },
+	{  684907218U, 799U,  367789491U },
+	{ 2121230701U, 931U, 2115467001U },
+	{ 1668516451U, 644U, 3620590685U },
+	{  768046066U, 883U, 2034077390U },
+	{ 1989159136U, 833U, 1195767305U },
+	{  536585145U, 996U, 3577259204U },
+	{ 1008129373U, 642U, 1478080776U },
+	{ 1740775604U, 939U, 1264980372U },
+	{ 1967883163U, 508U,   10734624U },
+	{ 1923019697U, 730U, 3821419629U },
+	{  442079932U, 560U, 3440032343U },
+	{ 1961302714U, 845U,  841962572U },
+	{ 2030205964U, 962U, 1325144227U },
+	{ 1160407529U, 507U,  240940858U },
+	{  635482502U, 779U, 4200489746U },
+	{ 1252788931U, 699U,  867195434U },
+	{ 1961817131U, 719U,  668237657U },
+	{ 1071468216U, 983U,  917876630U },
+	{ 1281848367U, 932U, 1003100039U },
+	{  582537119U, 780U, 1127273778U },
+	{ 1973672777U, 853U, 1071368872U },
+	{ 1896756996U, 762U, 1127851055U },
+	{  847917054U, 500U, 1717499075U },
+	{ 1240520510U, 951U, 2849576657U },
+	{ 1685071682U, 567U, 1961810396U },
+	{ 1516232129U, 557U,    3173877U },
+	{ 1208118903U, 612U, 1613145022U },
+	{ 1817269927U, 693U, 4279122573U },
+	{ 1510091701U, 717U,  638191229U },
+	{  365916850U, 807U,  600424314U },
+	{  399324359U, 702U, 1803598116U },
+	{ 1318480274U, 779U, 2074237022U },
+	{  697758115U, 840U, 1483639402U },
+	{ 1696507773U, 840U,  577415447U },
+	{ 2081979121U, 981U, 3041486449U },
+	{  955646687U, 742U, 3846494357U },
+	{ 1250683506U, 749U,  836419859U },
+	{  595003102U, 534U,  366794109U },
+	{   47485338U, 558U, 3521120834U },
+	{  619433479U, 610U, 3991783875U },
+	{  704096520U, 518U, 4139493852U },
+	{ 1712224984U, 606U, 2393312003U },
+	{ 1318233152U, 922U, 3880361134U },
+	{  855572992U, 761U, 1472974787U },
+	{   64721421U, 703U,  683860550U },
+	{  678931758U, 840U,  380616043U },
+	{  692711973U, 778U, 1382361947U },
+	{  677703619U, 530U, 2826914161U },
+	{   92393223U, 586U, 1522128471U },
+	{ 1222592920U, 743U, 3466726667U },
+	{  358288986U, 695U, 1091956998U },
+	{ 1935056945U, 958U,  514864477U },
+	{  735675993U, 990U, 1294239989U },
+	{ 1560089402U, 897U, 2238551287U },
+	{   70616361U, 829U,   22483098U },
+	{  368234700U, 731U, 2913875084U },
+	{   20221190U, 879U, 1564152970U },
+	{  539444654U, 682U, 1835141259U },
+	{ 1314987297U, 840U, 1801114136U },
+	{ 2019295544U, 645U, 3286438930U },
+	{  469023838U, 716U, 1637918202U },
+	{ 1843754496U, 653U, 2562092152U },
+	{  400672036U, 809U, 4264212785U },
+	{  404722249U, 965U, 2704116999U },
+	{  600702209U, 758U,  584979986U },
+	{  519953954U, 667U, 2574436237U },
+	{ 1658071126U, 694U, 2214569490U },
+	{  420480037U, 749U, 3430010866U },
+	{  690103647U, 969U, 3700758083U },
+	{ 1029424799U, 937U, 3787746841U },
+	{ 2012608669U, 506U, 3362628973U },
+	{ 1535432887U, 998U,   42610943U },
+	{ 1330635533U, 857U, 3040806504U },
+	{ 1223800550U, 539U, 3954229517U },
+	{ 1322411537U, 680U, 3223250324U },
+	{ 1877847898U, 945U, 2915147143U },
+	{ 1646356099U, 874U,  965988280U },
+	{  805687536U, 744U, 4032277920U },
+	{ 1948093210U, 633U, 1346597684U },
+	{  392609744U, 783U, 1636083295U },
+	{  690241304U, 770U, 1201031298U },
+	{ 1360302965U, 696U, 1665394461U },
+	{ 1220090946U, 780U, 1316922812U },
+	{  447092251U, 500U, 3438743375U },
+	{ 1613868791U, 592U,  828546883U },
+	{  523430951U, 548U, 2552392304U },
+	{  726692899U, 810U, 1656872867U },
+	{ 1364340021U, 836U, 3710513486U },
+	{ 1986257729U, 931U,  935013962U },
+	{  407983964U, 921U,  728767059U },
+};
+
+static void prandom_state_test_seed(struct rnd_state *state, u32 seed)
+{
+#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
+	state->s1 = __seed(LCG(seed),        2U);
+	state->s2 = __seed(LCG(state->s1),   8U);
+	state->s3 = __seed(LCG(state->s2),  16U);
+	state->s4 = __seed(LCG(state->s3), 128U);
+}
+
+static void test_prandom_seed_boundary(struct kunit *test)
+{
+	int i;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test1); i++) {
+		prandom_state_test_seed(&state, test1[i].seed);
+		prandom_warmup(&state);
+		KUNIT_EXPECT_EQ(test, test1[i].result, prandom_u32_state(&state));
+	}
+}
+
+static void test_prandom_taus113(struct kunit *test)
+{
+	int i, j;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test2); i++) {
+		prandom_state_test_seed(&state, test2[i].seed);
+		prandom_warmup(&state);
+
+		for (j = 0; j < test2[i].iteration - 1; j++)
+			prandom_u32_state(&state);
+
+		KUNIT_EXPECT_EQ(test, test2[i].result, prandom_u32_state(&state));
+	}
+}
+
+static struct kunit_case prandom_test_cases[] = {
+	KUNIT_CASE(test_prandom_seed_boundary),
+	KUNIT_CASE(test_prandom_taus113),
+	{}
+};
+
+static struct kunit_suite prandom_test_suite = {
+	.name = "prandom",
+	.test_cases = prandom_test_cases,
+};
+
+kunit_test_suite(prandom_test_suite);
-- 
2.52.0


