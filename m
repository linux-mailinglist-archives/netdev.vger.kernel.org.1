Return-Path: <netdev+bounces-257052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE1zLOVZhGl92gMAu9opvQ
	(envelope-from <netdev+bounces-257052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:50:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8CF0097
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F9930028CA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3423563DE;
	Thu,  5 Feb 2026 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="qHbkn/Xh"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FE34A76A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281438; cv=none; b=nbroIl3edrpvTTw1hilBfTLKBiPJhZ4RpTUi6ApJacqfoLwbCDzjHd7F+CM4VoOUQbhFSf/VCGpPkgfYTynspoJdowl1Cd5ZlDjXRc4RRJMJCiPpexYteIJOdcGuyxkjuvyPkAse2PBc9TsR7Idfeq67bvxB6FzEyeVFyPv/0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281438; c=relaxed/simple;
	bh=hpKVzP1DmRoecduP8bI/ozE8B53XIPIzxHhqQTgfrkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0oGzFSkgR+M+gsZ9ORQVj4Hu/ByQHgYn25mGdRbNir9QDx/CnXZm4IujTTDrk6mQhjo+HTGRaAVY3lc5YQhXz94W2O6GzMJBD2x3T+tAfRYjwbTygpjIU1ZIMW4azMlVXDP+AfivlxX0JHQw0xWFXl7J265y+E5Bt2HYO2Ic6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=qHbkn/Xh; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6158oWoE095645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 17:50:33 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=vzZSPwzsQrlN833+ulO08E4OEkrP3Y5ctEKzjtV2B+Q=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770281433; v=1;
        b=qHbkn/Xhh5GCW3lqtt3BFNbRWW2diSTeAbyG65f/JYW0cpqRPrvOWQfIqoP9ADEk
         xtXMlputaR8IBEMaPyQ0yZJS7/cnJHY0v/edvAP9nO+3zE2eEhmcHODVYMGjkG6o
         hOxhNtQeP+1MQ1JClMAJp6inMhph9FdxS0ta3QbbNTkCrV5+W7G+wtXlKziqqdih
         OMhQjz2d+pysDFsaqGqaCMDLCLV92fMGb/ORDuKBtbCPTYHWOZ+E1rsgreVjGWLz
         vZeYjkDgLCDRfP6YcbveoWH891MTrgHKjZwMdp3WJ6L70qdtww0XJLENEkgj1QTK
         XA8ezhbJ8QIZURItM1FPZA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] igc: fix null pointer dereference in igc_eeprom_test() on NVM-less devices
Date: Thu,  5 Feb 2026 08:50:26 +0000
Message-ID: <20260205085030.60080-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257052-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20F8CF0097
X-Rspamd-Action: no action

On devices without NVM, hw->nvm.ops.validate is set to NULL, therefore
functions that perform EEPROM-related operations such as
igc_ethtool_set_eeprom() and igc_probe() check for NVM presence in
advance. However igc_eeprom_test() unconditionally calls
hw->nvm.ops.validate(), potentially causing a null pointer dereference.

NVM-less devices may not be common but possible, so add NULL check
before calling hw->nvm.ops.validate().

Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244ee70..973d26a5a6c9 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -158,7 +158,7 @@ bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	if (hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
+	if (hw->nvm.ops.validate && hw->nvm.ops.validate(hw) != IGC_SUCCESS) {
 		*data = 1;
 		return false;
 	}
-- 
2.51.0


