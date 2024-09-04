Return-Path: <netdev+bounces-124887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162ED96B466
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85149B25949
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796D18D64B;
	Wed,  4 Sep 2024 08:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746E3F9D5;
	Wed,  4 Sep 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437948; cv=none; b=alwPC+hUyhuKtykeX5tajfnZW3yZFao8nYeBK9bmQqDJIoBUHu8JXXLv9dN7mTdscxHwRLQyMzbTZlE5zaVyhSQRe6wW8HIu8xrrAU59YjDb72ztkZcILroOpiItNML8opnW5W/KvyTOOngZEUEDxWVihzhYc49guamoQJjr7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437948; c=relaxed/simple;
	bh=jVtS6nvwU8vVVn+pBIWHXO9OZg+fZnTF+s7TWc2HnWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XpBWDuZZXg8EdBqsCHxul2ORFUw1dHOAxRkLpMjvtV9YXSmw1jxupCTEw8Yaz8Tqqdexi//ocMaTw9Z9Jl/IxvUmB46MqnIEErnjwgNRb8XYCedTRWlv4mivRdIdyQC5muvpSCrqGbh+rF6wpMtXiv/b31wJCCeiyA/BbKHQ4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABXOuruF9hmZ9knAQ--.4818S2;
	Wed, 04 Sep 2024 16:18:54 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] ionic: Convert comma to semicolon
Date: Wed,  4 Sep 2024 16:17:28 +0800
Message-Id: <20240904081728.1353260-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXOuruF9hmZ9knAQ--.4818S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4ktF1xGrg_yoW8JFy5pw
	43G34qqF17Xa4UW3WkJF18ur95X398uryDur4DC3yrua4kAFyxCa1Iqa4fJa4kXr4UAr40
	qr42ywn8XFn5A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfU518BUUUUU
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
 drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 1ee2f285cb42..528114877677 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -312,8 +312,8 @@ static int ionic_lif_filter_add(struct ionic_lif *lif,
 	int err = 0;
 
 	ctx.cmd.rx_filter_add = *ac;
-	ctx.cmd.rx_filter_add.opcode = IONIC_CMD_RX_FILTER_ADD,
-	ctx.cmd.rx_filter_add.lif_index = cpu_to_le16(lif->index),
+	ctx.cmd.rx_filter_add.opcode = IONIC_CMD_RX_FILTER_ADD;
+	ctx.cmd.rx_filter_add.lif_index = cpu_to_le16(lif->index);
 
 	spin_lock_bh(&lif->rx_filters.lock);
 	f = ionic_rx_filter_find(lif, &ctx.cmd.rx_filter_add);
-- 
2.25.1


