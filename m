Return-Path: <netdev+bounces-253104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDG1C7YkdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2E7ECAD
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F516302F72B
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C670244186;
	Sat, 24 Jan 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iRLODas1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31363238C3A
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284719; cv=none; b=leYSPwka+aW/iM/0fGBTvgnxPQekoHY68nqQTb49sJR3ZIm0OQU7cxP8UifTMP+PU+n62Cbb8yqZaSXtj/oKhJ/WI9EBqI8Xzv6A4ZdK9euMq01KH9Tib42rAmlGURCPp+8z0sGonv2RTN560zOdq2NafSIO3ex9IHVpnRmPQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284719; c=relaxed/simple;
	bh=5NRB4XCWelTmpWdc9RXR7au56YzDFxTG8/CTwKf2QUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk3OXDr9EUh1k9DRpJTWCLBdMhluZcLprj1Kx1zXfuZiVYyzLB2BQ5hldRWY0k6nYzRVksGqY3A0qMMxQfUTXe9nyFLuHtCtmyCcj2fNbUcsubf7NgIJrVx9FlNFgVnknidxvy5TROMv85OIED1leW9Lp67gNFapOow0sPc8tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iRLODas1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso27509985e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284716; x=1769889516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkxLfvFuPA+eZczt+TKGIyxqXPDImJrJbK7sfWrPoAQ=;
        b=iRLODas1JhnqzIYSE6F/9fIjl8/sOXmjxeVIIqtpnaKkmnyVqVj1tLfafaGig4G6li
         Ae/iAk8QwuWrE1ZfWxhhFimfUrdU2v8nhYSO1ceF54AUvhwzc5Mc6hlq1npHpBiHiJSc
         2atPyvG2s4HhfMEgglRdfhpcd3wE55KdMGoIhGsplhkiVqWZm9zOsPqfGjmhAU2LVcE6
         8uq0UpkVEel1Fg8u5crZgUHy59YrVBLRPgQrL+ej750qM5FJ4vc+egU/hUIOHFvwZusn
         7CL6n/8RQx5kLEOLMYjtjhNNzPQszxygQTQizWvsO91pyOzegCHKfpE7nqDuYz/9TRAp
         gp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284716; x=1769889516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkxLfvFuPA+eZczt+TKGIyxqXPDImJrJbK7sfWrPoAQ=;
        b=xSr3xyBLJ1WnCSqQUb2qOsQH+WnjnVmdbrKweS2f/eUX3PJjROrGgB7S1kx5F+RmlX
         1edFsOBa1lxtX9ZsSOsJOHUsnRDTNglYJ80gkU9H3kMaTABPeKQWZ0VS7R9WmLW/0TID
         mS9ZCAPP7vOrVX/hJjQNjz4zKuPPNA8QdnuZqhhQg1vaXoc/6mQ83ddhLlAvT36GWYh0
         TefqP3HG3EAPRZaKc6juCwyt+Ae1kGIFG9LaKPY1a7NCMRYkC7SaGL5f/ywDkcwOtc5H
         On/xN93OPapC8XZA9mjKR1RItMGjIb7/MWEiSCf7cpWAPlHX6sTR0Oihuv6HQ/HpRfWP
         l2dw==
X-Gm-Message-State: AOJu0YzPONAABiAf72cWjkfEKBPaPzpL0m8rkRjGyw0u5KRxCbxcvw1x
	P6819vH0BkJoleG8PstrjLSNnhbtDROYvaBlYgmQmShXw4Ktvwr8c78a/Z9YLadjxz2C2ap7fKG
	80EI4
