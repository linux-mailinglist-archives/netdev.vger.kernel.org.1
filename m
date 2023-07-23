Return-Path: <netdev+bounces-20171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B3075E05E
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A2281D04
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DAED2;
	Sun, 23 Jul 2023 07:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F4EBD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 07:56:53 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FEDC191;
	Sun, 23 Jul 2023 00:56:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgBnb58w3bxkTWR_Cw--.18730S4;
	Sun, 23 Jul 2023 15:56:32 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
Date: Sun, 23 Jul 2023 15:56:31 +0800
Message-Id: <20230723075631.3712113-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBnb58w3bxkTWR_Cw--.18730S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWfGw48GryfJFWrAF48Crg_yoW8Ww43pa
	4kJrsrtFZ3urn7JrZrXw48XFsa9r47AF15KFyqvw1SvFn8W3sxGry8Wr4agr13GF4rCws3
	Jrs0y34xWwn09FUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUQyCJUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
not check the length of the nested attribute. This can lead to an
out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
be viewed as 8 byte integer and passed to priv->max_rate/min_rate.

This patch adds the check based on nla_len() when check the nla_type(),
which ensures that the attribute has enough length.

Fixes: 4e8b86c06269 ("mqprio: Introduce new hardware offload mode and shaper in mqprio")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/sched/sch_mqprio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index ab69ff7577fc..7bd1d261d8e7 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -285,7 +285,8 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
 		i = 0;
 		nla_for_each_nested(attr, tb[TCA_MQPRIO_MIN_RATE64],
 				    rem) {
-			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64) {
+			if (nla_type(attr) != TCA_MQPRIO_MIN_RATE64 ||
+			    nla_len(attr) < sizeof(u64)) {
 				NL_SET_ERR_MSG_ATTR(extack, attr,
 						    "Attribute type expected to be TCA_MQPRIO_MIN_RATE64");
 				return -EINVAL;
@@ -307,7 +308,8 @@ static int mqprio_parse_nlattr(struct Qdisc *sch, struct tc_mqprio_qopt *qopt,
 		i = 0;
 		nla_for_each_nested(attr, tb[TCA_MQPRIO_MAX_RATE64],
 				    rem) {
-			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64) {
+			if (nla_type(attr) != TCA_MQPRIO_MAX_RATE64 ||
+			    nla_len(attr) < sizeof(u64)) {
 				NL_SET_ERR_MSG_ATTR(extack, attr,
 						    "Attribute type expected to be TCA_MQPRIO_MAX_RATE64");
 				return -EINVAL;
-- 
2.17.1


