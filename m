Return-Path: <netdev+bounces-62693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DE828914
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75631C243AC
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8F3A1A8;
	Tue,  9 Jan 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftyRm3zn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5939FFA
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704814460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaNy5QRvkkdunqcUmXIKgQhWD8nhtQEH/Txb6bZEHSU=;
	b=ftyRm3znJlZ46nSjDvkE5wTVkR2nUQ6fn6NkFKl+3JGaO/6/RtIxRMnuCcdsC02fNv78aN
	erCCUJjnkhMNC6A7RnOIowql55A0C+fnb5WMkM4LH9WuPtzLGB9BtsH4/jtjweFy7MTObn
	x92+9ZvalSHc9rrLnR7Cddw/dGKjETk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-5jOFkuYtOWaU-ZDEAaBPjA-1; Tue, 09 Jan 2024 10:34:16 -0500
X-MC-Unique: 5jOFkuYtOWaU-ZDEAaBPjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07AFD185A786;
	Tue,  9 Jan 2024 15:34:16 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E799E492BC7;
	Tue,  9 Jan 2024 15:34:13 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <hadi@cyberus.ca>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 2/2] genl: ctrl.c: spelling fix in error message
Date: Tue,  9 Jan 2024 16:33:54 +0100
Message-ID: <d7b588ec35b3e5a7b4dfb2fdacb54fdbbe903585.1704813773.git.aclaudi@redhat.com>
In-Reply-To: <cover.1704813773.git.aclaudi@redhat.com>
References: <cover.1704813773.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Canot --> Cannot

Fixes: 65018ae43b14 ("This patch adds a generic netlink controller...")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 genl/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index d5b765cc..aff922a4 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -329,7 +329,7 @@ static int ctrl_listen(int argc, char **argv)
 	struct rtnl_handle rth;
 
 	if (rtnl_open_byproto(&rth, nl_mgrp(GENL_ID_CTRL), NETLINK_GENERIC) < 0) {
-		fprintf(stderr, "Canot open generic netlink socket\n");
+		fprintf(stderr, "Cannot open generic netlink socket\n");
 		return -1;
 	}
 
-- 
2.43.0


