Return-Path: <netdev+bounces-19172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D962D759E14
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083341C21189
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EC1FB3E;
	Wed, 19 Jul 2023 19:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9A1BB5F
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 12:00:00 PDT
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00AA1734
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 931F8D8FFA;
	Wed, 19 Jul 2023 20:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792736; bh=8BpDe0wvMiuaogemH+4PtrQkNxU5JnHHedFJIejbJ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7fvLZJyPJRnV3rzJYP1REeOMnT/Kf6c0mfrefaJ8pXHP8H6WpR/zIwcEqs1dJgYD
	 Bi/8yU5Eavdc34l0ju2OtSQt7XvMOQPbk14Rgo5i5F8L1HhUw7uowNqfaOaorgSMVw
	 cN/Uvsn4Qe+e1FX4DIhyk/y4I16DXHB6l7XnYN1Lj2QPGFYnITr3Le6qonz3Rw9j1/
	 Eilg+AMytLpM+VybjS/F2kJ9ZVkUol3C0xgffZbBB/LjSlWSfHr072tY0Lk69shzBR
	 WWiYYmhlk2G3n4HkKXEmGHFY0qMY08CY4VlEh+TdVwMuFq7q7UMILYPiveX5mm3yqO
	 LwpzslPHEys2A==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 01/22] Makefile: Rename CONFDIR to CONF_ETC_DIR
Date: Wed, 19 Jul 2023 20:50:45 +0200
Message-Id: <20230719185106.17614-2-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 Makefile                 |  8 ++++----
 include/utils.h          |  4 ++--
 lib/bpf_legacy.c         |  2 +-
 lib/rt_names.c           | 28 ++++++++++++++--------------
 man/man8/Makefile        |  2 +-
 man/man8/ip-address.8.in |  2 +-
 man/man8/ip-link.8.in    |  4 ++--
 man/man8/ip-route.8.in   | 18 +++++++++---------
 8 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/Makefile b/Makefile
index 8a17d614..54e5cde2 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,7 @@ endif
 
 PREFIX?=/usr
 SBINDIR?=/sbin
-CONFDIR?=/etc/iproute2
+CONF_ETC_DIR?=/etc/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
@@ -37,7 +37,7 @@ ifneq ($(SHARED_LIBS),y)
 DEFINES+= -DNO_SHARED_LIBS
 endif
 
-DEFINES+=-DCONFDIR=\"$(CONFDIR)\" \
+DEFINES+=-DCONF_ETC_DIR=\"$(CONF_ETC_DIR)\" \
          -DNETNS_RUN_DIR=\"$(NETNS_RUN_DIR)\" \
          -DNETNS_ETC_DIR=\"$(NETNS_ETC_DIR)\"
 
@@ -100,11 +100,11 @@ config.mk:
 
 install: all
 	install -m 0755 -d $(DESTDIR)$(SBINDIR)
-	install -m 0755 -d $(DESTDIR)$(CONFDIR)
+	install -m 0755 -d $(DESTDIR)$(CONF_ETC_DIR)
 	install -m 0755 -d $(DESTDIR)$(ARPDDIR)
 	install -m 0755 -d $(DESTDIR)$(HDRDIR)
 	@for i in $(SUBDIRS);  do $(MAKE) -C $$i install; done
-	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONFDIR)
+	install -m 0644 $(shell find etc/iproute2 -maxdepth 1 -type f) $(DESTDIR)$(CONF_ETC_DIR)
 	install -m 0755 -d $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/tc $(DESTDIR)$(BASH_COMPDIR)
 	install -m 0644 bash-completion/devlink $(DESTDIR)$(BASH_COMPDIR)
diff --git a/include/utils.h b/include/utils.h
index 0b5d86a2..d3bf49bf 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -38,8 +38,8 @@ extern int numeric;
 extern bool do_all;
 extern int echo_request;
 
-#ifndef CONFDIR
-#define CONFDIR		"/etc/iproute2"
+#ifndef CONF_ETC_DIR
+#define CONF_ETC_DIR "/etc/iproute2"
 #endif
 
 #define SPRINT_BSIZE 64
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 8ac64235..706820f5 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -2924,7 +2924,7 @@ static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
 	}
 
 	bpf_save_finfo(ctx);
-	bpf_hash_init(ctx, CONFDIR "/bpf_pinning");
+	bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
 
 	return 0;
 out_free:
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 68db74e3..0407b361 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -153,10 +153,10 @@ static void rtnl_rtprot_initialize(void)
 	DIR *d;
 
 	rtnl_rtprot_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_protos",
+	rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
 			    rtnl_rtprot_tab, 256);
 
-	d = opendir(CONFDIR "/rt_protos.d");
+	d = opendir(CONF_ETC_DIR "/rt_protos.d");
 	if (!d)
 		return;
 
