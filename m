Return-Path: <netdev+bounces-207140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41BB05F2D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522F8502CCA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCB2E3AFF;
	Tue, 15 Jul 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wjts9OSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716A2E3AE2
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587195; cv=none; b=pQKKQADZTTUyhgMeIEYNZz8QcHukUQWtQjCVWiOPBsuq/+ajg8q8Hx2f1KKqk5T8QbIaYZCh0aa69q/3x1BBc2ACzJnvioE7XsLdCDc0/juGDjLTod/RUHE+8/wp+jLLrQLYh+DdfDnWly4tS6Gl/qZpjcyGQBEl305HJCQ3IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587195; c=relaxed/simple;
	bh=RKQYS8TcAZiYvGQDH+XpT4TCxWolbEbJ6rXdMaVirpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcP2It2cLh2C0i03JiBy1/yxyXPozOpz/XrOqAmhzaq3wNVhOg98JYaOHbDpD33VJColeoeI0ggpbrAT2bK5uMV5fJULCfwLSaD2P/3QpHMOHgi6UKM90N+iwXPCI47gr9O+w4BNfQKvZdo0BNIycty0YliqFuLheczjmqH/1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wjts9OSm; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587112;
	bh=rQmC2fT7t1QerTXaC4lb+PTlBodpE334vwPD+1BbEVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wjts9OSmF7J9zue7nrnsfbwPy4jBQa19CYFuWNOu+GAYLzB8oiQzzn/IQM1Th1ifL
	 MaTehwZqOKTa42CN3YCHmDt4/y2iccWutlqeNvrp/ieG/4Yb/A/55TQWqpiDmgzUfH
	 DD8EnZn98Es6TBnbwoF46gEDIljEHMmZArX4c3lo=
X-QQ-mid: zesmtpip2t1752587098tca5493a2
X-QQ-Originating-IP: bz3FlVgOsDFMU4yP789akKxa0PSTuDy5vUHH1rKzucE=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:44:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17118280138594798834
EX-QQ-RecipientCnt: 63
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: airlied@gmail.com,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	andrew+netdev@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	arend.vanspriel@broadcom.com,
	bp@alien8.de,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	davem@davemloft.net,
	dri-devel@lists.freedesktop.org,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	ira.weiny@intel.com,
	j@jannau.net,
	jeff.johnson@oss.qualcomm.com,
	jgross@suse.com,
	jirislaby@kernel.org,
	johannes.berg@intel.com,
	jonathan.cameron@huawei.com,
	kuba@kernel.org,
	kvalo@kernel.org,
	kvm@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux@treblig.org,
	lucas.demarchi@intel.com,
	marcin.s.wojtas@gmail.com,
	ming.li@zohomail.com,
	mingo@kernel.org,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	niecheng1@uniontech.com,
	oleksandr_tyshchenko@epam.com,
	pabeni@redhat.com,
	pbonzini@redhat.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	rodrigo.vivi@intel.com,
	seanjc@google.com,
	shenlichuan@vivo.com,
	simona@ffwll.ch,
	sstabellini@kernel.org,
	tglx@linutronix.de,
	thomas.hellstrom@linux.intel.com,
	vishal.l.verma@intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2 4/8] net: mvneta: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:44:03 +0800
Message-ID: <41013AF60AF9B5BE+20250715134407.540483-4-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NAIVcA2/v6CHPs2kJIIniRobkxAzBP5o/UpLSNDAISe4wTVIJipMkkIF
	fBhm5J3Zwu6+m0jcMosserc2p6QyJCoLza145USzButLQwMzQ3klRqT1fZtwA9moIuhiKKi
	D/ZJSPy3RJ08Egcf9K8XYMiWifKjakuDYfd+rM9NbdZXB+S5CwqpzO0SY3zZ/PSxbQEVMwT
	qeOs7dNV3bo4xp96C35R/+JzS8w3vFyEyhweiBRpLS7RFnV1F/TpCPgM6IaJdIe2d+N0R8/
	xRgpU1XwLR4tEk0wtcTQ4daVSVYVUMDGg2cvkhheWgp4+mnwuXL39y0FPOVLyqs8fA43KPr
	HOPPg71s/kd3JK1TbIhH1tcHyqGdG23oD4SIAMk6w9PK40s8bZ05KupfhuTVm1yiQ/qb45j
	/ii0PXwjDQ6JP8XAtzxOnGq+k70Mtc77V/k0bc7eWtG8vtS2ANiBAO6v26oehtkb0X2hiUk
	M6Q9CXQ0ktJpntdiufHLLIwzPzRWqywWOpa5mMZ0xXO3L5IN3unRa7/L1dvEorOR3UMS5DY
	UAOUBBWuEuy2eXAowtVKQM/6hC33m1GpIRb2tu1okCwBVZIWFOf+bnG9q8LOlY6mg68ss+C
	Y8/vHO6BidTbMT9klhwNJtPXETC4L7p+18xPTvoZaMd0CC6A9GDSjDuqKp0X66rqW3sxGjn
	FO0LqPQAh4g94r3Mqbqms2MRXH5a6uWcY2Pd9WZyTgDbd39MW9Utji/YW7KfPQX14JKmokd
	Pf/wZhGtNDjOyJSpC0dytUkxq9ffFmjhHZGDWpvPgb+UtOFQI8OsitqmiBf0VNyDEvwE6Ji
	n1hSgOa2OdLhDclBKQv7TX8TQu5p3PV5yaNXBVHC5PJi/83E5sAawuSIN+mz1C2ZESswGUb
	G4kHtfxX29LAyVT5b5F2Fph5ZiCHsQTYNcnqNzOe002nKSU6ufnQxElBFI/VNTNPR5fw3D7
	Pr+kg2gpVdDpwsfeUwn40fL6+2Sn9Gyh35KUkTvIgkEzblbV/tgX7tHQdzgppEZHXDI+wL3
	J7henYEB0WJbmDJP8WdJP7TGjnzyWesycZgFC6hbhFIkF4jEVgBXoLFNojbr6DODtXW4XDU
	83FGiunFNxVqWdj5aIS7gExiHD3xdT2S19FG5zeR2TFbAb+3CU9GfM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 147571fdada3..ee4696600146 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4610,7 +4610,7 @@ static int mvneta_stop(struct net_device *dev)
 		/* Inform that we are stopping so we don't want to setup the
 		 * driver for new CPUs in the notifiers. The code of the
 		 * notifier for CPU online is protected by the same spinlock,
-		 * so when we get the lock, the notifer work is done.
+		 * so when we get the lock, the notifier work is done.
 		 */
 		spin_lock(&pp->lock);
 		pp->is_stopped = true;
-- 
2.50.0


