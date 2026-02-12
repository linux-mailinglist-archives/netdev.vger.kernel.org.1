Return-Path: <netdev+bounces-258396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKlaNZcmjWlOzgAAu9opvQ
	(envelope-from <netdev+bounces-258396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53233128C0D
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02548302CD2F
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626021018A;
	Thu, 12 Feb 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH2OgMbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA21EBA19
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858113; cv=none; b=iKKdyA+OTBej1I4y1OU05Ywr9VlBmZ4c4mHpd5yhvHmFLXIXfCmty1Y1VB48xeLkQWJmY2o7MaKmOJte8DkHuOdMUEe/8rlgyJtACnEvvleXaSMlLOXRmlDcWrX/LotSicHBxXwYODpJEeCZYQ+ZFriAhKfa1qzLsr10WKc+dbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858113; c=relaxed/simple;
	bh=zktDEYYU3DDBRPUPo4PVQU/HdJL8/6FwLa6TYkRnm1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcAhyKxBpG4g7NI7rSK2S0oR7TcTcl0w72tu74xoaMtZnkB8PLr1b5BCUF4LJMVRNd7s1thp0vPG5wBP9rmzDpLkc+EJB9+KLoXzsU40KzjG/RJPqhElzlh2EhHDPuPaSsoKKWWH96b0Nd9Sbluhb5aAp6nO2niuSZqcd6CK+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH2OgMbu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7974d908318so5340097b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858111; x=1771462911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeC44Eh/w10HWx6k5aqFmc4ViuCuD52xfeamBzvXwS4=;
        b=XH2OgMbujxDgCk98940EQ07oa9zNBVng00frwNtKeCOraNUCUBtL73i20O036f2/Fn
         hK7p7jWU6OnfkEVj4VfryhyaprlBjWFzZMr4fLzA68fNaaSJoKvVKuFsLQcmcmVk4fCM
         qqKhYeyvDmk9CBfp4jO2irJYwT3XmUZkp0j1jGASA3/a4v4rOW6vXxzFJoqR0Bm6LkY2
         hvgk8UcQTwZQ3puvVgMINmju9SWCoQBorUWQrnsNy67DId5WrfI3fEXNqlqlXvQDfnea
         KN02R9IcEPfFJYY3zvhRYuPD1cGex96fmQI4QEXxtKsea5g3tBTqY9nIa0Fd6C+PWrTs
         I0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858111; x=1771462911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YeC44Eh/w10HWx6k5aqFmc4ViuCuD52xfeamBzvXwS4=;
        b=LRaRxfXHWR5DC3Y3B025Up7Gyo15Xplds/EmQuurctHkED/k2C48d8aqfYAccmx4Vs
         i6xfiLQPVaZYOXBcc40wZJsrDRJsXzFYwBsoVwfad2yb5skEFuYTG+zbs1c30K0eUR8q
         8VhGznh9sNBlHSVmQBIkH7cSgHyQl2N2RkFYJMvHAGHsAFi859K7z8uzz0mExSeW9T7w
         SaC0+hDnhMTY6mce4NzyqqwIJnvCF7Rw3aUune8fPB0P0K1EeaVcpTrKQuKXM5Yi5hCk
         JBBlnk+axVmokzTvtZqJZtWNIxLAiHyYPJ4k4PvxpjED5iP4o3L6j4KEJUcAbw+Q2t6P
         PeSw==
X-Gm-Message-State: AOJu0Yx+aRI0iq08tC1OCKw/eaO01RGa8x3Yl+9A531dxJMYp5G5XERi
	YGhkLxT12UJJVsvFwSF0/eeYJYMbHQ1aKbS6J0Nn1V5xp1dqM8pWMMJs
X-Gm-Gg: AZuq6aJsbbaA+arcPK1/y5Yjx6US87B0xGGcwv1QA1y8xgFsNEaNg4gceKOMEGvK+uo
	nLfkNu2lTR5auGze/E8Ydr1mTFbNnOIUL+rfYQph0WuSRmEDqPBC6unSilhz1QQEL4mVeuLlsFp
	/9fPOj1OboxlOwcxvQTbEwvvxXeTrNc429tHFADCzqYxV5gT24ewXp0bFi4DRnRMafOVEfFnzyk
	RkX0/oL2VNQYT0FqKujlN8UDrZBype6lETlYv96Bn41oczp+WIGnK+loVMDoCk1CnueRm9mT/nJ
	ipmpAZGIVCAZi0P7hK4TbF1cdd3IYkcbmmfBc673cfI1PdApe0PPBzwisDWVeJZ8m6hJmaoBcnm
	saA8lFw2nCLsBKMmZ8JHH2aegW1Y2pTa3WS4UHKO3AMS5WV91lDA7NcZ4PnzRWgltqm+bT21NXr
	I6MR4E4+b8gFaBpDlnmGM3bQ==
X-Received: by 2002:a05:690c:a053:b0:788:247f:3648 with SMTP id 00721157ae682-7973768d21fmr11485697b3.66.1770858110863;
        Wed, 11 Feb 2026 17:01:50 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16f201sm32051927b3.10.2026.02.11.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:01:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 11 Feb 2026 17:00:43 -0800
Subject: [PATCH net 3/4] eth: fbnic: set DMA_HINT_L4 for all flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-fbnic-tcp-hds-fixes-v1-3-55d050e6f606@meta.com>
References: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
In-Reply-To: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258396-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53233128C0D
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

fbnic always advertises ETHTOOL_TCP_DATA_SPLIT_ENABLED via ethtool
.get_ringparam. To enable proper splitting for all flow types, even for
IP/Ethernet flows, this patch sets DMA_HINT_L4 unconditionally for all
RSS and NFC flow steering rules. According to the spec, L4 falls back to
L3 if no valid L4 is found, and L3 falls back to L2 if no L3 is found.
This makes sure that the correct header boundary is used regardless of
traffic type. This is important for zero-copy use cases where we must
ensure that all ZC packets are split correctly.

Fixes: 2b30fc01a6c7 ("eth: fbnic: Add support for HDS configuration")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c     | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 693ebdf38705..5edc28ba2955 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1142,6 +1142,9 @@ static int fbnic_set_cls_rule_ins(struct fbnic_net *fbn,
 		return -EINVAL;
 	}
 
+	dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DMA_HINT,
+			   FBNIC_RCD_HDR_AL_DMA_HINT_L4);
+
 	/* Write action table values */
 	act_tcam->dest = dest;
 	act_tcam->rss_en_mask = fbnic_flow_hash_2_rss_en_mask(fbn, hash_idx);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 7f31e890031c..42a186db43ea 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -338,9 +338,8 @@ void fbnic_rss_reinit(struct fbnic_dev *fbd, struct fbnic_net *fbn)
 		else if (tstamp_mask & (1u << flow_type))
 			dest |= FBNIC_RPC_ACT_TBL0_TS_ENA;
 
-		if (act1_value[flow_type] & FBNIC_RPC_TCAM_ACT1_L4_VALID)
-			dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DMA_HINT,
-					   FBNIC_RCD_HDR_AL_DMA_HINT_L4);
+		dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DMA_HINT,
+				   FBNIC_RCD_HDR_AL_DMA_HINT_L4);
 
 		rss_en_mask = fbnic_flow_hash_2_rss_en_mask(fbn, flow_type);
 

-- 
2.47.3


