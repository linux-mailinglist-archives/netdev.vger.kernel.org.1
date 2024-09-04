Return-Path: <netdev+bounces-124780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D896AE1B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797481F2577B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81ED502;
	Wed,  4 Sep 2024 01:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5A3211;
	Wed,  4 Sep 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414622; cv=none; b=GnHSBwi5yU5ejisVhKdPzESwtupsRlnoGiUub7t3SfIaH2aNTsv8VMosgsI4JT4tcWzd9G6QXeTihX4PP7yMYeGL7ZY3Cxc/kc9BZWRik4inChxJacxXWrkjMHnlIF7buzRY1Ol5VAyAtfz2QImfOQ+3mr2vv4Gahq8Zl69VnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414622; c=relaxed/simple;
	bh=84VRkPJTtA9jez+1Ca+HJo77sFU4+bGKeT4ApDxyVVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHAqtRhAZItXxSB1jiLoEhSl9AO8ggIyaBGt62n3tLFibYdRWgxHn0Tv29WKmECIEiCtLzoPCwKJNy/V3R8bYTwkD+f60+5Y55aqjHSSgk0MDoK1yQistb3262XxtoEd+bsAGbab/TV+IPypkaKXCc7Gmvn4Gb+8Z8REEjleZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3f3_WvNdm9sn1AA--.50551S2;
	Wed, 04 Sep 2024 09:50:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next v2] ptp: ptp_idt82p33: Convert comma to semicolon
Date: Wed,  4 Sep 2024 09:50:03 +0800
Message-Id: <20240904015003.1065872-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3f3_WvNdm9sn1AA--.50551S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4kZF4UCFg_yoW8Jw1Upr
	yqya9Iyr4ktFWjva9rKanxXry5Wan3W3yxJrW5twnIy3W0yF17Zr1Fkr15ArZ8W3y8KrWx
	Ar1xAryjyF4Fv3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUbuWlDUUUU
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
Changelog:

v1 -> v2:

1. Update commit message.
---
 drivers/ptp/ptp_idt82p33.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index 92bb42c43fb2..d5732490ed9d 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -1171,10 +1171,10 @@ static void idt82p33_caps_init(u32 index, struct ptp_clock_info *caps,
 	caps->owner = THIS_MODULE;
 	caps->max_adj = DCO_MAX_PPB;
 	caps->n_per_out = MAX_PER_OUT;
-	caps->n_ext_ts = MAX_PHC_PLL,
-	caps->n_pins = max_pins,
-	caps->adjphase = idt82p33_adjwritephase,
-	caps->getmaxphase = idt82p33_getmaxphase,
+	caps->n_ext_ts = MAX_PHC_PLL;
+	caps->n_pins = max_pins;
+	caps->adjphase = idt82p33_adjwritephase;
+	caps->getmaxphase = idt82p33_getmaxphase;
 	caps->adjfine = idt82p33_adjfine;
 	caps->adjtime = idt82p33_adjtime;
 	caps->gettime64 = idt82p33_gettime;
-- 
2.25.1


