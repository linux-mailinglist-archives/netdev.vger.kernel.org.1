Return-Path: <netdev+bounces-20167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB975E050
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB54B1C20A5C
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE3ED0;
	Sun, 23 Jul 2023 07:41:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69FEBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 07:41:30 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332211722
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 00:41:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [36.24.99.225])
	by mail-app3 (Coremail) with SMTP id cC_KCgDHzw+X2bxk5h9_Cw--.18638S4;
	Sun, 23 Jul 2023 15:41:11 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Date: Sun, 23 Jul 2023 15:41:10 +0800
Message-Id: <20230723074110.3705047-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDHzw+X2bxk5h9_Cw--.18638S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7WFWxZF1rXFy3Cw1UAwb_yoW8WF18pF
	W8C34xCwnrX34jkwnruFn2ga1Iga47XFyDGF9IvFyrA3ZIg3Z0g34fC34aq3yvyF4rJFW7
	AF4ayry5KF1q9rUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYMKZDUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
message to user space") added one additional attribute named
XFRMA_MTIMER_THRESH and described its type at compat_policy
(net/xfrm/xfrm_compat.c).

However, the author forgot to also describe the nla_policy at
xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
bytes) value can be faked as empty (0 bytes) by a malicious user, which
leads to 4 bytes overflow read and heap information leak when parsing
nlattrs.

To exploit this, one malicious user can spray the SLUB objects and then
leverage this 4 bytes OOB read to leak the heap data into
x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
userspace via copy_to_user_state_extra(...).

The above bug is assigned CVE-2023-3773. To fix it, this commit just 
completes the nla_policy description for XFRMA_MTIMER_THRESH, which 
enforces the length check and avoids such OOB read.

Fixes: 4e484b3e969b ("xfrm: rate limit SA mapping change message to user space")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c34a2a06ca94..ab0e73c1e352 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3035,6 +3035,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK]	= { .type = NLA_U32 },
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
+	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.17.1


