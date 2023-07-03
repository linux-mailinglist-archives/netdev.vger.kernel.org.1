Return-Path: <netdev+bounces-15103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37D745AC9
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058EA280D6F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34485DDC7;
	Mon,  3 Jul 2023 11:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24773DDA5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 11:09:14 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB780C4
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 04:09:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [122.235.246.99])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXCJ07rKJk7DGtCQ--.10331S4;
	Mon, 03 Jul 2023 19:08:44 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX
Date: Mon,  3 Jul 2023 19:08:42 +0800
Message-Id: <20230703110842.590282-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBXCJ07rKJk7DGtCQ--.10331S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ury3KrykZFyxAw45JF15XFb_yoW8Xr18pF
	yDWa97Kw47WFy3WF1SyFs7Za4Igw1rGr1UGr1qkr4fArn8Wa1rW3Wj9r97urZrCr4DZ347
	Jr1UtrWfJ3Wvvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The attribute TCA_PEDIT_PARMS_EX is not be included in pedit_policy and
one malicious user could fake a TCA_PEDIT_PARMS_EX whose length is
smaller than the intended sizeof(struct tc_pedit). Hence, the
dereference in tcf_pedit_init() could access dirty heap data.

static int tcf_pedit_init(...)
{
  // ...
  pattr = tb[TCA_PEDIT_PARMS]; // TCA_PEDIT_PARMS is included
  if (!pattr)
    pattr = tb[TCA_PEDIT_PARMS_EX]; // but this is not

  // ...
  parm = nla_data(pattr);

  index = parm->index; // parm is able to be smaller than 4 bytes
                       // and this dereference gets dirty skb_buff
                       // data created in netlink_sendmsg
}

This commit adds TCA_PEDIT_PARMS_EX length in pedit_policy which avoid
the above case, just like the TCA_PEDIT_PARMS.

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to the conventional network headers")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/sched/act_pedit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index b562fc2bb5b1..1ef8fcfa9997 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -29,6 +29,7 @@ static struct tc_action_ops act_pedit_ops;
 
 static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 	[TCA_PEDIT_PARMS]	= { .len = sizeof(struct tc_pedit) },
+	[TCA_PEDIT_PARMS_EX]	= { .len = sizeof(struct tc_pedit) },
 	[TCA_PEDIT_KEYS_EX]   = { .type = NLA_NESTED },
 };
 
-- 
2.17.1


