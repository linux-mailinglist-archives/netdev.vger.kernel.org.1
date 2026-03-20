Return-Path: <netdev+bounces-269841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwfGOoGvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:35:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1732D746B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1309E3099167
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15435BDCF;
	Fri, 20 Mar 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ceRg2892"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0336492D;
	Fri, 20 Mar 2026 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995732; cv=none; b=SKXuJkTnycwiET+ktACh/MlsAINXSIGuqIK659CcxuWRRHZyl9n6iH4ie/2iBVDtACfK/TvKrQ2zbnkWqghWtZppZg6VgJZany4+d6At22brYViTIw1BsKigSfvGStibLRfveFOakRc2tCAmAJBZaeaF6yQWy15RFTGclcp4X5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995732; c=relaxed/simple;
	bh=XMv6Tt2lJmwz4M90Ro4a8aZCiBxqxgqLva3JWpVU/s4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kWKGQnwyo+ps2JJ9w3aYA4sM5IZdBHFvi8Qs76ZE5Uy4WN61e9J/aAXmK6ZZtapi5ItNHHwuYjgAUSQwZ/CuR0egLn8Ad08MlI8TNL+4DEPtTS3aMs3fkLon5jTZlv6/mnQkyqT0nHpgjpUcgpVJo5BBc41pSST3nXYr19LKol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ceRg2892; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62K8Yxu461191271, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773995699; bh=cE8OGoOY9Eg2trw+bwHylmKiCJkS5C/fSUXsUfErpL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ceRg2892p2rmJgNskUjFM4ATCD/Fq5YkwciYcVn0xtw6cLLcISyUPqM8/qbfi6dUI
	 GA0rtJ1ykBfkChAFJW8oRmxPDl/kJTY7Jq0UUsAg3BoSVUVjuAwkZCRB3hasZpKpvJ
	 mg82prn+YeeN+AfwouLoUsIYAcsQqirARf1bMJOUzmaaTenTgHQ9nfV8b+cn1LLR+0
	 G8lGos4z4RBv3JlBXeQ/qv2qvXeaBSepjHxzaSzvF3f1NDNFL0PthbLiQokFrUx0sz
	 OcAVkidSFZ/8n0AXULuF1R7kiOlAx0IyXP+12A83EmVVh2QH5dXqKlTBii96OHeGd+
	 JyjXJRNUE+/CQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62K8Yxu461191271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:34:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Mar 2026 16:34:57 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 20 Mar 2026 16:34:57 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v2 0/2] r8152: add helper functions for PLA/USB/PHY OCP registers
Date: Fri, 20 Mar 2026 16:34:36 +0800
Message-ID: <20260320083438.6295-447-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA1732D746B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2:
For patch #2, remove variable set but not used from r8153_init(),
r8153b_init() and r8153c_init()

v1:
Add bitwise operaion functions for PLA/USB/PHY OCP registers 
to simplify the code.

Chih Kai Hsu (2):
  r8152: add helper functions for PLA/USB OCP registers
  r8152: add helper functions for PHY OCP registers

 drivers/net/usb/r8152.c | 1810 ++++++++++++++-------------------------
 1 file changed, 639 insertions(+), 1171 deletions(-)

-- 
2.34.1


