Return-Path: <netdev+bounces-272769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL34FX3bx2mAdgUAu9opvQ
	(envelope-from <netdev+bounces-272769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 14:45:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E2C34E900
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E80D03024A33
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13130FC23;
	Sat, 28 Mar 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PujCjxuF"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA711A9B46;
	Sat, 28 Mar 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705526; cv=none; b=XlMoQeoRraQCxyp7IJNYEY8IDpVMrEAvxwGuEW2NwG8JldrDRdQLV3Cm1WZI4Jqsjhphx1QvzIQCW+Jdiy3cnrLXMiR1GD+L9ZQKDI3h3GL14ffSeTHY/aW133tsmVep1ECO8ptiqhCTQhbavzEByMlZu8untZ2ARmPavh+Mj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705526; c=relaxed/simple;
	bh=p2TdSlFkFD4OPSxJzmGlNscEub3vS4ev2PtfoPBNO74=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=GTquwrhLlDySYxRKdHoHEe4lVjHMLyYVZaqCpT5/M51Sf/F6PeGvZkexVxYxrrsVKxiITPTDsQfBsQUdKMOqef3UFtR1GGFTFwNmLRasFwNpAWqQ51er+FyedqZ2d9xFD+gAPb/XWeiUfZvmOUWygonTaPgWBgntZvbvhB3/giQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PujCjxuF; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774705513; bh=rFLCYdDTvsSc8eyn9nD3Tqfl6DUP1pTYa4FCzNUr3pk=;
	h=From:To:Cc:Subject:Date;
	b=PujCjxuF+R1Iovj/A2+OzHt+kpUiTp6Q21hcsKShuhAMXrB3J3v+Lgiac+Zmdh4ID
	 ASrYJ5HJFYDRM3U6VEQnREyB7vdSl5o10SYfgn16b+ZKguGuDUndQbA7hg/XU30Cy/
	 kg6+kx0lUr24YXmoOUVbUeI7DKZGms3IJZ6awrTQ=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id AEC8E62D; Sat, 28 Mar 2026 21:43:44 +0800
X-QQ-mid: xmsmtpt1774705424t775usdsw
Message-ID: <tencent_833D2AD6577F21CF38ED1C3FE8814EB4B308@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahgv7/OMCpr9OjGJVJ35WpFVBu5hY3UbIKjaD8n0VNPx0ORi4DKu
	 xxvo2ulNpGH1tHptD/O0r4fn/N3oU+DBXq5Wvrksv8aJhedYI73PyPknhlyBoV4dkxU2r83r7NgI
	 NzwrZaQUBAv0z+0eZHNJpA1h98SMzsHksMuIhCNX+247Vu03Y6WYaaWg4KT4LQMkYan6BDNpOWPQ
	 3Q1EFiAJ8/xgssRkADtBVYhWiFJgMWDI5UcX08lZdUV7J0fltBxXlgX1O1FfSE3yu4vutBdiz8in
	 0/2assn8KjpWDrDI8szZiOrrhqXTV6Onvo4Ed/hJKWbAJjkiunnyj+XianaHH5GpuJjtKwRG21qa
	 fvKrrpFp/tuz993awFMvuSycJMs08dv5P0bqhAuC9oqCMSSECytdbpIAguHoY33CM7/p96qL+fdA
	 QSySXUGJETn+osENjS6n6i4rFd49XETgr/fDDmXES9/ZeS5wEHThWysFZVr1R0vXu1nLo4eS5zqV
	 uhSdn+8+EU17y4F9m1TsRe6I16vlRL3ZEbBmdaFT51n/myvF/rZU1tiP4FdGNCqyIAFSrMZYxhcb
	 5toweIp9YUzq5vL1aTc9KDVR/kAg+2as78wu9tq78FcBdbvTD3jvLT/wYPooz7bgjNPmEYzXbxPG
	 KsD5BfY5fcUZvgoiW7TS2zuFHkdCiVAFkLjevFe8hcj5UzBEOx6K9vAZ6Pf9JHOpKWaAqZUc+vUZ
	 aB7bWPbtnxcBGwWG0pNIv4p169Iy3LzBtwEsdPVk7Q6UUU/V4hM3ma7nzkB5+G5ziifQFteY8gCf
	 DNfmWwccx5xbt9L7epqJN2vRpADeHUGoAByEKcZoMIq5FotygvnsmQ0HWDrtHcOca+oX6D8x1zzE
	 jc1JhA9nzlIeGj+ErnSbK8NRYtOAWPZ3e6eJFlD02uyAbZPjb3Z2HLTIkrG54v4bvN5C+MOx9kWK
	 DMAVGvbGKMW37w+w3ZcKjYZ7mwrFOLrjm5R3uC3dWn2d0EawK+UXZJXC36iw9Z7yboR7YuPC5xP8
	 T0yvBw0DByvqqwUxMLpi2J03/iQR3kiDjE5fjiPxaLXLcAj2/q
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-rockchip@lists.infradead.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: dwmac-rk: Fix typo in comment
Date: Sat, 28 Mar 2026 13:43:31 +0000
X-OQ-MSGID: <20260328134331.26627-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[red54.com : SPF not aligned (strict), DKIM not aligned (strict),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272769-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yeking@Red54.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[Red54.com,sntech.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid,red54.com:email]
X-Rspamd-Queue-Id: 00E2C34E900
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Correct the typo "rk3520" to "rk3528" in comment.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index b0441a368cb1..8d7042e68926 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -214,7 +214,7 @@ static int rk_configure_io_clksel(struct rk_priv_data *bsp_priv)
 	cru = !io;
 
 	/* The io_clksel configuration can be either:
-	 *  0=CRU, 1=IO (rk3506, rk3520, rk3576) or
+	 *  0=CRU, 1=IO (rk3506, rk3528, rk3576) or
 	 *  0=IO, 1=CRU (rk3588)
 	 * where CRU means the transmit clock comes from the CRU and IO
 	 * means the transmit clock comes from IO.
-- 
2.43.0


