Return-Path: <netdev+bounces-253102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAXoD5YkdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5E7EC9E
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C288301F984
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0A274B40;
	Sat, 24 Jan 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XeG5GiR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA8263899
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284716; cv=none; b=nzE2iAHNGa5RxFvq5jeDKlR+NkKiWQORRBAMVnzumbUSX0FF2WXoBEEHudwgZ427XWeNIxP4T2+fksWIxGN9KrFvPDHlpDmmeztg4Rc7qIqRw0P+XTYDkFGHlmKrhbVB+t2OxLnRreIi75tZaNOkrWO6hSsNJueXvCIHbHnSigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284716; c=relaxed/simple;
	bh=SiAmVbxXslaomHbo/y78+2pVq+aHdb6yqAmkDrphu4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h56IyrPX3MYpXb4Y0SEqpv2wA5PjE+1WaOQ68Cbn3WvqB6Cj6mWps5/slpcXoaweKTICKrrPWA9YS4RPfU/Ovlf8vNZB4NaE1PugXqk+FhFxs6tiFybmM8AoCalOJikEYfR7mfAU1AhlWaso8I0gr9SCDsc1L8Fiy4sxEsgFXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XeG5GiR7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edffe5540so37423435e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284713; x=1769889513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGgkNSgPv+4DWg1/0xpqIlGMpixZAm1LMI7hGDSXCiE=;
        b=XeG5GiR7sH9PO45fI5PLs3P3svB02UTL08NiXFcz5lK5Q5Dasdh9ewz0G+2iS0KcDj
         8CtA8nXqt91VyyiSL1/cylFlEm/SbinKjgP65hU1v25QotIKxpR4kK04na0rvCSqmX9d
         3XdXSPusziZZqiZhtCfPSFXzqVXKZT0ypNbDgP/y2Mqe6P+eivqbI9KqTqXRSGqleM4q
         0GMSWQaU4G6AE5WZJk/EOckfFetyB/FHQDXcjkLR/wjL44V+eo2n0H+48Mff8gQcPs8Y
         x2e/ctwPoKeEH5wJRvrSID1bgmxzDfnpCVjX6Eo+8RYdccELtKEZhDa89BbDyWaoLrz6
         sBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284713; x=1769889513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGgkNSgPv+4DWg1/0xpqIlGMpixZAm1LMI7hGDSXCiE=;
        b=lP7MkdMg5bBz8G1pOrGv5uFwpX3tt8ZHcC30rn3T5pDgoQxEjb+e3RExIhY1Mrt6cr
         QsN/HO9wVxOMmxXfOz5TOlQp3skkfOV2I6xtKgqGqG45FEmh4T9oXByekUNEYizMPIEs
         sj3Qyina0DfhGTi2qhxiUFOzUXpc0RoehI/dqAHHsLg+STNVnykTL1Chxacg2/bpRU9k
         orx8GmKnS0jSzexSBRwc1pPNHlea4wqQRf8up5UmE0hXLC9F/Vt+AoIaOZg0ZVhe8EWD
         kVEB+a6wR3hHmOfwG92O/nwlEqVGUDIDS9n95ZVQxyn0bujGZlGvx9l2VmhGFGInJTO4
         mtag==
X-Gm-Message-State: AOJu0YxUJxS1kSGuzND1KAIeOwoHsiNFhQBhT7LRVJ0bVoNFk0Zxv6rr
	g/mI30gAgN8PobXtwJGdQK6QRBX+gzqnLESD/IeTCrBADx6kFNHZqJffMj3G7TD0DhD53njfW/G
	eeMIW
X-Gm-Gg: AZuq6aIIYq2swgejIvm913zyaXNgARMZIOrJiU8FCACnxuyrYAMA7mzUOwsfZr3YEYt
	4PPu2RRIuJXYZRphDybyrr1kkd6JK7W/9CEIq2VqJf0lo8+2CB/7cJmVVn6uIABbvrjunRuboQ3
	RDJ424RWZ6b9lnRWW9Iu/zi52DjvqTRPi8qdEzJwt6pkH5JwHIXJ/H1NFsO4oyjn4a0nEcpK3zr
	CMjti5BAOQcnFuzUt9818RNvh+NzLJTITYq+29Kf3xBBdHLr6mKe1JcA7BjY10CelBMYv2zidD2
	FahfZzqchU+Lb9DdHq0sDQrrFZIn+t6WJMfFPQPxoXTjDFQN3OZoWu3QCtW5N+P2jjXwajtvdW1
	A4UcSekKMjayC9sUZOVYUwKWfDHretEx19S4c4xAHQoJYYvEERq3aI6abuxx5+JEhnEN3u7TYQg
	BtYWZzilC60aG44X78Cjf71J2M8AvCtiXA7JhyGgP2CdAnkNnwjw==
X-Received: by 2002:a05:600c:c170:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-4804c947110mr115775475e9.3.1769284713589;
        Sat, 24 Jan 2026 11:58:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 3/7] fix grammar and style issues in man pages for stat related pages
Date: Sat, 24 Jan 2026 11:49:27 -0800
Message-ID: <20260124195824.221305-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260124195824.221305-1-stephen@networkplumber.org>
References: <20260124195824.221305-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253102-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9DA5E7EC9E
X-Rspamd-Action: no action

This patch addresses grammatical errors and style inconsistencies in
the ifstat, lnstat, and rtacct man pages documentation.

lnstat Changes:
  - Capitalize "Linux" as proper noun in NAME and DESCRIPTION sections
  - Add missing period to -j/--json option description
  - Fix passive voice: "is being used" -> "is used"
  - Fix word form: "can not" -> "cannot"

