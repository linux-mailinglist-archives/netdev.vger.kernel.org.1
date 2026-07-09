Return-Path: <netdev+bounces-306365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gR6WBlYCUGpPrwIAu9opvQ
	(envelope-from <netdev+bounces-306365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5437354E6
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=O1VF9SRz;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306365-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC741301DD3A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21D31716E;
	Thu,  9 Jul 2026 20:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FD2580CF
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:19:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628371; cv=none; b=fsTEPML1JY4RV008YVAfedeHOXhW6F+j0mzvzwywDQ8TpuML6Ru3U76Rq56fMK20cqf9kbMnQ19PiK4QE1hxzA96QSyKstcFD8d6ZFqfqRlnY8G5soAlB7iVY/V9BXnDrQqhlnxxs4IejpExvJAV6Uxrp1YOew9FjzOtowxpjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628371; c=relaxed/simple;
	bh=Rtt8nr3qT6hzMGJBoDeZojgqNi/SCvnpBDlzHvuaz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1gtjWHTPYg2RTGWFT/ih0aj/Vt0krxKXpsVuS5mbQGrhL2G7UKzaDJOkdA/YqduBGPrM+WSZRGKW1ING9gtcTkXWy1P0sHD5C9ZbzIELwKvOLf+SUXTCLwVJ3rOzLtI3PfLB9TmDaWP5SneUvIAz51v9yvUV6BNisv0mJbQXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O1VF9SRz; arc=none smtp.client-ip=209.85.160.225
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51c0006ea8eso1316011cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628368; x=1784233168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+lEIT10jaUsYVAQviHGdUkscS5sAHeOl4kQGTRtqCbo=;
        b=KqIGp+nuBGTrisCsenZRsqX0HznvVnj0IV3QAKED7BofpXMN35J3p+/cIMH+fIvJTg
         2BcklflonQRSntjQd72CbOtDwjhOybelQlxu7eU5S2YjaPqq0PGEjeIwsbr8GWoJi58A
         T8lHaI886al0FK9TPFr2fEzEyZWOAtr2Owp3w4QJ3zhhP1KAU4kC3NkJG9luOPVyCBSs
         JTv5W3EhJ88t2g8OdL5MX6r7CRJm9V3igCAmQ0EmOupiExGLdaAop4UWtjrVZ+m3x3T0
         h3/2kGuCbDAg83klNT5/SMW8HciafAUfvRvTYle/qDOJ5CsP7aZJPJKTV/owsGAz4sIx
         d7Fg==
X-Forwarded-Encrypted: i=1; AHgh+RoMNeZu4rD79DaIOZeEnGd6mKKnlU2KT9FGlqbO3Ktp34sqeGfarAqKIG0EQMhWMLcOJuD7ttk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEHnxj59HCzzbAd8yD7zv2AQ2wFoxBoHwFXxdcf6TLg0a2VeD
	6nY8uNll0fcGjHeCU+bBgzYJWLEN0EpNWidGKDAj30Xc19TxlPI/S4he0odAe36OgFnTORPK0q8
	axIaTbFa2CnCkJisDLOkgSyD2Z0ZN0i4WRWEkXLHaeDCvq/DwZJZIZONYO0nM0VQbVhJwCQrJjx
	LqbmJJQvmkCXgqo4T1uqgM/SzG9Rzc5qyA5IEWvJiSarkIG21BoGgrmYzOh70UF6h8G4H4oT//l
	CtTQOojV03EfaPfhnsp
X-Gm-Gg: AfdE7ckZ7M61MOyCIZaLDWKdV5o1vTyt7N/zJ3DHQWKJ6uS3wo+hOoLL/SU/KVbVip3
	7rM3yMNzFngf/bq1S3kIkM6MRYGtEpp1P1nYWSO6kzTIleXF2of+Tihm/zHbIlXRDNhKtaIrj6F
	Q8k70q/vwuIaOSjtqj4Gcutnv14DILFsCCtmKV7O/izqFl3zMwG+i23rx43LvoU1LaoWS47H964
	shc9hCzTEhKD+iwkuJXdnBfXvT+QN0P+vZnTYrOZ+oFt99dfVF515yYE4WHgIrPQype7A6PrRss
	YJhxANaRaJdCuXGV09lwawA3VaXMjeLXKR/7tB7z+9xUoKDjxZ4tZ6xMS19vO41rQMk6ZtDHPXr
	o8Fnj+Ty9+ZGhOr+KRIqlNVf/8BysYurgJUadpfvdsaT6YKhnqCYxwlgNGC8ZB/Ls7zUY1dWqzd
	oshrzDlj1t/P1a2xbt130894xS1/Nze2mVTOAJzMWBE7tbI5Kf4bqY
X-Received: by 2002:a05:622a:1:b0:51c:1590:8e13 with SMTP id d75a77b69052e-51c8b2ae557mr111235571cf.4.1783628368516;
        Thu, 09 Jul 2026 13:19:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51caadbae83sm129301cf.16.2026.07.09.13.19.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 13:19:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so170875a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783628367; x=1784233167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+lEIT10jaUsYVAQviHGdUkscS5sAHeOl4kQGTRtqCbo=;
        b=O1VF9SRzqnvbm/OXwjh8cTXyEJ5TmXWKxHmo2Mheaf8hxVfgN0+SXTklaIrpbIOgJ4
         VQKWjDPFK0N7J+eQXjMAYlWrAT9q9nMmv3w9431Fr578WkH+epmgJK2H0zURtzSRKvfa
         /m3KCNfixx3axcwk5Nhs+hbD3Fn7Umlu1NdvM=
X-Forwarded-Encrypted: i=1; AHgh+Ro8jCajSPlJ6cJWxh7jB9GvCzqPRvoxEi/lMSY9qrkZmW3JmNJrtZ6i4j15/ZkwPwl2w+O8ci0=@vger.kernel.org
X-Received: by 2002:a05:6a20:7d9f:b0:3c0:9c19:6599 with SMTP id adf61e73a8af0-3c0bd1b32c8mr12492667637.65.1783628367186;
        Thu, 09 Jul 2026 13:19:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9f:b0:3c0:9c19:6599 with SMTP id adf61e73a8af0-3c0bd1b32c8mr12492626637.65.1783628366437;
        Thu, 09 Jul 2026 13:19:26 -0700 (PDT)
Received: from lvn-dbc2448.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm35839987c88.12.2026.07.09.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:19:25 -0700 (PDT)
From: Harshaka Narayana <harshaka.narayana@broadcom.com>
To: harshaka.narayana@broadcom.com
Cc: andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	guolin.yang@broadcom.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ronak.doshi@broadcom.com,
	sankararaman.jayaraman@broadcom.com
Subject: [PATCH net v2] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
Date: Thu,  9 Jul 2026 13:16:54 -0700
Message-ID: <20260709201654.4108084-1-harshaka.narayana@broadcom.com>
X-Mailer: git-send-email 2.52.0
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306365-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:harshaka.narayana@broadcom.com,m:andrew+netdev@lunn.ch,m:bcm-kernel-feedback-list@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:guolin.yang@broadcom.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ronak.doshi@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A5437354E6

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
v2:
  - Check VMXNET3_RCD_HDR_INNER_SHIFT up front to catch the Geneve
    inner-header case directly, and convert the remaining
    BUG_ON(hdr.eth->h_proto != ...) checks to return 0
  - Reworded commit message to describe the root cause via
    VMXNET3_RCD_HDR_INNER_SHIFT
v1: https://lore.kernel.org/netdev/20260707165248.1859188-1-harshaka.narayana@broadcom.com/
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


