Return-Path: <netdev+bounces-181593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FEEA85988
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E264E1E91
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2010F290081;
	Fri, 11 Apr 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SX3CQSH+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD75298CCD;
	Fri, 11 Apr 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366701; cv=none; b=FrBCAgL32Af36uVaF03zLe3RIZBLuJMl3hE0fwzJQfMGsSXPCfBStOs0Uxoniy6JzPlZ818tMTp6RbMPSt3kEqrfbi3UWV4syeWeQnkiMxIorsF7nDTNH0PNC9E+GCrs7rw6ZPWuAPSOGFHeFPTZ5vfAb/inIhSb36BRKlzgrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366701; c=relaxed/simple;
	bh=krboiesaP6HVfibkIahD0MDTcdik9Hd/EgxPJkcurFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQ+0J4sVkprElvdd5IMWLTg627t0ya/jJJ62c4DqbLn9sAEeuBjPcoHTOtqfBq1QJNw3yqO4ruGIL4DvGLqjYj3Aex3mwptMQOIvYDsk7l1Fj2GPKkQPHOi4HOwgOa91lO17AgfGl2e4AJOoD3CslGAlT93PwdX6ID0Aa0n8Y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SX3CQSH+; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744366686;
	bh=08+vRtxGxjTUJ5sRYnVssZcNIbqP4X3HDjK9klwPl5g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SX3CQSH+mpoeq6EHIZx7wTFSJxfbcSfsx0gByQLjP8bcfX7JEen3lAd84s5eXybYP
	 Gzv0pVGz1aeBUunBwwvWapJKWFRcCukGZ0PQJpYBUFuDTER6PMNknvLAnYwWm4r54Z
	 Hmm9I5jcdtXLMTi8vh0rCdaIef9j262MI6XTkm80=
X-QQ-mid: zesmtpip3t1744366678tb788e7d1
X-QQ-Originating-IP: IooXNj1ALdIX2k9IMN8uo/y1y3ZvOpQrcA8reD71HAQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:17:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15758265876071545783
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: rmody@marvell.com,
	skalluru@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH net] bna: bnad_dim_timeout: Rename del_timer_sync in comment
Date: Fri, 11 Apr 2025 18:17:36 +0800
Message-ID: <61DDCE7AB5B6CE82+20250411101736.160981-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKzYG8XJzx27px6yV5wRJmn9O91mZK060Q9m8uU6VGdq20tyPiQiNA6X
	QvkKrP8B2btvZFfXscycIm5+L9nQMHMi/RApsEnQ5NyrdBhOtv+U0OciSi9CIUhIqRMT1ZN
	sajbclj7klWpSou8OiS3mc287nVpxvhx4rnpzcTiUZMde6oLocGegmhBsKYvQAApcpOrhTb
	SXwwsnwH7naqas18TF8RTSwe0EceSie5gIKrJvByNbaxcBod2Hz0ziu/aIQc9wrX0qTTNuU
	cUEh9iFGRSU5+bnoCcw4MWw3BXn2n+0JUyb0GNAAmiABeoBm992AHP5uSU+gV/NUS/VSBEC
	LG7BLU3EiK3gzJIkV/8q6klzPcmTeNDpOQ2+mDCmhZrbciJefuOIyBSnI3ccjuCjGgsXfl7
	dvC4NGojZpzaLu9Swoa29okp36Wd4wcvSR7JTg2KwIhYs6Vd0ZgFvRS1lyOiqvF0wzfefcH
	2sncjsLEpRFn9Fg3PzIMcQa9zwWbUgHFVwa5xupAA//U4AU0QS7abRM9u+6CNVPJucWo61V
	xMzD8vcBy3TeyLJ1CFw1veYKTkoUmHie3l4xxoQs31SIkvOaegL9rJrZZ1CLN5oD6NTQ+nX
	pszJKkSr8aSha+oSe+N4MljUGIRlt4tNHGorIHtFBjQQ32EROeEVXi+VGHYJ23r841UGYVk
	uRZtHj7Od3+oHSbLM+uLLvxgsJ5rPE/mC/UQNNxbSrNSbT6xB9I96sa88Hs4tSoewjQ8JQZ
	Vf0iRjlvuc0OVhlIq+eE4inIxWu0dVb28f+ZHvm6M9QnntwRxMVEvU0XBAVpQPapOlVDDXO
	4H9/TuULxU/Kh3R03ZzcLge7aKynn+BB6mrlPOjaeAeBe/Ye+RTwQfHcyej1amLH3FAeFep
	VsWfeuYTviruZWxWNdHNj0aFUK9Q2y0c5RnvR4RwOd2DAS6MsGIyGDqXR5St7f+4/+rxfMd
	SBc7OPzfgobcJ7aUOgUgabc+1u18L1DCeYX8aJ7k+yEfP77y5WtgpHdLO96NQ7RtMW3s=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Commit 8fa7292fee5c ("treewide: Switch/rename to timer_delete[_sync]()")
switched del_timer_sync to timer_delete_sync, but did not modify the
comment for bnad_dim_timeout(). Now fix it.

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


