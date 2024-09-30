Return-Path: <netdev+bounces-130305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9198A064
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCBD1C2279F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE9192B7A;
	Mon, 30 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="s06oSpFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5A191F8D;
	Mon, 30 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695311; cv=none; b=DvBhEY8XDmSq12GngvebVc087qFtJJHdl3h3bmk0nYU0D6X+qg0bRjFQbhFqfykj3BlaTE5x5vH6URLV55khNZkZgbiRnUiKO817OxHjDralaGAOb/66oAnV11IUnTjPKyyJpMCcK1oqfxx076ofhJGty7Um19TPnmNSxY2RB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695311; c=relaxed/simple;
	bh=PgwIMygjWOyNNQQhqkAx39w3297DqiDCBEhTHKUEBpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9sq9N9TiyAqsQs8aGzmAGm27PCY5xta4T8d1d/K/v9s9jm/JrFpvm43SanYyQ6IabiKbvJhcmDWHdaJ5F9EfeEvG1bgjcvTbh8JxUnD+fEkjYliUrlOqQGc/NH5v6XnPtyZ5BlXJkRFBHBZk6suRNk8nTSL2FyfrSXbkO8GBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=s06oSpFg; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiAMZdHfzRRadEJUpeFbdHkU5NVv6AAREPGmWLFa9N8=;
  b=s06oSpFgNGj4vEEvBslzvjOKYQsmgjcckUHnAXT0NQdiYMYLFkYqyLKf
   GIj0BnZ4kI2kL8qj2nuqgVAZUbMdVmTG0ceim4mOrZKYqF/Dvm+x+n11e
   /1Y0OhDC2c3e2uNvX0jyHlKwa1N6HD6/W9OfIhrQDKI1XoM8vqiZNT4SE
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956887"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/35] net: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:02 +0200
Message-Id: <20240930112121.95324-17-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 601ad74930ef..f4ac3939fbb0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -235,8 +235,8 @@ static const struct net_proto_family __rcu *net_families[NPROTO] __read_mostly;
 /**
  *	move_addr_to_kernel	-	copy a socket address into kernel space
  *	@uaddr: Address in user space
- *	@kaddr: Address in kernel space
  *	@ulen: Length in user space
+ *	@kaddr: Address in kernel space
  *
  *	The address is copied into kernel space. If the provided address is
  *	too long an error code of -EINVAL is returned. If the copy gives


