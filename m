Return-Path: <netdev+bounces-281686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKacHzxn8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:52:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FB47F4E3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF9E7310EAA1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A83DCDBB;
	Tue, 28 Apr 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGIHnEMB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31F3DA7D9;
	Tue, 28 Apr 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360939; cv=none; b=PaEAfugmJs3IjqAvvDSrER9yGr8bEDmTbP2aoAwWYpmeOQRx1MqVfdCBtMcGCu+rnBfEmP0jjG9X5/foSc2Wc6lroSir9X6RUt5ypAShcmn+4UlUe5KtJXBYr4gL+6VnGnXW5D+Oas9tOhEu7SIDP4Y/4ioMgI5Uu2FO3Ies1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360939; c=relaxed/simple;
	bh=GsYEHEkt98uPa1kAUcoAyuDvM0AUCRrOyaT9RTmz9q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag8ZHOlcmzLS9bbVuKQCU0TNZTmpd91ACV6OdMkOuotRDmsmTDdikJFZHEtcYoc81iZMhAQpfenbW/+fyi8ItoxTZDKks6DyqdckJruFyDb533SGuZ7NshhQRe0vuc832BkPofaVGx4Scr2nxg+KZs/YoKQ/hT28DzGSNGh4740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGIHnEMB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360937; x=1808896937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GsYEHEkt98uPa1kAUcoAyuDvM0AUCRrOyaT9RTmz9q8=;
  b=dGIHnEMB5PWlLtFAzfU0/alY0HiBI76q3PwGLo8q69v5Mmbz9fmgryCt
   lseGNXDwTpP27xjhXbcZkemHreBpmp7UbwE8KuEHyZ5OP+5g+BBKFQXP9
   9VfbEoRQleUnUXIlsBOHetOghmEeVWRHNo4vx5jiiG+pGZGu3EPEP3qm4
   RhpGOhJodSAc691PnVnrb1Ea+Hc0r9FL+kTfS5VzfyDZCiVKJR2LVOk+S
   Dx34mRVucUB8oiDKhc9Vx89K5X41OYKSAl8Bjv/YEsbI4ypZdEAzIT98L
   +A3Z3qEfMjbiDT2DVtVbLeM3objRvXyq66tneGz0mL923SYw9z743/4gX
   w==;
X-CSE-ConnectionGUID: +QqqQzjBRK+UJNh2GJiBgA==
X-CSE-MsgGUID: 5srFOKerRQeX/Sn/kogdfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89720831"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89720831"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:14 -0700
X-CSE-ConnectionGUID: WASokzf3QwCfAqesvCb2Gg==
X-CSE-MsgGUID: fLtZC1HJS5mPzb1uoGYSWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238206405"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Apr 2026 00:22:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 01E3699; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/9] thunderbolt: Add KUnit test for tb_property_merge_dir()
Date: Tue, 28 Apr 2026 09:22:02 +0200
Message-ID: <20260428072209.3084930-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D33FB47F4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]

This makes sure it keeps working if we ever need to change it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/test.c | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f4318249c22..ce14ab9ef7dd 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2852,6 +2852,87 @@ static void tb_test_property_copy(struct kunit *test)
 	tb_property_free_dir(src);
 }
 
+static void tb_test_property_merge(struct kunit *test)
+{
+	struct tb_property_dir *dir1, *dir2, *dir3;
+	struct tb_property *p;
+	uuid_t uuid;
+	int ret;
+
+	dir1 = tb_property_create_dir(&network_dir_uuid);
+	KUNIT_ASSERT_NOT_NULL(test, dir1);
+	ret = tb_property_add_immediate(dir1, "prtcid", 1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = tb_property_add_immediate(dir1, "prtcvers", 1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = tb_property_add_immediate(dir1, "prtcrevs", 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = tb_property_add_immediate(dir1, "prtcstns", 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	dir2 = tb_property_create_dir(&network_dir_uuid);
+	KUNIT_ASSERT_NOT_NULL(test, dir2);
+	ret = tb_property_add_text(dir2, "descr", "This is text");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	/* This replaces the value in dir1 */
+	ret = tb_property_add_immediate(dir2, "prtcvers", 0x1234);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	uuid_gen(&uuid);
+	dir3 = tb_property_create_dir(&uuid);
+	KUNIT_ASSERT_NOT_NULL(test, dir3);
+	ret = tb_property_add_immediate(dir3, "value0", 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = tb_property_add_text(dir3, "value1", "Text value");
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	ret = tb_property_add_dir(dir2, "my", dir3);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = tb_property_merge_dir(dir1, dir2, true);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	p = tb_property_get_next(dir1, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "prtcid");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_VALUE);
+	KUNIT_ASSERT_EQ(test, p->length, 1);
+	KUNIT_ASSERT_EQ(test, p->value.immediate, 1);
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "prtcvers");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_VALUE);
+	KUNIT_ASSERT_EQ(test, p->length, 1);
+	KUNIT_ASSERT_EQ(test, p->value.immediate, 0x1234);
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "prtcrevs");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_VALUE);
+	KUNIT_ASSERT_EQ(test, p->length, 1);
+	KUNIT_ASSERT_EQ(test, p->value.immediate, 0);
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "prtcstns");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_VALUE);
+	KUNIT_ASSERT_EQ(test, p->length, 1);
+	KUNIT_ASSERT_EQ(test, p->value.immediate, 0);
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "descr");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_TEXT);
+	KUNIT_ASSERT_EQ(test, p->length, 4);
+	KUNIT_ASSERT_STREQ(test, p->value.text, "This is text");
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	KUNIT_ASSERT_STREQ(test, &p->key[0], "my");
+	KUNIT_ASSERT_EQ(test, p->type, TB_PROPERTY_TYPE_DIRECTORY);
+	compare_dirs(test, p->value.dir, dir3);
+	p = tb_property_get_next(dir1, p);
+	KUNIT_ASSERT_NULL(test, p);
+
+	tb_property_free_dir(dir2);
+	tb_property_free_dir(dir1);
+}
+
 static struct kunit_case tb_test_cases[] = {
 	KUNIT_CASE(tb_test_path_basic),
 	KUNIT_CASE(tb_test_path_not_connected_walk),
@@ -2892,6 +2973,7 @@ static struct kunit_case tb_test_cases[] = {
 	KUNIT_CASE(tb_test_property_parse),
 	KUNIT_CASE(tb_test_property_format),
 	KUNIT_CASE(tb_test_property_copy),
+	KUNIT_CASE(tb_test_property_merge),
 	{ }
 };
 
-- 
2.50.1


