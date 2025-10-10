Return-Path: <netdev+bounces-228468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F359BCB8E8
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 05:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B54F9A49
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79F265CD0;
	Fri, 10 Oct 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="wvMlekmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8D49620
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067249; cv=none; b=i1QL3zXorpZdWoR8dLkxK5zEUf/0FjWR5gTmaWgYj4qqYtDOOu3ef1r/DATG/wJUeE/3myBZ75yXXPbR7RY7klygGI257EGENBy9yWf18F/RMadrGpE4vPDY51zRSJnKKa1jDdZq7PdId+XtV1GFq2rUZ/LKoXwN+VpprlOXXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067249; c=relaxed/simple;
	bh=8Ecs8UZeH+b4SFAAI+6b36v7Q78syLPFPq0fwyqiMLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNv/EdSJ/L9mUj1pilqK6HjqMWH3zMxRue/a2oM0OG4KehCFu8Zw0NKZeiC9RvGAl0jFwokcRxlhgw2cFcxlEFksabYHqiW6+NVzUCWJ5iZFDR58waca2zGT28jBZfpE2Zro2P1xAvhAuxhyscv6PULm5WEdFVSi1Elmfj59Z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=wvMlekmJ; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760067241;
	bh=EOWtoEy/CENb7q7Vmbx0hb+czVRDYnfp98ILfotb5W0=;
	h=From:Subject:Date:Message-ID;
	b=wvMlekmJ0eecn1k8uXiGbo6NmJhSAs99n6yl4YPHG2jqECw9w5quVq6x1xGN6VLHN
	 OUIt+ySGqEytQMYY+2S18w7+DTZHXjH4NJ8uQOkdsA+0tNShHseXD1qZ5hO4Xi03f9
	 qFVKrqy4AQUykyXuusvEEcYfZwRyQGyEF0NQ40HY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68E87E7E00005A32; Fri, 10 Oct 2025 11:33:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4028846816270
X-SMAIL-UIID: 73ADCBB3595B4B0BA3BBAF15F56B7D5C-20251010-113322-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid context in __set_page_owner
Date: Fri, 10 Oct 2025 11:33:02 +0800
Message-ID: <20251010033310.8501-1-hdanton@sina.com>
In-Reply-To: <68e7e6e3.050a0220.1186a4.0001.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 09 Oct 2025 09:46:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174a4b34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
> dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e0dcd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1581452f980000

Test Alexei's fix.

#syz test

--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -168,6 +168,9 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	unsigned long flags;
 	struct stack *stack;
 
+	if (!gfpflags_allow_spinning(gfp_mask))
+		return;
+
 	set_current_in_page_owner();
 	stack = kmalloc(sizeof(*stack), gfp_nested_mask(gfp_mask));
 	if (!stack) {
--

