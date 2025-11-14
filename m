Return-Path: <netdev+bounces-238730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D1C5E727
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D270D388D7E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DC2C21FE;
	Fri, 14 Nov 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="QBQjoEYw"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3812C15A3
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139350; cv=none; b=RLzikKs0PcQycJNjcUcPc4knGkZvk5tWLQQ11qEPKXGpNO8GRbWeEMouyjY6lAYOT48e+uaFZm+O63EY+2ohd2J7Y9BNUgVQ/eaIWAI0JljowvLLC8y7IjTwNeSQyMz3qPVg2mC2AxE5jbs8q/l+QrqTgXblPj44ntaCfkU9ocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139350; c=relaxed/simple;
	bh=0NpKQbRnEq6Ge72Q1npDXwt6avqaNS3pmhXp3LTOsvk=;
	h=Date:Message-Id:To:Subject:From:Mime-Version:Content-Type; b=qLKdgBCmuftz5H0398QOgTtFQXmHTY+JDpXaJ/S0uvOP3txn17heZ8rGLhnZlEuVip8tTKJh1PI6dQzr9GvgYJLGY+76+qeG4EHJ+ooCGgDv7Qq2RK1PQwDq+g1S+25O4I5EQ8HG/XGsOTxTVvN6Oz89NpMPNhMoh5doOjdjmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=QBQjoEYw; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:
	Message-Id:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=zOFvCXLKtANp7HnUMV9wvcD5WtzEt+e0awruKuGK5gk=; b=Q
	BQjoEYwNxxK0aLJ/r0IFJdRdD1ley+B1PclSPTRZRRBFpdgynE7gpi1rXC0ybJaJkVkXlHOe26cCg
	pG38ve8s8CYG5XMjQ9HLLIgDQrG/a8KLZ3dq4aIGyUmp6bvsG6V3rEI+FKeVdAPNuCfSiqF5MMMqd
	4yqXOmRSuG72eJouXia+7sU9nnRfZcgZkVop6Y/chQbmrp7BGc4+vB7xFgZADOHGboCnwNxa4Pjbj
	PFmSAchqeIdsKGP5jYCUVUeN8EimvTF/gI3+eIIB+jTUq+Rem1EPIAZtos9K445khdY+53kZ6oWnR
	gYbXcvsov0uoYv8MHzS4Jz2fLvKdyo1/A==;
Date: Fri, 14 Nov 2025 17:55:43 +0100 (CET)
Message-Id: <20251114.175543.1553030512147056405.rene@exactco.de>
To: netdev@vger.kernel.org
Subject: [PATCH] fix 3com/3c515 build error
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

3c515 stopped building for me some months ago, fix:

drivers/net/ethernet/3com/3c515.o: error: objtool: cleanup_module(): Magic init_module() function name is deprecated, use module_init(fn) instead
make[6]: *** [scripts/Makefile.build:203: drivers/net/ethernet/3com/3c515.o] Error 255

Signed-off-by: René Rebe <rene@exactco.de>

--- a/drivers/net/ethernet/3com/3c515.c	2025-05-26 19:16:50.055582886 +0200
+++ b/drivers/net/ethernet/3com/3c515.c	2025-05-26 19:27:45.400746652 +0200
@@ -1549,7 +1549,7 @@
 
 
 #ifdef MODULE
-void cleanup_module(void)
+static void corkscrew_cleanup_module(void)
 {
 	while (!list_empty(&root_corkscrew_dev)) {
 		struct net_device *dev;
@@ -1563,4 +1563,5 @@
 		free_netdev(dev);
 	}
 }
+module_exit(corkscrew_cleanup_module);
 #endif				/* MODULE */

-- 
  René Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactco.de | https://t2linux.com | https://rene.rebe.de