@@ -174,7 +174,7 @@ static void rtnl_rtprot_initialize(void)
 		if (strcmp(de->d_name + len - 5, ".conf"))
 			continue;
 
-		snprintf(path, sizeof(path), CONFDIR "/rt_protos.d/%s",
+		snprintf(path, sizeof(path), CONF_ETC_DIR "/rt_protos.d/%s",
 			 de->d_name);
 		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
 	}
@@ -240,7 +240,7 @@ static bool rtnl_addrprot_tab_initialized;
 
 static void rtnl_addrprot_initialize(void)
 {
-	rtnl_tab_initialize(CONFDIR "/rt_addrprotos",
+	rtnl_tab_initialize(CONF_ETC_DIR "/rt_addrprotos",
 			    rtnl_addrprot_tab,
 			    ARRAY_SIZE(rtnl_addrprot_tab));
 	rtnl_addrprot_tab_initialized = true;
@@ -297,7 +297,7 @@ static int rtnl_rtscope_init;
 static void rtnl_rtscope_initialize(void)
 {
 	rtnl_rtscope_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_scopes",
+	rtnl_tab_initialize(CONF_ETC_DIR "/rt_scopes",
 			    rtnl_rtscope_tab, 256);
 }
 
@@ -362,7 +362,7 @@ static int rtnl_rtrealm_init;
 static void rtnl_rtrealm_initialize(void)
 {
 	rtnl_rtrealm_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_realms",
+	rtnl_tab_initialize(CONF_ETC_DIR "/rt_realms",
 			    rtnl_rtrealm_tab, 256);
 }
 
@@ -439,10 +439,10 @@ static void rtnl_rttable_initialize(void)
 		if (rtnl_rttable_hash[i])
 			rtnl_rttable_hash[i]->id = i;
 	}
-	rtnl_hash_initialize(CONFDIR "/rt_tables",
+	rtnl_hash_initialize(CONF_ETC_DIR "/rt_tables",
 			     rtnl_rttable_hash, 256);
 
-	d = opendir(CONFDIR "/rt_tables.d");
+	d = opendir(CONF_ETC_DIR "/rt_tables.d");
 	if (!d)
 		return;
 
@@ -461,7 +461,7 @@ static void rtnl_rttable_initialize(void)
 			continue;
 
 		snprintf(path, sizeof(path),
-			 CONFDIR "/rt_tables.d/%s", de->d_name);
+			 CONF_ETC_DIR "/rt_tables.d/%s", de->d_name);
 		rtnl_hash_initialize(path, rtnl_rttable_hash, 256);
 	}
 	closedir(d);
