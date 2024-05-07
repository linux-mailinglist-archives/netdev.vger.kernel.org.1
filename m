Return-Path: <netdev+bounces-93928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103888BD9BE
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A0B1F2320F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FE2A8DD;
	Tue,  7 May 2024 03:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D14C94;
	Tue,  7 May 2024 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052782; cv=none; b=UdXsZFb3e8dF/BrqTRQHpsc7mYXPVnjvwha9m7ZXC0HHUnpEdtGh0Qw7jPkR87hcY+WK0C1apNdx2CpJQ1QpcVRiZqpBxN3evFD/cGNUHBRt89n5p3I+/Fsg0FvFhYWn6vvosrn2sLtGarmp1A4vSjFUvPVaq7yUUq5MF53tyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052782; c=relaxed/simple;
	bh=7wd/yUfKcL6tjsmswtHH9lv5HGLnvEwVClY4hN6jGIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iU7Mw87T14BXVyCpL4zBzH6eCSFQ/Lql+BhoLepwTGbwwT4gybU1g3he8sOnAheE8E+VHMZOOd1L8r67r1j3ew+ruVjOfntVGrULUOAY5MXe1U7onwQPN8w5FYSncEwquadBBYKXDgOFrJdBkyLS9WeIRGcpJkBGXfwSv9NIdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 77bd87380c2211ef9305a59a3cc225df-20240507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9ce386ab-0914-421d-8764-ed15d5d60748,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:9ce386ab-0914-421d-8764-ed15d5d60748,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:953b18f2e0dff68bcc53e53b1d5fe9c7,BulkI
	D:2405071132467M9YECP2,BulkQuantity:0,Recheck:0,SF:19|44|66|24|17|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,UOG
X-CID-BAS: 1,UOG,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 77bd87380c2211ef9305a59a3cc225df-20240507
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 764133066; Tue, 07 May 2024 11:32:44 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id A4719B8075B2;
	Tue,  7 May 2024 11:32:44 +0800 (CST)
X-ns-mid: postfix-6639A0DC-523906690
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id DBB2FB8075B2;
	Tue,  7 May 2024 03:32:42 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: hdanton@sina.com
Cc: linux-kernel@vger.kernel.org,
	syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	netdev@vger.kernel.org
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
Date: Tue,  7 May 2024 11:32:42 +0800
Message-Id: <20240507033242.1616594-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414025336.2016-1-hdanton@sina.com>
References: <20240414025336.2016-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Indeed, the taprio hrtimer does cause CPU stuck in certain specific scena=
rios,
and this patch indirectly confirms it.

However, it seems this patch isn't the final solution?=20

On my testing machine, after starting Taprio hrtimer and then adjusting t=
he
system time backward, it can be observed that the taprio hrtimer indeed g=
ets stuck
in an infinite loop through tracing. And, the patch below can effectively=
 resolve
this issue, but it doesn't work for syzbot's tests.

https://lore.kernel.org/all/20240506023617.1309937-1-luyun@kylinos.cn/

Are there any better suggestions from others regarding the resolution of =
this CPU stuck issue?


