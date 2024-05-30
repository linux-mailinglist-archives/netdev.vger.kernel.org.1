Return-Path: <netdev+bounces-99360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76D8D49BD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E481F24091
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46004176AD8;
	Thu, 30 May 2024 10:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E6183965
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065338; cv=none; b=AIlHN0ejEFQyF8zRY8PmZKWtqAdSSRNiQCOcnVTxFXWG+PEyZLZtiikBo7EbaNvtCx+PdCcnfSSsX+leMs64hSTXSRwymPcotPyv1ELUVjG2HMtaPokdJkI3xyncBHjbsCmQn7SPbqgjyRg5Q/6loStDWfr2zhNzEAEGaqM4eEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065338; c=relaxed/simple;
	bh=FiR3ojO/QBJpeG8z5eu829M5OJ7putiXt4e2LkYJcnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7VVaxj8zKjFC1NxLa1kwM9wvLo7k9EqQyMp1ogi1aAzE9aOWGV4E914QtAgSdzrGmksRCFx8u5/SM48rzIE0lS4NSrbFxAtJEbMuc6zmArDDKz4mWbkzml+BnkzNWtwNZTmmnTySPtNljhlWsPD2eBPWgUrd5xhJlBs1weCDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (10.185.250.21) with ESMTP
	id 6658564400002BD7; Thu, 30 May 2024 18:34:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8654903408262
X-SMAIL-UIID: 6E961D22B36B45DB8351F8958C627EC6-20240530-183446-1
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
Date: Thu, 30 May 2024 18:34:35 +0800
Message-Id: <20240530103435.3077-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  main

