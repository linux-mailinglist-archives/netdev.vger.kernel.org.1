Return-Path: <netdev+bounces-165051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B390A30376
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EE188A6C5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661001E9B2C;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVN5nM0t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7811E990A;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254995; cv=none; b=F7BYt4fEsMAKm6eNYP9jPrZdPOagTXcy/QJF65XISqrfKlIUZ2PSwCs1Db14e0Hkyp/zbAguNp9UJEBOjN6dlaK0S/NQYrSgP6zku4+4yGX9TWNWBkfGuCOZWj3qlBursp9SPJGdDj6IrsuirQT32VpCkiMC+pXq98vdRbtmFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254995; c=relaxed/simple;
	bh=mcoeXqisQ9cCp+d9XJhL6+xR7Bjlo3DbBhHTGHu6E1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNLE44K8NbCdjcdNnLt9h15Bz4A1eQ4sKTBxfZRuoYiqHs/nmDFVFNAuFdksYIowhIxiIy6Yu5Z+Uj9g8VNqSlOPEfdTxMBwuG0/qB4Mr7TQTukL/EZfioqkd7TnrsvjoyGH5KuuU64KIBPMc654MJgCh9wEZSXCD9y1gyWtMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVN5nM0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7668C4CEEC;
	Tue, 11 Feb 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254994;
	bh=mcoeXqisQ9cCp+d9XJhL6+xR7Bjlo3DbBhHTGHu6E1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVN5nM0tdhhy/eqByyC8XuNz3jFo4Gp+LWSGqFAzvzn93ltbUAis/axNGLDYhLCLP
	 Nx7PcgBa7tXmIS4bC7MZp+jyAzj79R33cbLDxxsRxQ3KWuN5to3sU8dIuZWajsxuQa
	 pbUfRU1uSbr3tN6Ozl7U8glhoKpLHOKJlCBek50XSwrqR9kB9J9CW4HOEdBAnwgYBX
	 b1CBjgywTTR9/QQC5jzmgyEsksAz6Cs+8sv+My6iwWqUoHxq7/Brd4IH1CE7U52xrx
	 0ggOHmJcmidyCfbWDACfeFpIaCS/DTxEWXjSJhoFIpTa9SgUG1gvEaYrahmrQ5yH2J
	 /8oJzsOXNQaWQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjfs-00000008YBf-3lxF;
	Tue, 11 Feb 2025 07:23:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 7/9] docs: networking: Allow creating cross-references statistics ABI
Date: Tue, 11 Feb 2025 07:23:01 +0100
Message-ID: <a34ab9bef8f4e6b89dcb15098557fd3a7a9aa353.1739254867.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739254867.git.mchehab+huawei@kernel.org>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that Documentation/ABI is processed by automarkup, let it
generate cross-references for the corresponding ABI file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/statistics.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 75e017dfa825..518284e287b0 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -143,7 +143,7 @@ reading multiple stats as it internally performs a full dump of
 and reports only the stat corresponding to the accessed file.
 
 Sysfs files are documented in
-`Documentation/ABI/testing/sysfs-class-net-statistics`.
+Documentation/ABI/testing/sysfs-class-net-statistics.
 
 
 netlink
-- 
2.48.1


