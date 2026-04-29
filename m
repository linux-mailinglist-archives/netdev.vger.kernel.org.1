Return-Path: <netdev+bounces-282244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBccABeq8WkAjgEAu9opvQ
	(envelope-from <netdev+bounces-282244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93D48FFA1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB59300D86F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9639C012;
	Wed, 29 Apr 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gazr7/cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58B39C007
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445306; cv=none; b=EB2b1H5uTUBYr6h1STDIIusRJhItsdSC2+sGCisKRwbnafQbCjH69vcVhLfC6VYrBSA1AoZOdaAyvX67FVft8vufTXFaK92LsAd2+TPoWlp696jLzoJj85689+8zaeBsl8ZWual1Uakq+DtMd3pnghgkbLsVx5Uyi32ekE9Onq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445306; c=relaxed/simple;
	bh=74yiVA+barDrmw2/b2nNUKKQm1v84lTrbgkdtxA3hzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pWKxVUn+W6DEgt2YZb3EiSWWm+93pnRY4HgWb4k2BPSFB2HviISYmJZK6cXqe7WIEnlboaR5KQwpFzTZ6/uc0sY5lSHDGkrwk6FA6rR02ZtU0PawwUkN5LLtYfU7qBzDeZdCTd2p+C/SJdxbRiAVCE2Ga1nI29cBK0tdCAKJbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gazr7/cz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891b0786beso88258365e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777445302; x=1778050102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDhQuZ2fFicfJqp5+3HbIXCIa2+xN5jtTHPkvfbA9J0=;
        b=Gazr7/czH233ef4C9mEBOpGxLjLkPZwUhkISYTYvY+1CZFBrEhV/AqEBG+Wnfec5Ty
         xFUDes3bsfRKouMRjClJLxT6+EiE1pBO179KVhCI2BJoTCNqrNNcUktk9xGV8d/ImYem
         P2FCN/q4zP9ek8U862wP5ZdIkRMkPPWhGobTjfX5cw2tpFQPCTY8HKdao98qaLKUlGRO
         ibxvKq82bZOWqYrfZ2MrW7H25wLeWLhptpX7fDPIfa60rHAY917sBcdAfsrrIPtny4PM
         HtKVNZPiS2Uj8Ix25lodL57ZQev+WrgBazQ15AmwUXOm9JYXBaUlRocmWdDIb8w812kH
         RxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445302; x=1778050102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDhQuZ2fFicfJqp5+3HbIXCIa2+xN5jtTHPkvfbA9J0=;
        b=gshGkOECCKVNi6DhX62Gc21ULXV5XKkj1CM0KHZEZgUR/Uxy5IvfPAa8okZZ1S6tCT
         DMTFoDA9mwTrbPmhpuY8Ix3qdlCiGxWlByHg/CgZ+IJmmLgzOYReNtUAfJRKZCPK2bWp
         xmr/a0IBRAyR49UdjpAsw5yD50CdZj8y1j6hORzCODWyM2HI+0oe38/FSEM9C+5MQ3PX
         FuY/xYDzmmuQ1p0u2l7MsNQURKBLy6UYhUif5l6vrCA8KBvazMT+zHbajPg1R7nwIt6c
         TwS73FDZMJSw5FySDSWjXenwsAsjKFTkRwXE7eS6ztomI9amWcTMP0QR+kzU/L4mzRGB
         F8nA==
X-Forwarded-Encrypted: i=1; AFNElJ/1gMxPouPR8Hw1FCm75gc1Nzs9/aVlpXZr40oikvJqwDsSPVjv7nmsgsGeLPNouhn47BNbQbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOCBdUBZArTQw9mG0drhwfN8eGFRXrJh/cdAox5JowkjQCfVg
	TUUwlBCXBI78yfIV2qO2SCqzURnjHFV/MhCTgywy08KwlI9fzrgzwA5W
X-Gm-Gg: AeBDietuOB0rRpjy362GNXlNm6Mo9kCSlN4sTDCobsp8mUzbiOSzY568/PNbiVLm4em
	LFOW4GGFyLIBEV7mbDrD++uevwKFC5B0WHL+CyLHRdEXPg6U5Y7QkpqihBk+P9AsGHJ0PvzvxBJ
	L7ZCnRcNXqu3e1xdt0yB45dWzii7oCzwhXh0Jo8bc2L7hZeJq4MjxoJ7ayM65r7RaKZldziwMif
	R3c9q0qbTkqlFb3ItK/iAO8liRy86u5S9EheZVTpK3oJ9G0beFkYlOrY212p51JyLtKYQCHcAoX
	acGHQIUielXKkjsdHM3ZLhn3L668CRN+STkMGp5E2yp0C1aR2I9gpcE+PRQvnR7as5maP9peNB2
	J9NLa4Ikf7+zH4ERaVJlcFScUNvK56UOJ86gyi6U6E529V3Jlxq5zXvqXqZiT6DVF6aV8eUx/oa
	LWXOWNQxn1XjvtMj2WEZ9GSr4RHpOQRA==
X-Received: by 2002:a05:600c:c091:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48a7b5125ffmr30806325e9.1.1777445301640;
        Tue, 28 Apr 2026 23:48:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c57b579sm33738925e9.4.2026.04.28.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:48:20 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:48:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] sfc: fix error code in
 efx_devlink_info_running_versions()
Message-ID: <afGpsbLRHL4_H0KS@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Queue-Id: 4A93D48FFA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-282244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,vger.kernel.org,amd.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]

Return -EIO if efx_mcdi_rpc() doesn't return enough space.

Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: Originally I returned -EINVAL but -EIO is the usual error code
    when 'MC response was too short'
---
 drivers/net/ethernet/sfc/efx_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index d842c60dfc10..e5c6f81af48b 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -531,7 +531,7 @@ static int efx_devlink_info_running_versions(struct efx_nic *efx,
 	if (rc || outlength < MC_CMD_GET_VERSION_OUT_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mcdi MC_CMD_GET_VERSION failed\n");
-		return rc;
+		return rc ?: -EIO;
 	}
 
 	/* Handle previous output */
-- 
2.53.0


