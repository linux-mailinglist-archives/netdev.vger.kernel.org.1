Return-Path: <netdev+bounces-179506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39542A7D26B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D5316D0D1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853161A3168;
	Mon,  7 Apr 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="H1fL2PNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24772290F;
	Mon,  7 Apr 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743995954; cv=none; b=MuUR/H0yffCTEdJlS+uFgbt/InsezUIz2zVfLAwPYno6GFa0FncD1fBAOTUaq1g71ItWmaeGzxiS8amnAfFriL3SXeOQlcSmjKBNbSxTvv6wQxLhpY4p/eACm1GfxJoniO2tzOoXmVbRE7MFrSR+xfawQ5MWO5dvXBI3G60HxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743995954; c=relaxed/simple;
	bh=6qOaICOf+luhocr5ziH6trTEHZu5/9SRvXds/cLTn9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzWIugE2Ai1oYq34/DkPGwrc3guV3VcNOSGeOt1uZ0YlHkZAIM5xyx4SiI9xNwL9VPcj2OnqanoQzJHVcG6J8VDlAxqgQMlEFWBkH9oAVJXGd9axZcXKAWO6ZblZMLcSVUaoBoP7oWi9LDioU58Y1gZep7MJCqKRRp6HI7BW994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=H1fL2PNW; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1743995882;
	bh=aqkR8dc4JLTMm5HpUhR2fOx35XLhNyasEt6VNslqwTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=H1fL2PNWawtCm/cCBhzZNhLdbVQf3xBDeatJjSW9ApJCSRdmJRwO3tvcYcf1cLVOI
	 7E1NAC/kT0jJooF4VpfbTayXG6mZ3fI10vSIVMNaSrrzn3t+k0gEAhEPh6twpi9I0w
	 pNO5gjTmZ2xGViuAkcN7wtw4pjlRFlNmEH7vz5Tw=
X-QQ-mid: bizesmtpsz6t1743995877tfb6a6s
X-QQ-Originating-IP: nxWDDVkGiKqAzUO/GFz+mQJEu/FlJbh2FzYmVaJbEWk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Apr 2025 11:17:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4845501015925666581
EX-QQ-RecipientCnt: 10
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: tproxy: fix formatting for nft code block
Date: Mon,  7 Apr 2025 11:17:27 +0800
Message-ID: <CFD0AAF9D7040B1E+20250407031727.1615941-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NrDiNNADEAQwXmONuYVNzuUAYSXYqeKKGUcN3eEk+lALh55ZeJtLoWQY
	poVATVZYdpoVSbtpeb4ktfLK5dJqkyOtzjSqtEN1+jQEg3wkDYbNGkJcMe6VmKQv0OP3AW3
	XYt7F5slqgx11XYHixe6YGOoz7URR/58LzyRjPmNbn+M8gLqM/t9sLdLru3P6Et2fsrX/5T
	vjAW477CWvfL93qqqCGJAtt8jNuHxGY4hREEplGDeZIbKoQaxZqSd4Z0XWWrvDwrB53IA+p
	IMeivmi2ODTRMpWkQfLPmCkCwh8kmq3X1r6yPaUmvIVy5NlT/gSub/NUlukTPZIe9AU0YHF
	+DrPTmZnAm4p9Ix6q7vbyVdRU6AuNRFWy8fm6w0I4CvA+wu8CYeAaqCqB99vToX6zER1CoU
	4DPWtK0vy7mGoeBnReHzxTKFLkMYLkDYHzcGJPJ196xDOVAt13zTkUQ807Ou2wtuGWjZF+J
	z2nBfvAqO04zkoBO9oGcqScr5wyaYwLJijlC3GfBHnZEKkb0Bj3QqTZQ38+eQJEUgue3AwX
	JzpYR8BdpB86aNVbIGQ1L2YVvoJkNHzQ6ZKcgVPk11/MlJ4vwagrxMmetN0hAF2f0yOgkp4
	eKMMkuLatMX5Temh7bcRYTUjZ+vsOzNPVdyLbVDvs5J4EmFdeO2qs/Cl78Ye3MteFDeD5kp
	jj1wvNmyo5FAXzoe2Wk/26ZtNYWQ+56Q/U38e3x5/ZGUmlNZ2Tzmquml5SXHLfSaSsJzYAQ
	58SOYhBSehp4Hi3Hh1x7tF/QSvv8k24MGjLne9EmFS6SSF+yVWBv21DCRp2GAXEtr7NLrgs
	Q4GGFjiJh5liQnzazAEHC4bTFH+2eMrkEDZi3SciWolhDLhCqBBHrzRU9M1WNTHH6wmiDtd
	mgVHYbIKpjBjS4pAAPH6IOMjFT62Q1beqh7aShtzTXhPkkEtTsHeVHFpsWLNNuqNO2DqRSp
	NJFW227+ZgqMrfjw2Myj9YpXALUVvk7NyEBw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/networking/tproxy.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tproxy.rst b/Documentation/networking/tproxy.rst
index 7f7c1ff6f159..75e4990cc3db 100644
--- a/Documentation/networking/tproxy.rst
+++ b/Documentation/networking/tproxy.rst
@@ -69,9 +69,9 @@ add rules like this to the iptables ruleset above::
     # iptables -t mangle -A PREROUTING -p tcp --dport 80 -j TPROXY \
       --tproxy-mark 0x1/0x1 --on-port 50080
 
-Or the following rule to nft:
+Or the following rule to nft::
 
-# nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
+    # nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
 
 Note that for this to work you'll have to modify the proxy to enable (SOL_IP,
 IP_TRANSPARENT) for the listening socket.
-- 
2.48.1


