Return-Path: <netdev+bounces-62440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751CD827486
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B41C22EC4
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049451032;
	Mon,  8 Jan 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDvgLGVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BA51C2F
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ed1ca402so17175125ad.2
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704729289; x=1705334089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E4079ibVinIdGps59KvFdwr6rMljC3CIAqrs9YlyJ8=;
        b=LDvgLGVZ8Gbb2OWLXN+sYZQ3Mto26Doy3Fgge9VN93o9LEr/5J2ykecnuJCOht1LS4
         DMwEcfSLxjLoHblr6K/6WvsiqvPuqsnsv3zzqAaMFfRbaTu+EnwgbESagYVHtVle6TvD
         FXa8otRKobvLeEkUx98jNkcgxFjiTGvdDjB6yHnxxuui3HvAVqUN3cfMoKwI8KtOXo2n
         7eAYhSAGlxRsp233NkLRPiPKhWsFTPdwTidg12ViU7VnEm4MYB667DWfxxfIzWYFK2ln
         Zrq3y8l+5QfjqPZETAXHj98hSXYR15745LPZsJlzbcg/LNkB5vNT0l23lNu8NtZRDw8g
         e5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704729289; x=1705334089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E4079ibVinIdGps59KvFdwr6rMljC3CIAqrs9YlyJ8=;
        b=LsgngEbwQKJVVnxWw/XzfOi80iap1tj+gsGWYsfSFJQi1gm/1QDl1LzjtI2LKGMt7p
         rIZfsxpT0tmy0097qjprauJGwHqr7emGwg7+Igz5zllFH1/IlQqcclqR0v9acInrFRLH
         pWotjMnxz+Wb749p1pAkNvzNJEWeFtmBjjoHiyltLkmWKtIvhgnzNzNmgugG5cVNfJgq
         sA/nuBG/pX4UcvjZz/FN5zFfmtqiatrjNqRTRdsn1lNqLCJV2A4PpU1euK94F9uiooc7
         1M3QhKJ58IpIdv7oMAVpj4JD2x1TC1hJidmYHE4+BT4qwn+YYYuMuKVv2D61+XtKugR9
         Lz7w==
X-Gm-Message-State: AOJu0YzNSIvBpmvHVdaRiSqt/uJDhqOLrvlXVx2Nnir0rApEe45oiCtv
	hO7Tkshz5L8EZ1kiYxXEm1aGlRKPVpE=
X-Google-Smtp-Source: AGHT+IHCTWvl+pvZoooSwDicCrTkXjuEwcqU1KjJqjhrAdQnoIAt+v5o9N5LdIN8fn1qhDkBqzOfxw==
X-Received: by 2002:a17:902:d2cb:b0:1d4:7e51:ff73 with SMTP id n11-20020a170902d2cb00b001d47e51ff73mr5385646plc.106.1704729289123;
        Mon, 08 Jan 2024 07:54:49 -0800 (PST)
Received: from xavier.lan ([2607:fa18:9ffd:1:982:276b:1538:60b5])
        by smtp.gmail.com with ESMTPSA id p20-20020a170903249400b001d4593a2e8fsm68194plw.83.2024.01.08.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:54:48 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	dan@danm.net,
	bagasdotme@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jikos@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next] net: ipv6/addrconf: make regen_advance independent of retrans time
Date: Mon,  8 Jan 2024 08:53:36 -0700
Message-ID: <20240108155347.156525-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RFC 4941, REGEN_ADVANCE is a constant value of 5 seconds, and the RFC
does not permit the creation of temporary addresses with lifetimes
shorter than that:

> When processing a Router Advertisement with a Prefix
> Information option carrying a global scope prefix for the purposes of
> address autoconfiguration (i.e., the A bit is set), the node MUST
> perform the following steps:

> 5.  A temporary address is created only if this calculated Preferred
>     Lifetime is greater than REGEN_ADVANCE time units.

Moreover, using a non-constant regen_advance has undesirable side
effects. If regen_advance swelled above temp_prefered_lft,
ipv6_create_tempaddr would error out without creating any new address.
On my machine and network, this error happened immediately with the
preferred lifetime set to 1 second, after a few minutes with the
preferred lifetime set to 4 seconds, and not at all with the preferred
lifetime set to 5 seconds. During my investigation, I found a Stack
Exchange post from another person who seems to have had the same
problem: They stopped getting new addresses if they lowered the
preferred lifetime below 3 seconds, and they didn't really know why.

Some users want to change their IPv6 address as frequently as possible
regardless of the RFC's arbitrary minimum lifetime. For the benefit of
those users, add a regen_advance sysctl parameter that can be set to
below or above 5 seconds.

