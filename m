Return-Path: <netdev+bounces-168156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79EA3DC29
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3248E700E66
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330191B85CC;
	Thu, 20 Feb 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NTznyQ7W"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135321BBBF7;
	Thu, 20 Feb 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060500; cv=none; b=uaE6yU0r2Wa6ASPBiiu9d4ES+nHbxAXL3N15hZjAe2n76uXEK5XkSXXYZWMJ2CdjY1pmOQGWyHzNajDW+ZnjGISfix4JzG6h1mgnknyutzp0lLvnVy9FRg8FMqPXAcMkYOAVQ9FanNT9kKZSXoV7LqNjIwOSFxpCYHTrgWmB8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060500; c=relaxed/simple;
	bh=CoHFlBoN0AcSa0D3D3bSPzTlGbRoOzu9bkMfziXLfYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7kxarMF5HjAJQnPoqJG705elk16wnh9GKB14jUjOvhQ4lJA9EGB8CZgFNOkpNyzjnqDU1QhaXzhvkMD/ht5J2tJTvplRFuc4qllS4WGk3mheQOLap/sg9xvY+AKvCPlV1a53YRQDhtUDIznZNejNKAtbuAqgxyhp3HCCg0j3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NTznyQ7W; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=8K5p3TMW4brEw9zIKOr+aOV1W5N+3CjUyZ3AitePbPY=; b=NTznyQ7WxjSAYRJw
	tlNpUoTjfxToIh1pxx4I4Fu2aNIScWk/KgtHSn3X9FYs3coL4AgrioDN3ZP/AUHe2vBzFkgi5tSv9
	7ssLEV2AiPRQbZNLX8lDf/O4Zs3v/MXQxDfTD453FdOcue872nC2vTRxlj7U8pxV5Poq4UnmRyVN8
	ZjIKDrVscpnBoYe+Gy+RGQDsf6CSj9DtHTN6TX0JaJpXwdA5dscnqzY+HHcIKonR3RhCE4EomcSz5
	NQX88hKpvXSWUTQR7PI4kdYyaEC7z3iHPZpsURvk9QGlSsZGN+uT6viivvGg+LvwgDqpHMN5KkjuE
	RSb5Ifv3qh0rOnVxOw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tl7Dl-00HBXK-0b;
	Thu, 20 Feb 2025 14:08:09 +0000
From: linux@treblig.org
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] netlabel: Remove unused cfg_calipso funcs
Date: Thu, 20 Feb 2025 14:08:08 +0000
Message-ID: <20250220140808.71674-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

netlbl_cfg_calipso_map_add(), netlbl_cfg_calipso_add() and
netlbl_cfg_calipso_del() were added in 2016 as part of
commit 3f09354ac84c ("netlabel: Implement CALIPSO config functions for
SMACK.")

Remove them.

(I see a few other changes in that original commit, whether they
are reachable I'm not sure).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/netlabel.h       |  26 -------
 net/netlabel/netlabel_kapi.c | 133 -----------------------------------
 2 files changed, 159 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 02914b1df38b..37c9bcfd5345 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -435,14 +435,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
 			       const struct in_addr *addr,
 			       const struct in_addr *mask,
 			       struct netlbl_audit *audit_info);
-int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
-			   struct netlbl_audit *audit_info);
-void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info);
-int netlbl_cfg_calipso_map_add(u32 doi,
-			       const char *domain,
-			       const struct in6_addr *addr,
-			       const struct in6_addr *mask,
-			       struct netlbl_audit *audit_info);
 /*
  * LSM security attribute operations
  */
@@ -561,24 +553,6 @@ static inline int netlbl_cfg_cipsov4_map_add(u32 doi,
 {
 	return -ENOSYS;
 }
-static inline int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
-					 struct netlbl_audit *audit_info)
-{
-	return -ENOSYS;
-}
-static inline void netlbl_cfg_calipso_del(u32 doi,
-					  struct netlbl_audit *audit_info)
-{
-	return;
-}
-static inline int netlbl_cfg_calipso_map_add(u32 doi,
-					     const char *domain,
-					     const struct in6_addr *addr,
-					     const struct in6_addr *mask,
-					     struct netlbl_audit *audit_info)
-{
-	return -ENOSYS;
-}
 static inline int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap,
 				     u32 offset)
 {
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index cd9160bbc919..13b4bc1c30ec 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -394,139 +394,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
 	return ret_val;
 }
 
