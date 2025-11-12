Return-Path: <netdev+bounces-237856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDCC50F29
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95F23A9511
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595E2C15B4;
	Wed, 12 Nov 2025 07:29:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27B2C21F3;
	Wed, 12 Nov 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932544; cv=none; b=QurhiTF2cMKDrw5Dxf/U/IKvicfCAfMBw/b9cLqn6gUcbf/hKjzSjAy5kj/c8pcE4eKb2LqofmC0M5h9Nt9qpmqHMdIjLfW/oajrAKvC9FjTZaoqt0b/PjqcJ++vALQQhsTlx/JOALcBMuNw00SFI0Z7+juiSoEZiZCPXXM62Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932544; c=relaxed/simple;
	bh=e28E9DEW384uAUF90lF74MBOLOLdTU36ftx2KeFRstI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4urPSXwurL5jxSOrxZ2zwQbCpf4nvnlkShQuXL1xiJAByHn3w4VOCk4HY8DBFgAy4Otz2jUZud+d448c44jMXL/AEJpt7TbF+E3Ptl+iKbW2dWj5iTVwbojlm9r8Uh9Shv/79j8BFfmc9zo9aUoaioDyjmjAxHfst4BRPfFd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABX8M8tNxRp_apxAA--.8506S2;
	Wed, 12 Nov 2025 15:28:45 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] net/sched: act_ife: convert comma to semicolon
Date: Wed, 12 Nov 2025 15:27:09 +0800
Message-Id: <20251112072709.73755-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABX8M8tNxRp_apxAA--.8506S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoWDKFc_Ww
	1S9ws7C3W0qrn8tan7Zr4YvFWFgayIyryrWr1v9a4Yk3Wrt34DursYvFn7Gr1UCFW7uF13
	Grn5XF1jka1xujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB6wZUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 net/sched/act_ife.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 7c6975632fc2..1dfdda6c2d4c 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -649,9 +649,9 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 
 	memset(&opt, 0, sizeof(opt));
 
-	opt.index = ife->tcf_index,
-	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+	opt.index = ife->tcf_index;
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref;
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
 
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
-- 
2.25.1