Link: https://datatracker.ietf.org/doc/html/rfc4941#section-3.3
Link: https://serverfault.com/a/1031168/310447
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 20 +++++++++++++-------
 include/linux/ipv6.h                   |  1 +
 include/net/addrconf.h                 |  5 +++--
 net/ipv6/addrconf.c                    | 17 +++++++++++------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7afff42612e9..0f121eda2978 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2502,18 +2502,17 @@ use_tempaddr - INTEGER
 		* -1 (for point-to-point devices and loopback devices)
 
 temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses. If less than the
-	minimum required lifetime (typically 5 seconds), temporary addresses
-	will not be created.
+	valid lifetime (in seconds) for temporary addresses. If temp_valid_lft
+	is less than or equal to regen_advance, temporary addresses will not be
+	created.
 
 	Default: 172800 (2 days)
 
 temp_prefered_lft - INTEGER
 	Preferred lifetime (in seconds) for temporary addresses. If
-	temp_prefered_lft is less than the minimum required lifetime (typically
-	5 seconds), temporary addresses will not be created. If
-	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
-	is temp_valid_lft.
+	temp_prefered_lft is less than or equal to regen_advance, temporary
+	addresses will not be created. If temp_prefered_lft is greater than
+	temp_valid_lft, the preferred lifetime is temp_valid_lft.
 
 	Default: 86400 (1 day)
 
@@ -2535,6 +2534,13 @@ max_desync_factor - INTEGER
 
 	Default: 600
 
+regen_advance - INTEGER
+
+	How far in advance (in seconds) to create a new temporary address before
+	the current one is deprecated.
+
+	Default: 5
+
 regen_max_retry - INTEGER
 	Number of attempts before give up attempting to generate
 	valid temporary addresses.
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5e605e384aac..1ff10ef9abb6 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -27,6 +27,7 @@ struct ipv6_devconf {
 	__s32		use_tempaddr;
 	__s32		temp_valid_lft;
 	__s32		temp_prefered_lft;
+	__s32		regen_advance;
 	__s32		regen_max_retry;
 	__s32		max_desync_factor;
 	__s32		max_addresses;
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 61ebe723ee4d..b8f9d88959c7 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -8,8 +8,9 @@
 
 #define MIN_VALID_LIFETIME		(2*3600)	/* 2 hours */
 
-#define TEMP_VALID_LIFETIME		(7*86400)
-#define TEMP_PREFERRED_LIFETIME		(86400)
+#define TEMP_VALID_LIFETIME		(7*86400)	/* 1 week */
+#define TEMP_PREFERRED_LIFETIME		(86400)		/* 24 hours */
+#define REGEN_ADVANCE			(5)		/* 5 seconds */
 #define REGEN_MAX_RETRY			(3)
 #define MAX_DESYNC_FACTOR		(600)
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c..047ac97ae3c8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -195,6 +195,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_advance		= REGEN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -257,6 +258,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mostly = {
 	.use_tempaddr		= 0,
 	.temp_valid_lft		= TEMP_VALID_LIFETIME,
 	.temp_prefered_lft	= TEMP_PREFERRED_LIFETIME,
+	.regen_advance		= REGEN_ADVANCE,
 	.regen_max_retry	= REGEN_MAX_RETRY,
 	.max_desync_factor	= MAX_DESYNC_FACTOR,
 	.max_addresses		= IPV6_MAX_ADDRESSES,
@@ -1372,9 +1374,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	age = (now - ifp->tstamp) / HZ;
 
-	regen_advance = idev->cnf.regen_max_retry *
-			idev->cnf.dad_transmits *
-			max(NEIGH_VAR(idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+	regen_advance = idev->cnf.regen_advance;
 
 	/* recalculate max_desync_factor each time and update
 	 * idev->desync_factor if it's larger
@@ -4577,9 +4577,7 @@ static void addrconf_verify_rtnl(struct net *net)
 			    !ifp->regen_count && ifp->ifpub) {
 				/* This is a non-regenerated temporary addr. */
 
-				unsigned long regen_advance = ifp->idev->cnf.regen_max_retry *
-					ifp->idev->cnf.dad_transmits *
-					max(NEIGH_VAR(ifp->idev->nd_parms, RETRANS_TIME), HZ/100) / HZ;
+				unsigned long regen_advance = ifp->idev->cnf.regen_advance;
 
 				if (age + regen_advance >= ifp->prefered_lft) {
 					struct inet6_ifaddr *ifpub = ifp->ifpub;
@@ -6789,6 +6787,13 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "regen_advance",
+		.data		= &ipv6_devconf.regen_advance,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "regen_max_retry",
 		.data		= &ipv6_devconf.regen_max_retry,
-- 
2.43.0


