Return-Path: <netdev+bounces-118094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2E9507B3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C39284CED
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331219DF40;
	Tue, 13 Aug 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb7KCUj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80B125AC
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559584; cv=none; b=tt6W5W7xLpW8od2m0Xw5U0ACTTlZHuMukSZWc8NJROm4+BwxoM+EWmteSyEuC+sNd+EVKIAXzAIP4ly65Yh80VPHgEDQki35G527VrMV26zQyRqSIgEyzRsGAlDRA1ssdaa8GBgu+q0MVIqtm1cRYjic47HSIQHvCX2vQqjOLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559584; c=relaxed/simple;
	bh=+Toju3c/JnKuyBGDMJ2Je6BDER8BS+DlIMjmnUJKK04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnY2nWHg54jDPkrzaZ6tmJPboWzV1BvPT2ViHEsRCgMyApVETPqXZySKhm4i+LnNmDL1SzubaWtqFDOmctK8YkPmD781oZeNMghCtfotIBtv8gvbFmapwof/hSC0sWM+EXsRwP/nchsKqy6xc82OamuZ0ficGRwfQYQYF1LnHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb7KCUj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE034C4AF17;
	Tue, 13 Aug 2024 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559583;
	bh=+Toju3c/JnKuyBGDMJ2Je6BDER8BS+DlIMjmnUJKK04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gb7KCUj7xzybxnt9szxumMeWx3cJ3B9T7saZwW/7EwUCflOX9fl3w+NRDykWB+uW4
	 QJDHoboFfiCRpOp4YLQxgPvrCzexSHr1BmIThLRO4gAy07p062I8+nuZmcSku/ljdA
	 WKwlDejGvC52Rsgqmm7S/yMMirMJWvJbePdj/Vgrm8WZ5il4CY/4bgzLcZaYtmXtbD
	 A3CUWh7L0LnPvrtRb8un7AmZXoPWQLOq3YI5eA+p6ury4Jx/QTuY7CCfuD0gpCAZcl
	 5bK4FU7EESEs6FZr70pT5Mf86YPe/Cf+WedBbjx/QVsWWzroAAutID/bGMlfILIS4q
	 R3plJ0hMjBZfQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 13 Aug 2024 15:32:55 +0100
Subject: [PATCH net-next v2 1/2] bnxt_en: Extend maximum length of version
 string by 1 byte
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-bnxt-str-v2-1-872050a157e7@kernel.org>
References: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
In-Reply-To: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This corrects an out-by-one error in the maximum length of the package
version string. The size argument of snprintf includes space for the
trailing '\0' byte, so there is no need to allow extra space for it by
reducing the value of the size argument by 1.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
v2: New patch
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 61d6afc3cacb..39eed5831e3a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4161,7 +4161,7 @@ static void bnxt_get_pkgver(struct net_device *dev)
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
 		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len,
 			 "/pkg %s", buf);
 	}
 }

-- 
2.43.0


