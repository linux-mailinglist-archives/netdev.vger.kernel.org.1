Return-Path: <netdev+bounces-182027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51CA876ED
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A90188FD26
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820EA155C83;
	Mon, 14 Apr 2025 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BVgoz2aB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBE28E3F;
	Mon, 14 Apr 2025 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604848; cv=none; b=cKL+hcuyjlbIoD42n8SJsW8cnF/t+P9Bfz23l78LPmjbXwB00K9xVPD33M4uBHPB3f95II6KRTDP6XegXt56IYcJxgU3soWEb1lzO9aISRZjmDWNH+3kJBYCAyGdZBZEEDTOB/hgNLMZH1bxq9ZGOJIzTGYrQ/K2sFHbqEHdJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604848; c=relaxed/simple;
	bh=j4MYb6RVTpLF/OHvBkanLy0iEejvwD4jd18R/nxyKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkv4rmlh+xa5x6T2iEXteWJhJW5DTeuu9iUYCeMb76OUWDp1vqPeyiNM84nRVU4/pCtmV0/0HmySjPrrh+OZFHsFVsoFWn/VLIdodkz7HwPlTG+L9kNEXoc1f6HF89y/4i+EKKoGhDQ5xj8hX3Ln1L0kLpfFhk082+KJ8PZrLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BVgoz2aB; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744604814;
	bh=KPm6homno2OIodX8ovj0TGGxLESvoArCHRFaF6Tjv98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BVgoz2aB3GaY4IDSZn4IvHIUCBXdL1D5e0PcZKh0GSCA/OQLJ9pCGcPp4CwlpVj/0
	 ClSQqR6JbdtYRYQMJOSPOqIacyuAuYL0G1K63TuRvif7cGEuBBFh3a0HOWedZ3ner3
	 rdmW/LwadLxnkUvtqfLUeRcKLP5Ij1SeUHYcVS4o=
X-QQ-mid: bizesmtpip4t1744604799t7c4642
X-QQ-Originating-IP: CpTEDf2RT5I03ge7QTMeZ+lfzyPSflUOhm4AzwaerQo=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 12:26:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16277305603624599492
EX-QQ-RecipientCnt: 17
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: akpm@linux-foundation.org,
	guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	niecheng1@uniontech.com,
	tglx@linutronix.de,
	zhanjun@uniontech.com,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/5] bna: bnad_dim_timeout: Rename del_timer_sync in comment
Date: Mon, 14 Apr 2025 12:26:25 +0800
Message-ID: <66962B9D4666B555+20250414042629.63019-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <37A1CE32D2AEA134+20250414042251.61846-1-wangyuli@uniontech.com>
References: <37A1CE32D2AEA134+20250414042251.61846-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4lPCacZ9YlexUY+K5B6LtUk+dUYUPB7FRgYCF/GKPloyGJF0JkR5eZs
	3vK2Kl0mGd27G9RdEVGX4MP4PF6pocXfiFrQQTeXpd0DtZPHTasijiTqA2cfBpTeEviJOEO
	GssYJnpwEB2Y2A91SqMBFLM3/S7XJcDfmwBxsse2AcLP0iUywuWF3Zeq9kNSYaAhdDT5kRf
	9oALXRJdvvKc6fDV85tSlVannn5GKC16m2pS3SSNglHqhd5n93UAMUgAL5u4M1yTxzb/9Av
	4O0XW9XgUmuVSxi0nfrRkNqeKrmbMFEQ4S9RgujxKSVusi47z/7fX/KdMRVGsz0hNqd7rSV
	jEaZa3/RPILHU24i7aZwHEp0986L9rVrorGz/Cuc8bBN9R/RTOnaI10wBmi0NCjUn0AKvuc
	7aC3Nx+OWrQB5BkkM+UiE2SdUL3KefwQ9xzjkx92M5p+QC3ag5tITBnii4kiFi8fRz7v7xc
	nuRgrbvgjc5DTVCRyc7HMvh/vg2MkEQPBJDPs0pyP4u9K3eQ3l0P/Yyw0w4i+E/cZ/WYK0O
	8JWQv5RqnrbgIGaXaM+UgWQSn4Yor/8bEqlPpjGfolpPZLTsV1sNr+UnL5pYhNrUGWaC9nG
	w6bjUtV6ZBks6lRVr5ojniGf2EzVy29GPAbXXBXQipocJvjCpW0+FEjDoOQL+WaoluUEUe9
	qs5UNvOX5NehnWbEnFR5MA34FllqJOmMO588l8efgytLJupTMAs/McYiTDjpEdwAhX3jYzZ
	YlL9DVm6oWO6ijVOhAcHIfxv3CUKF9KVc9wiO8HIc19cDLlgbV+ChPVDULVMm+BS14MiLM2
	Ml0D5JGKFioNjcfR33k7+ClfrjqUbq/kWBGKKnQADDZuUfvHNcNLt0/yC3NSuM7Jd1OBLTg
	azdAwhAuLaAcdxf7QOKEhRNMNiRxlDEF0u0j6Zqgjn4qTXPKnkpHpIHwibaj8jGtHO00ata
	IYzjNdo2Wd3Cp5Lei6sa6bR18NtDI9h3G1249fwvhCQEjawEz0MrY9p6jGuYPYHzuRfMV32
	RcX+aUvgNJF/JlfvORWij1eO05EJA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Commit 8fa7292fee5c ("treewide: Switch/rename to timer_delete[_sync]()")
switched del_timer_sync to timer_delete_sync, but did not modify the
comment for bnad_dim_timeout(). Now fix it.

Cc: Rasesh Mody <rmody@marvell.com>
Cc: Sudarsana Kalluru <skalluru@marvell.com>
Cc: GR-Linux-NIC-Dev@marvell.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index a03eff3d4425..50eb54ecf1ba 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1735,7 +1735,7 @@ bnad_iocpf_sem_timeout(struct timer_list *t)
  *	Time	CPU m	CPU n
  *	0       1 = test_bit
  *	1			clear_bit
- *	2			del_timer_sync
+ *	2			timer_delete_sync
  *	3	mod_timer
  */
 
-- 
2.49.0


