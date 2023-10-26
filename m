Return-Path: <netdev+bounces-44417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B640D7D7E96
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E394D1C20EA2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E711C9F;
	Thu, 26 Oct 2023 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnuhbYmh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914563D6C
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:38:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8D128
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698309510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BGnModyxxabVDouEDH7V4XE5H33aX5s1L3RuIOlJgco=;
	b=HnuhbYmhy5Q4Z8xfiOJ+hBcMg9FFEQS+/taXxxZd6309/ibtI389g2I2980LbJ7UmG3i6I
	qbuf/lbgYrNq7TJ5a0BRS04sPa7denW21KFXMNSJxvZOoi922i1bX4R/Y90fPJhqSWEh1I
	VLGQA4cHfQAlfgj7q+nQ3zcWlJMUJXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-qldHcjaqPfG72UpL-PRVFg-1; Thu,
 26 Oct 2023 04:38:26 -0400
X-MC-Unique: qldHcjaqPfG72UpL-PRVFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B2F61C07244;
	Thu, 26 Oct 2023 08:38:25 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC671121319;
	Thu, 26 Oct 2023 08:38:23 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next] i40e: Remove AQ register definitions for VF types
Date: Thu, 26 Oct 2023 10:38:22 +0200
Message-ID: <20231026083822.2622930-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The i40e driver does not handle its VF device types so there
is no need to keep AdminQ register definitions for such
device types. Remove them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index d561687303ea..2e1eaca44343 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -863,16 +863,6 @@
 #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
 #define I40E_PFPM_WUFC_MAG_SHIFT 1
 #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
-#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
-#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
-#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
-#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
-#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
-#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
-#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
-#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
-#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
-#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
 #define I40E_VFQF_HLUT_MAX_INDEX 15
 
 
-- 
2.41.0