X-Gm-Gg: AZuq6aLfl6WK0kQ9BX1FHdoGjLNOb5l1QAtVFMb6cRparvIFIsj/bYyUmIjvPrfTRn3
	PmYivVMKks9q8nGoctsiRocr71qTetqpLdU6KgOSLuCHl2cTD19l7gC5Niz6qfc6EBkBtLCHM40
	5b6ynFCbJmEZ0TOjo90HXCMWk+J1nRKNnKI1nY0D/0GMqIs15lXt9jT3ZVIWxVFEni4AQIbLFuw
	5iSvlaH9gLLYCxBmqtYj/aQ3rtchIcW80SiigBRNehkjSZb+BL3PHhqGkxmdXA880R59A8CCQTL
	byfdHajfKKZsw738W/AeangngmiCv3lBXy6eLNHJd+nEPSCFyKPXI624MPK9enCgKYUQDrstgmg
	NtHFMQ+PyHvg49OmAUYHY0abd/fqHctBrbSEfxiK0d4pW76mFou3UCst3B2t+TQIWoxX8ko0QlP
	harMjhTWoJ40FgaZTr0Hem7lgo/egY2fyAHWs9Sr/RqhQMSp+bQA==
X-Received: by 2002:a05:600c:8708:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-4804d2be33emr111999695e9.7.1769284716499;
        Sat, 24 Jan 2026 11:58:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 5/7] tipc: fix grammar and style issues in man pages
Date: Sat, 24 Jan 2026 11:49:29 -0800
Message-ID: <20260124195824.221305-6-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-253104-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 78D2E7ECAD
X-Rspamd-Action: no action

This patch addresses grammatical errors, typos, and formatting issues
across the TIPC man page documentation.

Changes by file:

tipc.8:
  - Fix subject-verb agreement: "consists" -> "consist"

tipc-bearer.8:
  - Fix verb agreement: "udp identify" -> "udp identifies"
  - Fix article and hyphenation: "an multi bearer" -> "a multi-bearer"
  - Fix IP notation: "IP v4/v6" -> "IPv4/IPv6"

tipc-link.8:
  - Fix plural verb: "messages has been" -> "messages have been"
  - Fix preposition: "If set of 0" -> "If set to 0"
  - Fix plural noun: "Possible status are" -> "Possible statuses are"
    (3 instances)

tipc-nametable.8:
  - Fix misplaced help text: move from after -p option to -h option
    where it belongs

tipc-node.8:
  - Fix preposition: "On the form" -> "In the form"
  - Fix typo: "Can by used" -> "Can be used"

tipc-socket.8:
  - Add missing comma in SEE ALSO section after tipc-bearer(8)

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tipc-bearer.8    |  6 +++---
 man/man8/tipc-link.8      | 10 +++++-----
 man/man8/tipc-nametable.8 | 11 +++++------
 man/man8/tipc-node.8      |  4 ++--
 man/man8/tipc-socket.8    |  2 +-
 man/man8/tipc.8           |  2 +-
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/man/man8/tipc-bearer.8 b/man/man8/tipc-bearer.8
index d95b1e1c..4011d6d1 100644
--- a/man/man8/tipc-bearer.8
+++ b/man/man8/tipc-bearer.8
@@ -112,7 +112,7 @@ identify a bearer with a
 .I DEVICE
 while
 .B udp
-identify a bearer with a
+identifies a bearer with a
 .IR "LOCALIP " "and a " NAME
 
 .B ib
@@ -155,7 +155,7 @@ link establish requests.
 Default link priority inherited by all links subsequently established over a
 bearer. A single bearer can only host one link to a particular node. This means
 the default link priority for a bearer typically affects which bearer to use
-when communicating with a particular node in an multi bearer setup. For more
+when communicating with a particular node in a multi-bearer setup. For more
 info about link priority see
 .BR tipc-link (8)
 
@@ -178,7 +178,7 @@ bearer. For more info about the link window size see
 .TP
 .BI "localip " LOCALIP
 .br
-Specify a local IP v4/v6 address for a
+Specify a local IPv4/IPv6 address for a
 .B udp
 bearer.
 
diff --git a/man/man8/tipc-link.8 b/man/man8/tipc-link.8
index 47dae25d..ac6c7a2b 100644
--- a/man/man8/tipc-link.8
+++ b/man/man8/tipc-link.8
@@ -158,7 +158,7 @@ Subsequently the
 .B fragments
 are the total amount of packets that the
 .B fragmented
-messages has been broken into.
+messages have been broken into.
 
 .TP
 .B Bundles
@@ -262,7 +262,7 @@ activated.
 .br
 The threshold specifies the cluster size exceeding which the link monitoring
 algorithm will switch from "full-mesh" to "overlapping-ring".
