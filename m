Return-Path: <netdev+bounces-283144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHsWOg959GmLBgIAu9opvQ
	(envelope-from <netdev+bounces-283144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 11:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B34AB70F
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 11:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A10AA300679B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350B383C96;
	Fri,  1 May 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="wBDXD0uV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4F382F34
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629448; cv=none; b=i4DyvfsX3NeyzmK69I3K9LLqVt5o00MnU5HCZrJZ1S5/YL8N/qhKfYCnC3qIDiqEB0SJ1OGraMHIGXrz0CyFuT8lBs5ErE471qv7DuJcj6pJKM9tQo5B0eSl1ITggtH9S+3dAFl95Z9iaVJ52eWgbp2NgXpWAKqKK6O5IK3miFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629448; c=relaxed/simple;
	bh=G/XFuwWSYegiGjSYZM0aXjfEM9ASQLOuSIcX/VLpzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkZmrKbYDJB8QBUP3NsUZyM6FZz55wSKRTmJthpOUt8LcGmLUKRESroWfysMRvDmmlsnwkkaDusIoQ6WH90E0MwVNr/d78P3dM9lk2mWD9L22vThnvK4bWFYOBQXHBKRc7ChTcoTK9OqrCKYNKUt65WhDroCBT//zgvNIXcJ5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=wBDXD0uV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso12953285e9.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1777629441; x=1778234241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xTN6OsAVuW3jnezW6FjJSAEG6gFeBXpHPEFbG0OKV4=;
        b=wBDXD0uV35huVdD1wM1fFaUo3/JXJQuZ/MXEeyXa44aStTGI/am5hzYZA+PKmW/WeK
         KxSj6Iym+6hMnvn2tyY7aHwkySlkYtxGDWMdlI0ygH76JqXA1LPbu6NPx4flhBEHsbob
         v6XqInW59UwHPaUgPOIoLLNzKS9jGqoKlXhy75rogcezANwzoK54qunUd/ZyNspCr6HV
         QEoqpUhOxfBEz9MHeay+a5j2R79yCMgRZV+bjChEDxYwLKY5/zEx3NaFOmLOQJHBLjFa
         BUhwkpyx8jqQoUZ9NNRkzSYYtt969Fzf3sCdhmvJrdCkY5g/SKiIrH1lTCjXsj8LtETO
         fDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777629441; x=1778234241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xTN6OsAVuW3jnezW6FjJSAEG6gFeBXpHPEFbG0OKV4=;
        b=AALSyGBJ2psLeg2oZxfNH1KUoqYk9pi47XFI4mbqGtyvjRHIgkBDY1zJu3LcXmT5Wf
         0NFz43B4BhOT5fpMc9IiS3ruFS9Q1j72dMenMF+h70QbT5DcB+a7V5dUFqxAQTkIYtv7
         fY8lZe7WKEXCp+R5C94lymUibCspHGJkpTYWU5ktJPJ+vvdCP2w9TppLc9U6Qe90dcvs
         OcOoAppfG3C1XpL/SOq+JUo9sLeotsRCL2mnpmsY4VTSLp+TGMclZrG69LzVSzr+vfrJ
         UaPEc6gjEZlG9Q+ADI2BXrkcHdNdIy2bXOrkRorw7tguuuphhlqYV4IFYn3DbsycPNax
         r5/A==
X-Forwarded-Encrypted: i=1; AFNElJ8mzRh3kQJ5XMh2lt2OKjsSLa6GbvIfNWNyBMmvHn8QvG+xg20lV/2L5edZ/qJEB8PDb91q1OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiTG1Bqg43eVsPvl2G8hbEGNeqYCp4rXNJN+kONU0OBRhlqTH
	2WBxjgNKUSIE+EEbOM1BkI8/1QESP8ng0NtnOgMfy8XrSLmxoxitHNpYttpOAMePWLE=
X-Gm-Gg: AeBDietwp5AzxE38n7vq/VBDrKbGM8iqnSsYcnbSzLAAHwJcXqqSTa3ckMj6B2vhjR8
	LwI/MbomXnFE4FdE2q77UTjcbj83+nM8BU7o+qhgYZbnZGNLE8ih0YwGLOdjBVB6BF/aDMGJKki
	7WsT2elxlQrcdzHyF3UO2qcii97zva6g4JuQH/kgHKEfBgjKpolzR2EsryhBMW1rwTEbUFPpkXY
	Di74NEvqAaOc9BAUA0TTMYIF/v252IarpNfwUdLjMIQBK0TL/TfiuVl2jZR1znHTbMdxqqkOoqU
	wSu92ujJCkYM8EZ/8JgtMNiWrdYa+VVYv+TlkBBihjjMjoFXwJ6UYkbEs5nuucTWTfVqByeU489
	XvF8bKiuiENFh2oh0nqCBRXW28yWcB63L8fHuN/KWeOiXdo+Pvj/vdO1qI9C+Q16tmV6lOWVANb
	+0llklcQQe/CXaXKKbqM/n9BGicp/Uee8O63Bi
X-Received: by 2002:a05:600c:154d:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48a8452db0fmr108898045e9.25.1777629441256;
        Fri, 01 May 2026 02:57:21 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26d2::3de:68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm73837315e9.0.2026.05.01.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:57:20 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ice: Fix missing 1's complement negation in GCS raw checksum
Date: Fri,  1 May 2026 10:57:17 +0100
Message-ID: <20260501095717.1032151-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 739B34AB70F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-283144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readmodwrite.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,readmodwrite-com.20251104.gappssmtp.com:dkim]

From: Matt Fleming <mfleming@cloudflare.com>

Commit 905d1a220e8d ("ice: Add E830 checksum offload support") added
Generic Checksum (GCS) support for E830 NICs but omitted the 1's
complement negation (~) when converting the hardware raw_csum to
skb->csum for CHECKSUM_COMPLETE.

Without the negation, every CHECKSUM_COMPLETE packet fails the
fast-path validation in nf_ip_checksum() and falls through to software
checksumming via __skb_checksum_complete(), which triggers the
rate-limited "hw csum failure" warning. Packets are still accepted
(the software recheck passes) but hardware checksum offload is
effectively disabled and the warning floods dmesg on systems running
nf_conntrack on VLAN sub-interfaces.

Multiple other drivers (idpf, ehea, iwlwifi, cassini, sunhme, enetc)
also apply ~ for CHECKSUM_COMPLETE. The ice driver was the only in-tree
user of csum_unfold() for CHECKSUM_COMPLETE that omitted it.

Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
v2:
  - Add Cc: stable@vger.kernel.org (Aleksandr)
  - Pick up Reviewed-by tags from Aleksandr and Simon
  - No code changes
v1: https://lore.kernel.org/netdev/20260408190214.1287708-1-matt@readmodwrite.com/

 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..c177579e0114 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -92,7 +92,7 @@ static void ice_rx_gcs(struct sk_buff *skb,
 	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
 	skb->ip_summed = CHECKSUM_COMPLETE;
 	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
+	skb->csum = csum_unfold((__force __sum16)~swab16(csum));
 }
 
 /**
-- 
2.43.0


