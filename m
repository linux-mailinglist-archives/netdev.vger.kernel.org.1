Return-Path: <netdev+bounces-303615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1bK6OfT5RGqD4QoAu9opvQ
	(envelope-from <netdev+bounces-303615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838786ECD17
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ot+XN4C2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303615-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303615-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE433010BDF
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D447AF67;
	Wed,  1 Jul 2026 11:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5F47AF6D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905319; cv=none; b=seWik4ckw3ueL4muMENldbVYwCsTjUH3s+0xzweXGvVHzMGrxCo3LQhawtlzyAyTOtL5E3c40iDlrLt25eaHaRH7rrkwCgIhMhNvcafZsfNuaob5mPqPxIytddo4L0uQzqNOvA+lUTbnezzCbaKSjSjEd1jbRwDiAhqnX9lCqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905319; c=relaxed/simple;
	bh=dH5EIq8uJv+DLGh/8edth3FqKBiNu/NXZg3yrCuZPwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+8ycusN4XOGA/e7FImxiuOaBYiV1IrSlxfsA/EeoKyV6jqwL2dbAfJjWtemEhr34RIU8dwxDmTWO2ruf6iJ1fMM4PTql6T6wxeXsBhJ7FDrxULVQxnekpzfAFUSAdmEWrwPY562BWrwRQLYu3TeQMO3Q8/+Ix0xwTm15UwHrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot+XN4C2; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8478a25f268so307329b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782905315; x=1783510115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96KziMX+rGVpoJYIBo0SzFKVDh+T7GIMIX3qVY3Kn8Q=;
        b=Ot+XN4C25PBd6giX0CdaezVu3PL/yxQcos5r1NYswVzgpdS7D/rQ2HThVcLliKHOyT
         EFDba8Oxgzy1MNIckoUD/B2kcVmsHStjX+ffcWQ+vfzA8h3vsY52me8TmPGSYCqvZMdM
         dxWLYtkh1+w/ntw8S67b5cNpF4VPTTwRDABQZGpAh7PGH4P8T81lbGStG2gwbqEX57DO
         aK8skVaoZsVQP/lg41PPQeAVnWc7veOC3cZZKtS8WfufJxFzO8VZBpn4BnQDU2IpALMt
         mqiJ0IYLq4ytxpxwG7A0X+Hf4J6qv67YLuF3KKtOxx0Uf0m8czS9e1RMK7nir0Ydiezo
         iEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905315; x=1783510115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96KziMX+rGVpoJYIBo0SzFKVDh+T7GIMIX3qVY3Kn8Q=;
        b=IFGNseZ3hLJ4OE2r3WuX7L8iYydjhHhQqjhmdYCaUyMfRmSK82MQGtY4D6OKM8AYlE
         G7hzdzIKxeewqTZOqpIAhTPx+qZPW7CA+sEDAYexwsjsYknQrGGffzbql0il2LCV6YrN
         sncpgchw50W/rEdZy1DUx/m8QPqf+v+xYuZoYVJRU4e+zXzz7qzMr81vq4c/Umxtdae+
         Ea1r9t3JK/e7t4suIcNUzvyxr03fc3TUTSEh7i4M0v3mhrRPhVPTLb4O6rCl5EBwIrkF
         mcdu4urABj+GsN6WicveCphm1oywprk1hYljeCwTKh00lRT0B/4bQYvlrLsyRRNh2Yq7
         LLCA==
X-Forwarded-Encrypted: i=1; AHgh+RoblcdD5jLxbhZwp62TD6uU4mMLrdfWxBnTMARbFlG7JdjXkbunBNKhSE0YKn0T6akYraYa/iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8LKA0f60Q8sGRbND0VEij37q6mvh+s1P0z1rpkImIh4qmzrY
	NpzehmfkXlfYrrrXjdfrweopq1600QNFIUzYhh2AOzNFWUChkxT/O+iw
X-Gm-Gg: AfdE7clshsOLXlJAFJDxzPz+0tacIdQIe9vi8d3CijBg+5IX0OPBCIZaG8zH7XOSlzb
	gZvVNQXnMRf7bsCukqaRj26g/gO4n7VFOPKQmChNnXdVJtk1zzqPQLyj3YGsJ7mvhp7zJ6VWdBu
	Cmrl//PWcEYaEB0eRlM4Erj1zICzN6IgEpT+kbQHog9XlxoNyhRYlpDKxKijiD4f/uE4ljq8l8o
	jS+KppEe5NH22Bmg1H+ZvV66qs6NvedGhRqm40qyRJJ0umruUfCclbvecjibgew6lRuGoc2BunM
	eg4AFq5IMPBcxwmYGDOMX9zG1XgyWavYJu41/ohwKGlg+1tvq2Wzp1Zg7gtESpRm0zwg4Rz+Pg7
	ZUoDJFUZwMaWyspSOjybzDZr82puYLtqFrbtA4gi0EQQZZnonQDozJjPND0HwmAB0N+NubxhEXD
	CbVEk/i7TeH1NHq7YknwBEqd6VgR8qJBBDySrgTQ==
X-Received: by 2002:a05:6a00:3d14:b0:845:d285:3b6a with SMTP id d2e1a72fcca58-847c51ea690mr298858b3a.54.1782905315240;
        Wed, 01 Jul 2026 04:28:35 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbff28998sm2934290a12.22.2026.07.01.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:28:34 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] octeon_ep: fix skb frags overflow in the RX path
Date: Wed,  1 Jul 2026 19:28:24 +0800
Message-Id: <20260701112825.1653044-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
References: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303615-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 838786ECD17

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk:

	data_len = buff_info->len - oq->max_single_buffer_size;
	while (data_len) {
		...
		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
				buff_info->len, buff_info->len);
		...
	}

buff_info->len comes from the device response header
(be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
about 3776 on 4K pages, so a full packet yields about 18 fragments. That
is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
writes past shinfo->frags[].

The driver now drops a packet that would need more fragments than the skb
can hold. octep_oq_drop_rx() consumes its descriptors, as on the build_skb
failure path. The same class was fixed in other RX paths, including
commit 5ffcb7b890f6 ("net: atlantic: fix fragment overflow handling in RX
path") and commit f0813bcd2d9d ("net: wwan: t7xx: fix potential skb->frags
overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a00c..4ee911b6c0107 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -476,6 +476,12 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			skb_put(skb, oq->max_single_buffer_size);
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				dev_kfree_skb_any(skb);
+				octep_oq_drop_rx(oq, buff_info,
+						 &read_idx, &desc_used);
+				continue;
+			}
 			while (data_len) {
 				buff_info = (struct octep_rx_buffer *)
 					    &oq->buff_info[read_idx];
-- 
2.34.1


