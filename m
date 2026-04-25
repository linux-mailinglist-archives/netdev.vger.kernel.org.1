Return-Path: <netdev+bounces-281105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tXshKtiE7GneZQAAu9opvQ
	(envelope-from <netdev+bounces-281105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E73544659C9
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEADD3009B2C
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BC36D9EE;
	Sat, 25 Apr 2026 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqETPIQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CE35F5F4
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108179; cv=none; b=lOO5PLtFaUD95QClR7zGiVEBZD/XMZXcAAyEufcTMHZ605ATotoNAp8t51RhCBy142oeNL+iiHvHcRrhemwEjRyBhP7REueo+s24UPlO0yGpyHt6tV0u5YwiLGaVIJf46tpRgNnN+SF7+ZK+xVupArGmeabwOa4e6G3KE46oP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108179; c=relaxed/simple;
	bh=yn0n7unySXi2xE38g0Fs5uwMd71BZF2HOYgbp6bbEcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cnoTMooX4hHmgvXnUJI3G2tuQGcpE0IqXc2mNZmZMNURt51dpN674+4q5BWWmu1cMtAtU9UfrLDVrTX3AQF2MhAqz4Ec5FwkLC1I7hiRfZYs/t6Vyprw5KJMFoFV/8fWSMB4mfA/ZHpZ+UKmpqmOYOQ1i2TtPnrZ5Mmpv9elA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqETPIQb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso79944355e9.3
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777108176; x=1777712976; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GuYWc9nESbYSG7ThORlI5mhNLyHqE9tuWw4BPRuJSI=;
        b=jqETPIQbJ+ORypc0Yu7mYdfEGjcTZvVecsV3RMS1Qdaby40HZFVhdHeWoiX0jAvSBs
         XTj7PXMxBvNf2JuBOPppeQkjbw4obkjtQN2NRfr5g2qcQHMVzum3D3/53fT5Wi8X3vds
         /gZ7bI3oWp0NTzUtNj2NAGVrqVou/PJQ9p+EOuTO9hYv/dtDDneMqlCBy662jLJnkj6d
         gMLq5PmdfiKDR2e9wZYbtM3sdmHA7wJc3RFZy+RehR6UMzBgddWNLYZh6bCdmcUFYX8B
         zL52xKQQWXwhUiWDzxVc78IHD6u5ZCamj9iY8qv74HjhMXHLKqEjh2v0wd04anzyEmLK
         l7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777108176; x=1777712976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GuYWc9nESbYSG7ThORlI5mhNLyHqE9tuWw4BPRuJSI=;
        b=pGxDMeqdcn7ka/g3s1GEhrRzfDhKSFrgzio9NPzfTaGfsHpa72GbMrMclLqOSXSnn9
         YU4hF2B6Nq8F8wIOiL94W829mj1cY49RNcslshiEMZtCG7lDuPoB4qqyhIkPMCyVH1hb
         aZTshC1WRwNRK84i5FH+m3BGozKNFg/iwBtGxXuS/xQXdNCX06rv+txFdkGzGHw3Rhkr
         cEllrfltHO47deMcvgxNtjCZ+tJWFLZUnDwKcD4LAFCtBHlOcZusvGk1oJszoF8HsytY
         LMclA/5DSHNtyyDpgunTzyMpaN1QSxyWxonTEkEdBVqkqjU97LU9uj6L4P7Z6alIdDFd
         m88Q==
X-Forwarded-Encrypted: i=1; AFNElJ8chTm6ZBxCjzN9yGwwQpPrUPrmxWM+zWXL/2NcHb7k4O1zs/XA5pxyZCXO+lmdmuaKEmnO6xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJOMQbEUKA2XD/++zZQsFZOWCnMcfT02/K2JQRPDTbAP5Hbss
	SCDfDumQNP4zWB7T4x2pT0S9/zVVm8DnoiZr9K5WQ9/yJs63JoZm1PMR
X-Gm-Gg: AeBDieuhboDCzlCIAWGSo2j8cWxtekzApw/ifcZAocSEd0xt1VPw7cb4RSVsdu/xTbI
	PG3Jk++/0NmZtvfTkAacfyFbxW/j02cvUvznchhU+NczWl2bCgTwWifUb8MroKAfF1ZARTXjiCt
	fEv1MNhJiDZQnYVwwhSysjAL59rLfn0YgqanxBhSVt8ZhAchvqRoV7kvBiJt17xXlodHtyWmCDx
	zyuTDmbRq2FUhXRvfGqOImWPvPidoBSykK5bscDjpbs2Omj+hYTD1Nq+V57k1Si0UL1lX8Esgt4
	lMHsAg7tHjT/9ErwogrRR5B+iBPegWaLI7kSDrUFQJSxLbXpdB3cMsN5NFkslgUo9x37vMIplLw
	n+7UPRAdYvosbAXx+oMl95+lSh7jcsbqs4K6PeAZX8VFyRuUWrf321pCnnAFgNt+F3DKgba0HDz
	8kSqU7Xjq33qH1kpKBLe8TVUEEd1VzSQALbzWPnxrb
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488fb796f95mr416216655e9.31.1777108176309;
        Sat, 25 Apr 2026 02:09:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm782163945e9.1.2026.04.25.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:09:35 -0700 (PDT)
Date: Sat, 25 Apr 2026 12:09:32 +0300
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
Subject: [PATCH net] sfc: fix error code in
 efx_devlink_info_running_versions()
Message-ID: <aeyEzO6C-v6J1VHH@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Queue-Id: E73544659C9
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
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281105-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
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

Return -EINVAL if efx_mcdi_rpc() doesn't return enough space.

Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/ethernet/sfc/efx_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index d842c60dfc10..45f412bb9b5d 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -531,7 +531,7 @@ static int efx_devlink_info_running_versions(struct efx_nic *efx,
 	if (rc || outlength < MC_CMD_GET_VERSION_OUT_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mcdi MC_CMD_GET_VERSION failed\n");
-		return rc;
+		return rc ?: -EINVAL;
 	}
 
 	/* Handle previous output */
-- 
2.53.0


