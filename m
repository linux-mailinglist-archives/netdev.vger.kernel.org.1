Return-Path: <netdev+bounces-208812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E854B0D3A6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF85E1886584
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AC2E5414;
	Tue, 22 Jul 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PhtDPLo9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFD2D3723
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169855; cv=none; b=E0cwlYzSBGNIs7xWDKyXtNAqnMsCTaufFsPGNoJqrdJ2puGaC/2JzDfsLI90lrk9NBVRiOeBFVchxLH6kbvY8cn0hn+r7fWXsZLt3zBP/UKJ8QbEm8aC2ptCm0Dgi23fg3oBdimY8JRfqsdsgIFSSXMK0bCuOK5q3Y793hkeHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169855; c=relaxed/simple;
	bh=kbyo0H2bbsDviUujpmI40aEKink0Gsb1aIkKzjjCyK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pf8WKTvH1Sy7ggn92rTZYIMf/yIJoxXCJAWtrZDNYZaF+BjY3nYG2/NKFwZXwqMQkGTUsLY/AzKsUCBXsoCgAyeo1Q18MjVfmfnD1dzY9NwhwtEdygg4p3MM/WUJKQNiCaeFTZ2tCq7zXeryfaMLbsmrDD05gLkpPEpYXJmo8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PhtDPLo9; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169780;
	bh=m+UXxlrjT5dODP8ALqZgjPieqq+D0qMqbX8YRGfdS4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PhtDPLo9y6c3GyaY1DjEYaUY76U9ml1O7VRtDndXyrbmN86To21pHgveN2eryVQJg
	 2c5sOxBKVLeW2Wpy+Lz7eMoTpl4dD2lKHQvsmUo0HFfMTdLBa06pvmm2psvj23btGW
	 /Ee+AzhWHJVNqNGDDQ/cB+TWNcM52e0rOCN7vnDE=
X-QQ-mid: zesmtpip2t1753169721t82d79e29
X-QQ-Originating-IP: VhBpf0Yvw5Lj6PbKLNVVhr1ZGW55NX9MRAkCLXPkiaM=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:35:17 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15702502862464076907
EX-QQ-RecipientCnt: 64
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
	wangyuli@deepin.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v3 6/8] serial: 8250_dw: Fix typo "notifer"
Date: Tue, 22 Jul 2025 15:34:29 +0800
Message-ID: <BD4804BF4FBA1648+20250722073431.21983-6-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
References: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NUD6C8ibrP4BlpyOlLDI06chYZekOUCZTlSlcpL8dzVHHwru8SSCc+Yf
	uclUpL6SNW+PshL7oaMfB38E3p9RutDk/H/p+fLXg6OLwHGseLsqad9viM6TvN1ioul8Lqn
	EHKSRtFC9/zEmyD4nq7HbiUNr6o20OLXsfPgDde8sPosaCWamUMOsfRsuOQFwiL9iWrgTz9
	WQnx4W6FMtEhEJa0f7ZHQv9AzWNWWPYBxFf/GxFv0SVCWYfe/LDhs+L1RdjrgNDTwhX4uPW
	TytUw1RsNAngUBWGQio8cl54YfP1KAb3HfrXoSqc/DOCH9l7xs4tvQ2X51QI8JkypQJ3HE5
	0zvedK5LvOFBDNm5Bvt8lIRjnCoTcbDa3BCB4paP4LuWpl500TOTEo9zuhprepk8ZVe92Kx
	bvthcCZ2E/IY8EbbXHev2hzsmG3nV78hEIILHUxmTA2fR5ZIovhaoQV/1sLCTYaF0T9tV1F
	CNmgWgb0JlTHyGeSHE1yWvRxKqYDIITNpKlY8UFR+k7ebW8ZSkAwdYhYnvy6ib5eq4lPLTK
	F/ojPixmhoHSSl5G6LzYND27bG13jmukknrO3y9KBgsq1SF4BBC6ROaP1S/FLIoW5oNyyWw
	OeHslp/jNu9uvp8hIRsCI3+CkcFIfJ4XcZHZuWHmswvLcVOHblZJbZWumhH2t+g2OUZ7IFg
	34O6dCZ718Qmek0M7D5hCUTYKT+DjbiYQ2QouycFLCAdXZUL5ve36UgaeacvuyntJyy6pDF
	54RV1rXJ/0/60j7CCwEGtERi1V00Hn+H+artdgVdZlXayfHG8omeUFjeWKjXo2N+TB7+OGO
	UECNUZ3OkYIfksg34le9OlWzACOk/zuGWg3hnMr9is/MNhlI17hvhi/s9JWGs9jzX7je50C
	sJYnXkFnWVUe6J7GkMN+GY/89bR159kRRyPj+k9wH9L7HMJyDhB/EbJYpSySUfDEIJGxvi1
	eM4oF4O0MjcDEUpFJ8xFsAaxzaOeC+RQDgcblV6eVUsjLedMxAHQ4Hw1WOWoX605LTVFauJ
	T6irZALqHy/Y84jN5k7tWxSSItgaNA2qwqVmc8QG0ff9Mg0UKAt3EQbxluYffUQuPcd4gqT
	AkT/a0rXK+afAttcWoOrdzUMv/XukhMZy0yxgr56bzdo5x99p9yVJ4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1..6d9af6417620 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -392,7 +392,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
 		/*
-		 * Note that any clock-notifer worker will block in
+		 * Note that any clock-notifier worker will block in
 		 * serial8250_update_uartclk() until we are done.
 		 */
 		ret = clk_set_rate(d->clk, newrate);
-- 
2.50.0


