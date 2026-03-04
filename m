Return-Path: <netdev+bounces-263622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCn6Apndp2lnkgAAu9opvQ
	(envelope-from <netdev+bounces-263622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143C1FB893
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A69F30088A7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E8352C2B;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2W1jNNH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BD342CA2;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608917; cv=none; b=LjyDtT6KF1NtN603KPy3FTEsnJkLK4wb5sqTc8Tf82LaNQpNmwu+1UtEgjC0x9DU5yq7H0Ew7aBIEUJbcw+laOISwnPOK5cMyWaL21CMZf6/1DO2QraKHFdLt2FE0lSYIJH3ys7b2xzHl7Exd/KPtS9g/I02jscNulG//Fj0MPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608917; c=relaxed/simple;
	bh=oyRqZoSbdyXDKvYDihwfAYkGmgYR4/jkeHFWdp8zAhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnMd/rBk2HSgTGpWHBJypKgN/xigXYQg2RbtfBXuT5d6E27LT4hxOTlLbApyoXlK1y/mz8ybwruvakXUJHDDChVgKR+4YVnWg4w07KsMQjVFjklENMfvb+Zm/jg2XPdrYjx+YOY5p9rhhvDf0dR/oueU7VuO+WTbdzAotjKeEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2W1jNNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9327FC19425;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772608917;
	bh=oyRqZoSbdyXDKvYDihwfAYkGmgYR4/jkeHFWdp8zAhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S2W1jNNHfzgsJx9+QKkefG2Di66ktkhoWKa8Qsz6Ui8VCjmL7Cf5dm1/ljKWJ/R9b
	 0z5gfo8H9Cs2zhZXRxqRbyLt8qOHimmlA3yOt8p2/b+7rUlv/Y3uodAr+6KVwYSGPi
	 r5QuNGU32fPfkWv6PouMdZCRgkDJfoqfNayOI+63jBjz6R7OxgI1TEJ9+yu1PovXVv
	 znqI4Dc0dMNAfjXF+dzgIMMvhUAkmhocBPj9Ot6lQeo+8klEr4ZIjRGmEKZhe/H7Sl
	 ARqPaOdcs2av9ETNrE94OUXcVdlQBjGUQdR8f7eiap3Dn76cZe3SZykwHUM8Ykhfcs
	 Bv6OXXIBZfk3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E6EDEC1B;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Wed, 04 Mar 2026 08:21:20 +0100
Subject: [PATCH v2 2/2] igc: fix typos in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joe Damato <joe@dama.to>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772608916; l=2238;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=wTWL+QiTKzAwIGFQ05V+EO1NynA/0tINfOR7I6TtIno=;
 b=/AN+sK9PL2C+4d7bU9X1/MY23gpkk2X6byJ0rYwfANKT2fEFNCgCoHvnRiyNRURPmdy3Gt82U
 SDZKdJvfvv0CYINO1Xu58PXu7nGfNAZ8emc6DFPAG3FvYI5jLyZILdU
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: 7143C1FB893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263622-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,dama.to,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
 - igc_main.c: 'revisons' -> 'revisions' (two occurrences)

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..031561fdce49 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -172,7 +172,7 @@ bool igc_link_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	/* add delay to give enough time for autonegotioation to finish */
+	/* add delay to give enough time for autonegotiation to finish */
 	ssleep(5);
 
 	link_up = igc_has_link(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27e5c2109138..de3f3d95de19 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1793,7 +1793,7 @@ static const enum pkt_hash_types igc_rss_type_table[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = PKT_HASH_TYPE_L4,
 	[10] = PKT_HASH_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = PKT_HASH_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = PKT_HASH_TYPE_NONE,
 	[14] = PKT_HASH_TYPE_NONE,
 	[15] = PKT_HASH_TYPE_NONE,
@@ -7021,7 +7021,7 @@ static enum xdp_rss_hash_type igc_xdp_rss_type[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX,
 	[10] = XDP_RSS_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = XDP_RSS_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = XDP_RSS_TYPE_NONE,
 	[14] = XDP_RSS_TYPE_NONE,
 	[15] = XDP_RSS_TYPE_NONE,

-- 
Git-155)



