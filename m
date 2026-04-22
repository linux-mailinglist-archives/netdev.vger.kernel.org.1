Return-Path: <netdev+bounces-280468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCPlCi3y6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B94483DB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75B6B3013BB1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1638CFE4;
	Wed, 22 Apr 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLdUHqnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00415383C78
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873917; cv=none; b=VuBBZyqei8/tasC3jVuX3Oe5l7StOv9mzd/BW5Lko0pH4CvTKXhDVIckrTHNKK7VpHVYxFls1cXzHWgx9xMh+CoAXtbkr1bY/qom6s5Mn5KlYzZF0ou7G3kKChJSA6Cy2aimmJIH3A6wzKZ9PyYoXU/c2XT9ri3FvmmSdM9YKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873917; c=relaxed/simple;
	bh=AtnVryVx9lrXSxBtUvHjd0g9UDr19+73eoU6BB1Ndsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAy2ZLrFoMi1rWHbt58h23Qho3uPaanoNqcw5bfIANtAiqivpeTd3QfDjD5KaVrUBPoQQC0/M7ifttFcJpAsr1aeiEFsYYCHxO0izvREyYzHfyLal/Lhaz7PUZZc8M9ywn6RJk1XotNn+0ys7qtavFoYgaSP/iopNddTIUbmsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLdUHqnY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8f0579401c4so56242785a.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873914; x=1777478714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAsi8zUH7ChWQsvBus194I1lIQB9uLlb+xLBIearhJU=;
        b=aLdUHqnYoPmjaVv77TbajnV64t+k67UNr+/eSkA92z9mGge6w60zePtKDJkemqRBsz
         FaVj66iKYrFVWCzc6tdvGP7B2rP8/HuwDJ3k9OzI9MSpzlVC2j5b11vxwafuoBxVDH+E
         yvMKawCmuFVOsH0UJLDMl7KpdhvB+RuKlI5QaIRI1f62Y3/bHY8+VBH+dzvSgry/16mS
         sA8OsDIwRjx3wuDwP2MjoT9djMOdoThLtP0vLcYRoe+0Nb0FTObW2JNX9dtr3sap3Qsh
         wkOqM+0Bb4lwdehyaWuYGU4l8/alXO1vapd9/7+hbxe9JAQ+neL6XbHsiMFvSDxhUxhn
         X9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873914; x=1777478714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAsi8zUH7ChWQsvBus194I1lIQB9uLlb+xLBIearhJU=;
        b=j8kDuoHSEHXU5mlhbaScrcM93r7+pFOeeOqx5AirgUNY9819cp7rfGxxUsfA3GN2+l
         mKq7zyXAg9U84iTwJn66x+c2OeaqZPK1kqF/etVF3YeFMCNZJ2dHtpKtA8Csp+IpE2MF
         k4CEZaCuuFyDackHEht3VVdpAs8cGeGhMfH66rTXbL5MKNQ/EDpf8CkQhSQPQNIWSy7E
         Kh6tWS+OYE61hQozI8Ke8XvLlBby3MLcyp9YFxXCA5kL7kFmHeUX6ip6uXqv/qnq4CK/
         BTkrWjVyWzdovIAl1/RPHrVY6Y38ZETyeSfXu233QavMW7klIhDWktUzoLVluc/Q8ykI
         l05w==
X-Forwarded-Encrypted: i=1; AFNElJ+xUNoDTVcIFxsP09fs81XQuhRiToNcZFfoP/NY5OlQDihkyvJX/buHEYist43dfsajMHhR6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2Xn1+QDK5zQ9STHXLFGuevyiakzah+poI62E+xEe9gMLPjTz
	lz+wvnO9H0ocnNDiIkJt668oJjtyCokdLoINoTFZODbjd7RmQz+lJZgZ
X-Gm-Gg: AeBDievKDnAVWb3z7RuHQhFxHGuaJ4mb+s0W0keg9aXjtXEb6n1koqz+Luh/5Pw3nmY
	zuWRpAKY69zq+UWQSlIPb4tCu3I4TDl3W458ajU2uh9RWKMkZhDFfz/RToIuPpfSAHviEOA43Yj
	tKylfbiDEYsjM5vB4Iok5m9TuqjPpR9kII4UUBrs48kW9HBtsYTOxaMdo/L3VeNypAaijSh+teH
	LmpnAYfpk0C/FN/y1/Ayci4Jd3DyLMv3bwJx54GsSYNAho5BqWH4JmBx+RE5mXzNH5NW3ef9MIV
	mdAVt9CaTlNU4n6tWXItRadVmIFj2jobSv/3CWGRaD5MKG5GM6B9JejKZr76L9DgWNw802K9MHX
	suFWgwHJmi2D6gX7/Bv2MXxry62ZeVuNt5sLVcMzI9Q+x31rVLmCX1GE+RjsWXtw27Om/N8iCcr
	U3aCVmTpln5loRCjx2i7rSTQqFAAQ9RrS9Z6rGQeprOUzC0S/pFyFoD7PM9MiqTpyfgLrRERH+U
	myH+TvKVYRp3lKnDjwYcgES+oRtyLM=
X-Received: by 2002:a05:6214:400a:b0:8a0:846e:8850 with SMTP id 6a1803df08f44-8b028042ba3mr348401516d6.20.1776873913609;
        Wed, 22 Apr 2026 09:05:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 6/6] net/ncsi: validate GP payload lengths before parsing
Date: Wed, 22 Apr 2026 12:03:42 -0400
Message-ID: <20260422160342.1975093-7-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280468-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B74B94483DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ncsi_rsp_handler_gp() now bounds MAC and VLAN counts to software
and GC-reported limits, but it still assumes the advertised GP
payload is large enough for the fixed fields plus the consumed
filter-table bytes. A short GP reply can still make parsing start
past the payload or walk beyond its tail.

Validate that the declared GP payload covers the fixed GP prefix,
the consumed MAC and VLAN entries, and the checksum before parsing
the filter tables.

Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 94354dca23ea..565d38fd4b92 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -899,6 +899,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_rsp_gp_pkt *rsp;
 	struct ncsi_channel *nc;
+	size_t needed;
+	unsigned int payload;
 	unsigned short enable;
 	unsigned char *pdata;
 	unsigned long flags;
@@ -924,6 +926,14 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	if (rsp->mac_cnt > mac_nbits || rsp->vlan_cnt > ncvf->n_vids)
 		return -ERANGE;
 
+	payload = ncsi_rsp_payload(nr->rsp);
+	needed = offsetof(struct ncsi_rsp_gp_pkt, mac) - sizeof(rsp->rsp);
+	needed += mac_cnt * ETH_ALEN;
+	needed += vlan_cnt * sizeof(__be16);
+	needed += sizeof(rsp->checksum);
+	if (payload < needed)
+		return -EINVAL;
+
 	/* Modes with explicit enabled indications */
 	if (ntohl(rsp->valid_modes) & 0x1) {	/* BC filter mode */
 		nc->modes[NCSI_MODE_BC].enable = 1;
-- 
2.53.0


