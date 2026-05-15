Return-Path: <netdev+bounces-288264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFMTOoPzBmohpQIAu9opvQ
	(envelope-from <netdev+bounces-288264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7154D389
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B70231B9BD1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7F44B69F;
	Fri, 15 May 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Gx71AIHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97944A715
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838960; cv=none; b=Zb4CYPZ3UQCXpU6xGYgFSJ8OMLe7ULjj6luRjEuoph56XbThmhc+RjLqD2JqcPRIeIDvrEhCCGUwE7jiCZHZGxRhKhNvwh+Rh0gfh9HRXafIgS4+MaxwZoT023GdxxZU4+stjIwsFvvSgeWYXKKtZuZPArXdTOCMP3sIrbhCI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838960; c=relaxed/simple;
	bh=iAXxAaQDu7AYQ3yh9XXeq98ASqueitjzAdAvlTkipVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYj6f9Sw27OzsSOsYkBA/b0e82tNoytI20q50JUyOrFZUmkVwvOCTe6wRTeMD1bglJjscRySj7xyQOj/1VbZJOo5Zo1649LLkZ6TEsi9XoiknY00bmM96DLdpOxN5/oZHpeKsSNKJNoDQZnENOlWeZeh9FqvQueUui7Orr8mbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Gx71AIHx; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bO6/WoBwND4qMmKm1Rn3FY79+Y+Anm0CU0JzhPC1W1U=;
	b=Gx71AIHxNgXIXEZZXBe2kyvtQVl+PXIodvYYHeQakLOQ1Sx02z+TGSlY9DTIK6ebz+Ll0e
	y7ub8k/e/mjswEd3GEz5ac7zGTvdbe3+GlcQZ/CwzbN0YMThUpxOk/3eOIq0nrToHtvD1Q
	8qrW/RNQiavX620ptl1uKSTmw/0DK++DB+ev9WPNQpR6sHqN6YcFP/C/A6QgAMpmprGeql
	njdu0A+U+0kUteSS9q3b0xLZK9qaPCABOZTAZqj1ilt50yWYSASMvLPCneJRMMt63KX62z
	dGmzGM5c5LK0488Wtb2FOpNCL1Z9LHckkNMaLrBATc1j2M9xKkCSMhiVmjqeQA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 06/14] batman-adv: tt: fix TOCTOU race for reported vlans
Date: Fri, 15 May 2026 11:55:31 +0200
Message-ID: <20260515095540.325586-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47E7154D389
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288264-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Sven Eckelmann <sven@narfation.org>

The local TT based TVLV is generated by first checking the number of VLANs
which have at least one TT entry. A new buffer with the correct size for
the VLANs is then allocated. Only then, the list of VLANs s used to fill
the VLAN entries in the buffer. During this time, the meshif_vlan_list_lock
is held. But the actual number of TT entries of each VLAN can still
increase during this time - just not the number of VLANs in the list.

But the prefilter used in the buffer size calculation might still cause an
increase of the number of VLANs which need to be stored. Simply because a
VLAN might now suddenly have at least one entry when it had none in the
pre-alloc check - and then needs to occupy space which was not allocated.

It is better to overestimate the buffer size at the beginning and then fill
the buffer only with the VLANs which are not empty.

Cc: stable@kernel.org
Fixes: 16116dac2339 ("batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 06548dae1039d..f009cbf8a2768 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -887,11 +887,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		if (vlan_entries < 1)
-			continue;
-
-		num_vlan++;
 		total_entries += vlan_entries;
+		num_vlan++;
 	}
 
 	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
@@ -916,6 +913,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -926,8 +924,15 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 
-- 
2.47.3


