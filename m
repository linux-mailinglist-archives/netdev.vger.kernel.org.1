Return-Path: <netdev+bounces-291144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH+vDHB7Emom0AYAu9opvQ
	(envelope-from <netdev+bounces-291144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D675C15E7
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D198E301588A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CC2F7EE7;
	Sun, 24 May 2026 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXklRN6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176A2F25F0
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596109; cv=none; b=g6IoSI81jGrIcFp6BoP3FCiISJALLhflFuSlV0CC228L90ewhFqFYh8tV1F27/5tECEDkt6GKPpr1qfwqItpyhH9XH3KDmo1YniS2c1QkpxYZ46dpKPe0FNZaiwq2pwIZT3pHyYVhJcGzt+4S2sffmrvYXz1jNTjbAozXTTDMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596109; c=relaxed/simple;
	bh=zlROHpspN4svB9VHuRgW/RNOHKabtQok9h5ytT2jjOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdRc213CRWCxEHJ/P9Skph/Kvuo/om23l0huy3zfvP65oCcC+JOJpWBQcLZ9c6X1D85Jsf91XklzHZciyBWSOOvN+tcEP3UNr3cKxoTwg+1csdJSoBbYUfb5MkBO0oU60RTCBrcIKoF0cUsepcKJWfU7CdohBeg345DW9Miu8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXklRN6E; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30246cfd41aso3872583eec.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596107; x=1780200907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7xIC92IytMwCoIpp3F6gfBN1+ahv97EwLManb72nZc=;
        b=DXklRN6Ero41d1ZWvZEgMh+V2QyLzI0NY6IjduXNOqGEDbVDKqx1p48d1GBRvnNhGk
         JRoPkGexU4TxAjJgtQDCXf7m2zKKaCydXLdNiItRGpYnBCrzmJyJSZt/JFOI8OQlKH2p
         JNwHzu+9+iJXGpdZQGn0mA10LWLCU6k4FvCw+kMHLKR4P4HJSBmsOqyE17HgiROdei/m
         WnP7t6EJdd1194jGABhu4YWoyIeggXuQUrLtmrnF7gRXxvpGujWD4sAm1Uzts9V8c+5L
         LFLaIQ0xrxCgKjF9FszNz4MReVjoEVqmvXrCDnG2HooW5JAL8zX4+hXtl5X7YNNwSVda
         +g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596107; x=1780200907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7xIC92IytMwCoIpp3F6gfBN1+ahv97EwLManb72nZc=;
        b=XjplU71Ohc0tAE9QfjDpdijSCuObw7fIKhM1NuXgBock99lO09+Iz0giIpqqR1012E
         TJXkDTbRJbP0zcovuWPllxCzmtf0JM+XmUTEOjYvH3r7XjUJh2ce8kvCKDtTBAyh1yGo
         pH5db+RypzDRwVkhlc24qCju3nJSl262Rfsno5gGl/2blNV50I+c2RJR4Qaksi5Yio4r
         Zp+zqfKJskEuR6u0l6oAXc4o/zLnzSq+hGVPBxEpDf73DaRWFIyfYeRKwd6K5sURZ1IJ
         A7OwnhQ4IJF5c/mwbdCYJDu8wRMpSKLGI6tUiJCmNGL0huwg/mZo7Ky/HrpxWUxh2Deb
         Rung==
X-Gm-Message-State: AOJu0Yxo4DVd5UIu6gwX4WEHI9k34k6N9cd7CUoAUZwA/gJQZtPO3F0s
	odsDf875mUeL6wfMLF+3jOQgMHpGVsryUBtvg3ebYiD8NSZUSJlF7gMR
X-Gm-Gg: Acq92OFwjl89IqTNXt10IiwrYUQg7Yyx3lseCqkp10cA8lhBaCc5kgY6drmKTA5ymtu
	YJ7+jfE3A0LYQYzb4LaqQNhyYQsQUgn7DiB6ezPNATfGF/Yc87501ZAxLrB1kYO1DsaiNHg+os5
	oeLvtbfvZ+67Kre8EJzTWseiAPGdE54oYpABqrAz1O6a3eQENW6bfK31ivQN4+hl4ZSfsFUHFb9
	faQQCrklRe6qRJjlU9oCxqvZ4v7ZlmiIAcfYiolvbOVirrwn3UQHxEN7OSoyGwNcDaHpSF/IE/y
	YhhRukCZ075E15CCOqZ3mwxTOeV71TFn/2tib/pbr5AjrE/kzOXKAkux8JmhxTo+w+yK7RZGgB3
	9KE52Wnxp+gEGANjBW7gcx7qdn29T9V9SUgwn2D6gCZUjN2hVf2WH/INx0slyIyWaBB0XYSmZuq
	FUIGlcd70MaVsNxjtR1i/76DaDCI6ptEdSRw==
X-Received: by 2002:a05:7301:19a5:b0:2df:919f:ce59 with SMTP id 5a478bee46e88-30449149c79mr5024715eec.19.1779596106994;
        Sat, 23 May 2026 21:15:06 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:15:06 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Sun, 24 May 2026 12:14:37 +0800
Message-ID: <20260524041442.2432071-4-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524041442.2432071-1-tpluszz77@gmail.com>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,paul-moore.com,kernel.org,codeweavers.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E4D675C15E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
header via calipso_optptr() and hands the bare pointer to
calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
calipso + 10 for cat_len bytes via netlbl_bitmap_walk().

ipv6_hop_calipso() validates these bytes only at parse time inside
ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write reachable
from an unprivileged user namespace can rewrite both bytes between
parse and the SELinux peer-label consume path
(selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
netlbl_skbuff_getattr).  The self-consistency check
(cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
mutating both bytes consistently, allowing a ~232-byte
slab-out-of-bounds read from calipso + 10 whose set bits become MLS
categories driving the access decision.

netlbl_skbuff_getattr() has the skb; gate the consume on the option
fitting within skb_tail_pointer().  The IPv6 option layout is
type(1) + length(1) + length bytes of data, so requiring
ptr + 2 + ptr[1] <= skb_tail covers the option and its embedded
bitmap.  When the bounds check fails the packet has been mutated
after parse, so return -EINVAL rather than fall through to the
unlabeled path.

Runtime confirmation (SELinux compat path with selinux=1 enforcing=0
and a CALIPSO DOI added via netlabelctl): Udp6InDatagrams increments
to 1 with the mutated cat_len, showing
selinux_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
option's true bound; with this patch the consume path returns
-EINVAL at the bounds check and the counter stays 0.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01f..d0d6220b8d59d 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1399,11 +1399,22 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			return 0;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_data_len;
+
 		ptr = calipso_optptr(skb);
-		if (ptr && calipso_getattr(ptr, secattr) == 0)
+		if (!ptr)
+			break;
+		if (ptr + 2 > tail)
+			return -EINVAL;
+		opt_data_len = ptr[1];	/* IPv6 option data length */
+		if (ptr + 2 + opt_data_len > tail)
+			return -EINVAL;
+		if (calipso_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #endif /* IPv6 */
 	}
 
-- 
2.47.3


