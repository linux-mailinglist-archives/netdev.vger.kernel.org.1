Return-Path: <netdev+bounces-296109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zx0EJJAbJGoZ3QEAu9opvQ
	(envelope-from <netdev+bounces-296109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1539264D956
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AbLPVol+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296109-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296109-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 731FE300CDAF
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2F3AEF56;
	Sat,  6 Jun 2026 13:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4084374195
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 13:07:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751245; cv=none; b=GfNOBQ2PMG/7krF4IYW8PKuKNbA9WEJDf5Oy4wafmoxm7tFHUb5SQpJdNtngArPtMYO6UQzW6v5GTNNAZBveNC5D+CtBvYrwG31q7D/oRgiU4cjWMYFZnhnZAQdYvFgSA5jtAISeOPdk65vlVG+JwaHajINLj/iIDh8HMfV4BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751245; c=relaxed/simple;
	bh=TH02C531ya4EYCZQFY6c3f5eVTZECijz5Aysbs8Gx2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e84mLpTBZdE1KMhqh5qyESsoOLASdpKC+HiBzH69W5KLcpWR1IVXEFaJxYpf8AmKl+ntkzJJCyH7PVanzpkwhf7H2UzUfnvPSqVsDz+K82WJFc/fYJQ0ThLkJ9xszStsLLiYV4C6kPJWs0aYEgEZIqLezyzKEawrj9QLKe9GeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbLPVol+; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3315c5dso30598645ad.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780751241; x=1781356041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veYfMy0PCVcZ+n592xWxBVNK/i0lhuN94fc/OXBB5Rs=;
        b=AbLPVol+xgAaKT0Pgim8OEPMg1/TKOUj+4pOwAnkFH7yZkEdnhMEXriBYom54XjZ2d
         x5E4KONHcnXi7T5Wk3ffKJyPIbKB1blXc7uOImlslk9qCGZ9moW/U9BWJIUTxu38nzNA
         XeXdKZRexB+Kw3d1KTqYvUgacpg+/gD5FuNry1dTyLVK4qBk9D3KajBU8uibykeXjjKV
         UboDH2L3tiREZdTG4pnThrzcObtnGhkwlFBItIICviR83Gv1Rx+8ZgAJaPF69D8ZIUgz
         3gZCi1K/M+UkEMUClTc4vLFrE5y7bk6gVxz/UKNx7DAM8F60VWYnq2sHbtnT4q5io0Kc
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780751241; x=1781356041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veYfMy0PCVcZ+n592xWxBVNK/i0lhuN94fc/OXBB5Rs=;
        b=hljc63+NoGpFze4jsxoxS8eoF/AB9JkXK6h8fw/ikpFBi7qE1uUnYYs65rYKmtI8qu
         UepEmFJdka4RbCxNj2tVdiRShtqfp56BSl/aVtvLtnD9VQGEVTqaNapLwYq8zmXWOUGx
         0yDu5HO1FM+IZRT95cXeFUBt9RoykeBY5FYc7rHIfUIQJP7IVFiKmaKScL1WkPsgVvvw
         fvPbxPMz2luSOnftWrGF0t7F4DL8lDdAj+CMbX37Fn2UPcGyLMvEXoFoXC3HEZuab45T
         7iA0Hj0fOQmJ16HzSaMNyy9c4cVPEN6vDMMRMHpkALP2BzL+srTv6zLDdpynKUzFcFyV
         rR3A==
X-Gm-Message-State: AOJu0YypQBj/lOEea6KGHZ5hqPvHMu/JP3GmpdXF81kiD1lhXIR88WZ5
	xIvjVQaghWQPqOjEdIQdvdLg7LZr16DaxDz0et0MTg7jrrA0S9RhFiN2YRW8iZFI
X-Gm-Gg: Acq92OF1FQgrwiEqR9dgtHvGkWuWMCv7UzxK0mflI6slFdwy75Gw3MIySvppMgECTCk
	uwxJvDbW71jY7Zi/mUCbSsNxctl11hemYDtB+ICt+A2gFQ7ojlz0ewItUZlKI+9i47sI0d8JEOy
	IGgvc8EvMqIF1kEhdoex5TaVrmecdhN/MJUE8DF8hV26XDrbA1t5CylSreuhQZvNVyYIYOYClkD
	Ur4/VZvwTW1nUc5a6dD/wzSyBBICpjYNo30FiE6zoLR/c96vvIK+8IIttjaX1n6bN+GXrO71JMs
	4DZUgVKV3PjMZZthkCBX1+86O+elp4qoyqMYHxMMnIOTB9YrnxXXo3LvDjNPN5sq7anCit0nMaU
	MbYIwdxZGUICRgfB3s51gIDOFQYXhuxupHjRnsJC4vrb7mwmW4+IFBKMlKxb8BgqYfZxgJG/pk+
	QDs9laZiyi0OCPaZShmTtj1xQGifGTQEUThVNJo7EjCyot71Y441V4gLXtLAvf
X-Received: by 2002:a17:902:d485:b0:2bc:eea4:83c3 with SMTP id d9443c01a7336-2c1e847ec9emr86096395ad.25.1780751240699;
        Sat, 06 Jun 2026 06:07:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm126349745ad.52.2026.06.06.06.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:07:19 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	hong son Nguyen <hongson.hn@gmail.com>
Subject: [PATCH net-next v6 2/2] net: dsa: yt921x: Add ACL support
Date: Sat,  6 Jun 2026 21:00:07 +0800
Message-ID: <20260606130011.307812-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606130011.307812-1-mmyangfl@gmail.com>
References: <20260606130011.307812-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296109-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:hongson.hn@gmail.com,m:hongsonhn@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1539264D956

Enable filtering of incoming traffics. Note that custom filters are yet
to be utilized, and thus not all flow dissectors are implemented.

Tested-by: hong son Nguyen <hongson.hn@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 1072 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  286 ++++++++++
 2 files changed, 1355 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 9cc211b90c6c..9929676a15e1 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -186,6 +186,16 @@ struct yt921x_reg_mdio {
 #define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
 #define to_device(priv) ((priv)->ds.dev)
 
+static u32 ethaddr_hi4_to_u32(const unsigned char *addr)
+{
+	return (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+}
+
+static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
+{
+	return (addr[4] << 8) | addr[5];
+}
+
 static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
 {
 	WARN_ON(!mutex_is_locked(&priv->reg_lock));
@@ -1457,6 +1467,1023 @@ yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+/* ACL: 48 blocks * 8 entries
+ *
+ * One rule can span multiple entries, but within a block.
+ */
+
+static void
+yt921x_acl_entry_set(struct yt921x_acl_entry *entry, unsigned int offset,
+		     u32 flags, bool set)
+{
+	if (set)
+		entry->key[offset] |= flags;
+	entry->mask[offset] |= flags;
+}
+
+static unsigned int
+yt921x_acl_entries_set_is_fragment(struct yt921x_acl_entry *entries,
+				   unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV4_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA3_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_MISC_FRAG, set);
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_L4_FRAG, set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 1, YT921X_ACL_BINb_MISC_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_first_frag(struct yt921x_acl_entry *entries,
+				  unsigned int size, bool set)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+			yt921x_acl_entry_set(&entries[i], 1,
+					     YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG,
+					     set);
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			yt921x_acl_entry_set(&entries[i], 0,
+					     YT921X_ACL_BINa_MISC_FIRST_FRAG,
+					     set);
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	yt921x_acl_entry_set(&entries[size], 0,
+			     YT921X_ACL_BINa_MISC_FIRST_FRAG, set);
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l3_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l3_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_MAC_DA0:
+		case YT921X_ACL_TYPE_MAC_SA0:
+			entries[i].key[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[0] |= YT921X_ACL_BINa_MISC_L3_TYPE(type);
+			entries[i].mask[0] |= YT921X_ACL_BINa_MISC_L3_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[0] = YT921X_ACL_BINa_MISC_L3_TYPE(type);
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[0] = YT921X_ACL_BINa_MISC_L3_TYPE_M;
+
+	return size + 1;
+}
+
+static unsigned int
+yt921x_acl_entries_set_l4_type(struct yt921x_acl_entry *entries,
+			       unsigned int size, enum yt921x_l4_type type)
+{
+	for (unsigned int i = 0; i < size; i++)
+		switch (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1])) {
+		case YT921X_ACL_TYPE_IPV4_DA:
+		case YT921X_ACL_TYPE_IPV4_SA:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV4_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_IPV6_DA0:
+		case YT921X_ACL_TYPE_IPV6_DA1:
+		case YT921X_ACL_TYPE_IPV6_DA2:
+		case YT921X_ACL_TYPE_IPV6_DA3:
+		case YT921X_ACL_TYPE_IPV6_SA0:
+		case YT921X_ACL_TYPE_IPV6_SA1:
+		case YT921X_ACL_TYPE_IPV6_SA2:
+		case YT921X_ACL_TYPE_IPV6_SA3:
+			entries[i].key[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_IPV6_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_L4:
+			entries[i].key[1] |= YT921X_ACL_BINb_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_L4_TYPE_M;
+			return size;
+		case YT921X_ACL_TYPE_MISC:
+			entries[i].key[1] |= YT921X_ACL_BINb_MISC_L4_TYPE(type);
+			entries[i].mask[1] |= YT921X_ACL_BINb_MISC_L4_TYPE_M;
+			return size;
+		}
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return 0;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_BINb_MISC_L4_TYPE(type) |
+			       YT921X_ACL_KEYb_TYPE(YT921X_ACL_TYPE_MISC);
+	entries[size].mask[1] = YT921X_ACL_BINb_MISC_L4_TYPE_M;
+
+	return size + 1;
+}
+
+static struct yt921x_acl_entry *
+yt921x_acl_entries_new(struct yt921x_acl_entry *entries, unsigned int *sizep,
+		       u32 type)
+{
+	unsigned int size = *sizep;
+
+	if (size >= YT921X_ACL_ENT_PER_BLK)
+		return NULL;
+
+	entries[size] = (typeof(*entries)){};
+	entries[size].key[1] = YT921X_ACL_KEYb_TYPE(type);
+
+	(*sizep)++;
+	return &entries[size];
+}
+
+static struct yt921x_acl_entry *
+yt921x_acl_entries_find(struct yt921x_acl_entry *entries, unsigned int *sizep,
+			u32 type)
+{
+	for (unsigned int i = 0; i < *sizep; i++)
+		if (FIELD_GET(YT921X_ACL_KEYb_TYPE_M, entries[i].key[1]) ==
+		    type)
+			return &entries[i];
+	return yt921x_acl_entries_new(entries, sizep, type);
+}
+
+static void
+yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
+			  u16 ports_mask)
+{
+	struct yt921x_acl_entry *entries = aclrule->entries;
+
+	for (unsigned int i = 0; i < hweight8(aclrule->mask); i++) {
+		entries[i].key[1] |= YT921X_ACL_KEYb_SPORTS(ports_mask) |
+				     YT921X_ACL_KEYb_ORD(ord);
+	}
+}
+
+struct yt921x_acl_rule_ext {
+	struct yt921x_acl_rule r;
+
+	struct yt921x_marker marker;
+};
+
+static int
+yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
+				       const struct flow_cls_offload *cls)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct yt921x_acl_entry *entries = ruleext->r.entries;
+	struct netlink_ext_ack *extack = cls->common.extack;
+	const struct flow_dissector *dissector;
+	struct yt921x_acl_entry *entry;
+	unsigned int size = 0;
+	bool use_dport;
+	bool use_sport;
+
+	/* Incomplete and probably won't, since it supports custom u32 filters.
+	 * New adapters are welcome.
+	 */
+	dissector = rule->match.dissector;
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
+		return -EOPNOTSUPP;
+	}
+
+	/* Entries */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		if (match.mask->dst) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV4_DA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->dst);
+			entry->mask[0] |= ntohl(match.mask->dst);
+		}
+
+		if (match.mask->src) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV4_SA);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->src);
+			entry->mask[0] |= ntohl(match.mask->src);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+		struct flow_match_ipv6_addrs match;
+
+		flow_rule_match_ipv6_addrs(rule, &match);
+
+		for (unsigned int i = 0; i < 4; i++) {
+			if (!match.mask->dst.s6_addr32[i])
+				continue;
+
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV6_DA0 + i);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
+			entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
+		}
+
+		for (unsigned int i = 0; i < 4; i++) {
+			if (!match.mask->src.s6_addr32[i])
+				continue;
+
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_IPV6_SA0 + i);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
+			entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
+		}
+	}
+
+	use_dport = false;
+	use_sport = false;
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		entry = yt921x_acl_entries_new(entries, &size,
+					       YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports(rule, &match);
+
+		use_dport = !!match.mask->dst;
+		use_sport = !!match.mask->src;
+
+		entry->key[0] |= (ntohs(match.key->dst) << 16) |
+				 ntohs(match.key->src);
+		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
+				  ntohs(match.mask->src);
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		struct flow_match_ports_range match;
+
+		entry = yt921x_acl_entries_find(entries, &size,
+						YT921X_ACL_TYPE_L4);
+		if (!entry)
+			goto err;
+
+		flow_rule_match_ports_range(rule, &match);
+
+		if ((use_dport && match.mask->tp.dst) ||
+		    (use_sport && match.mask->tp.src)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Port mask and range are mutually exclusive");
+			return -EINVAL;
+		}
+
+		if (match.mask->tp.dst) {
+			entry->key[0] |= ntohs(match.key->tp_min.dst) << 16;
+			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
+			entry->mask[0] |= ntohs(match.key->tp_max.dst) << 16;
+		}
+
+		if (match.mask->tp.src) {
+			entry->key[0] |= ntohs(match.key->tp_min.src);
+			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
+			entry->mask[0] |= ntohs(match.key->tp_max.src);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+		u32 mask;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		mask = ethaddr_hi4_to_u32(match.mask->dst);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_DA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->dst);
+			entry->mask[0] |= mask;
+		}
+
+		mask = ethaddr_hi4_to_u32(match.mask->src);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_SA0);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= ethaddr_hi4_to_u32(match.key->src);
+			entry->mask[0] |= mask;
+		}
+
+		mask = (ethaddr_lo2_to_u32(match.mask->dst) << 16) |
+		       ethaddr_lo2_to_u32(match.mask->src);
+		if (mask) {
+			entry = yt921x_acl_entries_new(entries, &size,
+						       YT921X_ACL_TYPE_MAC_DA1_SA1);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= (ethaddr_lo2_to_u32(match.key->dst) << 16) |
+					 ethaddr_lo2_to_u32(match.key->src);
+			entry->mask[0] |= mask;
+		}
+	}
+
+	/* Entries + Misc */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		if (match.mask->n_proto) {
+			enum yt921x_l3_type l3type = YT921X_L3_TYPE_OTHER;
+
+			if (match.mask->n_proto == htons(~0))
+				switch (match.key->n_proto) {
+				case htons(ETH_P_IP):
+					l3type = YT921X_L3_TYPE_IPV4;
+					break;
+				case htons(ETH_P_IPV6):
+					l3type = YT921X_L3_TYPE_IPV6;
+					break;
+				case htons(ETH_P_ARP):
+					l3type = YT921X_L3_TYPE_ARP;
+					break;
+				case htons(ETH_P_LLDP):
+					l3type = YT921X_L3_TYPE_LLDP;
+					break;
+				case htons(ETH_P_PAE):
+					l3type = YT921X_L3_TYPE_PAE;
+					break;
+				case htons(ETH_P_CFM):
+					l3type = YT921X_L3_TYPE_ERP;
+					break;
+				}
+
+			if (l3type != YT921X_L3_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l3_type(entries,
+								      size,
+								      l3type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_new(entries, &size,
+							       YT921X_ACL_TYPE_ETHERTYPE);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= ntohs(match.key->n_proto);
+				entry->mask[0] |= ntohs(match.mask->n_proto);
+			}
+		}
+
+		if (match.mask->ip_proto) {
+			enum yt921x_l4_type l4type = YT921X_L4_TYPE_OTHER;
+
+			if (match.mask->ip_proto == (u8)~0)
+				switch (match.key->ip_proto) {
+				case IPPROTO_TCP:
+					l4type = YT921X_L4_TYPE_TCP;
+					break;
+				case IPPROTO_UDP:
+					l4type = YT921X_L4_TYPE_UDP;
+					break;
+				case IPPROTO_UDPLITE:
+					l4type = YT921X_L4_TYPE_UDPLITE;
+					break;
+				case IPPROTO_ICMP:
+					l4type = YT921X_L4_TYPE_ICMP;
+					break;
+				case IPPROTO_IGMP:
+					l4type = YT921X_L4_TYPE_IGMP;
+					break;
+				}
+
+			if (l4type != YT921X_L4_TYPE_OTHER) {
+				size = yt921x_acl_entries_set_l4_type(entries,
+								      size,
+								      l4type);
+				if (!size)
+					goto err;
+			} else {
+				entry = yt921x_acl_entries_find(entries, &size,
+								YT921X_ACL_TYPE_MISC);
+				if (!entry)
+					goto err;
+
+				entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
+				entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
+			}
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG;
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		if (!flow_rule_is_supp_control_flags(supp_flags,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
+
+		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			bool set = match.key->flags & FLOW_DIS_IS_FRAGMENT;
+
+			size = yt921x_acl_entries_set_is_fragment(entries, size,
+								  set);
+			if (!size)
+				goto err;
+		}
+		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
+			bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
+
+			size = yt921x_acl_entries_set_first_frag(entries, size,
+								 set);
+			if (!size)
+				goto err;
+		}
+	}
+
+	/* Misc only */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(rule, &match);
+		if (match.mask->ttl) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Matching on TTL not supported");
+			return -EOPNOTSUPP;
+		}
+
+		if (match.mask->tos) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_TCP)) {
+		struct flow_match_tcp match;
+
+		flow_rule_match_tcp(rule, &match);
+		if (match.mask->flags & htons(~0xff)) {
+			NL_SET_ERR_MSG_MOD(extack, "Unsupported TCP flags");
+			return -EOPNOTSUPP;
+		}
+
+		if (match.mask->flags) {
+			entry = yt921x_acl_entries_find(entries, &size,
+							YT921X_ACL_TYPE_MISC);
+			if (!entry)
+				goto err;
+
+			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
+			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
+		}
+	}
+
+	if (!size) {
+		NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
+		return -EOPNOTSUPP;
+	}
+
+	ruleext->r.mask = (1 << size) - 1;
+	return 0;
+
+err:
+	NL_SET_ERR_MSG_MOD(extack, "Rule too complex");
+	return -EOPNOTSUPP;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
+				      const struct flow_cls_offload *cls,
+				      struct yt921x_priv *priv, int port)
+{
+	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	const struct flow_action *flow_action = &rule->action;
+	struct netlink_ext_ack *extack = cls->common.extack;
+	enum flow_action_id redir_act = NUM_FLOW_ACTIONS;
+	const struct flow_action_entry *act;
+	u32 *action = ruleext->r.action;
+	bool seen_priority = false;
+	const char *reason = NULL;
+	bool seen_police = false;
+	unsigned int i;
+	int res;
+
+	memset(action, 0, 3 * sizeof(*action));
+	flow_action_for_each(i, act, flow_action)
+		switch (act->id) {
+		case FLOW_ACTION_ACCEPT:
+		case FLOW_ACTION_DROP:
+		case FLOW_ACTION_REDIRECT:
+			if (redir_act != NUM_FLOW_ACTIONS &&
+			    redir_act != act->id) {
+				reason = "Different redirect actions";
+				goto fallback;
+			}
+			redir_act = act->id;
+
+			switch (act->id) {
+			case FLOW_ACTION_ACCEPT:
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_FWD;
+				break;
+			case FLOW_ACTION_DROP:
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_REDIR;
+				break;
+			case FLOW_ACTION_REDIRECT: {
+				struct dsa_port *to_dp;
+
+				to_dp = dsa_port_from_netdev(act->dev);
+				if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
+					reason = "Redirect to non-local port";
+					goto fallback;
+				}
+
+				action[2] |= YT921X_ACL_ACTc_FWD_EN |
+					     YT921X_ACL_ACTc_FWD_REDIR |
+					     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
+				break;
+			}
+			default:
+				break;
+			}
+			break;
+		case FLOW_ACTION_PRIORITY:
+			if (seen_priority) {
+				action[0] &= ~YT921X_ACL_ACTa_PRIO_EN;
+				action[1] &= ~YT921X_ACL_ACTb_PRIO_M;
+
+				reason = "Multiple priority actions";
+				goto fallback;
+			}
+			seen_priority = true;
+
+			if (act->priority >= YT921X_PRIO_NUM) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Priority value is too high");
+				return -EOPNOTSUPP;
+			}
+			action[0] |= YT921X_ACL_ACTa_PRIO_EN;
+			action[1] |= YT921X_ACL_ACTb_PRIO(act->priority);
+			break;
+		case FLOW_ACTION_POLICE: {
+			const struct flow_action_police *police = &act->police;
+
+			if (seen_police) {
+				action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+
+				reason = "Multiple police actions";
+				goto fallback;
+			}
+			seen_police = true;
+
+			res = yt921x_police_validate(police, flow_action, act,
+						     extack);
+			if (res)
+				return res;
+
+			res = yt921x_marker_tfm_police(&ruleext->marker, police,
+						       0, priv, port, extack);
+			if (res)
+				return res;
+
+			action[0] |= YT921X_ACL_ACTa_METER_EN;
+			break;
+		}
+		default:
+fallback:
+			if (cls->common.skip_sw) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "Action not supported when skip_sw: %s",
+						       reason);
+				return -EOPNOTSUPP;
+			}
+			fallthrough;
+		case FLOW_ACTION_TRAP:
+			redir_act = FLOW_ACTION_TRAP;
+
+			action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
+				     ~YT921X_ACL_ACTc_FWD_M;
+			action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				     YT921X_ACL_ACTc_FWD_TRAP;
+			break;
+		}
+
+	ruleext->r.sw_assisted = !cls->common.skip_sw;
+	return 0;
+}
+
+static int
+yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
+			       const struct flow_cls_offload *cls, bool ingress,
+			       struct yt921x_priv *priv)
+{
+	struct netlink_ext_ack *extack = cls->common.extack;
+	int res;
+
+	if (!ingress) {
+		NL_SET_ERR_MSG_MOD(extack, "Only ingress is supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (cls->common.chain_index) {
+		NL_SET_ERR_MSG(extack, "Only chain 0 is supported");
+		return -EOPNOTSUPP;
+	}
+
+	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
+	if (res)
+		return res;
+	res = yt921x_acl_rule_ext_parse_flow_entries(ruleext, cls);
+	if (res)
+		return res;
+
+	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	ruleext->r.tag = cls->cookie;
+	ruleext->r.type = TC_SETUP_CLSFLOWER;
+	return 0;
+}
+
+static unsigned int
+yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag)
+{
+	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
+		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
+
+		if (!aclblk)
+			continue;
+
+		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
+			    aclblk->rules[i]->type == type)
+				return YT921X_ACL_ENT_PER_BLK * blkid + i;
+	}
+
+	return UINT_MAX;
+}
+
+static unsigned int
+yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
+		   struct netlink_ext_ack *extack)
+{
+	int candidates[YT921X_ACL_ENT_PER_BLK + 1];
+	unsigned int acl_used_cnt = 0;
+
+	if (WARN_ON(entscnt > YT921X_ACL_ENT_PER_BLK))
+		return UINT_MAX;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(candidates); i++)
+		candidates[i] = -1;
+	for (unsigned int i = YT921X_ACL_BLK_NUM; i-- > 0;) {
+		unsigned int blk_used_cnt = hweight8(priv->acl_masks[i]);
+
+		candidates[blk_used_cnt] = i;
+		acl_used_cnt += blk_used_cnt;
+	}
+
+	if (acl_used_cnt >= YT921X_ACL_NUM) {
+		NL_SET_ERR_MSG_MOD(extack, "ACL entry limit reached");
+		return UINT_MAX;
+	}
+	if (acl_used_cnt + entscnt <= YT921X_ACL_NUM)
+		for (unsigned int i = YT921X_ACL_ENT_PER_BLK - entscnt + 1;
+		     i-- > 0;)
+			if (candidates[i] >= 0)
+				return YT921X_ACL_ENT_PER_BLK * candidates[i] +
+				       ffz(priv->acl_masks[candidates[i]]);
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "ACL entry allocation failed, simplify your rules or remove existing rules");
+	return UINT_MAX;
+}
+
+static int
+yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
+{
+	const struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int blkid;
+	unsigned int binid;
+	unsigned long mask;
+	u32 zeros[3] = {};
+	unsigned int i;
+	unsigned int o;
+	u32 ctrl;
+	int res;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	/* Write actions */
+	res = yt921x_reg96_write(priv, YT921X_ACLn_ACT(entid),
+				 aclrule ? aclrule->action : zeros);
+	if (res)
+		return res;
+
+	/* Select the block */
+	ctrl = YT921X_ACL_BLK_CMD_MODIFY | YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	/* Write keys and masks */
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
+		ctrl |= YT921X_ACL_BLK_KEEP_KEEPn(i);
+
+	mask = entsmask;
+	i = 0;
+	for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		res = yt921x_reg64_write(priv, YT921X_ACLn_KEYm(blkid, o),
+					 aclrule ? aclrule->entries[i].key :
+					 zeros);
+		if (res)
+			return res;
+
+		res = yt921x_reg64_write(priv, YT921X_ACLn_MASKm(blkid, o),
+					 aclrule ? aclrule->entries[i].mask :
+					 zeros);
+		if (res)
+			return res;
+
+		ctrl &= ~YT921X_ACL_BLK_KEEP_KEEPn(o);
+		i++;
+	}
+
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_KEEP, ctrl);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++) {
+		const struct yt921x_acl_rule *other = aclblk->rules[i];
+
+		if (!other)
+			continue;
+
+		mask = other->mask;
+		for_each_set_bit(o, &mask, YT921X_ACL_ENT_PER_BLK)
+			ctrl |= YT921X_ACL_ENTRY_ENm(o) |
+				YT921X_ACL_ENTRY_GRPIDm(o, i);
+	}
+	res = yt921x_reg_write(priv, YT921X_ACLn_ENTRY(blkid), ctrl);
+	if (res)
+		return res;
+
+	/* Commit the block */
+	ctrl = YT921X_ACL_BLK_CMD_BLKID(blkid);
+	res = yt921x_reg_write(priv, YT921X_ACL_BLK_CMD, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
+	       unsigned long tag)
+{
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	int res;
+
+	entid = yt921x_acl_find(priv, type, tag);
+	if (entid == UINT_MAX)
+		return -ENOENT;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	aclblk->rules[binid] = NULL;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	/* the kernel never rolls back on failure */
+
+	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
+		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
+				    aclrule->action[0]),
+			  priv->meters_map);
+	priv->acl_masks[blkid] &= ~aclrule->mask;
+	kvfree(aclrule);
+	if (!priv->acl_masks[blkid]) {
+		kvfree(aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return res;
+}
+
+static int
+yt921x_acl_add(struct yt921x_priv *priv,
+	       const struct yt921x_acl_rule_ext *ruleext,
+	       struct netlink_ext_ack *extack)
+{
+	unsigned int entscnt = hweight8(ruleext->r.mask);
+	struct yt921x_acl_rule *aclrule;
+	struct yt921x_acl_blk *aclblk;
+	bool use_trap = false;
+	unsigned int meterid;
+	unsigned long mask;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	unsigned int o;
+	int res;
+
+	/* Allocate resources */
+	entid = yt921x_acl_reserve(priv, entscnt, extack);
+	if (entid == UINT_MAX)
+		return -EOPNOTSUPP;
+
+	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
+		meterid = YT921X_METER_NUM;
+	} else {
+		meterid = find_first_zero_bit(priv->meters_map,
+					      YT921X_METER_NUM);
+		if (meterid < YT921X_METER_NUM) {
+			res = yt921x_meter_config(priv, meterid,
+						  &ruleext->marker);
+			if (res)
+				return res;
+		} else if (ruleext->r.sw_assisted) {
+			use_trap = true;
+		} else {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more meters available");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Prepare acl block ctrlblk */
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	if (!aclblk) {
+		aclblk = kvzalloc_obj(*aclblk);
+		if (!aclblk)
+			return -ENOMEM;
+		priv->acl_blks[blkid] = aclblk;
+	}
+
+	/* Prepare acl rule ctrlblk */
+	aclrule = kvmemdup(&ruleext->r,
+			   offsetof(struct yt921x_acl_rule, entries[entscnt]),
+			   GFP_KERNEL);
+	if (!aclrule) {
+		res = -ENOMEM;
+		goto err;
+	}
+
+	/* Replace the placeholder resource IDs */
+	aclrule->mask = 0;
+	mask = priv->acl_masks[blkid];
+	for_each_clear_bit(o, &mask, YT921X_ACL_ENT_PER_BLK) {
+		aclrule->mask |= BIT(o);
+		entscnt--;
+		if (!entscnt)
+			break;
+	}
+
+	if (use_trap) {
+		aclrule->action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
+				      ~YT921X_ACL_ACTc_FWD_M;
+		aclrule->action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				      YT921X_ACL_ACTc_FWD_TRAP;
+	}
+	if (meterid < YT921X_METER_NUM)
+		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
+	else
+		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+
+	/* Write rules */
+	aclblk->rules[binid] = aclrule;
+	res = yt921x_acl_commit(priv, entid, aclrule->mask);
+	if (res) {
+		aclblk->rules[binid] = NULL;
+		kvfree(aclrule);
+		goto err;
+	}
+
+	if (meterid < YT921X_METER_NUM)
+		set_bit(meterid, priv->meters_map);
+	priv->acl_masks[blkid] |= aclrule->mask;
+	return 0;
+
+err:
+	if (!priv->acl_masks[blkid]) {
+		kvfree(aclblk);
+		priv->acl_blks[blkid] = NULL;
+	}
+	return res;
+}
+
+static int
+yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
+			  struct flow_cls_offload *cls, bool ingress)
+{
+	struct netlink_ext_ack *extack = cls->common.extack;
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_acl_rule_ext ruleext;
+	int res;
+
+	res = yt921x_acl_rule_ext_parse_flow(&ruleext, port, cls, ingress,
+					     priv);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_add(priv, &ruleext, extack);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -1747,12 +2774,12 @@ yt921x_fdb_in01(struct yt921x_priv *priv, const unsigned char *addr,
 	u32 ctrl;
 	int res;
 
-	ctrl = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
+	ctrl = ethaddr_hi4_to_u32(addr);
 	res = yt921x_reg_write(priv, YT921X_FDB_IN0, ctrl);
 	if (res)
 		return res;
 
-	ctrl = ctrl1 | YT921X_FDB_IO1_FID(vid) | (addr[4] << 8) | addr[5];
+	ctrl = ctrl1 | YT921X_FDB_IO1_FID(vid) | ethaddr_lo2_to_u32(addr);
 	return yt921x_reg_write(priv, YT921X_FDB_IN1, ctrl);
 }
 
@@ -3613,6 +4640,24 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int yt921x_chip_setup_acl(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT921X_ACL_PERMIT_UNMATCH_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PERMIT_UNMATCH, ctrl);
+	if (res)
+		return res;
+
+	ctrl = YT921X_ACL_PORT_PORTS_M;
+	res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
 static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
 {
 	u32 ctrl;
@@ -3659,7 +4704,7 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	u32 ctrl;
 	int res;
 
-	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_METER;
+	ctrl = YT921X_FUNC_MIB | YT921X_FUNC_ACL | YT921X_FUNC_METER;
 	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
 	if (res)
 		return res;
@@ -3672,6 +4717,10 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_chip_setup_acl(priv);
+	if (res)
+		return res;
+
 #if IS_ENABLED(CONFIG_DCB)
 	res = yt921x_chip_setup_qos(priv);
 	if (res)
@@ -3767,6 +4816,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
 	.port_setup_tc		= yt921x_dsa_port_setup_tc,
+	/* acl */
+	.cls_flower_del		= yt921x_dsa_cls_flower_del,
+	.cls_flower_add		= yt921x_dsa_cls_flower_add,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
@@ -3843,6 +4895,20 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 
 	dsa_unregister_switch(&priv->ds);
 
+	for (unsigned int i = 0; i < ARRAY_SIZE(priv->acl_blks); i++) {
+		struct yt921x_acl_blk *aclblk = priv->acl_blks[i];
+
+		if (!aclblk)
+			continue;
+		for (unsigned int j = 0; j < ARRAY_SIZE(aclblk->rules); j++) {
+			struct yt921x_acl_rule *aclrule = aclblk->rules[j];
+
+			if (!aclrule)
+				continue;
+			kvfree(aclrule);
+		}
+		kvfree(aclblk);
+	}
 	mutex_destroy(&priv->reg_lock);
 }
 
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 70fa780c337f..555046526669 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -24,6 +24,7 @@
 #define  YT921X_RST_SW				BIT(1)
 #define YT921X_FUNC			0x80004
 #define  YT921X_FUNC_METER			BIT(4)
+#define  YT921X_FUNC_ACL			BIT(2)
 #define  YT921X_FUNC_MIB			BIT(1)
 #define YT921X_CHIP_ID			0x80008
 #define  YT921X_CHIP_ID_MAJOR			GENMASK(31, 16)
@@ -420,6 +421,10 @@ enum yt921x_app_selector {
 #define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
 #define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
 #define  YT921X_CPU_COPY_TO_EXT_CPU		BIT(0)
+#define YT921X_ACL_PERMIT_UNMATCH	0x1806a0
+#define  YT921X_ACL_PERMIT_UNMATCH_PORTS_M	GENMASK(10, 0)
+#define   YT921X_ACL_PERMIT_UNMATCH_PORTS(x)		FIELD_PREP(YT921X_ACL_PERMIT_UNMATCH_PORTS_M, (x))
+#define  YT921X_ACL_PERMIT_UNMATCH_PORTn(port)	BIT(port)
 #define YT921X_ACT_UNK_UCAST		0x180734
 #define YT921X_ACT_UNK_MCAST		0x180738
 #define  YT921X_ACT_UNK_MCAST_BYPASS_DROP_RMA	BIT(23)
@@ -454,6 +459,249 @@ enum yt921x_app_selector {
 #define  YT921X_VLAN_CTRLa_METER_EN		BIT(5)
 #define  YT921X_VLAN_CTRLa_METER_ID_M		GENMASK(4, 0)
 
+#define YT921X_ACLn_ACT(n)		(0x1c0000 + 0x10 * (n))
+#define  YT921X_ACL_ACTc_STAG_M			GENMASK(26, 25)
+#define   YT921X_ACL_ACTc_STAG(x)			FIELD_PREP(YT921X_ACL_ACTc_STAG_M, (x))
+#define   YT921X_ACL_ACTc_STAG_DONTCARE			YT921X_ACL_ACTc_STAG(0)
+#define   YT921X_ACL_ACTc_STAG_UNTAG			YT921X_ACL_ACTc_STAG(1)
+#define   YT921X_ACL_ACTc_STAG_TAG			YT921X_ACL_ACTc_STAG(2)
+#define   YT921X_ACL_ACTc_STAG_KEEP			YT921X_ACL_ACTc_STAG(3)
+#define  YT921X_ACL_ACTc_CTAG_M			GENMASK(24, 23)
+#define   YT921X_ACL_ACTc_CTAG(x)			FIELD_PREP(YT921X_ACL_ACTc_CTAG_M, (x))
+#define   YT921X_ACL_ACTc_CTAG_DONTCARE			YT921X_ACL_ACTc_CTAG(0)
+#define   YT921X_ACL_ACTc_CTAG_UNTAG			YT921X_ACL_ACTc_CTAG(1)
+#define   YT921X_ACL_ACTc_CTAG_TAG			YT921X_ACL_ACTc_CTAG(2)
+#define   YT921X_ACL_ACTc_CTAG_KEEP			YT921X_ACL_ACTc_CTAG(3)
+#define  YT921X_ACL_ACTc_FWD_M			GENMASK(22, 21)
+#define   YT921X_ACL_ACTc_FWD(x)			FIELD_PREP(YT921X_ACL_ACTc_FWD_M, (x))
+#define   YT921X_ACL_ACTc_FWD_FWD			YT921X_ACL_ACTc_FWD(0)
+#define   YT921X_ACL_ACTc_FWD_COPY			YT921X_ACL_ACTc_FWD(1)
+#define   YT921X_ACL_ACTc_FWD_REDIR			YT921X_ACL_ACTc_FWD(2)
+#define   YT921X_ACL_ACTc_FWD_TRAP			YT921X_ACL_ACTc_FWD(3)
+#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M	GENMASK(20, 10)
+#define   YT921X_ACL_ACTc_FWD_REDIR_DPORTS(x)		FIELD_PREP(YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M, (x))
+#define  YT921X_ACL_ACTc_FWD_REDIR_DPORTn(port)	BIT((port) + 10)
+#define  YT921X_ACL_ACTc_FWD_EN			BIT(9)
+#define  YT921X_ACL_ACTc_SDEI			BIT(8)
+#define  YT921X_ACL_ACTc_SDEI_REPLACE		BIT(7)
+#define  YT921X_ACL_ACTc_SPRI_M			GENMASK(6, 4)
+#define   YT921X_ACL_ACTc_SPRI(x)			FIELD_PREP(YT921X_ACL_ACTc_SPRI_M, (x))
+#define  YT921X_ACL_ACTc_SPRI_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTbc_SVID_M		GENMASK_ULL(34, 23)
+#define   YT921X_ACL_ACTbc_SVID(x)			FIELD_PREP(YT921X_ACL_ACTbc_SVID_M, (x))
+#define  YT921X_ACL_ACTb_SVID_REPLACE		BIT(22)
+#define  YT921X_ACL_ACTb_CDEI			BIT(21)
+#define  YT921X_ACL_ACTb_CDEI_REPLACE		BIT(20)
+#define  YT921X_ACL_ACTb_CPRI_M			GENMASK(19, 17)
+#define   YT921X_ACL_ACTb_CPRI(x)			FIELD_PREP(YT921X_ACL_ACTb_CPRI_M, (x))
+#define  YT921X_ACL_ACTb_CPRI_REPLACE		BIT(16)
+#define  YT921X_ACL_ACTb_CVID_M			GENMASK(15, 4)
+#define   YT921X_ACL_ACTb_CVID(x)			FIELD_PREP(YT921X_ACL_ACTb_CVID_M, (x))
+#define  YT921X_ACL_ACTb_CVID_REPLACE		BIT(3)
+#define  YT921X_ACL_ACTb_PRIO_M			GENMASK(2, 0)
+#define   YT921X_ACL_ACTb_PRIO(x)			FIELD_PREP(YT921X_ACL_ACTb_PRIO_M, (x))
+#define  YT921X_ACL_ACTa_PRIO_EN		BIT(31)
+#define  YT921X_ACL_ACTa_COLOR_M		GENMASK(30, 29)
+#define   YT921X_ACL_ACTa_COLOR(x)			FIELD_PREP(YT921X_ACL_ACTa_COLOR_M, (x))
+#define   YT921X_ACL_ACTa_COLOR_GREEN			YT921X_ACL_ACTa_COLOR(0)
+#define   YT921X_ACL_ACTa_COLOR_YELLOW			YT921X_ACL_ACTa_COLOR(1)
+#define   YT921X_ACL_ACTa_COLOR_RED			YT921X_ACL_ACTa_COLOR(2)
+#define  YT921X_ACL_ACTa_COLOR_EN		BIT(28)
+#define  YT921X_ACL_ACTa_DSCP_M			GENMASK(27, 22)
+#define   YT921X_ACL_ACTa_DSCP(x)			FIELD_PREP(YT921X_ACL_ACTa_DSCP_M, (x))
+#define  YT921X_ACL_ACTa_DSCP_REPLACE		BIT(21)
+#define  YT921X_ACL_ACTa_METER_ID_M		GENMASK(20, 15)
+#define   YT921X_ACL_ACTa_METER_ID(x)			FIELD_PREP(YT921X_ACL_ACTa_METER_ID_M, (x))
+#define  YT921X_ACL_ACTa_METER_EN		BIT(14)
+#define  YT921X_ACL_ACTa_MIRROR_EN		BIT(13)
+#define  YT921X_ACL_ACTa_FLOWSTAT_EN		BIT(12)
+#define  YT921X_ACL_ACTa_FLOWSTAT_ID_M		GENMASK(11, 6)
+#define   YT921X_ACL_ACTa_FLOWSTAT_ID(x)		FIELD_PREP(YT921X_ACL_ACTa_FLOWSTAT_ID_M, (x))
+#define  YT921X_ACL_ACTa_GPIO_EN		BIT(5)
+#define  YT921X_ACL_ACTa_GPIO_PIN_M		GENMASK(4, 1)
+#define   YT921X_ACL_ACTa_GPIO_PIN(x)			FIELD_PREP(YT921X_ACL_ACTa_GPIO_PIN_M, (x))
+#define  YT921X_ACL_ACTa_INTR_EN		BIT(0)
+#define YT921X_ACL_BLK_KEEP		0x201000
+#define  YT921X_ACL_BLK_KEEP_GRPIDn_M(bin)	(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_BLK_KEEP_GRPIDn(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_BLK_KEEP_KEEPn(bin)		BIT(4 * (bin))
+#define YT921X_ACL_PORT			0x202000
+#define  YT921X_ACL_PORT_PORTS_M		GENMASK(10, 0)
+#define   YT921X_ACL_PORT_PORTS(x)			FIELD_PREP(YT921X_ACL_PORT_PORTS_M, (x))
+#define  YT921X_ACL_PORT_PORTn(port)		BIT(port)
+#define YT921X_ACL_BLK_CMD		0x202004
+#define  YT921X_ACL_BLK_CMD_BLKID_M		GENMASK(6, 1)
+#define   YT921X_ACL_BLK_CMD_BLKID(x)			FIELD_PREP(YT921X_ACL_BLK_CMD_BLKID_M, (x))
+#define  YT921X_ACL_BLK_CMD_MODIFY		BIT(0)
+#define YT921X_ACLn_ENTRY(blk)		(0x203000 + 4 * (blk))
+#define  YT921X_ACL_ENTRY_GRPIDm_M(bin)		(7 << (4 * (bin) + 1))
+#define   YT921X_ACL_ENTRY_GRPIDm(bin, x)		((x) << (4 * (bin) + 1))
+#define  YT921X_ACL_ENTRY_ENm(bin)		BIT(4 * (bin))
+#define YT921X_ACLn_KEYm(blk, bin)	(0x204000 + 0x200 * (bin) + 8 * (blk))
+#define  YT921X_ACL_KEYb_ORD_M			GENMASK(29, 21)
+#define   YT921X_ACL_KEYb_ORD(x)			FIELD_PREP(YT921X_ACL_KEYb_ORD_M, (x))
+#define  YT921X_ACL_KEYb_SPORTS_M		GENMASK(20, 10)
+#define   YT921X_ACL_KEYb_SPORTS(x)			FIELD_PREP(YT921X_ACL_KEYb_SPORTS_M, (x))
+#define  YT921X_ACL_KEYb_SPORTn(port)		BIT((port) + 10)
+#define  YT921X_ACL_KEYb_REVERSE		BIT(9)	/* reverse match */
+#define  YT921X_ACL_KEYb_TYPE_M			GENMASK(8, 4)
+#define   YT921X_ACL_KEYb_TYPE(x)			FIELD_PREP(YT921X_ACL_KEYb_TYPE_M, (x))
+/* KEY_* fields need no masks */
+#define YT921X_ACLn_MASKm(blk, bin)	(0x205000 + 0x200 * (bin) + 8 * (blk))
+
+enum yt921x_acl_type {
+	YT921X_ACL_TYPE_NA,
+	YT921X_ACL_TYPE_MAC_DA0,
+	YT921X_ACL_TYPE_MAC_SA0,
+	YT921X_ACL_TYPE_MAC_DA1_SA1,
+	YT921X_ACL_TYPE_VLAN,
+	YT921X_ACL_TYPE_VTAG,
+	YT921X_ACL_TYPE_IPV4_DA,
+	YT921X_ACL_TYPE_IPV4_SA,
+	YT921X_ACL_TYPE_IPV6_DA0,
+	YT921X_ACL_TYPE_IPV6_DA1,
+	YT921X_ACL_TYPE_IPV6_DA2,
+	YT921X_ACL_TYPE_IPV6_DA3,
+	YT921X_ACL_TYPE_IPV6_SA0,
+	YT921X_ACL_TYPE_IPV6_SA1,
+	YT921X_ACL_TYPE_IPV6_SA2,
+	YT921X_ACL_TYPE_IPV6_SA3,
+	YT921X_ACL_TYPE_MISC,
+	YT921X_ACL_TYPE_L4,
+	YT921X_ACL_TYPE_UDF0,
+	YT921X_ACL_TYPE_UDF1,
+	YT921X_ACL_TYPE_UDF2,
+	YT921X_ACL_TYPE_UDF3,
+	YT921X_ACL_TYPE_UDF4,
+	YT921X_ACL_TYPE_UDF5,
+	YT921X_ACL_TYPE_UDF6,
+	YT921X_ACL_TYPE_UDF7,
+	YT921X_ACL_TYPE_ETHERTYPE,
+	YT921X_ACL_TYPE_NUM
+};
+
+/* Range: turn KEY:MASK into MIN:MAX */
+
+#define  YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M	GENMASK(3, 0)
+#define   YT921X_ACL_BINb_MAC_xA0_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MAC_xA0_L3_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_xA0_MAC_xA0_M	GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE(x)	FIELD_PREP(YT921X_ACL_BINb_MAC_DA1_SA1_L2_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_DA1_M	GENMASK(31, 16)
+#define  YT921X_ACL_BINa_MAC_DA1_SA1_MAC_SA1_M	GENMASK(15, 0)
+
+#define  YT921X_ACL_KEYb_VLAN_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VLAN_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_VLAN_CDEI		BIT(3)
+#define  YT921X_ACL_BINb_VLAN_CPRI_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_VLAN_CPRI(x)			FIELD_PREP(YT921X_ACL_BINb_VLAN_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CTAG_FMT_M	GENMASK(31, 30)
+#define   YT921X_ACL_BINa_VLAN_CTAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_CTAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SDEI		BIT(29)
+#define  YT921X_ACL_BINa_VLAN_SPRI_M		GENMASK(28, 26)
+#define   YT921X_ACL_BINa_VLAN_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VLAN_STAG_FMT_M	GENMASK(25, 24)
+#define   YT921X_ACL_BINa_VLAN_STAG_FMT(x)		FIELD_PREP(YT921X_ACL_BINa_VLAN_STAG_FMT_M, (x))
+#define  YT921X_ACL_BINa_VLAN_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VLAN_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_SVID_M, (x))
+#define  YT921X_ACL_BINa_VLAN_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VLAN_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VLAN_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_VTAG_SVID_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_VTAG_CVID_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINa_VTAG_CDEI		BIT(31)
+#define  YT921X_ACL_BINa_VTAG_CPRI_M		GENMASK(30, 28)
+#define   YT921X_ACL_BINa_VTAG_CPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SDEI		BIT(27)
+#define  YT921X_ACL_BINa_VTAG_SPRI_M		GENMASK(26, 24)
+#define   YT921X_ACL_BINa_VTAG_SPRI(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SPRI_M, (x))
+#define  YT921X_ACL_BINa_VTAG_SVID_M		GENMASK(23, 12)
+#define   YT921X_ACL_BINa_VTAG_SVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_SVID_M, (x))
+#define  YT921X_ACL_BINa_VTAG_CVID_M		GENMASK(11, 0)
+#define   YT921X_ACL_BINa_VTAG_CVID(x)			FIELD_PREP(YT921X_ACL_BINa_VTAG_CVID_M, (x))
+
+#define  YT921X_ACL_KEYb_IPV4_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_IPV4_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV4_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV4_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV4_ADDR_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_IPV6_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_IPV6_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_IPV6_ADDRx_M		GENMASK(31, 0)
+
+#define  YT921X_ACL_BINb_IPV6_xA1_IP_OPTION	BIT(3)
+
+#define  YT921X_ACL_BINb_IPV6_xA2_FIRST_FRAG	BIT(3)
+
+#define  YT921X_ACL_KEYb_IPV6_xA3_ADDR_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_IPV6_xA3_FRAG		BIT(3)
+
+#define  YT921X_ACL_BINb_MISC_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_MISC_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_MISC_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_MISC_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_MISC_PPPOE_FLAG	BIT(30)
+#define  YT921X_ACL_BINa_MISC_FIRST_FRAG	BIT(29)
+#define  YT921X_ACL_BINa_MISC_IP_OPTION		BIT(28)
+#define  YT921X_ACL_BINa_MISC_TCP_FLAGS_M	GENMASK(27, 20)
+#define   YT921X_ACL_BINa_MISC_TCP_FLAGS(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_TCP_FLAGS_M, (x))
+#define  YT921X_ACL_BINa_MISC_IP_PROTO_M	GENMASK(19, 12)
+#define   YT921X_ACL_BINa_MISC_IP_PROTO(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_IP_PROTO_M, (x))
+#define  YT921X_ACL_BINa_MISC_TOS_M		GENMASK(11, 4)
+#define   YT921X_ACL_BINa_MISC_TOS(x)			FIELD_PREP(YT921X_ACL_BINa_MISC_TOS_M, (x))
+#define  YT921X_ACL_BINa_MISC_L3_TYPE_M		GENMASK(3, 0)
+#define   YT921X_ACL_BINa_MISC_L3_TYPE(x)		FIELD_PREP(YT921X_ACL_BINa_MISC_L3_TYPE_M, (x))
+
+#define  YT921X_ACL_KEYb_L4_DPORT_RANGE_EN	BIT(31)
+#define  YT921X_ACL_KEYb_L4_SPORT_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_L4_FRAG		BIT(3)
+#define  YT921X_ACL_BINb_L4_TYPE_M		GENMASK(2, 0)
+#define   YT921X_ACL_BINb_L4_TYPE(x)			FIELD_PREP(YT921X_ACL_BINb_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_L4_DPORT_M		GENMASK(31, 16)
+#define  YT921X_ACL_BINa_L4_SPORT_M		GENMASK(15, 0)
+
+#define  YT921X_ACL_BINb_UDF_IS_IGMP		BIT(0)
+#define  YT921X_ACL_BINa_UDF_UDF0_M		GENMASK(31, 16)
+#define   YT921X_ACL_BINa_UDF_UDF0(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF0_M, (x))
+#define  YT921X_ACL_BINa_UDF_UDF1_M		GENMASK(15, 0)
+#define   YT921X_ACL_BINa_UDF_UDF1(x)			FIELD_PREP(YT921X_ACL_BINa_UDF_UDF1_M, (x))
+
+#define  YT921X_ACL_KEYb_ETHERTYPE_ETHERTYPE_RANGE_EN	BIT(30)
+#define  YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M	GENMASK(2, 0)
+#define   YT921X_ACL_BINb_ETHERTYPE_L4_TYPE(x)		FIELD_PREP(YT921X_ACL_BINb_ETHERTYPE_L4_TYPE_M, (x))
+#define  YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M	GENMASK(15, 0)
+#define   YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE(x)	FIELD_PREP(YT921X_ACL_BINa_ETHERTYPE_ETHERTYPE_M, (x))
+
+enum yt921x_l2_type {
+	YT921X_L2_TYPE_ETH,
+	YT921X_L2_TYPE_ETHV2,
+	YT921X_L2_TYPE_ETHSAP,
+	YT921X_L2_TYPE_ETHSNAP,
+};
+
+enum yt921x_l3_type {
+	YT921X_L3_TYPE_OTHER,
+	YT921X_L3_TYPE_IPV4,
+	YT921X_L3_TYPE_IPV6,
+	YT921X_L3_TYPE_ARP,
+	YT921X_L3_TYPE_LLDP,
+	YT921X_L3_TYPE_PAE,
+	YT921X_L3_TYPE_ERP,
+	YT921X_L3_TYPE_SLOW_PROTOCOL,
+};
+
+enum yt921x_l4_type {
+	YT921X_L4_TYPE_OTHER,
+	YT921X_L4_TYPE_TCP,
+	YT921X_L4_TYPE_UDP,
+	YT921X_L4_TYPE_UDPLITE,
+	YT921X_L4_TYPE_ICMP,
+	YT921X_L4_TYPE_IGMP,
+	YT921X_L4_TYPE_MLD,
+	YT921X_L4_TYPE_ND,
+};
+
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
 #define YT921X_PORTn_IGR_TPID(port)	(0x210010 + 4 * (port))
@@ -470,6 +718,14 @@ enum yt921x_app_selector {
 #define  YT921X_LAG_HASH_MAC_SA			BIT(2)
 #define  YT921X_LAG_HASH_MAC_DA			BIT(1)
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
+#define YT921X_UDFn_CTRL(x)		(0x210094 + 4 * (x))
+#define  YT921X_UDF_CTRL_UDF_TYPE_M		GENMASK(8, 7)
+#define   YT921X_UDF_CTRL_UDF_TYPE(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_TYPE_M, (x))
+#define   YT921X_UDF_CTRL_UDF_TYPE_ETH			YT921X_UDF_CTRL_UDF_TYPE(0)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L3			YT921X_UDF_CTRL_UDF_TYPE(1)
+#define   YT921X_UDF_CTRL_UDF_TYPE_L4			YT921X_UDF_CTRL_UDF_TYPE(2)
+#define  YT921X_UDF_CTRL_UDF_OFFSET_M		GENMASK(6, 0)
+#define   YT921X_UDF_CTRL_UDF_OFFSET(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_OFFSET_M, (x))
 
 #define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
 #define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
@@ -589,6 +845,11 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_TAG_LEN	8
 
+#define YT921X_ACL_BLK_NUM	48
+#define YT921X_ACL_ENT_PER_BLK	8
+#define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
+#define YT921X_UDF_NUM		8
+
 /* 8 internal + 2 external + 1 mcu */
 #define YT921X_PORT_NUM			11
 
@@ -647,6 +908,26 @@ struct yt921x_mib {
 	u64 tx_oam;
 };
 
+struct yt921x_acl_entry {
+	u32 key[2];
+	u32 mask[2];
+};
+
+struct yt921x_acl_rule {
+	unsigned long tag;
+	enum tc_setup_type type;
+
+	u32 action[3];
+	bool sw_assisted;
+
+	u8 mask;
+	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
+};
+
+struct yt921x_acl_blk {
+	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
+};
+
 struct yt921x_port {
 	unsigned char index;
 
@@ -686,6 +967,11 @@ struct yt921x_priv {
 	struct yt921x_port ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
+
+	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
+
+	u8 acl_masks[YT921X_ACL_BLK_NUM];
+	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
 #endif
-- 
2.53.0


