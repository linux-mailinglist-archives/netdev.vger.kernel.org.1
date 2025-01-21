Return-Path: <netdev+bounces-160026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D84A17DE6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03194161595
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE41F1927;
	Tue, 21 Jan 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SPMvQgw2"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9511F1937;
	Tue, 21 Jan 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463268; cv=none; b=imcRe25huav+iSyQPIRJfjPjBzg7P5e1GHEx2V7p92SjrGAIE29VnSSOFM1BBkpn/cxyvnceyFYzhHC3pv579SDXeQC0uUp6CgOOWrbQXvCba4zxhJZl2kX76ifbkCfzHX8AWcX2MvwCNnnmm0OSW2OnW8fjaRiEyYnfPDx+2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463268; c=relaxed/simple;
	bh=dvt2fwsPbF+EFTfAQNSFmZouo6NesdIYYIpj+Ad4EVA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=PTU6bWK3911PpsrKUHEh7vnQQPz8jRroRBfnQ+YV0MKRtc89oYyUcZk5Qz0VyeZ2rdLKhoVFJ7ZoSIRt4rNE/leMWEArYourt1YCe0CH3F71T4EoFG0K/96JuWIFT8sWhcZGNK5/6Hluj6FtWHDPYN249gkxn2vjayWBjI6fIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SPMvQgw2; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737463252; bh=N7rA/iHdMTB1fKmLDUs/vF9+xgtl9sw35Exmqoz+OII=;
	h=From:To:Cc:Subject:Date;
	b=SPMvQgw2tOliJSfQ6NcdSYupxnx07l6Or9Rr96cin+nc8/LApt9xCbIpDuizkO2Eg
	 4f+zHZifKCF09RKGQtSWN5otm/bWjFLdhzIxMY5nTDKEuNmji9okuqimazgPwd5nhO
	 DfdHIk24K9YtJ+6NSVE5wByc+3ZrIRsPLw28d7+E=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A270187A; Tue, 21 Jan 2025 20:40:39 +0800
X-QQ-mid: xmsmtpt1737463239tiw56r1y3
Message-ID: <tencent_20DAAA1E396BD1BFBEE79076A81FA1402907@qq.com>
X-QQ-XMAILINFO: NmYPxqSo4aXv/zCG5efrKtDyunzY2ebWJG6lw3FqBsk0c5DnMlniPnzuzhBujE
	 +SlG+iC3uJ5CCBK88PYiNw0AqdLFk1/iyV47kaas6ILZBXb2gbw0pr1bTJcRZwNzkAkA7mSsmF/c
	 vmntDtW+C4QSaGetNP+T+9xv0pPoEtlOGSpKa6RZaLCNKSF+ahiICnkqk0tGc6Vok7FiBm9sIgBU
	 +qfmWVwanTy9tdCSKisNjGEeUJdfusaAjNzs0R+27uBESfLaRHLRDkKYkPK1Iwf0Aefxoam0QnLc
	 OiFhRXdedKZ8rUC77aeWHITU16Zmd0oOX0vQwl+khpebFn37m2XDhtst7GkLwkjcpi+MEKcPIc+b
	 b8I+YGOe445f48ZxNbSO95KnkKOwkLiPurOT8Qd8rsXnJ9c9wsetnyOi0MRkpU1RYyQH6FKCiLkI
	 VUH62Jy/jja6C40gfK7tf6ACzGNVsc5OvL/k7A0WXOPv4Qb272N58FJ2+PfA3lVmJ65Mt5T+m+b+
	 btIHiIlcL+becnF02JdeiG+gL68mE2LItabrzGu7gURqd8lVAzgM7H9y5ka18oWXn+rB/m0OCvyW
	 ABuAz6k6ANt+b3yxmFSOxl6OtXv258fiSUezl3DlvNVhNzAjvX16FJIy7V1/wcZ/KLgDTeZYqtSN
	 3iZhEyh0Yp9qCNxqzSGgZ8Wi1r5lv2925hReQKhUixewOCdXDBPN7xKh5VT1MWHTjr11ywFojt5S
	 Juk81GsC4OIXHVcoflTs82nqyCJFRHHyAotZr2Vp1B0eUnYAjM4aUM8ZvmU2wYqEgCkUrwEXDj3C
	 JJlaCOkUNizllLvLXfAZFhFZKRC3B8FWfrDUU3uXOanObtUWGqCpBTpRN8YwZXF/V0fG8Dn6iv2P
	 bDGiKIgHOpKTDjGummVEMLtQSHrXI7HQIvh0UU80YTaEZI5OYED8iEYad+71dSJeRuSAEQ4T84fC
	 CxfD6QCQcTUmhAOIItTAArPVSWR8oRAzU7wbj/wa4JyIFVY27Dlnevl4Mzh669
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: the appletalk subsystem no longer uses ndo_do_ioctl
Date: Tue, 21 Jan 2025 12:40:32 +0000
X-OQ-MSGID: <20250121124032.352083-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

ndo_do_ioctl is no longer used by the appletalk subsystem after commit
45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8da4c61f97b9..2a59034a5fa2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1085,8 +1085,8 @@ struct netdev_net_notifier {
  *
  * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Old-style ioctl entry point. This is used internally by the
- *	appletalk and ieee802154 subsystems but is no longer called by
- *	the device ioctl handler.
+ *	ieee802154 subsystem but is no longer called by the device
+ *	ioctl handler.
  *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
-- 
2.43.0


