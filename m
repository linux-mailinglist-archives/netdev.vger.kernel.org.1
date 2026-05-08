Return-Path: <netdev+bounces-285877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFeTElz5/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B24F82BD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 511613024A38
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FE3FCB3E;
	Fri,  8 May 2026 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBcSVAhu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205C3FCB00
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252048; cv=none; b=VgRYmZwAEZ8nokNDqFoYyNHoDGcWo7sjhnMFGhT8J2WTyWFUTKq30eXR8hs7zWtIjMCoNqI/cXQ64VROKqr7bEL8UIOPqEHPwKOOhOKh/dJ5d0Mz6JsV6F9dzhygHtk1tBt+jiyFyKMF0b+eLUqGnf9li5YgVaX+Je/heM0IDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252048; c=relaxed/simple;
	bh=36DgZFE5cWQ/2I06imy7s6CW61tBQ1NllxQ2tZYBFhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUnAs5bZ9FeepL39AMfz/7ETJh432NG6Sb0GrRdS/wdtO93hbefKpHNYnnV0jmZ+1abvY+bve9PKsuOPby9fWgh2HF6WW0wbx9zcQoU61CfCgQh1w8f4SAmUxbTerYD0n3KmhCZ/6XIUwsyXhD2433GH2IKGbatWSOpVrqob2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBcSVAhu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd89701acso1879494a34.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252045; x=1778856845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHL1wJQG1EIug8Z16j66mJo+lKQHRHLvWtIK615c/6Y=;
        b=eBcSVAhui0dnRIpBkoAxEI+H+frOMTDPxFMo7GarVpT7ZTW1UfuynJ6w68J8KHKiLD
         EcVbm0GJxepUWcNQSZQ631emacVQ5QvFGi6CMZMnoCkChgPSgqKYEu/dmthR5/jXWf5E
         SvQP4PjnsseCTU2v4CrgRWYoYJ7quG5itsWq2JLbR79BkDMRuuxwJLKvXjlNJKan5xKC
         0/cVkEbwcwAEEV1sEiGWZcgaOc7xA8QOVuDhl3TJ7KQ7hXY/F864Ac86MspnB6EqP0UK
         +P98XP7s303GRlUhtnR4dVnQWGVKKSUmCa7mXFOcF7F8kGuIssDGvgkSkt4DYxLyTMRe
         L8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252045; x=1778856845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHL1wJQG1EIug8Z16j66mJo+lKQHRHLvWtIK615c/6Y=;
        b=TF9G+hC96/fV+hMJwRgRE0GVeMWDCJFnXAv1PxiJYKKiDDxhuyaT9x7fPOQa+VClan
         kXxVkhzflB120DHbeUXzlaTPltsIWnt8E3EpQ5HXy+Ocg2q8lnA7b/k1dOLRnnngxhWi
         zPHzKa7T0JGD4pOT9YWaz4npy1pyeu8AKugbJ+y0gcuzCjI4zz4S1cocA98CnukCGTqC
         UTtCVKsG4Rti0014ujjXKKmf1wVRwEON5P1HQLJNIuhBAmUMWACF9zPa4bXy28iQlf/Y
         CAm5TTp1sLUM48QX12rerJH7oS6pSKQniizG8dwgfHbXFj8Dd54FEF4/dE/DyzYN1RSM
         6Fhw==
X-Gm-Message-State: AOJu0Yyc1BVP6aNjRG7M04PC4B7bDbLbbOQRj+F7oq4jUTF2xIhfEh+D
	SCJjsqqWJNc7T00suGMxuvy9WMOo68T4tAbSdhbas6rGq/aHqh5EIGXwvHZ6bQ==
X-Gm-Gg: AeBDietWeZDQBSGa1Yxarl8Yw9r/fPsebWil7FMIPOxHD6Xn4AOKby1yRoD/MnlPRgn
	yI9hqa1eMCYZ21ogPcVoGAa+e9+aogywfAXUFnXoMgCfYGW+etbVKDoXmonQo+fdf8XZg9C6+L9
	1+tnAQQKd6h9BngFYyw+Gix6XkwCy6XXO5/wfLS/QJts9QGsnGdoAlnrh99VWggO+yd/AM2T2VQ
	tQI0Y/uZwmVGjS7/w9lbK2xKK+3uOJJO6vtyXWJoSqjJIptL129CU89LZqTYoJJ63MgR305S/oI
	y2EWDRMbBXl1odw9JOdoafonvQQFu6E+2gAU3T0TfEi4vQjV0u2OJXFj+3dEFDtpVIftTSrl7cD
	c3RGh+zvfLAexPVCBqc3b4S9/u+tcVbHB89sRk50mrOl6lNQQruQVydvtv+B0EdtiHD7Pqy4eCB
	jKdQvNVlgMvYvRL4ghdkwGafdum7WK5cuWx9T6SMLcTq5YRsR8CgzYgdnjkelLl1A=
X-Received: by 2002:a05:6830:d8d:b0:7de:a2cc:9dde with SMTP id 46e09a7af769-7e1df04e894mr8115894a34.15.1778252045438;
        Fri, 08 May 2026 07:54:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c056desm1190872a34.10.2026.05.08.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:54:04 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:49 -0700
Subject: [PATCH net-next 6/6] netdevsim: psp: count rx authentication and
 length errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-6-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: DE7B24F82BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that netdevsim does psp parsing and aes-gcm decryption in rx, we
can report authentication and length errors in the psp stats api.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  2 ++
 drivers/net/netdevsim/psp.c       | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 112fe1ee10bc..5f0f638ee893 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -118,6 +118,8 @@ struct netdevsim {
 	struct {
 		u64_stats_t rx_packets;
 		u64_stats_t rx_bytes;
+		u64_stats_t rx_auth_fail;
+		u64_stats_t rx_error;
 		u64_stats_t tx_packets;
 		u64_stats_t tx_bytes;
 		struct u64_stats_sync syncp;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 4945973d523d..053c01cc310d 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -207,8 +207,12 @@ bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
 
 	psp_off = l3_hlen + sizeof(struct udphdr);
 	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
-	if (payload_len < 0)
+	if (payload_len < 0) {
+		u64_stats_update_begin(&ns->psp.syncp);
+		u64_stats_inc(&ns->psp.rx_error);
+		u64_stats_update_end(&ns->psp.syncp);
 		goto drop;
+	}
 
 	if (FIELD_GET(PSPHDR_CRYPT_OFFSET, psph->crypt_offset))
 		goto drop;
@@ -238,6 +242,9 @@ bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
 			    payload_len, (u8 *)psph, PSP_HDR_SIZE,
 			    iv, authtag)) {
 		memzero_explicit(&ctx, sizeof(ctx));
+		u64_stats_update_begin(&ns->psp.syncp);
+		u64_stats_inc(&ns->psp.rx_auth_fail);
+		u64_stats_update_end(&ns->psp.syncp);
 		goto drop;
 	}
 	memzero_explicit(&ctx, sizeof(ctx));
@@ -346,6 +353,8 @@ static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 		start = u64_stats_fetch_begin(&ns->psp.syncp);
 		stats->rx_bytes = u64_stats_read(&ns->psp.rx_bytes);
 		stats->rx_packets = u64_stats_read(&ns->psp.rx_packets);
+		stats->rx_auth_fail = u64_stats_read(&ns->psp.rx_auth_fail);
+		stats->rx_error = u64_stats_read(&ns->psp.rx_error);
 		stats->tx_bytes = u64_stats_read(&ns->psp.tx_bytes);
 		stats->tx_packets = u64_stats_read(&ns->psp.tx_packets);
 	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));

-- 
2.52.0


