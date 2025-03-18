Return-Path: <netdev+bounces-175610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0DDA66CD6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3A1189FF52
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDD1DF742;
	Tue, 18 Mar 2025 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="STWlnEc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F11C5F2C
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284050; cv=none; b=u6bwk+eNTjVe9DE3Z5Nb7y3nFCPWdCJDJ/KZFubTVRP0jSAxvXCXoRO4Ofdm87gEfbv2KNm9/gNchmcfR0d6Gd0uphWuB6zEhTH2PPMQ4pOk1/VZ/nACkLPZzSK10xGhj5FqmNGL3xqquyntUEHc4+LwafVPpnCym76FiltkBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284050; c=relaxed/simple;
	bh=PiTmRzbTygWH1lLN0blb1/x2kmM+fyMCiD0dtvyVriU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXcEO5c1Cd8sGLl9IIZDFVggjzTCynbt+u9NlhHcv5GodRE0ANiGDe3knhHWJdTjTc4lTweadc570RGNSAyXsDVb7i3sU4vQGledg4Xl7zivopfhKPs5mgCRe/HFNcQB6BsrJdoySViLu7Fk/Wd/R16e4DntEud0gxT7a+2WoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=STWlnEc/; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742284034;
	bh=fxtfU5VJRnJzZUAvhJzy3Ea93trYsTtSrjDniPVubhU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=STWlnEc/yEsCVBZvnYHlVn1OmJAmt1qJYwB1Q0K0ma9kfJ8296bl5Er24LdqQR6Bl
	 VuGLCucMQUgngN9rWsafd2wLFEfJXlOOuXNTZwpJNWCB2xTlmGjwfawbbzgMuB3pRm
	 vowztSgO70j3Mx3Tf5dsfnq4R26yp+mu3FloPNcU=
X-QQ-mid: bizesmtpip2t1742284023tvs5xyy
X-QQ-Originating-IP: A/rClot4DoAeHUjd/IqQnETxzddDYCW2UZntEibBBFk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 15:47:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11619654860580283103
From: WangYuli <wangyuli@uniontech.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tom@herbertland.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Sourcery AI <hello@sourcery.ai>
Subject: [PATCH] docs: networking: strparser: Fix a typo
Date: Tue, 18 Mar 2025 15:46:56 +0800
Message-ID: <A43BEA49ED5CC6E5+20250318074656.644391-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NIzMBgenmFvtYTCCG5ODXYQvkRvfpjXLXyhI7HUT29CEVuzh6/+vqAnH
	OoYFAfSsQBeND5y0XjsNhDiyKWHuORH1H91l/y3YWxDQH1gBPHV9HcjAXEaZIbDFzcUeGim
	0rLOmryJV6sYS6iRvkL30zsfGDcicnjoRlWhh7ZBztxMDPXxuZTTBHQn6PZOdqj89xbUFdW
	PjOyzGmJVLT3HQZPnhEH3RhW1V4+YEv+F29qy0kWkXSVqd0gvzNA5HgUPSCrANMBtgTeo2a
	PPFTgheUhGjdazX95uDePQj9FH+lLQJs407PlL9+3yssr/nV9nlfIynv40a08UDAnwgFtXx
	LXkbdvrWMSDcLpq5K4/+2LxI0yzUZLKG6XKNsgPF6qxrWrMbZI9Oczl51U/iRoBGghO0ZnZ
	LW08t1l2npzK1MH7afCsb/Cx4tELwJqzr3QLgLX8abt6DU64MLAV+h+SDu6X7oFRSwyQqb+
	zpCS8sB7sGlIueU0ZK9U1VMQbMakRKtMyZBcsK1qb2p2266WCXnq79r+sIBoCYRIzUZD9oi
	0GKkx+r+JIvb+bGukkHEmT3NtG7tQLq5yLwgGY5QNTarNy+hOixInhjktPuV6UOUCQLJ/Gi
	HeVYoBhSWh1pNp2hIaKp3A1cWuIBBOE0cXtP4NCrfCCTP8gH/WLce0SHr78qHbTlreEl3Fg
	DkuHB2ojOzbO1HHVrUs7Dd48Fkiz1X4q8GhSv2BWizT03BnHssNGkPKlcbk0la8S8imAbXC
	1AbgDKnGQ4uRcd+lGmwZJNUmFj6QfFQhhT+BdBCqzpF1YzK3G1sL3QgvUUQJMuTYISi4Yf0
	ayEO4+1lKB1bqRhDtR/RtQPyvfhfUpT/hr1dT6YOg+Xps1G+jBkR/2xVf8SwBVyU8bZEuj4
	ztSxzWFt7nis+ImxYuYPD9YamPxBPGYNd20tAI69ptr1Eu/TjydOHFlE6hSmPUsBkSvmC5X
	SMSrcvszZo0dxKi5h12IPXywc9VXc7ZbFCuUPO9MgcH5E4Z1fXt0s7vt3xNX4LUKpL8zujS
	B9iL5mLtJUgcurnunR
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The context indicates that 'than' is the correct word instead of 'then',
as a comparison is being performed.

Given that 'then' is also a valid English word, checkpatch.pl wouldn't
have picked up on this spelling error.

This typo was caught by AI during code review.

Fixes: adcce4d5dd46 ("strparser: Documentation")
Reported-by: Sourcery AI <hello@sourcery.ai>
Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 Documentation/networking/strparser.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 7f623d1db72a..8dc6bb04c710 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -180,7 +180,7 @@ There are seven callbacks:
     struct contains two fields: offset and full_len. Offset is
     where the message starts in the skb, and full_len is the
     the length of the message. skb->len - offset may be greater
-    then full_len since strparser does not trim the skb.
+    than full_len since strparser does not trim the skb.
 
     ::
 
-- 
2.49.0


