Return-Path: <netdev+bounces-110128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3292B113
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7101C223BC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92314431B;
	Tue,  9 Jul 2024 07:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD27140E30;
	Tue,  9 Jul 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510214; cv=none; b=k/9YMNzwisbcZoNNeNrUyf6hcKA1/rCX1GclwdabvatJvZyrZEKcO1F9sfbDOGuvz8WJx0G86s+nW6pZKrekkMpheVNXn1hGLK7OLim3uajnWA+ImXRWm6BfnFVEGOJTXEUd6jTDf+ablnux/8NemvVLKQP60xbDWPiPwRtLPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510214; c=relaxed/simple;
	bh=T38RomaN6IVvN1u99Rxq68WUG0h/IzMUegAp2pExboQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehdkDgBNPQja0eweL51mNQbJWztN+eObflhhRP/rVCI14aa++aKKLb90buO4+4uwUw5+J+4iTSl1T/2r0EsMAapt1wNKMX8+DeaZTtLK09Dk8F0o4AmB1Jhc0eZAqbLgJxOVBl7PpoG9kFuvpfSoy6rGHkp077mOvbdJ65HJenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABHTs7y5oxmx7fMFA--.39776S2;
	Tue, 09 Jul 2024 15:29:55 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] net/sched: act_skbmod: convert comma to semicolon
Date: Tue,  9 Jul 2024 15:28:38 +0800
Message-Id: <20240709072838.1152880-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTs7y5oxmx7fMFA--.39776S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47JryfCFyUKFg_yoW3WFb_Zw
	15KF4kJFy8tr1vyw4xZw4Yvr4fK3yxuF48Wr1j9FyYy3WkJryDZr1vkrn7GFy5urW7uF13
	Gwn3XFy8Ca17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd5rcUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 net/sched/act_skbmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index cd0accaf844a..dc0229693461 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -246,7 +246,7 @@ static int tcf_skbmod_dump(struct sk_buff *skb, struct tc_action *a,
 
 	memset(&opt, 0, sizeof(opt));
 	opt.index   = d->tcf_index;
-	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref,
+	opt.refcnt  = refcount_read(&d->tcf_refcnt) - ref;
 	opt.bindcnt = atomic_read(&d->tcf_bindcnt) - bind;
 	spin_lock_bh(&d->tcf_lock);
 	opt.action = d->tcf_action;
-- 
2.25.1


