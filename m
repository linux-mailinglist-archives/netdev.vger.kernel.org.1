Return-Path: <netdev+bounces-27938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D577DB64
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093AF1C20DD1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB7C8FA;
	Wed, 16 Aug 2023 07:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FF2CA9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:53:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB964196
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692172420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YOP78zVa0Ukkx/l4UPLqEkG86C+z235K7eiMck3yliI=;
	b=H/bWiQUuNKrpC3nmZojDqNwSX/Whz+vBiLUHX0qLRG6k9FIkinLvwqYFGzXu8Kjh4rxoAK
	uu3IgNd+RNBw4Kwyg3Hh9ojprgGYfjw15+UWI2VzPhfhx5b3YYpZKXWvh2vLkcDOrox2Kn
	yqANHS/7wA/dkz6ugdsj+KKA9JT47RU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-N7mL4eSjNjKCyYI0W5E0TQ-1; Wed, 16 Aug 2023 03:53:37 -0400
X-MC-Unique: N7mL4eSjNjKCyYI0W5E0TQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF298DC672;
	Wed, 16 Aug 2023 07:53:36 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F3863F77;
	Wed, 16 Aug 2023 07:53:35 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] ipv6: fix indentation of a config attribute
Date: Wed, 16 Aug 2023 13:26:06 +0530
Message-ID: <20230816075606.16377-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Prasad Pandit <pjp@fedoraproject.org>

Fix indentation of a type attribute of IPV6_VTI config entry.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 net/ipv6/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 658bfed1df8b..08d4b7132d4c 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -152,7 +152,7 @@ config INET6_TUNNEL
 	default n
 
 config IPV6_VTI
-tristate "Virtual (secure) IPv6: tunneling"
+	tristate "Virtual (secure) IPv6: tunneling"
 	select IPV6_TUNNEL
 	select NET_IP_TUNNEL
 	select XFRM
-- 
2.41.0


