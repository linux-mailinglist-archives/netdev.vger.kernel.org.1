Return-Path: <netdev+bounces-251966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AGjLw0JcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A62575A5B3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B28F138C0D1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220448C3EF;
	Wed, 21 Jan 2026 15:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559644A701
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010987; cv=none; b=iUN+bnuZs9pim8Nm8WrbofmOBElJGP2qA+oWYGxyoD5lP9YyuHoYdO9ANsYq10flaXO7xxbSqbsKVJJmszbELmbWV1OWmIPmrpKRmrtVn9kRQ3tAR5iPwR8hZF61eggjLd/Rf0bjs8Dzhk4i7F73Lecm7QRD0VVkfN9jIcEwTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010987; c=relaxed/simple;
	bh=KiK6mfmbvfAjTMgI1Nxjqq2yBnQ7fftuW5wYTWWOth8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5lOCwyiLQ9YAzjPPLcksayMXpLJj2BBxeP8LunsTDeLTMKH0/JgtXVPXOKUXpBxUN/nI8bvx8XKxd9rGvh7RM/6nNLdX5ZPsA0aihwUkxCPVGiZp0T+tcn+sG5lhwiTMnglYC/c2MjlHO+f4fgFIDzkR1mKzcuCIzCzCEZS7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40427db1300so23319fac.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010984; x=1769615784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obI4wQS/LQ9vhDitZWs7Cx+s8XoRN4vJudvn3e5+msk=;
        b=a/D12rqkxC/BGp1OIKBTWhxoKqwONuM8ma6a3B4Js2jHfwBU1YBtycHgReD9/wHmfR
         vomWjNozPJdHZwHgaMT5o2P1DkdVmqfRVlJ1qHNFL/Wjp61SRTDxZ3Gj0RJ4RCaPsa0l
         R5nnainTwwr90a7+wDvksGmaYoK9pm3Esgqtx/kdcB++dX+emsK3AHxilncCv/354120
         TGCf446lNk/UN5G+wpoMhpPVJOtgm4EPhHtUDMWr7ZZ7CTWPeiUVzq+63Oap4vYAZ7i/
         hU8wgt8TnnpuNp2Y8vAI6y40MUUjqlmopgaCQFZzNkoD2oN64zcGsumtS0iwwz3/0ieZ
         6lNA==
X-Gm-Message-State: AOJu0YxsXyC1eHvKlmTotp9iyQXJmjG60BsOJBnKBBkYqkCv6OugS4BE
	KhLSnhj+4oUHp3feLXX6ep2QJQz+TpmMiB5eGC2hlAPuchtz3yc59z7w
X-Gm-Gg: AZuq6aL2RNCX8UNUpMcBnNZtGIu5HvcYe87OVB0pZ5fDTmdBlgHtFpDLBtUXSE64e57
	xBbhs4Qskzf654tGv9HcylIwsE9WutyWAyJLQcf8qXcUiQv3v//EC6Ab+MHT64VzCN7uhYr7zxf
	llguXShHtSTYHEnhfiaGRfJNY4NtwJCdJxOW3R/EbeCun+S5vTaXZj+jEGV780Ky/tHNgTJmfbZ
	RDBl8R6TLe4sLo8Jx/FwpH9zM35qb46eEa/xdyca1ggiihYQddhNUhgzkq2Wxb4pccwA72ePXE3
	j7U34fobdwBMcYD5LZk35WzPJTCFgo8JLE9ZsBPiP4gv/MTVdSUn/n2de8dTvi4mQ1LOIb0NVN1
	t/9ozfhD/83cnv2/gw2E/7tYINxuFQutRYssBvipxFvkKh8Jw5Qf4suwEwomeN5SWT8iIeTq9zZ
	gF9fz1iRybDWeE
X-Received: by 2002:a05:6870:96ab:b0:404:3569:5a41 with SMTP id 586e51a60fabf-4044c48851bmr8465128fac.43.1769010983920;
        Wed, 21 Jan 2026 07:56:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb51d4csm11180043fac.6.2026.01.21.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:41 -0800
Subject: [PATCH net-next 4/9] net: mana: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-4-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=leitao@debian.org;
 h=from:subject:message-id; bh=KiK6mfmbvfAjTMgI1Nxjqq2yBnQ7fftuW5wYTWWOth8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchuDZz2+z3ebNhVWvJuTRSz6BSL//QPW796
 671I66a6waJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bZ65EACXI508P/RfwmkFR+L8D8KIHhJLLGUTsHGVjf7f9Uzbxq1t5/rrWDTt0LzUqDjFooCLwyJ
 NAPPf9u9UEpKrVBeJ5qG7lNHbk6Ky/b8SEiGGZKVJPV3dqIzhhaiuIVNkrIDXjbqfjdT9Sg2wDv
 pzvi3YTkEd0kWWdk78owEkZQAezX8WB1kNjAxyuukT+ODvCFQVHhFPhzdiQ8Bun+WouGUtNveAd
 +EWtKYH5fKPUucNkEkLhlbEhMC/ebXKNXQueOamJj+ntMcFXgidY1pdwefIqtoYe2JcU3LcgID0
 MyCeNp8I5LkPIETtF/XiDk9Lceuw7D6bSPHDcWeRQMjMLHrAzIH0i6aWXn9h2HmGP8xCx2ocgPs
 d4wlIEwi29qh0/t4snIuu+3KsnggeGblNdrnywSZL034mOuzRQQlts+GlszBXLeV9mVoHitLTiY
 K+IujBqywA39DOWRCUHjCleMUH2/ygr1YN03sHmm612ZLHoJbPpCrQG/24G0q2IWlxkydxMQhxQ
 lfXJsFAipVTTZRJqYsNen+XbQKYSGiyNb2nDQC21kmGrX+cIVcgkgUG6zyyHV0MgrXTmbs/8Whm
 5ddLIlmTa2w15UOJOSRLnGcQ8K8ZqEt7y4CFh1TvVZseEhRiu9MooSRKujESwSL8EWbytf50r+w
 2NVXroXMqRDJzMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251966-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A62575A5B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by mana_get_rxnfc(),
remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 0e2f4343ac67f..f2d220b371b5d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -282,18 +282,11 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
 	}
 }
 
-static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *cmd,
-			  u32 *rules)
+static u32 mana_get_rx_ring_count(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = apc->num_queues;
-		return 0;
-	}
-
-	return -EOPNOTSUPP;
+	return apc->num_queues;
 }
 
 static u32 mana_get_rxfh_key_size(struct net_device *ndev)
@@ -520,7 +513,7 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
-	.get_rxnfc		= mana_get_rxnfc,
+	.get_rx_ring_count	= mana_get_rx_ring_count,
 	.get_rxfh_key_size	= mana_get_rxfh_key_size,
 	.get_rxfh_indir_size	= mana_rss_indir_size,
 	.get_rxfh		= mana_get_rxfh,

-- 
2.47.3


