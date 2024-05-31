Return-Path: <netdev+bounces-99838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC78D6AA2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2CB1F25845
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66F8061C;
	Fri, 31 May 2024 20:25:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFF1946F
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187110; cv=none; b=ZUiFzobNLVzPl6r+lzw4ttbsZN3U0gH49uDmHXJd91ocClyEOY/gHVNtt80gI6dVXqorjGXSOdez6Zk0LsW28ey3tfLNFSlgK3JxRi7N0szmEGC7X8jHxaKxCHobPZ3xjN0UU1SJg1R58YTRWYD257sTIuCDh/ZrVGY8NtnuN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187110; c=relaxed/simple;
	bh=bX1R9Y8f00vg6zNkRRxi11iyvyGXN3vFDQvhmQA51/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hF7lBShEgb63icUK/nWKco4mcS2QZN+0OVptXOD3t/oPb2jjAcFpS/KtZA35S6ZDckzxyjeTmm/wHmMGY4ptQxRwpieV8PM6rVcOkguICCj+9NJZKjcm3b/AyF7z5Mkyy2GDwb4STp9cNWzj3JAJz5NitZBu4Sh+j06q0mtejP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.229])
	by sina.com (10.75.12.45) with ESMTP
	id 665A31F300005F8B; Fri, 1 Jun 2024 04:24:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46481731457697
X-SMAIL-UIID: 874F51BDEF4D472D88C2D72B16F568BB-20240601-042422-1
From: Hillf Danton <hdanton@sina.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	radoslaw.zielonek@gmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Sat,  1 Jun 2024 04:24:10 +0800
Message-Id: <20240531202410.3390-1-hdanton@sina.com>
In-Reply-To: <20240530003325.h35jkwdm7mifcnc2@skbuf>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 May 2024 03:33:25 +0300 Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> What is the fact that you submitted only my patch 1/2 for syzbot testing
> supposed to prove? It is the second patch (2/2) that addresses what has
> been reported here;

They worked [1]. Sorry for my messup.

[1] https://lore.kernel.org/lkml/0000000000006055ba0619c3dd8f@google.com/

