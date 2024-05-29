Return-Path: <netdev+bounces-99212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54F58D421E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80468285FCC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABE200111;
	Wed, 29 May 2024 23:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AE161307
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717026494; cv=none; b=C4JgfUfdgZLzq5wGLTAKG8sZx2/A7RK0FuOgroouXp5HsrA1DaSXSwaHKHKiLMWvsU054+gmxijptAXEbm9rbClOMy3jPtJaTSBOkYOXS8aldRdQ/F6+NmMeDAZ542PqRpY05UtjwSQo0/IB9tnLjN7RhZhG5WHhy7G3fM4BACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717026494; c=relaxed/simple;
	bh=VPP80Y6bX7mpgJ2reko6KRR6cfiu4C/0yZT1T3uduEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tf7scDui6tTXD+Yu16vttYqaMV7bdbIbGI01jG9IFuYR0KDvv5eCw9yYOckJiQuWV0EfjjvBXghiwL5DqrCqdE0FJg7BOAKQHxOBrvjfCqLn63kwhKDpepvBrKvPIdIYHcadeF6ew17mTB/vRnPhmZvl7kGgUI83jOTgKtYh4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (172.16.235.24) with ESMTP
	id 6657BEAB0000795F; Wed, 30 May 2024 07:47:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 63944445089465
X-SMAIL-UIID: D3A3C44DE0B44A9891E0D3EAE79B62C1-20240530-074757-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	radoslaw.zielonek@gmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com,
	vladimir.oltean@nxp.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Thu, 30 May 2024 07:47:45 +0800
Message-Id: <20240529234745.3023-1-hdanton@sina.com>
In-Reply-To: <000000000000ae4d6e06199fd917@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 16:10:02 -0700
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in sctp_addr_wq_timeout_handler

Feel free to read again the root cause [1] Vlad.

[1] https://lore.kernel.org/lkml/20240528122610.21393-2-radoslaw.zielonek@gmail.com/

Adding the tested patch in the net tree now looks like a case of blind landing.

