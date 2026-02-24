Return-Path: <netdev+bounces-260308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL57IhQJnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:12:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C053180EFD
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13464303EC3C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF942257459;
	Tue, 24 Feb 2026 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="j7cEmt7D"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FA2566F7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899146; cv=none; b=jjCRvlHuEyu5gk6Pc36uNdJK1OD/Ru1s56k7FQiWd84qT7W+WYsfCrfhXo2zzRxtTZINzE0gf4u+rxA5aSGTslCvEaZ9a1uw/nRF7XxNR1vJzh3hyY56akasa9le3vDMQd5ciDWNbJbKDtXUfW9SfherMkOYLryUixmZzEmHDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899146; c=relaxed/simple;
	bh=jJj+kZdKOioMMsotcdIqtD9nb5qMlyuxTh6ZsA1H8Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b6mpxKU1aD0vZccCYtZqBaMvK5hjeOcs21L5cYYY5NqJCzeKjaJWdbvVa4o2PmeABkBqqxm6t4UUE74YSdUJjrzWyp8BsRIbo42AS5Dkk7uekr19sEO/EXVV+dhShIZYNBH5MbdooZc0zlNNgfo0Yr73QxZ/jSAmVLV3D24fQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=j7cEmt7D; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771899132;
	bh=5PbTEBULsmHXd7ZdpVwy62fGH3NKvHQD6unAhfnTd6g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=j7cEmt7DVV5DYDLDLnSKIcj6tUNlilEf+JwPF58ho6oPH8gMMqc3LLaHswaM3OocH
	 G2HgOC/Gme4NCqOcPcJkFmhMMUZvE7jB1VFpb4n65OeUDrE4w7aFUQsn3znfsbkd5G
	 kTejtlZkG5fUZCTzULCZg7VWn+lMK4vsYQ1oGq38=
X-QQ-mid: zesmtpgz6t1771899130t7e41b763
X-QQ-Originating-IP: k4TqKpmoPp0ztLHq6Z5lq/TRzvM1gvyT58ET3/Q/5xs=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 10:12:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5836410843024043249
EX-QQ-RecipientCnt: 12
From: kexinsun <kexinsun@smail.nju.edu.cn>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	kexinsun@smail.nju.edu.cn
Subject: [PATCH] net/hsr: update outdated comment
Date: Tue, 24 Feb 2026 10:12:05 +0800
Message-Id: <20260224021205.1285-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MiCmIIZEBTbfNRt8ZY/V5jeq8Umm5FMGXVcU3bJCcD91e1izjdpFy7pi
	k/sLZ/cxr9YtVWOZpc23nNsyOboBPlGrXcmH4FOfs4cKG4C3CT5f40I+2ZzKDTcc04YPKhm
	rwJblhGan7UG/4S49IpCvNSpokhCXsFWyiK7JeyOlUQl/gvG5PJL4arCivaG+nyGXEme1DZ
	4XciUwcp1aVqzVsVgrWMxZeqcWA6hwwLlqB9k2GLLQuHX5+PqkcKGkfNDl8AfAI0CXQAno7
	owH16ZILfyAHRNdOeIzwHC3753vLAMLhMgTFbhE4irQzY0fnYpB2JK9LowTry7KQ+8FVOdr
	uY8zzj4xV4h09kw9tz5kVNFuiemgpCIvK9KUnlUrxckmPXTnAEzTtwYDD1xZtnUYvrv5nvV
	R1SeNSRPmlwdBXUWfP+S4tj7ii+fF4wsr1LHA+Fmc6utGU8u7eo9aap18dzxzCRtTJP9fPz
	KFuZlHyR/R9bBlCWUH359nxWESeScRDXveezkh3My8fTnjCi2LmEFph3RYDyECkXL2TdW8/
	QmWTpTJFmcYPsVG1C67xkplB1D3uR2Kr0c8IMtR+5EpTNhcpZ8mKMV0h8R//hT0MOAecs4O
	J+BSMttUTwOvaK4j6gzyYrVOcNME/B7s6s/ReB3ct84sVnPRjOdbuEkxbFL3mziDxnV4nQ4
	QmYLOoTHuLX65U4MMkekRz8ZE9Elcd31I5zpAqYvwl/LTYlLkK1lEbqaPbPswjkBMRZtpXo
	Kx4nvP/+0VT/6EgB/h8/Cv4feoxDu3GbJ8oPKgppaMUj03lbrk3AWjrbtJmIhv7h0Bku/4y
	kF7aUlycesn8Wyh1Gie6BzTGnfFqUmcjCxJLqzmxpmSJExAKFF1jESsahjwwUAPJvkcUQmK
	ZUCfhQGSqu2QjO4hBKXV/93YZlGxMd/WJcUbka2nv5VWH01m4jrjR5e/RZEW5yfd/aC8Tr+
	4rzYVjpeooq5YlpiJkzO+6TZ/7WWuDgZO7xoGXT7so0dqzvfusdhjvuRC8DxJi5sN1eLBaj
	p0UzppQE14mDtZU+E6TbECgNI5D+Sptch4tEkejT/mifqzVizpJML+SxlXGcVLdlPAl+D0l
	dfQ+6uWfU6xUuOzYSgizeU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260308-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nju.edu.cn:email]
X-Rspamd-Queue-Id: 0C053180EFD
X-Rspamd-Action: no action

The function hsr_rcv() was renamed hsr_handle_frame() and moved to
net/hsr/hsr_slave.c by commit 81ba6afd6e64 ("net/hsr: Switch from
dev_add_pack() to netdev_rx_handler_register()"). Update the comment
accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
---
 net/hsr/hsr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d1bfc49b5f01..5c3eca2235ce 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -742,7 +742,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		hsr->proto_ops = &hsr_ops;
 	}
 
-	/* Make sure we recognize frames from ourselves in hsr_rcv() */
+	/* Make sure we recognize frames from ourselves in hsr_handle_frame() */
 	res = hsr_create_self_node(hsr, hsr_dev->dev_addr,
 				   slave[1]->dev_addr);
 	if (res < 0)
-- 
2.25.1


