Return-Path: <netdev+bounces-124896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E596B552
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848C028D5FB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA01D0483;
	Wed,  4 Sep 2024 08:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39A1CCEDE;
	Wed,  4 Sep 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439326; cv=none; b=HuHZ1DUbRzLoGVa65P0dikI8x1PtvsOoL2dTbS0TqhL+JW9bu+GOQ/TnGkJPdWHrsMv3BL1pM7XdQ4hW1ilE7hrVmWDYo+nJDxMRN08U3ZAh0OWfWKAaDxpfY+bxVGc85fyNUdvMJoc+8HcsLxQEtHv8J7rQNl7CT24YS7bs+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439326; c=relaxed/simple;
	bh=hbucqT7xCHO0ItaLmkrTPjZfpqSkgjRw0JD7uTbqBqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUo6YpZcs8Lqj55KmohlU6oWHL8hiKXaLEyxucJyxf7+/UkE82MajvnPreOK5wkFfeWyRRrugFkHNFyjcUfN3lct2oOdbYYDkDfd7K+ZrGnEzfcVyeIz4U6zQtlf4qxwcMLYF0SZwDHmZj/NSVKzHnRaqh0502Y33K2HYeGahIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHaupIHdhmYuUoAQ--.4628S2;
	Wed, 04 Sep 2024 16:41:44 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	shannon.nelson@amd.com,
	wintera@linux.ibm.com,
	kory.maincent@bootlin.com,
	alex.austin@amd.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] sfc/siena: Convert comma to semicolon
Date: Wed,  4 Sep 2024 16:40:34 +0800
Message-Id: <20240904084034.1353404-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHaupIHdhmYuUoAQ--.4628S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoW8Jry3p3
	y5Aryv9FWxJa97J3WfXan5uF9Iva1YgF9xCF1Sy34rZas5trn2q3yvgay5Zrn0yr40ya15
	Ar1FvrWSgF98CaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRTE_NUUUUU=
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
 drivers/net/ethernet/sfc/siena/ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
index c473a4b6dd44..85005196b4c5 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.c
+++ b/drivers/net/ethernet/sfc/siena/ptp.c
@@ -897,7 +897,7 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
 	timeset->host_start = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTSTART);
 	timeset->major = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MAJOR);
 	timeset->minor = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_MINOR);
-	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND),
+	timeset->host_end = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_HOSTEND);
 	timeset->wait = MCDI_DWORD(data, PTP_OUT_SYNCHRONIZE_WAITNS);
 
 	/* Ignore seconds */
-- 
2.25.1


