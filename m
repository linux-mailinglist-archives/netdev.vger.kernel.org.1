Return-Path: <netdev+bounces-124864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820F96B3EC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0141DB236A8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FA17BEB0;
	Wed,  4 Sep 2024 08:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC28155735;
	Wed,  4 Sep 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437373; cv=none; b=MZG0OwdwmV7a7teGvzX7kKQpINJ+ckC682sECpKBvdsRu2fNhQPyXJJC6A2unf8cZLwgu7BeJIn9ve4JE2vlmy4RD81aHWM8Byuk28mQyTArxkSImnTzCL2uQ2b3D2C52E6IbZBiK303skiXFLoqsjR3D5SZOqv78SRM8PYpEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437373; c=relaxed/simple;
	bh=KY99IEVaWZ+f1T7u1eXXvb4Hi2LMioMrpkFaFZpmETc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XA19uNOGYrnvbPl7oJJoeR1fG+5sCsd4ATe47tSjV0hiVNbaaU+tVSAR9/Ty7QMRKt4rEPa+Y9EqqVtdPFF+pxsCkNFf8JkDiceakD3sbA0KlIWSJ3i9HJdBUa7+cip+ZaubyqTZ9env0SD4ldl5JquOJIVTE8VntnghCYCepTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAX++qwFdhmk1UnAQ--.4786S2;
	Wed, 04 Sep 2024 16:09:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: irusskikh@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] net: atlantic: convert comma to semicolon
Date: Wed,  4 Sep 2024 16:08:45 +0800
Message-Id: <20240904080845.1353144-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAX++qwFdhmk1UnAQ--.4786S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoW8JF1Dpr
	W2ga4qgr4xZ3y8Ga1YqFW8AFnIqan7trWrKry5G34FvFn0yF1xJry5tF9Fkrn5XFZYkF13
	Kr4jvFWxJa95AFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfU5l1vDUUUU
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
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f7433abd6591..f21de0c21e52 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -557,7 +557,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 				}
 
 				frag_cnt++;
-				next_ = buff_->next,
+				next_ = buff_->next;
 				buff_ = &self->buff_ring[next_];
 				is_rsc_completed =
 					aq_ring_dx_in_range(self->sw_head,
@@ -583,7 +583,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 						err = -EIO;
 						goto err_exit;
 					}
-					next_ = buff_->next,
+					next_ = buff_->next;
 					buff_ = &self->buff_ring[next_];
 
 					buff_->is_cleaned = true;
-- 
2.25.1


