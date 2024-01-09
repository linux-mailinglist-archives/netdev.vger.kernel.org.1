Return-Path: <netdev+bounces-62699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA46828A0C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517B61F25B87
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51618364AB;
	Tue,  9 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5Pdp5c9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF03A8C4
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704817974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yS60jaIwtaEMzW/bOr4wioo6IojUjVR1L2Gi3XnL+w=;
	b=H5Pdp5c9TZfIXFZfOqDs5VgWVIaHR3B1qXVmgHO9kn3vAJAPQu0x0BvVAHqqV56woOCt67
	Dj1B25q6m2pcoj0Q9zrdAYXVpuD9zPioqr78uDOIoHCAXnwJDlK4pQpLfSkqh0xOuiiqst
	aGoZptiWVXZrFxUWaj7SKw/oolkLIcs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-VJls2hCzMsGFWEclN1xCUA-1; Tue,
 09 Jan 2024 11:32:53 -0500
X-MC-Unique: VJls2hCzMsGFWEclN1xCUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 266431C0BB45;
	Tue,  9 Jan 2024 16:32:53 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF471C060AF;
	Tue,  9 Jan 2024 16:32:51 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jon Maloy <jmaloy@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 1/2] docs, man: fix some typos
Date: Tue,  9 Jan 2024 17:32:34 +0100
Message-ID: <cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
In-Reply-To: <cover.1704816744.git.aclaudi@redhat.com>
References: <cover.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Fix some typos and spelling errors in iproute2 documentation.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 doc/actions/actions-general | 2 +-
 examples/bpf/README         | 2 +-
 man/man8/devlink-rate.8     | 2 +-
 tipc/README                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/actions/actions-general b/doc/actions/actions-general
index a0074a58..41c74d38 100644
--- a/doc/actions/actions-general
+++ b/doc/actions/actions-general
@@ -116,7 +116,7 @@ The script below does the following:
 - If it does exceed its rate, its "color" changes to a mark of 2 and it is
 then passed through a second meter.
 
--The second meter is shared across all flows on that device [i am surpised
+-The second meter is shared across all flows on that device [i am surprised
 that this seems to be not a well know feature of the policer; Bert was telling
 me that someone was writing a qdisc just to do sharing across multiple devices;
 it must be the summer heat again; weve had someone doing that every year around
diff --git a/examples/bpf/README b/examples/bpf/README
index b7261191..4c27bb4e 100644
--- a/examples/bpf/README
+++ b/examples/bpf/README
@@ -15,4 +15,4 @@ with syntax and features:
 
 Note: Users should use new BTF way to defined the maps, the examples
 in legacy folder which is using struct bpf_elf_map defined maps is not
-recommanded.
+recommended.
diff --git a/man/man8/devlink-rate.8 b/man/man8/devlink-rate.8
index bcec3c31..f09ac4ac 100644
--- a/man/man8/devlink-rate.8
+++ b/man/man8/devlink-rate.8
@@ -149,7 +149,7 @@ These parameter accept integer meaning weight or priority of a node.
 - set rate object parent to existing node with name \fINODE_NAME\fR or unset
 parent. Rate limits of the parent node applied to all it's children. Actual
 behaviour is details of driver's implementation. Setting parent to empty ("")
-name due to the kernel logic threated as parent unset.
+name due to the kernel logic treated as parent unset.
 
 .SS devlink port function rate add - create node rate object with specified parameters.
 Creates rate object of type node and sets parameters. Parameters same as for the
diff --git a/tipc/README b/tipc/README
index 578a0b7b..fbeb4345 100644
--- a/tipc/README
+++ b/tipc/README
@@ -16,7 +16,7 @@ bare words specially.
 Help texts are not dynamically generated. That is, we do not pass datastructures
 like command list or option lists and print them dynamically. This is
 intentional. There is always that exception and when it comes to help texts
-these exceptions are normally neglected at the expence of usability.
+these exceptions are normally neglected at the expense of usability.
 
 KEY-VALUE
 ~~~~~~~~~
-- 
2.43.0