rtacct Changes:
  - Fix date format: remove comma in "27 June, 2007" -> "27 June 2007"
  - Remove period from NAME section per man page convention
  - Capitalize SNMP acronym (2 instances)
  - Add missing periods to -h and -V option descriptions
  - Improve clarity of -s/--noupdate description
  - Add missing article in -d/--scan description

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ifstat.8 |  4 ++--
 man/man8/lnstat.8 | 10 +++++-----
 man/man8/rtacct.8 | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/man/man8/ifstat.8 b/man/man8/ifstat.8
index 8cd164dd..35389d57 100644
--- a/man/man8/ifstat.8
+++ b/man/man8/ifstat.8
@@ -28,7 +28,7 @@ Show version of program.
 Ignore the history file.
 .TP
 .B \-d, \-\-scan=SECS
-Sample statistics every SECS second.
+Sample statistics every SECS seconds.
 .TP
 .B \-e, \-\-errors
 Show errors.
@@ -67,7 +67,7 @@ Show extended stats of TYPE. Supported types are:
 .SH ENVIRONMENT
 .TP
 .B IFSTAT_HISTORY
-If set, it's value is interpreted as alternate history file path.
+If set, its value is interpreted as alternate history file path.
 .SH SEE ALSO
 .BR ip (8)
 .br
diff --git a/man/man8/lnstat.8 b/man/man8/lnstat.8
index b98241bf..9b548f19 100644
--- a/man/man8/lnstat.8
+++ b/man/man8/lnstat.8
@@ -1,6 +1,6 @@
 .TH LNSTAT 8
 .SH NAME
-lnstat \- unified linux network statistics
+lnstat \- unified Linux network statistics
 .SH SYNOPSIS
 .B lnstat
 .RI [ options ]
@@ -13,7 +13,7 @@ command.
 rtstat program. It is commonly used to periodically print a selection of
 statistical values exported by the kernel.
 In addition to routing cache statistics, it supports any kind of statistics the
-linux kernel exports via a file in /proc/net/stat/.
+Linux kernel exports via a file in /proc/net/stat/.
 .PP
 Each file in /proc/net/stat/ contains a header line listing the column names.
 These names are used by \fBlnstat\fP as keys for selecting which statistics to
@@ -46,12 +46,12 @@ Statistics file to use, may be specified multiple times. By default all files in
 Set interval to 'intv' seconds.
 .TP
 .B \-j, \-\-json
-Display results in JSON format
+Display results in JSON format.
 .TP
 .B \-k, \-\-keys k,k,k,...
 Display only keys specified. Each key \fBk\fP is of the form \fB[file:]key\fP. If \fB<file>\fP
 is given, the search for the given key is limited to that file. Otherwise the first file containing
-the searched key is being used.
+the searched key is used.
 .TP
 .B \-s, \-\-subject [0-2]
 Specify display of subject/header. '0' means no header at all, '1' prints a header only at start of the program and '2' prints a header every 20 lines.
@@ -145,7 +145,7 @@ Number of \fBsearched\fP entries which were successful.
 Number of conntrack entries added which were not expected before.
 .sp
 .B invalid
-Number of packets seen which can not be tracked.
+Number of packets seen which cannot be tracked.
 .sp
 .B ignore
 Number of packets seen which are already connected to a conntrack entry.
diff --git a/man/man8/rtacct.8 b/man/man8/rtacct.8
index 988a6d1b..e3d9a1b7 100644
--- a/man/man8/rtacct.8
+++ b/man/man8/rtacct.8
@@ -1,7 +1,7 @@
-.TH RTACCT 8 "27 June, 2007"
+.TH RTACCT 8 "27 June 2007"
 
 .SH NAME
-nstat, rtacct - network statistics tools.
+nstat, rtacct - network statistics tools
 
 .SH SYNOPSIS
 Usage: nstat [ -h?vVzrnasd:t:jp ] [ PATTERN [ PATTERN ] ]
@@ -12,10 +12,10 @@ Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]
 .B nstat
 and
 .B rtacct
-are simple tools to monitor kernel snmp counters and network interface statistics.
+are simple tools to monitor kernel SNMP counters and network interface statistics.
 
 .B nstat
-can filter kernel snmp counters by name with one or several specified wildcards. Wildcards are case-insensitive and can include special symbols
+can filter kernel SNMP counters by name with one or several specified wildcards. Wildcards are case-insensitive and can include special symbols
 .B ?
 and
 .B *
@@ -23,10 +23,10 @@ and
 
 .SH OPTIONS
 .B \-h, \-\-help
-Print help
+Print help.
 .TP
 .B \-V, \-\-version
-Print version
+Print version.
 .TP
 .B \-z, \-\-zeros
 Dump zero counters too. By default they are not shown.
@@ -41,7 +41,7 @@ Do not display anything, only update history.
 Dump absolute values of counters. The default is to calculate increments since the previous use.
 .TP
 .B \-s, \-\-noupdate
-Do not update history, so that the next time you will see counters including values accumulated to the moment of this measurement too.
+Do not update history, so that the next time you will see counters including values accumulated up to this measurement.
 .TP
 .B \-j, \-\-json
 Display results in JSON format.
@@ -52,7 +52,7 @@ When combined with
 pretty print the output.
 .TP
 .B \-d, \-\-scan <INTERVAL>
-Run in daemon mode collecting statistics. <INTERVAL> is interval between measurements in seconds.
+Run in daemon mode collecting statistics. <INTERVAL> is the interval between measurements in seconds.
 .TP
 .B \-t, \-\-interval <INTERVAL>
 Time interval to average rates. Default value is 60 seconds.
-- 
2.51.0


