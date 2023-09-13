Return-Path: <netdev+bounces-33651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9579F0BE
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C468281740
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF61200D8;
	Wed, 13 Sep 2023 17:58:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4905200C3
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 17:58:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66A3619AE
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694627931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEtiwNiM9PzpjRqi6jakAaaVv0eVpRImxmmfOJbw9+M=;
	b=SUdx+cTdg+47HmYDdeHwHc1CD1Sz0j32ZxJeyO5GSMx/9YAGYk8D4PJfWRSWA7pZzpfAr9
	mWwBmefpl4kEjZLpiT134tN8EJ58lkNBT8niiImverB0HaYi0WNgE4H21J6F7xZsac2OJ9
	ZnQedE8zLtTQ9U1PY+1xEOj5fzsY6bU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-NaXQbMMjPkOpPhfNncG2hg-1; Wed, 13 Sep 2023 13:58:47 -0400
X-MC-Unique: NaXQbMMjPkOpPhfNncG2hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 222B681B08C;
	Wed, 13 Sep 2023 17:58:47 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A97740C6EA8;
	Wed, 13 Sep 2023 17:58:44 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 2/2] treewide: use configured value as the default color output
Date: Wed, 13 Sep 2023 19:58:26 +0200
Message-ID: <ccc21b33a1a338bc943ac5d0fb40a5bb7ad5fa43.1694625043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1694625043.git.aclaudi@redhat.com>
References: <cover.1694625043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2

With Makefile providing -DCONF_COLOR, we can use its value as the
default color output.

This effectively allow users and packagers to define a default for the
color output feature without using shell aliases, and with minimum code
impact.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 bridge/bridge.c | 3 ++-
 ip/ip.c         | 2 +-
 tc/tc.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 704be50c..339101a8 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -23,7 +23,6 @@ int preferred_family = AF_UNSPEC;
 int oneline;
 int show_stats;
 int show_details;
-static int color;
 int compress_vlans;
 int json;
 int timestamp;
@@ -103,6 +102,8 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
+	int color = CONF_COLOR;
+
 	while (argc > 1) {
 		const char *opt = argv[1];
 
diff --git a/ip/ip.c b/ip/ip.c
index 8c046ef1..860ff957 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = 0;
+	int color = CONF_COLOR;
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/tc/tc.c b/tc/tc.c
index 25820500..082c6677 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -35,7 +35,6 @@ int use_iec;
 int force;
 bool use_names;
 int json;
-int color;
 int oneline;
 int brief;
 
@@ -254,6 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
+	int color = CONF_COLOR;
 	int ret;
 
 	while (argc > 1) {
-- 
2.41.0


