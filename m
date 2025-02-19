Return-Path: <netdev+bounces-167569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EBEA3AF43
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CC83A30FE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BD18E25;
	Wed, 19 Feb 2025 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bjYDMJEP"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA62AD0C;
	Wed, 19 Feb 2025 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930587; cv=none; b=QTVCBqWgoETXXaDm05Rl54bmbFWgwArpgaPqpeBwPrxZVVIl667KsXnTs59KlHTa63qaGwMoS/fEuINmp+1p76TE4UF1iOhjeHyUsl18kJnLh+nB2K/3a+/5XXTHkBaFskjum5gZlkJJNYI71viTuCc77XayYBW+cuBFVa5LG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930587; c=relaxed/simple;
	bh=fELp2PNa8iDJ1WHE5FVlLsHwIN3FhNevWlC0Rway+E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqNHrRUoQeG3HuQJENBRXaTx/WN+dc9fbx+DLmdwx0Donwo9YoawdQ6x5vEY2yyRoUu44BRlOGocvnBL9Hsaj2kOYzCeILPOwIUsOvN1pRZx8sqb2h/dvOdDmAi1U7+3ABUy2cB0xyreOX1h+A+TLEtkkRT9CEm4r71AGO8ZhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bjYDMJEP; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+CyruaMHsTGV/esc470Cv4UW/4i85eYmfd8kVyFEF94=; b=bjYDMJEPyWWtbtGJ
	3MgTpmX0O/o1bZV65G8CrQ5oUqv+xTrVGUvuxl81QeE9abupdTUSFhc6QLHMbRxBnhtdrLmIGdgId
	2YvRcuhZsz6swJCJOg67h8bgDL0oZ3eeklx58TYYkXbl5+B8SgBWl8K8mHHQl5ImhBP01bXnrD24B
	+IvsbwyMRuEuOtKhW4jNjtBbP5KLFdug04LiwMuyTrfkurOrJwEgY2ngFX3MhoANkOMy6NomeyEXE
	emKQlhnndhQaSoQvGC6/hqQUcurafbGspGABO0ecxIHdqbGVPaCwX566nSGLOyrM+yNR/RJbLKufr
	30Yvc2/Lq0oLp+eRMg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkZQR-00GmVS-0D;
	Wed, 19 Feb 2025 02:02:59 +0000
From: linux@treblig.org
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] nfc: hci: Remove unused nfc_llc_unregister
Date: Wed, 19 Feb 2025 02:02:58 +0000
Message-ID: <20250219020258.297995-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

nfc_llc_unregister() has been unused since it was added in 2012's
commit 67cccfe17d1b ("NFC: Add an LLC Core layer to HCI")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/nfc/hci/llc.c | 11 -----------
 net/nfc/hci/llc.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index ba91284f4086..e6cf4eb06b46 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -78,17 +78,6 @@ static struct nfc_llc_engine *nfc_llc_name_to_engine(const char *name)
 	return NULL;
 }
 
-void nfc_llc_unregister(const char *name)
-{
-	struct nfc_llc_engine *llc_engine;
-
-	llc_engine = nfc_llc_name_to_engine(name);
-	if (llc_engine == NULL)
-		return;
-
-	nfc_llc_del_engine(llc_engine);
-}
-
 struct nfc_llc *nfc_llc_allocate(const char *name, struct nfc_hci_dev *hdev,
 				 xmit_to_drv_t xmit_to_drv,
 				 rcv_to_hci_t rcv_to_hci, int tx_headroom,
diff --git a/net/nfc/hci/llc.h b/net/nfc/hci/llc.h
index d66271d211a5..09914608ec43 100644
--- a/net/nfc/hci/llc.h
+++ b/net/nfc/hci/llc.h
@@ -40,7 +40,6 @@ struct nfc_llc {
 void *nfc_llc_get_data(struct nfc_llc *llc);
 
 int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops);
-void nfc_llc_unregister(const char *name);
 
 int nfc_llc_nop_register(void);
 
-- 
2.48.1