-/**
- * netlbl_cfg_calipso_add - Add a new CALIPSO DOI definition
- * @doi_def: CALIPSO DOI definition
- * @audit_info: NetLabel audit information
- *
- * Description:
- * Add a new CALIPSO DOI definition as defined by @doi_def.  Returns zero on
- * success and negative values on failure.
- *
- */
-int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
-			   struct netlbl_audit *audit_info)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	return calipso_doi_add(doi_def, audit_info);
-#else /* IPv6 */
-	return -ENOSYS;
-#endif /* IPv6 */
-}
-
-/**
- * netlbl_cfg_calipso_del - Remove an existing CALIPSO DOI definition
- * @doi: CALIPSO DOI
- * @audit_info: NetLabel audit information
- *
- * Description:
- * Remove an existing CALIPSO DOI definition matching @doi.  Returns zero on
- * success and negative values on failure.
- *
- */
-void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	calipso_doi_remove(doi, audit_info);
-#endif /* IPv6 */
-}
-
-/**
- * netlbl_cfg_calipso_map_add - Add a new CALIPSO DOI mapping
- * @doi: the CALIPSO DOI
- * @domain: the domain mapping to add
- * @addr: IP address
- * @mask: IP address mask
- * @audit_info: NetLabel audit information
- *
- * Description:
- * Add a new NetLabel/LSM domain mapping for the given CALIPSO DOI to the
- * NetLabel subsystem.  A @domain value of NULL adds a new default domain
- * mapping.  Returns zero on success, negative values on failure.
- *
- */
-int netlbl_cfg_calipso_map_add(u32 doi,
-			       const char *domain,
-			       const struct in6_addr *addr,
-			       const struct in6_addr *mask,
-			       struct netlbl_audit *audit_info)
-{
-#if IS_ENABLED(CONFIG_IPV6)
-	int ret_val = -ENOMEM;
-	struct calipso_doi *doi_def;
-	struct netlbl_dom_map *entry;
-	struct netlbl_domaddr_map *addrmap = NULL;
-	struct netlbl_domaddr6_map *addrinfo = NULL;
-
-	doi_def = calipso_doi_getdef(doi);
-	if (doi_def == NULL)
-		return -ENOENT;
-
-	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
-	if (entry == NULL)
-		goto out_entry;
-	entry->family = AF_INET6;
-	if (domain != NULL) {
-		entry->domain = kstrdup(domain, GFP_ATOMIC);
-		if (entry->domain == NULL)
-			goto out_domain;
-	}
-
-	if (addr == NULL && mask == NULL) {
-		entry->def.calipso = doi_def;
-		entry->def.type = NETLBL_NLTYPE_CALIPSO;
-	} else if (addr != NULL && mask != NULL) {
-		addrmap = kzalloc(sizeof(*addrmap), GFP_ATOMIC);
-		if (addrmap == NULL)
-			goto out_addrmap;
-		INIT_LIST_HEAD(&addrmap->list4);
-		INIT_LIST_HEAD(&addrmap->list6);
-
-		addrinfo = kzalloc(sizeof(*addrinfo), GFP_ATOMIC);
-		if (addrinfo == NULL)
-			goto out_addrinfo;
-		addrinfo->def.calipso = doi_def;
-		addrinfo->def.type = NETLBL_NLTYPE_CALIPSO;
-		addrinfo->list.addr = *addr;
-		addrinfo->list.addr.s6_addr32[0] &= mask->s6_addr32[0];
-		addrinfo->list.addr.s6_addr32[1] &= mask->s6_addr32[1];
-		addrinfo->list.addr.s6_addr32[2] &= mask->s6_addr32[2];
-		addrinfo->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
-		addrinfo->list.mask = *mask;
-		addrinfo->list.valid = 1;
-		ret_val = netlbl_af6list_add(&addrinfo->list, &addrmap->list6);
-		if (ret_val != 0)
-			goto cfg_calipso_map_add_failure;
-
-		entry->def.addrsel = addrmap;
-		entry->def.type = NETLBL_NLTYPE_ADDRSELECT;
-	} else {
-		ret_val = -EINVAL;
-		goto out_addrmap;
-	}
-
-	ret_val = netlbl_domhsh_add(entry, audit_info);
-	if (ret_val != 0)
-		goto cfg_calipso_map_add_failure;
-
-	return 0;
-
-cfg_calipso_map_add_failure:
-	kfree(addrinfo);
-out_addrinfo:
-	kfree(addrmap);
-out_addrmap:
-	kfree(entry->domain);
-out_domain:
-	kfree(entry);
-out_entry:
-	calipso_doi_putdef(doi_def);
-	return ret_val;
-#else /* IPv6 */
-	return -ENOSYS;
-#endif /* IPv6 */
-}
-
 /*
  * Security Attribute Functions
  */
-- 
2.48.1


