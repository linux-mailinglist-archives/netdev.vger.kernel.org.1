Return-Path: <netdev+bounces-179032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF748A7A1FF
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3095A1893DE0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CC24A06C;
	Thu,  3 Apr 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="b+s4P4or"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB794198E63;
	Thu,  3 Apr 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680162; cv=none; b=IMbkerSVJVF98EBmTC8hvnuNc8MKJDX6luSNeCx27acPH/d5bMFE41zEjQxtjkIY6/y4VmA+d4O5W1CS9Cn/VMH7/jpYIejBt6CkMqVF3e0vMK33+84Q0+ne6t0fvZqki/YQWDKTHlPN7suZl1BNhkY5x89xOxNuin60tNuB3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680162; c=relaxed/simple;
	bh=WzHizEsxvxH3/Rf5G2wHhpJqiFqo7Fg0RS9NL+8Zsyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TD96t1NhOyCPjrHW8nMd8o3oPPlBcWx47VUHCpXBUSGfXbjXg9eVpZRR/mf3L0GHrrnvyefr5cmDJZptcBFGiL+LHg8lfSQ/Vh1Dht/tdSBGpuprlNmy2Dw4ty2PjM+WTxJt6TVzbf2eAc8N7L0LuQu60pyG67iquXY5cMYS44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=b+s4P4or; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 505FFC000A;
	Thu,  3 Apr 2025 14:35:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 505FFC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743680154; bh=L1sfnMs2RscMFSMKlzZmf8cCU/E4/6QoKqzpz7cx/2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=b+s4P4orXCBWgaXyQElmvyUjOqUqdAmd+IJQ1qFr6rKAMZA/0XVcmENSNq3XfTgvP
	 JobSG/iL7SpKj/Tc4LXhi9FAtCV0EZ/m5GTqQAJdp3CgI7tYQKk+7BrvAOv8rPB5E8
	 YSPtB3ibQ2qTlEnIhAgMzROLTDiqvM3gQjVmStC36lbA5z20I7tFBDLUOQVwn3fdnM
	 Jb83ORLzQVltdSjcnyrCltOx1z0AQaoDc8TaEfvq1FQnCphw+u/SfqEjIHmLtpwtuh
	 bMa8PUgyPvTlSvvn/enqQoKLu8GLHUfyE4H3eJADGzEy4UPjDMUNnb8QWsrK/DGA7s
	 YoLy318Ro51ew==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 14:35:54 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 14:35:53 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>,
	<syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Stanislav Fomichev <sdf@fomichev.me>, Ahmed Zaki
	<ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v2] net: Avoid calling WARN_ON() on -ENOMEM in netif_change_net_namespace()
Date: Thu, 3 Apr 2025 14:35:14 +0300
Message-ID: <20250403113519.992462-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/04/03 10:37:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192331 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 07:23:00 #27851719
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/04/03 10:37:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
device_rename(), since it only leads to useless splats caused by deliberate
fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8b41d1887db7 ("[NET]: Fix running without sysfs")
Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000a45a92061ce6cc7d@google.com/
Link: https://lore.kernel.org/netdev/20250328011302.743860-1-i.abramov@mt-integration.ru/
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v2: Add Reported-by and Closes tags and make sure to commit against
latest netdev/net as per Kuniyuki Iwashima's observation. Also add Link 
tag.

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..001c362a4c1d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12196,7 +12196,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_set_uevent_suppress(&dev->dev, 1);
 	err = device_rename(&dev->dev, dev->name);
 	dev_set_uevent_suppress(&dev->dev, 0);
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	/* Send a netdev-add uevent to the new namespace */
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
-- 
2.39.5


