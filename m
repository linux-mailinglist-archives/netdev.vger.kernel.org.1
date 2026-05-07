Return-Path: <netdev+bounces-285295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI3KOut//GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:04:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 769714E7F43
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68CD030056E9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C293ED5C8;
	Thu,  7 May 2026 12:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59C35B633
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155492; cv=none; b=OXcgGGI06jKPrtCCeoYkx40/qx6HfdQfM903Oh4u5xHoZeIGHnT1IjSvLz2luDwG5FsDXGCKyHzUKXkD6DmaFtiTzOESHFf0E/2t4YuJTyOk3ptcGEuyo4KYvL50L6oV3vCcRQQg4qR9a6fDEJ9dE43fyEpOP+e5Kw42B6gDEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155492; c=relaxed/simple;
	bh=hSUG09nHENB3l3k2WSy3g2qFr4tySgF/qi/LSfVUZ/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUGC37wqDfHeRcpcKA8Ma/7lH/J+6u5G+GZo1cl8Qb1uTrmeEDpUAp9jZwzs12EaucvGdvghmbI/eNtu6KlRcTqrk0FUY/1KGjfbOI+CbAr6bKOpwOQu7Y3nKIFK7gE5SiHUkuRvyjaHzDESiOeu5s5odwBsh3ojUOCBD4fbf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-67b7c77865dso1154452a12.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778155484; x=1778760284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VSQz3qWSBmu4rhZHr1DZdjiE1xIcn8ousLUryflVY8=;
        b=FZYyV+OqBLLPCw1zF7gTLouCvuYU8uYqDSq11Ktpm/l318ctiNGRvd1ieCRAL9831b
         Zlb+CL/VZAJl0X3SsdAvYBSIV4Yd8keobdRWZO4tP1HhcxnfM8ZCyCsWmkVBS50XSloq
         uMrEBxhMFFwtlKlRgKxXmfSYk/iBNQUmtVCMjoKCnbcjPIF+BWWiSOjuGHLIJhmZPR6P
         ksS+fY0RjHeYIlEGblQB39S5jV2F/e7gQlhV1ckC4s3CdQgHIrxkWmX+Iv8Pu9I1eHHT
         Dgxendr0d1+GLLC/vOJT6JiSdf+nrMfa6JGLATeirfwhoiE8Gpzruh/eZHjkKBjcr0xj
         RP5A==
X-Gm-Message-State: AOJu0YyvjZI93mlmDGBtsUBDWWtvohP5SeyhiesbIrrSwFuht420DoGH
	E235ZqFbCv/pQGInN/14oWNoJaWBUdmZYZMu8d4TrA30DJFIuEQDQiKdThqV8Syh
X-Gm-Gg: AeBDieskcUHcy/cNKjrHaf/7OZMcNQgaW7r+VzCoCOx9Gu0UmY2wE59SidDUfIABSIt
	KEWyAo8KIyvQ+81a++3spEcdThFhqSO+Zmf5ftidvlBP90jP2enkiic7xGbpK39LycKmWHdFWw7
	Ow+4wDKn1K77vxNMRRMIdh1NwPXb1p4GbsacuKND1+YIs7oxgMuNsFnJ0e9ImIfBCoctGJn/mI1
	OEY1Iznl9/wOkSVrYQZ+bf+LZe6n8TNWTB6PB4H0yHGoTwd4o7CnI8BkF7+l+KVqx5G9Dm3boA/
	h9vnrNJp+Xgp1EIJJ/Iki8bjsWyC7dYkMygatUo6CZc/owOwOCeb+1FC0e5CZ6ZZvF/aOBUvg83
	M4fGdsr6LHEWgRrSx6GvKyvH+wuzGo7HlW7TwQCGT+0gRJ4bZLvHg4DtUjvVfTeCmu7TjpO29Ai
	YcoRhHV9JwhlRD7EhCEQkCTqhRaUvbqTBjR3chDd/XJyeBYLQdxZKoksl0iF/1aPkaI5atWpapm
	cgcEkrb1bkSRiknTKk=
X-Received: by 2002:a05:6402:e07:b0:676:54d5:bc5b with SMTP id 4fb4d7f45d1cf-67d6489d7c1mr3837204a12.18.1778155483468;
        Thu, 07 May 2026 05:04:43 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90efee1sm2006365a12.11.2026.05.07.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:04:43 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Yi Yang <yi.y.yang@intel.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] net: nsh: fix incorrect header length macros
Date: Thu,  7 May 2026 14:04:26 +0200
Message-ID: <20260507120434.2962505-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 769714E7F43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

NSH header length is a 6-bit field that encodes the total length of
the header in 4-byte words.  So the maximum length is 0b111111 * 4,
which is 252 and not 256.  The maximum context length is the same
number minus the length of the base header (8), so 244.

These macros are used to validate push_nsh() action in openvswitch.
Miscalculation here doesn't cause any real issues.  In the worst case
the oversized context is truncated while building the header, so we'll
construct and send a broken packet, which is not a big problem, as any
receiver should validate the fields.  No invalid memory accesses will
happen during the header push.  But we should fix the macros to reject
the incorrect actions in the first place.

Using previously defined values and calculating the length instead
of defining numbers directly, so it's easier to understand where they
come from and harder to make a mistake.

Fixes: 1f0b7744c505 ("net: add NSH header structures and helpers")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

These macros were fixed in the userspace variant of this header some
years ago (by just adjusting the numbers though):
  https://patchwork.ozlabs.org/project/openvswitch/patch/1540503710-23597-1-git-send-email-pkusunyifeng@gmail.com/
And there was a patch a few weeks ago with the attempt to change the
validation for push_nsh() instead of fixing the macros:
  https://lore.kernel.org/all/9d2b5c6127e149ebd35094d662bfd008c20347c2.1777120226.git.ldy3087146292@gmail.com/
I haven't heard back from the author, so sending this patch myself
to cross it out of my todo list.  It's not a v2, as it's more of a
separate change, even though the outcome is similar.

 include/net/nsh.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nsh.h b/include/net/nsh.h
index 16a7510938969..15a26c5908151 100644
--- a/include/net/nsh.h
+++ b/include/net/nsh.h
@@ -247,10 +247,10 @@ struct nshhdr {
 #define NSH_M_TYPE1_LEN   24
 
 /* NSH header maximum Length. */
-#define NSH_HDR_MAX_LEN 256
+#define NSH_HDR_MAX_LEN ((NSH_LEN_MASK >> NSH_LEN_SHIFT) * 4)
 
 /* NSH context headers maximum Length. */
-#define NSH_CTX_HDRS_MAX_LEN 248
+#define NSH_CTX_HDRS_MAX_LEN (NSH_HDR_MAX_LEN - NSH_BASE_HDR_LEN)
 
 static inline struct nshhdr *nsh_hdr(struct sk_buff *skb)
 {
-- 
2.53.0