-If set of 0 the overlapping-ring monitoring is always on and if set to a
+If set to 0 the overlapping-ring monitoring is always on and if set to a
 value larger than anticipated cluster size the overlapping-ring is disabled.
 The default value is 32.
 
@@ -290,7 +290,7 @@ Possible values are full-mesh or overlapping-ring.
 .B status
 .br
 The node status derived by the local node.
-Possible status are up or down.
+Possible statuses are up or down.
 
 .TP
 .B monitored
@@ -313,7 +313,7 @@ of a domain record to know if it should ignore or process the record.
 The node status reported by the peer node for the succeeding peers in
 the node list. The Node list is a circular list of ascending addresses
 starting with the local node.
-Possible status are: U or D. The status U implies up and D down.
+Possible statuses are: U or D. The status U implies up and D down.
 
 .TP
 .B [non_applied_node:status]
@@ -322,7 +322,7 @@ Represents the nodes and their status as reported by the peer node.
 These nodes were not applied to the monitoring list for this peer node.
 They are usually transient and occur during the cluster startup phase
 or network reconfiguration.
-Possible status are: U or D. The status U implies up and D down.
+Possible statuses are: U or D. The status U implies up and D down.
 
 .SS Broadcast properties
 .TP
diff --git a/man/man8/tipc-nametable.8 b/man/man8/tipc-nametable.8
index f7c51f19..a8d357ab 100644
--- a/man/man8/tipc-nametable.8
+++ b/man/man8/tipc-nametable.8
@@ -18,6 +18,11 @@ tipc-nametable \- show TIPC nametable
 Options (flags) that can be passed anywhere in the command chain.
 .TP
 .BR "\-h" , " --help"
+Show help about last valid command. For example
+.B tipc nametable --help
+will show nametable help and
+.B tipc --help
+will show general help. The position of the option in the string is irrelevant.
 
 .TP
 .BR "\-j", " \-json"
@@ -28,12 +33,6 @@ Output results in JavaScript Object Notation (JSON).
 The default JSON format is compact and more efficient to parse but hard for most users to read.
 This flag adds indentation for readability.
 
-Show help about last valid command. For example
-.B tipc nametable --help
-will show nametable help and
-.B tipc --help
-will show general help. The position of the option in the string is irrelevant.
-
 .SH DESCRIPTION
 The nametable shows TIPC publication information.
 
diff --git a/man/man8/tipc-node.8 b/man/man8/tipc-node.8
index a72a4099..4a199c47 100644
--- a/man/man8/tipc-node.8
+++ b/man/man8/tipc-node.8
@@ -41,13 +41,13 @@ will show general help. The position of the option in the string is irrelevant.
 .TP
 .BI address
 .br
-The TIPC logical address. On the form x.y.z where x, y and z are unsigned
+The TIPC logical address. In the form x.y.z where x, y and z are unsigned
 integers.
 
 .TP
 .BI netid
 .br
-Network identity. Can by used to create individual TIPC clusters on the same
+Network identity. Can be used to create individual TIPC clusters on the same
 media.
 
 .SH EXIT STATUS
diff --git a/man/man8/tipc-socket.8 b/man/man8/tipc-socket.8
index 23ec1e51..5b04d866 100644
--- a/man/man8/tipc-socket.8
+++ b/man/man8/tipc-socket.8
@@ -43,7 +43,7 @@ Exit status is 0 if command was successful or a positive integer upon failure.
 
 .SH SEE ALSO
 .BR tipc (8),
-.BR tipc-bearer (8)
+.BR tipc-bearer (8),
 .BR tipc-link (8),
 .BR tipc-media (8),
 .BR tipc-nametable (8),
diff --git a/man/man8/tipc.8 b/man/man8/tipc.8
index 6706cca1..95904989 100644
--- a/man/man8/tipc.8
+++ b/man/man8/tipc.8
@@ -78,7 +78,7 @@ This flag adds indentation for readability.
 .SH ARGUMENTS
 
 Command arguments are described in a command specific man page and typically
-consists of nested commands along with key value pairs.
+consist of nested commands along with key value pairs.
 If no arguments are given a command typically shows its help text. The explicit
 help option
 .B -h
-- 
2.51.0


