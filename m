Return-Path: <netdev+bounces-282005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHvzAdzo8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-282005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A32489920
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1239D30C1C34
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F533D50F;
	Tue, 28 Apr 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="M7Yns1t7"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40E33CE86
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395527; cv=none; b=eWx8xFxsBt75gFIKZhfOzckdNbTOA22Gk0/Psh9ntqJzNN9hW/+sLTPAddLyMYPvFj7b2yPjufGueMEyDx4o0uwscVqA0YX6ZaxU/idocy5HF4asNNjlLWuQGGLiDhhLhWKXVgkxAsWHLdQ0DYIdHuxoBQz3JySKnMg/oR20AVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395527; c=relaxed/simple;
	bh=TNE3wFxySN+NnT7u8aGCpT/TMQW6VUAIal+tyAB0im0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEbWLvWbeZzk41IRhK66doS+5jfZ5mubZSH4GR9yhMPROF2JJemZVCCgsRj40Tkq9hVMjbI0XdoiGdBjXNh3s3phALBl5O+s6FpBbNmINjmU+pGWT6jp7fzSetfpeJmIwQdQbUxA6xX8dx45dC+qGzEFGNfRkL0LNEM5YlajPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=M7Yns1t7; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395526; x=1808931526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBezZd7agyWR38Sjrg0pK67g+bbxDS/5NCgYDQZAEAo=;
  b=M7Yns1t7WqiJW0ugiGQBD4SkM7rQQrz58NZved2VV7BnurIG0HWXowvz
   2OLiL9vd3hy6ZsYhnZ+UPd5R8dKi86ZG+MmsK0DkWMeWNydh1YN0WLil7
   jnhlDDQChN7JmceXncdC8ZhEiIjoUagJEt7zdpmLtHdWQXHSbCz9ytLY5
   t26R2ZQUu9OQ9e0TbRhV/KsUTSVz8MwmvZtOE96GNV/E9B2gjgcQigaxI
   lLbkJIJoH+h/ffvkCatBmG7LUf2cWNf+y2NORqBCM+iKhIlVX1hus7w+I
   APs25hehwhQaAkU3/s2UvsGZZVAKuRwP4LJpnA5a4tyOg3nIF4KtrEa5S
   Q==;
X-CSE-ConnectionGUID: zBTsRyBwQEi75ihrRaY3oA==
X-CSE-MsgGUID: SHgS0xejTWOPxxDE0RGOfA==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="18382072"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:13871]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.153:2525] with esmtp (Farcaster)
 id 87736d2e-eb13-4527-8e5a-20417de70872; Tue, 28 Apr 2026 16:58:45 +0000 (UTC)
X-Farcaster-Flow-ID: 87736d2e-eb13-4527-8e5a-20417de70872
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:43 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:39 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
Subject: [PATCH net-next 5/8] net: ena: PHC: Check return code before setting timestamp output
Date: Tue, 28 Apr 2026 16:54:23 +0000
Message-ID: <20260428165659.2811-6-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428165659.2811-1-akiyano@amazon.com>
References: <20260428165659.2811-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 56A32489920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282005-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

ena_phc_gettimex64() is setting the output parameter regardless
of whether ena_com_phc_get_timestamp() succeeded or failed.

When ena_com_phc_get_timestamp() returns an error, the timestamp
parameter may contain uninitialized stack memory (e.g., when PHC is
disabled or in blocked state) or invalid hardware values. Passing
these to userspace via the PTP ioctl is both a security issue
(information leak) and a correctness bug.

Fix by checking the return code after releasing the lock and only
setting the output timestamp on success.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_phc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
index 7867e89..c2a3ff1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_phc.c
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -46,9 +46,12 @@ static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
 
 	spin_unlock_irqrestore(&phc_info->lock, flags);
 
+	if (rc)
+		return rc;
+
 	*ts = ns_to_timespec64(timestamp_nsec);
 
-	return rc;
+	return 0;
 }
 
 static int ena_phc_settime64(struct ptp_clock_info *clock_info,
-- 
2.47.3


