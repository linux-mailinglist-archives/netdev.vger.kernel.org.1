Return-Path: <netdev+bounces-80561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3E87FCC2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83B41C22636
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F77E792;
	Tue, 19 Mar 2024 11:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF17CF03;
	Tue, 19 Mar 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847526; cv=none; b=sTG1Qk0ag1SqgS/8HbawA8UIip650P6CKD0/G6c0JYzxrw8ClzRwp+CagjURt+jmg6SOGaKhszPnqxgCq52cYslDXXaLeqV8ukyTBCeEuYEDoqohGALkJF23RC/BTMvLVgEBdYtfDVeJ5QZBjogMIU2HZVzprex6vipOeVJUHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847526; c=relaxed/simple;
	bh=8ulJ8+weqBSerN9tC3VoDoHcMsRlBraSpYHrb1Vcvwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEKnjQvJqU1Yaa+XsNmO947181cL7dysgnc25zy0jbqoQkcwm34C78OFD0+PraoapNGaZNzQV+fnVkDACsDVJnNFhQVl4CnTqeiODgYWm3YzSBZvqFyjACzubokDcMZiywl6L5D/KVrMgFNCMpGvfXgEs5thCNkQuGchJs8Zd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rmXas-0005GJ-8Z; Tue, 19 Mar 2024 12:25:22 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: <netfilter-devel@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] MAINTAINERS: step down as netfilter maintainer
Date: Tue, 19 Mar 2024 13:11:54 +0100
Message-ID: <20240319121223.24474-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I do not feel that I'm up to the task anymore.

I hope this to be a temporary emergeny measure, but for now I'm sure this
is the best course of action for me.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54775eaaf7b3..24b4f59d3ceb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15164,7 +15164,6 @@ F:	drivers/net/ethernet/neterion/
 NETFILTER
 M:	Pablo Neira Ayuso <pablo@netfilter.org>
 M:	Jozsef Kadlecsik <kadlec@netfilter.org>
-M:	Florian Westphal <fw@strlen.de>
 L:	netfilter-devel@vger.kernel.org
 L:	coreteam@netfilter.org
 S:	Maintained
-- 
2.43.2


