Return-Path: <netdev+bounces-257797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF9KNzzQh2mSdQQAu9opvQ
	(envelope-from <netdev+bounces-257797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:52:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468461076D8
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5AAD302A2D6
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDA2EA473;
	Sat,  7 Feb 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YoWUmwZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A522301
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770508311; cv=none; b=e01jf4rbq7sbbuzguaCcE6BZpkWEsQ8oXz0cbNzbSnoNlVAeV7/oGZnOCYYzuzZpMrB/7AJtBSV9FGAp/rrMLrAsB6BygdZGYSVUgkFUqcZ6DSNrQDLZ4wfajKPsuiJw+fLxlXd9v7zIz+Mp999nmj26PexWpjMtw7kXQyvPwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770508311; c=relaxed/simple;
	bh=H3E9stVAr6v88+2z0wBe+59xKlqqjfdH10QTWIEXe5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEne2i+xyxZIqwhWTysWHPjbhve64wbkbLCpgAO/I/l4lG5fYWbssOLu1/lElgdln1dTComaTJv+g/d4atmf3zGmd859zeVvRtdZKNzEuWKDZuXRFmR9TZtxNGGl9TI9OXAJb1bau2pvDLyF6GHyFdlql4YSPgvObRKtUJWchOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YoWUmwZ9; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a963f49234so2818395ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770508310; x=1771113110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMvFH+mJJ218Bjsbu54P7EMJQvPsv6VQirp/RETQzR4=;
        b=MHBAoTHqjl7NZ5kfCFZGleLSsGiiD27LYd3hIPWVPM1X8Jt668TGyjo8zuSsmYZbfH
         cQgRpePZV5MSaLa5WnDUlA7GWoumCUPjfkFj55Q0nNB7vqDk5aPi75X/4htmkScTPUYS
         YfeSco4cPsT2g45nmfNFAPHf2lhmgy9Gfrbw192LFwZrF9Jnqv5F2onoAURPe6zaiD7W
         tBhNMaDSQDrnshHLTNsBPhBmg9mPzBTrFhcHRFzyOE/G+oAUCDvFdvu1RaOUXlP9+riu
         mhgPqH+AK9X8TgRbpBo39T8/HLMePziXFuRG17h3IwtgSyXfwcogE2XPv2RSI3Jac7tq
         qplg==
X-Gm-Message-State: AOJu0Yy0Kisn273sT2iyE5h9i8/m9bv6FBEo3r+YFrhcB8h1USkkBNjc
	5w2HwB9nsxCdEFhD3HlIT1+tP75I8KHP1K/viQbBeVfEFszz0Bz2w8Ew4iKHYN+o0hYLFpvJn2r
	dL6OE6RPNH1fmT69Bxu/d/qAzNdyTv5kdRQRTUNBKBkS0g2Ijf4M/M+VTE39Ct0JvAimFibnm8V
	84i96PZ81216LzQri0vm+VIT2W6rVWXviC0WoFQgO5E/7AMKZe+cgxLJnhxnBgF8/tLD990HqtE
	ozFqLdARyw=
X-Gm-Gg: AZuq6aKxbaRKLfAJ2enyHx6Wx8lUJWnJa8EedQObtgx6iYYAbXiZaSIfBfVj7o7Ymik
	Ok05/29gXqDDxglMkur3PKApV5uztCAtwjN9RqJFx8tDxKgtGm7a5s2K2Kdd4113kHc2OYeiHNk
	uMihvjpQZsj5K3tQaJAQWaXiwU5uY5EEebskM/Co9i7fpPAK2UOEnk6AF4iF2gBSo9WjDoM7cRs
	VfEr50j4k6L3QpGg6C5nBUh+m14WiJ7os2V2bE5xpaU8eaaHmFHTrK0su+4aHQxkdbrXRQ1U17W
	Tk1jS51kbqpOZeF7AV8u3K9ZBzYgZaDhpsduDCkZ4kFrslS/2ZLuz1f3/SABnjjJXc3Y7y+yCI5
	D4xQkc5IQMBCWQzqZ0gvg1a95gTWEZbN9kDKzhnEaGwTZy0i4MPNLQLXioTI/WI2oz3qmYU+td8
	LIHO+2eSFlRb4EAo1EogoiV6JWeVuMrz6u6ucn5WqTn6cOsAo=
X-Received: by 2002:a17:903:1c1:b0:2aa:d672:3be with SMTP id d9443c01a7336-2aad67204b4mr14343175ad.52.1770508310388;
        Sat, 07 Feb 2026 15:51:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a951c8427csm9263605ad.22.2026.02.07.15.51.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Feb 2026 15:51:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba6ad2ca1fso551012eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770508308; x=1771113108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMvFH+mJJ218Bjsbu54P7EMJQvPsv6VQirp/RETQzR4=;
        b=YoWUmwZ9ZMGswL2Hr5ZinnY62Dx8ElD5TybDSr63hxEsKlt4DaJuUukKcZ8jfP5T7v
         5iifyGQ15qk3NWoF59araSIJ+wfookERbouBzakcp6cYnSfgQzR9n4ahzP08mOFOl/lJ
         5sG0FjYSLU5JwtJALEH0W+PMNBBFKiWDA5IWA=
X-Received: by 2002:a05:7300:dc88:b0:2ba:6723:5060 with SMTP id 5a478bee46e88-2ba67235587mr395759eec.31.1770508308436;
        Sat, 07 Feb 2026 15:51:48 -0800 (PST)
X-Received: by 2002:a05:7300:dc88:b0:2ba:6723:5060 with SMTP id 5a478bee46e88-2ba67235587mr395756eec.31.1770508307937;
        Sat, 07 Feb 2026 15:51:47 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3db30sm4479446eec.21.2026.02.07.15.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 15:51:46 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 2/2] bnxt_en: Check RSS contexts in bnxt_need_reserve_rings()
Date: Sat,  7 Feb 2026 15:51:18 -0800
Message-ID: <20260207235118.1987301-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260207235118.1987301-1-michael.chan@broadcom.com>
References: <20260207235118.1987301-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257797-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 468461076D8
X-Rspamd-Action: no action

bnxt_need_reserve_rings() checks all resources except HW RSS contexts
to determine if a new reservation is required.  For completeness, add
the check for HW RSS contexts.  This makes the code more complete after
the recent commit to increase the number of RSS contexts for a larger
RSS indirection table:

51b9d3f948b8 ("bnxt_en: Use a larger RSS indirection table on P5_PLUS chips")

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4745063d2f5c..59f0ae745446 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7956,6 +7956,7 @@ static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	hwr->rx = bp->rx_nr_rings;
 	hwr->grp = hwr->rx;
 	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
+	hwr->rss_ctx = bnxt_get_total_rss_ctxs(bp, hwr);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr->rx <<= 1;
 	hwr->stat = bnxt_get_func_stat_ctxs(bp);
@@ -7985,6 +7986,7 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 	if (hw_resc->resv_rx_rings != hwr.rx ||
 	    hw_resc->resv_vnics != hwr.vnic ||
 	    hw_resc->resv_stat_ctxs != hwr.stat ||
+	    hw_resc->resv_rsscos_ctxs != hwr.rss_ctx ||
 	    (hw_resc->resv_hw_ring_grps != hwr.grp &&
 	     !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)))
 		return true;
-- 
2.51.0


