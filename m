Return-Path: <netdev+bounces-297240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9pMeFvdhKGooDAMAu9opvQ
	(envelope-from <netdev+bounces-297240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:56:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA91663747
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=bAMCUPGe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297240-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DDE430188B2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14ED4C042C;
	Tue,  9 Jun 2026 18:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7048AE04
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:56:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031412; cv=none; b=sc998TGKGCHo9eeyX2oXG0tPJ5HYXYN+q2SastLQEpx6ZCzNb8DmrPCq/TCLmiT5jxIhwxo7nB+b7kmO4lTayE6bO9sYVmyQQDBe3s3ZjYddz2oQxAd7WwggE6UiuAPFTIvKZD2jFdFK583UmdP5CaRLDjihl4yBODdCdYqG4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031412; c=relaxed/simple;
	bh=HJCGm0COA5ItiBybYQGy5woQjXOj1c/FVQ+aq0Bzo8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMhPOMjC7u5zZB4C8+sttEzyZPUQeOOC6pV8x/AQTWq3SDEfkLM98qzlhVooboqclpaiD3ZDWOFwJ6KU0aBsQWEjgK1RZ7873CrSsE7QEBUfxYtfBq6vIsx7opPTV9DsERhxy0KFetPzz7LAoTfkyPJqwoMHtFVUTPEpYyvWM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=bAMCUPGe; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso82006856d6.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781031410; x=1781636210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16iV7RIIpsvJlA2HjI7+KG5mxLD2wZSYZrTwJS1TsvY=;
        b=bAMCUPGeCZaCNUZuI1s+oTJHWQHCcor5xmNLap8cSrfkfhjFL66Uqzz00L7LPSZSdv
         sR0kTZl+mDjwkNKqvq3GsRzTrPBJ+GT3wxK8VTyuPll7Xv+gf7HqNFyuxh10QIQnkaTW
         I82iOhwIQRc+TX6tRdUMB4I28BA2vXgjnJefipkC7VSwKH4Jxz/jnitzNoyRTPA7xnWd
         9GItCvjm0iyfxllhAKHH18Fshi5WrZH5s+A40Dvjrg+VZ7s660Sy32m3Nv37veLYaMkc
         UaPy4WNH5bTorYApPMPkxVijYNE6Q78/k4AJ0a9ynUHYj4AJ/bHx9q/worfEceEBMKmP
         lOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031410; x=1781636210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16iV7RIIpsvJlA2HjI7+KG5mxLD2wZSYZrTwJS1TsvY=;
        b=AURjjWUAycmMys2JPa9YIuwEUlFzeZWeNADoLmn/jPP2jjzApjBJXKirBE9UWEs3CG
         ziriiJjZLoMNcgZlfHHPFFjxd2syGS6N5dGq/4MjsgwHH7H0DjIEKV6X6iZO4rEX82ak
         Qe8BknxOvSSegAG+EP5x+cjoXbjYdxh9/yRm54F1l2jlhZmyZWadQ7KhJayohtGZyj2m
         kQwBkYK+bMS6Lv0hos6rfBJBWBwU3WgPq+rVcgTHZ1b22gy5I5upEBT20GEaf45BmmXx
         2A4ceoJlu76yAWeNYoPZe2PKFoDHsUF0p4xCawREVRUODo8UVam/zJBSk7B55skIsv1W
         aMkA==
X-Forwarded-Encrypted: i=1; AFNElJ/vnjbLjv6SM0AHG0hASzBKR40XGL93y9gT+0xDl/SzdhFWFzRYYVzX+XzdJjLLylDUo6d1XHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEslRtUDCsVY9/dgwxJ08PLK7J1m4jWk8FoTlmpW4dx3TncLh
	4z+aPM3zrV8OB86mSQK0JWZsn5hNSeWr2VEpdwsT8yDHPW4K0Vgyh0EqdmeGHCHzA1A=
X-Gm-Gg: Acq92OGpt9RQUEYANQrQJz3UGMOzOXZJ7liXiTk4lfrbVT84NC9r/ao1bGnJcx/W3lz
	imWGscaWel0RE478J0DupJ1Kn6qN0ke94w2L3MVFGEtY/rZIQhKupF1lgSAm7d+jDGdQ3rXstpD
	Y/Z6cc6YV+HWN7qcdFShaEECjZptftsqd2N+Em6XaFBd/DNCuDaFrw4PxFle6VAHcSjomr4vjEH
	nqqwJZeEPeq8KqY5tWn5bBbzefyHVsErfIiQSbrgRzn9YVdjgJrsJUWL6JnWk3kF+mkgMqym7PT
	cThmvo+gquBCWQxNltlPFU3dh7pT2EyJbJmpO8qBMWt/sZRFHuFvPLPtWxx2ntbiIB8rXF715rP
	gINQugTFUkdQ1m6ETRBkEVpgiv7UwLq3pwQNDAhZ3LDdrTd/Q6iJWmwzoPI3cesvUAhzG1VE/+V
	fvo15PfdDT9p6ef7FoaXQzzTVP/ELUNqv8r+N7sA==
X-Received: by 2002:a0c:ff49:0:b0:8a5:104b:e37b with SMTP id 6a1803df08f44-8cee629b32amr281614486d6.42.1781031410153;
        Tue, 09 Jun 2026 11:56:50 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd06d600sm212001306d6.35.2026.06.09.11.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:56:49 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Tottenham <mtottenh@akamai.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Josh Hunt <johunt@akamai.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] net/sched: act_pedit: require matching IPv4 L4 protocol
Date: Tue,  9 Jun 2026 18:56:34 +0000
Message-ID: <20260609185636.1599359-2-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609185636.1599359-1-sam.moelius@trailofbits.com>
References: <20260609185636.1599359-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:mtottenh@akamai.com,m:pctammela@mojatatu.com,m:johunt@akamai.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBA91663747

The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
header fields without confirming that the IPv4 protocol field matches
the selected transport header.

That lets a rule written for TCP or UDP modify unrelated payload bytes
in a packet carrying a different protocol.

Verify that the IPv4 header is long enough, that the protocol matches
the selected TCP or UDP header, and that the packet is not a non-initial
fragment before applying TCP or UDP extended header edits.

Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Add check of iph->frag_off & htons(IP_OFFSET)
 net/sched/act_pedit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bd3b1da3cd63..0d652dea4a69 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/overflow.h>
 #include <linux/unaligned.h>
+#include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -331,6 +332,9 @@ static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int head
 
 		if (!iph)
 			goto out;
+		if (iph->ihl < 5 || iph->protocol != header_type ||
+		    (iph->frag_off & htons(IP_OFFSET)))
+			goto out;
 		*hoffset = noff + iph->ihl * 4;
 		ret = 0;
 		break;
-- 
2.43.0