@@ -527,7 +527,7 @@ static int rtnl_rtdsfield_init;
 static void rtnl_rtdsfield_initialize(void)
 {
 	rtnl_rtdsfield_init = 1;
-	rtnl_tab_initialize(CONFDIR "/rt_dsfield",
+	rtnl_tab_initialize(CONF_ETC_DIR "/rt_dsfield",
 			    rtnl_rtdsfield_tab, 256);
 }
 
@@ -606,7 +606,7 @@ static int rtnl_group_init;
 static void rtnl_group_initialize(void)
 {
 	rtnl_group_init = 1;
-	rtnl_hash_initialize(CONFDIR "/group",
+	rtnl_hash_initialize(CONF_ETC_DIR "/group",
 			     rtnl_group_hash, 256);
 }
 
@@ -696,7 +696,7 @@ static int nl_proto_init;
 static void nl_proto_initialize(void)
 {
 	nl_proto_init = 1;
-	rtnl_tab_initialize(CONFDIR "/nl_protos",
+	rtnl_tab_initialize(CONF_ETC_DIR "/nl_protos",
 			    nl_proto_tab, 256);
 }
 
@@ -762,7 +762,7 @@ static void protodown_reason_initialize(void)
 
 	protodown_reason_init = 1;
 
-	d = opendir(CONFDIR "/protodown_reasons.d");
+	d = opendir(CONF_ETC_DIR "/protodown_reasons.d");
 	if (!d)
 		return;
 
@@ -780,7 +780,7 @@ static void protodown_reason_initialize(void)
 		if (strcmp(de->d_name + len - 5, ".conf"))
 			continue;
 
-		snprintf(path, sizeof(path), CONFDIR "/protodown_reasons.d/%s",
+		snprintf(path, sizeof(path), CONF_ETC_DIR "/protodown_reasons.d/%s",
 			 de->d_name);
 		rtnl_tab_initialize(path, protodown_reason_tab,
 				    PROTODOWN_REASON_NUM_BITS);
diff --git a/man/man8/Makefile b/man/man8/Makefile
index b1fd87bd..ae5e37a5 100644
--- a/man/man8/Makefile
+++ b/man/man8/Makefile
@@ -9,7 +9,7 @@ all: $(TARGETS)
 	sed \
 		-e "s|@NETNS_ETC_DIR@|$(NETNS_ETC_DIR)|g" \
 		-e "s|@NETNS_RUN_DIR@|$(NETNS_RUN_DIR)|g" \
-		-e "s|@SYSCONFDIR@|$(CONFDIR)|g" \
+		-e "s|@SYSCONF_ETC_DIR@|$(CONF_ETC_DIR)|g" \
 		$< > $@
 
 distclean: clean
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index abdd6a20..a2df22d4 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -209,7 +209,7 @@ The maximum allowed total length of label is 15 characters.
 .BI scope " SCOPE_VALUE"
 the scope of the area where this address is valid.
 The available scopes are listed in file
-.BR "@SYSCONFDIR@/rt_scopes" .
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" .
 Predefined scope values are:
 
 .in +8
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 6a82ddc4..ac1a3b5f 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2251,7 +2251,7 @@ give the device a symbolic name for easy reference.
 .BI group " GROUP"
 specify the group the device belongs to.
 The available groups are listed in file
-.BR "@SYSCONFDIR@/group" .
+.BR "@SYSCONF_ETC_DIR@/group" .
 
 .TP
 .BI vf " NUM"
@@ -2852,7 +2852,7 @@ specifies which help of link type to display.
 .SS
 .I GROUP
 may be a number or a string from the file
-.B @SYSCONFDIR@/group
+.B @SYSCONF_ETC_DIR@/group
 which can be manually filled.
 
 .SH "EXAMPLES"
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index c2b00833..9fc3f4a1 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -357,7 +357,7 @@ normal routing tables.
 .B Route tables:
 Linux-2.x can pack routes into several routing tables identified
 by a number in the range from 1 to 2^32-1 or by name from the file
-.B @SYSCONFDIR@/rt_tables
+.B @SYSCONF_ETC_DIR@/rt_tables
 By default all normal routes are inserted into the
 .B main
 table (ID 254) and the kernel only uses this table when calculating routes.
@@ -420,7 +420,7 @@ may still match a route with a zero TOS.
 .I TOS
 is either an 8 bit hexadecimal number or an identifier
 from
-.BR "@SYSCONFDIR@/rt_dsfield" .
+.BR "@SYSCONF_ETC_DIR@/rt_dsfield" .
 
 .TP
 .BI metric " NUMBER"
@@ -435,7 +435,7 @@ is an arbitrary 32bit number, where routes with lower values are preferred.
 the table to add this route to.
 .I TABLEID
 may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+.BR "@SYSCONF_ETC_DIR@/rt_tables" .
 If this parameter is omitted,
 .B ip
 assumes the
@@ -476,7 +476,7 @@ covered by the route prefix.
 the realm to which this route is assigned.
 .I REALMID
 may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_realms" .
+.BR "@SYSCONF_ETC_DIR@/rt_realms" .
 
 .TP
 .BI mtu " MTU"
@@ -627,7 +627,7 @@ command.
 the scope of the destinations covered by the route prefix.
 .I SCOPE_VAL
 may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_scopes" .
+.BR "@SYSCONF_ETC_DIR@/rt_scopes" .
 If this parameter is omitted,
 .B ip
 assumes scope
@@ -647,7 +647,7 @@ routes.
 the routing protocol identifier of this route.
 .I RTPROTO
 may be a number or a string from the file
-.BR "@SYSCONFDIR@/rt_protos" .
+.BR "@SYSCONF_ETC_DIR@/rt_protos" .
 If the routing protocol ID is not given,
 .B ip assumes protocol
 .B boot
@@ -880,7 +880,7 @@ matching packets are dropped.
 specified lookup table.
 .I TABLEID
 is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+.BR "@SYSCONF_ETC_DIR@/rt_tables" .
 If
 .B vrftable
 is used, the argument must be a VRF device associated with
@@ -896,7 +896,7 @@ and an inner IPv6 packet. Other matching packets are dropped.
 specified lookup table.
 .I TABLEID
 is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+.BR "@SYSCONF_ETC_DIR@/rt_tables" .
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
@@ -909,7 +909,7 @@ at all, and an inner IPv4 packet. Other matching packets are dropped.
 to the specified lookup table.
 .I TABLEID
 is either a number or a string from the file
-.BR "@SYSCONFDIR@/rt_tables" .
+.BR "@SYSCONF_ETC_DIR@/rt_tables" .
 The argument must be a VRF device associated with the table id.
 Moreover, the VRF table associated with the table id must be configured
 with the VRF strict mode turned on (net.vrf.strict_mode=1). This action
-- 
2.39.2


