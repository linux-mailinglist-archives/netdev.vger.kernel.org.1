Return-Path: <netdev+bounces-306340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E+TgFkHlT2qDpwIAu9opvQ
	(envelope-from <netdev+bounces-306340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:15:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C77342CC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:15:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VwHrcfTD;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306340-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A1A3041A26
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B14DBD70;
	Thu,  9 Jul 2026 18:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E494DBD60
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:13:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620834; cv=none; b=AcpfqABYSx7C7fg8hnhb7x95LEHy15nkp4FNScqh0zhObegT9wY9dMbbm/tFHFaCOQTDSigSv7/HQ1ODMkgKTEbdZw9SwkKc5sbQ/p5n2SL8X4GLqAEjsrK7z1r9fxw2DhmYk/QVC+wQcEL6y2yaRsElor8k7F4K68NBneB7/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620834; c=relaxed/simple;
	bh=jf3wizrO3DNNSjq1mqu3bOte7Q6bOCty8fy7G99VYS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4wdBd00DW1y9dCuK+tE38UKBxAUPY9VVyty5TjfddypOviiLWQtNOQJe1ehQBusxO57hlhYK6e222yg6XW9peztdFBw06xhY6Aqc7PDVNRA9Nhu0LiBgxPoX6ZsKG0sIlzeUYTPCaeLms05kJz1Nnv74QB+kc1Rb3XWpoRmcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VwHrcfTD; arc=none smtp.client-ip=209.85.217.97
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-73750ce4b2bso64624137.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620832; x=1784225632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GljFaPL3Kh0qSSSK7pTtIfC3Z+Tx2Ojf8hApXmO8iA=;
        b=CIF6yE31rbaDDvIQAVIci2Zw1WheBlCjpiXt/tCZZBgG5K/DV3h/Nc5iluVXG+YBur
         6GnbSzfEBs2WiaGmHpfDcM3/SHDi0Fwf2kMXl6vchHsNum4TunRcsNdzOgtzJjSd/G2q
         BbQdd+wNI5yTO5yVXJCdM4OQKE20QMy8DcWkMZ5Ghrt+QP4/XHW0m+mXIcNjKshhTgcU
         gsEce6Y8f321MrAUUOczIobgzBcG85qsBV/8b3rbcqSaN+MMyT9UeSc+q657pvwNXMaY
         J8Eoj8MIXT9AVf4WZVi7TnwFx+aAGDeaaL5ESSvRafHvJH+CfVzEEQE1Kh0yQHToQYHz
         Wodg==
X-Forwarded-Encrypted: i=1; AHgh+RrkBbkB2s2ZJETIOteLq443SbTswgEij/prSZ5rrtVn8MFsZwJSarGBpNi6lDECmoXIBflXzVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNADfJ2DFfGfoN8q5Le2IJCSD4UBOk0gr4hbQ6nGI1H3zk1Yfn
	Jlru7W/dYaFDGVy/4RJS/Q6bIsQhSUKJtxKpb3uyxwXgaGixR76UfIkU+8sC32TwJKrBgikOZgK
	92939prCJ1Q3Tf9FwgtQeGoIbpX3mu0j7f0ZHcv3LgCekrICzldIsSqE/+B4uKm3Xk1z/bdwkVj
	ilO80ecX26BdjI1yZGwZuC2cjNOjh/TkqUj0O82RqblC9s92YLQ3NCmzn8f6Nsry4PBPQrnhbgr
	zaEhtC+8+323P53So+2
X-Gm-Gg: AfdE7cmfvg0jwBN3+Ykh8p/EddxoUmmji3pZvx6+LyaP7q5DmZZTKu59k+8+/xjA0iB
	3bGdIirhlMAcqAJl/C3YiKaO25vXcOxtYGmjJUTgJgdF9fmuOszzu4Ycntrf9ox70Joo+s24Sqk
	4Q1UqsvBWbf8IJO4gYMYplKSIhvA/6iqlUF7Ai74rqAfNSVue0HfQmjrWk0Q7y9IRC4z4c+WmQ2
	0FItebvE/bKx/4yKfC0Sw4ff3yvacI4CV23jV75zdenQe1hYRizwp8iS4O9PrC5GpvYS1KeWXLN
	8wg+kzGau3UiV5qRVA3u1DGlMyiteZdsSpw6vyXtL+2b9+zEe9LN+mU6BNoJLk+npQxkR2amJs2
	dqWaPCjL6P49mMAg30Mgmi0JqNpdijyaNJWzIzwfG/bjw8rPcioBjDYiyF6gC71s0EQLUkc5fSS
	aklugO/6YBLbi4JllnMpflJ+GOXLX8Mpw1AjGAN8K2Phyp3YNcnRsh
X-Received: by 2002:a05:6102:a4b:b0:73e:605c:4078 with SMTP id ada2fe7eead31-744dfe61ac6mr5041962137.15.1783620831849;
        Thu, 09 Jul 2026 11:13:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-96ecf7878aesm293044241.0.2026.07.09.11.13.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 11:13:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so253767a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783620831; x=1784225631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GljFaPL3Kh0qSSSK7pTtIfC3Z+Tx2Ojf8hApXmO8iA=;
        b=VwHrcfTD7rAzhJYDwjofp9cG0iDEqfRqIO5vx0+3mrTndrUHf4Vhzf07Ze4uss7swN
         txEHns3nV6s3CPhjsEhM5Ia0cYv7GRTdpZCc0gBBK6X8Z+ZsMmZjAf9NpOzdS754UgQK
         8xE6CsJNrcllIY0+TSNWNX+n3kwNDI0YYo1kQ=
X-Forwarded-Encrypted: i=1; AHgh+RpbnjnHzBzTYsAe4isFxltpzDsVbV2Z097ZHFPg4oqvl/BG3bKxTnm5FbzPV0GiVCzym+V5Zow=@vger.kernel.org
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:aab1:cc8b with SMTP id adf61e73a8af0-3c0bcea2b24mr9653575637.46.1783620830754;
        Thu, 09 Jul 2026 11:13:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:aab1:cc8b with SMTP id adf61e73a8af0-3c0bcea2b24mr9653540637.46.1783620830282;
        Thu, 09 Jul 2026 11:13:50 -0700 (PDT)
Received: from lvn-dbc2448.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm35076417c88.11.2026.07.09.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:13:49 -0700 (PDT)
From: Harshaka Narayana <harshaka.narayana@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	guolin.yang@broadcom.com,
	Harshaka Narayana <harshaka.narayana@broadcom.com>,
	Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Subject: [PATCH net] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
Date: Thu,  9 Jul 2026 11:11:46 -0700
Message-ID: <20260709181146.3260540-1-harshaka.narayana@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
References: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306340-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:ronak.doshi@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:guolin.yang@broadcom.com,m:harshaka.narayana@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A71C77342CC

vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
outer header, but for a Geneve-encapsulated packet the device can set
them based on the inner header instead, signalled by the
VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
function never skips the outer encapsulation, this mismatch triggers:

- BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP), because the outer
  protocol is UDP (Geneve), not TCP.
- BUG_ON(hdr.eth->h_proto != ...), when the tunnel's outer and inner
  IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).

Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
function cannot locate the inner header it would need to parse. Also
convert the remaining BUG_ON()s in this function to return 0
defensively.

Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..dedf4082eb6c 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1530,7 +1530,13 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
 	} hdr;
-	BUG_ON(gdesc->rcd.tcp == 0);
+
+	/* v4/v6/tcp then describe the inner header, which we can't locate. */
+	if (le32_to_cpu(gdesc->dword[0]) & (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))
+		return 0;
+
+	if (gdesc->rcd.tcp == 0)
+		return 0;
 
 	maplen = skb_headlen(skb);
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
@@ -1544,15 +1550,21 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		if (hdr.eth->h_proto != htons(ETH_P_IP) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP))
+			return 0;
+
 		hdr.ptr += hlen;
-		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
+		if (hdr.ipv4->protocol != IPPROTO_TCP)
+			return 0;
+
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		if (hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6))
+			return 0;
+
 		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
-- 
2.52.0


