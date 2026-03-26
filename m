Return-Path: <netdev+bounces-271902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFBTKQfkxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:45:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E18330974
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B084302DA2A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67B34B1BE;
	Thu, 26 Mar 2026 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="q6F6BbVW"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702037F741;
	Thu, 26 Mar 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510809; cv=none; b=b8stgX7+fgbr5rq1RwWlSmXYAXgbVBXQhmZMNlUdSX+hSN1ntFlipZZUghRGUVz/wlMFj6lb9Ua9znqkjvnCzw0y3C67AJkyR9p2x2Ncqij4c1DIsbNMEPas/IobxoBq+wUh4E01sQwyXZvne40nAPMNYTVqeVMwPbq7nBGIHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510809; c=relaxed/simple;
	bh=ZfiOjVc2IrdgZEJLUmHF/3SEEQexFzH689uOXXnYF+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQwW6KQJMvs5tamrbY/dPsy1mO+LCV0mmfV0L6vEOt0TJe62aXeMVocA5+pchXh/FU4lRZU0RPUhQe5s0fe2ZDfF/W4lQaAV1wWuYMTSO0i09WE/Yw+xO4k+LG0qqw0HVEXBcO9VhaEv+gIc1OsjC3dJciwbODJNyrWbqbnRHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=q6F6BbVW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62Q7dYryD1073981, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774510774; bh=MSr8q9EsJW3GZK9hSTxKNGXrF9wnuG7c2y83VJ4jj34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=q6F6BbVWijczoJN72R++lhh0dFd3POW0TshTWp6itvOb3rspjhFu6ZUBGp12AJzS/
	 cMNeUgn731reqQUwCw/Cpc7JQsZ6iLicMpLJ5EyZbzUpZieMYFKeFWqGyVSZbIbyqx
	 /V2cgY5McdjMtl3f7RcHrLTSS1G5yTaqV6iF1U5M6TXw2l6iSjFP1SqI0VVV88SBKV
	 H16hayVe8nKj3sM632jyLyfRAB26FuF8b7Tyt/heZOVUKQdo05vRV/42sb8ZK64NZJ
	 xD/VC6MiwQg+VnCgwbSrjEnsSxgmaMN0K5ciR531Iw5JhhkaGyj8el3wZZkIdT7UoC
	 fyWdPenoz5Rrg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62Q7dYryD1073981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 15:39:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 15:39:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 15:39:33 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 26 Mar 2026 15:39:33 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v4 0/3] r8152: add helper functions for PLA/USB/PHY OCP registers
Date: Thu, 26 Mar 2026 15:39:22 +0800
Message-ID: <20260326073925.32976-453-nic_swsd@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-271902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35E18330974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v4:
- Add a new patch for original #1. We need to fix a typo first before
  original #1 patch.

- For patch #2, replace redundant ocp_word_set_bits() with ocp_word_w0w1().

v3:
- For patch #1, fix the issue identified by the AI review.
  In v2, ocp_byte_set_bits() was used to update the USB_LPM_CTRL register.
  However, since its function only perform a bitwise OR operaion, it fails
  to clear the old bits when updating a multi-bit field like LPM_TIMER.
  Therefore, use ocp_write_byte() to maintain the original direct-write 
  semantics.

- For patch #2, fix the line length exceeding 80 columns

v2:
For patch #2, remove variable set but not used from r8153_init(),
r8153b_init() and r8153c_init()

v1:
Add bitwise operaion functions for PLA/USB/PHY OCP registers 
to simplify the code.

Chih Kai Hsu (3):
  r8152: fix incorrect register write to USB_UPHY_XTAL
  r8152: add helper functions for PLA/USB OCP registers
  r8152: add helper functions for PHY OCP registers

 drivers/net/usb/r8152.c | 1800 ++++++++++++++-------------------------
 1 file changed, 634 insertions(+), 1166 deletions(-)

-- 
2.34.1


