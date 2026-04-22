Return-Path: <netdev+bounces-280309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EnZfAE1T6GkcJQIAu9opvQ
	(envelope-from <netdev+bounces-280309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71001442011
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65FE301017F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B4277007;
	Wed, 22 Apr 2026 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="hETPoWGj"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01761D6BB;
	Wed, 22 Apr 2026 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833350; cv=none; b=DIoO4TUvneIdc6VmrZJyYEx3FB9p9QbUwXOvgOR3GVkKJM6gJUkDn7LY9sVH9+ZR4q2b0lBnaALe9taz8E6dSDYvLdnCFadWFKvtFfZ2DQ6Uy+I6yQgZ9lXxFjhQoruOJF74m+4PsZfADw/EiRprDibB5Ow7tQpliybLT5DU2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833350; c=relaxed/simple;
	bh=a05SxGNTYrdYbRAPCBhMNX3uWD8pSTlf+Y2QLExUFP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bk5d6d4kCZ7pyxO883JvVHDC31zJBruKkM1IFDmxkwho9+UiP6wADqymJt9ZmlKWbRDfHEdvoVV/xlyiSeMsv42t/EvE9OIzsmp6OcPvpXYlapsY9kXMzJAj190+K6rIRDTyjZe2dDYjo/gCjNs4Z2Nz8mHIq1mQkYeWDX/ZOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=hETPoWGj reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=J7oC2ohQNX
	9P5FiCR2zzW9e8rpNvuSlbD0sIYrTDYgY=; b=hETPoWGjbH1C5unBxTsZzO+7G6
	oWV1ykr8WetrzmQQVnGwBzuCIs79Ro2MCkldwz/FBfnO6C24LV2YXFBhHoNXiRt8
	xXNdyMDn7Kalv9bA9EBbVozlkTJ0GyHQRy61AZd2McNlQ4QAqsuDJ5NiFl/T9cD2
	a6U2Vr435SuPEiqHk=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkBmTr4XU+hpcNqxAQ--.54565S2;
	Wed, 22 Apr 2026 12:48:43 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tglx@kernel.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 0/2] net: packetengines: remove obsolete PCI drivers
Date: Wed, 22 Apr 2026 12:48:18 +0800
Message-Id: <20260422044820.485660-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkBmTr4XU+hpcNqxAQ--.54565S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFWkJrykKw1DZrW8JFb_yoWkXFbE9F
	9FvF1ftw4jqFyFyw4UGw47Z34FkF1DXw1SvFW5KrZ0vwsrZ34UJws7ur4xXF17uryjyF1q
	v34IyFWxA340vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWnnlGRcDQAAsy
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280309-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	NEURAL_SPAM(0.00)[0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stu.xidian.edu.cn:mid]
X-Rspamd-Queue-Id: 71001442011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed with Andrew Lunn, this patch series removes the obsolete 
hamachi and yellowfin PCI drivers. Both drivers support hardware that 
is over two decades old and no longer in active use. 

Removing them eliminates dead code and reduces the overall maintenance 
burden on the netdev subsystem.

Mingyu Wang (2):
  net: packetengines: remove obsolete hamachi driver
  net: packetengines: remove obsolete yellowfin driver and vendor dir

 drivers/net/ethernet/Kconfig                  |    1 -
 drivers/net/ethernet/Makefile                 |    1 -
 drivers/net/ethernet/packetengines/Kconfig    |   44 -
 drivers/net/ethernet/packetengines/Makefile   |    7 -
 drivers/net/ethernet/packetengines/hamachi.c  | 1967 -----------------
 .../net/ethernet/packetengines/yellowfin.c    | 1438 ------------
 6 files changed, 3458 deletions(-)
 delete mode 100644 drivers/net/ethernet/packetengines/Kconfig
 delete mode 100644 drivers/net/ethernet/packetengines/Makefile
 delete mode 100644 drivers/net/ethernet/packetengines/hamachi.c
 delete mode 100644 drivers/net/ethernet/packetengines/yellowfin.c

-- 
2.34.1


