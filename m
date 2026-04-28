Return-Path: <netdev+bounces-281996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NrrAGbm8GmoagEAu9opvQ
	(envelope-from <netdev+bounces-281996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DA4896B5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A744930B31FE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45E3264DD;
	Tue, 28 Apr 2026 16:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E953264DE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394539; cv=none; b=PCSGnOOFA1gCE/JcWU/7NyCXm7l8AxJ6K/khu7uijqPlu8kg39XwI9maNWIiYd1LxNYeVurG7dgjB87NzVjmuPtRhE1TBnpX1FgkVXAZ+wGDsE0VCqfY312aUS4VzD+fUnEoTNH9ZQ25seyPBJIOKvu85t/wc1Mv+9AkyV99Yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394539; c=relaxed/simple;
	bh=swIbiRs52URCr4ERBXpm1D/Ebin53127fjmZKeifs8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYNI6gBJIIaHuOcfPPfOlbUZZ0cqSpvUQ48VzNObRpS9pNetv0/jguwSfsHBuiNPHqctG73dp7lSBHvR+G7Q9hH2E0zB0plPzPr3ZzDw3pZIpGHrMo0n8UoE2PbIhlHx+nkN7/wwXrbfRQfwUisvO3r8j5coatPTrnjutOp73Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADXTwBJ4_BpC1foAA--.57594S3;
	Wed, 29 Apr 2026 00:41:48 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	0x7f454c46@gmail.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ruijieli51@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] xfrm: provide message size for XFRM_MSG_MAPPING
Date: Wed, 29 Apr 2026 00:41:43 +0800
Message-ID: <93a1ffe802d9c5d741ab95dce75eb3e9368be97d.1777354203.git.ruijieli51@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777354203.git.ruijieli51@gmail.com>
References: <cover.1777354203.git.ruijieli51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADXTwBJ4_BpC1foAA--.57594S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFykJry8AF4ruF18Kw15urg_yoW8Gw47pr
	Z8Gr93KFyxXayjkw1kWry0gFWxGFZ2gryUt34akF15Xr9Fgr45GF1YyayDtrWkJFyUWrW0
	va4q9ry7tw4qvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF
	7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
	Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQELCWnwdGIImwAAse
X-Rspamd-Queue-Id: 143DA4896B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.280];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]

From: Ruijie Li <ruijieli51@gmail.com>

The compat 64=>32 translation path handles XFRM_MSG_MAPPING, but
xfrm_msg_min[] does not provide the native payload size for this
message type.

Add the missing XFRM_MSG_MAPPING entry so compat translation can size
and translate mapping notifications correctly.

Fixes: 5461fc0c8d9f ("xfrm/compat: Add 64=>32-bit messages translator")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..38a90e5ee3d9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3323,6 +3323,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSADINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_NEWSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
+	[XFRM_MSG_MAPPING     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_mapping),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 };
-- 
2.34.1


