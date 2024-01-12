Return-Path: <netdev+bounces-63201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB182BA8D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 06:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2FD287D26
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 05:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489C5B5B6;
	Fri, 12 Jan 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wYQe1ZSO"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C265B5B3;
	Fri, 12 Jan 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bXyd9tkvnAFckbnApZyeMwYLbnhNyf8xdmLc3fzP10M=; b=wYQe1ZSOVzA1rvF7QojeI3FHal
	neG1WjznwxkrXX3aT8tOJbtwPnFVx3y25fpPQbCZTr/B/PTrsJEWKAxdJd1N2xga8VvJsQvXNP9rZ
	D05M8p3X0qPco0UN1wD7jx5Wp8WJpCWCNK7SN82Sz8Mv/d7lYTgAwmb7J5pt8I66ZVMXGocyRWh71
	Rgl7fIJcgHcJ56JTV60TEzPDjSDogHQwthUJ7xILV2C0Fb1tNf2N6wHXUQv4o5ocJCPAiuAiifm41
	SbTt7LCP4UlywX75+ESnHofWVKnhNdMRf8hGordooTu4k9zFs83ZJUXDQh6OauO8D/qQPk3dTD5qb
	l5+UdX+g==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rO9eX-001tPH-1C;
	Fri, 12 Jan 2024 05:00:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] tipc: socket: remove Excess struct member kernel-doc warning
Date: Thu, 11 Jan 2024 21:00:20 -0800
Message-ID: <20240112050020.27109-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a kernel-doc description to squelch a warning:

socket.c:143: warning: Excess struct member 'blocking_link' description in 'tipc_sock'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 net/tipc/socket.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/net/tipc/socket.c b/net/tipc/socket.c
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -80,7 +80,6 @@ struct sockaddr_pair {
  * @phdr: preformatted message header used when sending messages
  * @cong_links: list of congested links
  * @publications: list of publications for port
- * @blocking_link: address of the congested link we are currently sleeping on
  * @pub_count: total # of publications port has made during its lifetime
  * @conn_timeout: the time we can wait for an unresponded setup request
  * @probe_unacked: probe has not received ack yet

