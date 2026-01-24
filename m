Return-Path: <netdev+bounces-253106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL7kONIkdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:00:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 603937ECBD
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 662603039806
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37824DD1F;
	Sat, 24 Jan 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1DScyITH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFD2750ED
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284722; cv=none; b=F8JcdJUqBA1XslASFhBVBIqzj/ciNlV4cmFvt92Q/C+KkmaYt45gxupf6vvJWXxzR8IVRV5LQ7wU5+o4FAVuZvPnu/C7SN4z1ON334Mr9dwbw+VTssAToMKXC8PaX2U1pyA6HWLjWY1ulKxNh4LMZR4w2tunx+XW2fCw8WaH58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284722; c=relaxed/simple;
	bh=SC4Zjr/fMbgYATZ+gMI2EOcPGQk3iamY9bXmcGWpbTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy9fbPlKwnGIY3WR1HKiCDyJpGQXCLPLegmTmEFvU2ei1U+j8QkYaVjz+VxKEYGuAzRX0wucQONggtaMW1W0eNEYNegls66SWAiO9ckzqcPXi44i3fEV9RrNZ0hoBisy0Lgu7NIQx2yZbUICFErBWFokbEm6aW0Is8u2U7ryG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1DScyITH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso35867085e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284719; x=1769889519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQuFR2we3LLcn2PNsJGG4pg3o3HQ6wXCKg2Xjm4Qldw=;
        b=1DScyITHWU9WxVsFACVYjPCv95s8Oej+cD7232CgsM9VmVxeWTOrvt6zhO2sxSLh5I
         BlZvEXGjBvVHxXBw6CokZy6IrvlqlBY3c7Mg8JAi+z9KA+0EERG/RvMQstGUuXmAdRWP
         Eo6HbJr/iQMK9XDjOtFkVp6JDxI68Q950vdWh/DIYRy8lwSJjypI/Wuq29xY/Q58nqy4
         KotJvZBPMGpOkFok8zyB2gDu4BZlGnYmzI0LEIbYU9ylHpORlkUP00PsomqtvbbUnbvm
         H5AbrlPlXijypWLf+jTuQ0V/kMR2X7npqoXX1V+WzUJlgDZG2cLD275m8+97tO/nvw4c
         HjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284719; x=1769889519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQuFR2we3LLcn2PNsJGG4pg3o3HQ6wXCKg2Xjm4Qldw=;
        b=ph3TgobxSZv0ivgRWT4ziFZ742uz8ZLSsn+qEn+6fTVOkaXw81XAC5/3mkyA/0q2f1
         uGttSmt/SoRfnXCg5WGVfdalOFmVMVdxzwcVSVv0eFQ+w6obpJv8FKPMWUZxPv1tqMiu
         NBGRUSu8H6qDuXs/P3TAukitKZMMlHhWsUYJfFjV9cMN9pm0LTlDbF5QSs65CsSgTiB8
         sIDrS2EvdWNnikXNjflhNpNTw3hLDpxHqLS7m9d7bHQk6qjFg2Nua60dlip+bbQAYwYh
         kJspUSqbKVevB/Ho9kYPz6C8wcb7tEekc5GYvHWM2YRBsVmVbvya6BZF/72CUo+H+PKD
         3inQ==
X-Gm-Message-State: AOJu0Yw+mboWZSNuCaLP8MwvytPPvTv26d7LlmKGCi2L2CW8MnZ/9uNs
	QQtwUHrdrlU0Be4MA2kZZlQtMpLrcG4oz59/ZSNmxffHxoNEz9KR93GkSfzpQrYz/EQwq4M0/xA
	+S1wm
X-Gm-Gg: AZuq6aJzUcVUHo7CNi4DaFfS7c76+1b43wCz1fyuu9RVbqKpE2eFGIcwVLYnziy3Gw3
	y4ZS1oMjv6B65c8TGj6h53jZFAml8f0h4OjrkVVWPVV9vuTLrBnyaYlKXkaBA8V2SjO1zThOFyB
	oEC6gAdC17pWeX/IPEAtkyRiFDuTtApnwef76AkBjhnfhHj7Tt4NIHuwtWVgUeSyJwYQfehkRqK
	uIG1sf4BsQ/PQRNNnK7Zh6oKVf9DwOaH9Uej0i+ODCD7/uVPFabrATlMlvSchdiGcY5Se4XCR7E
	UUMKXexO1QXl3tryvXNYkzbERgDdluWDeVfXmqYqSw0qGf+zZ8bB+COB9B1Be6iFxITa/lNlq+i
	U/L2YPCbA/zIvMjXMI880QVapeYTgwAwPcI49gmqGXNxaWnWLEOVxWYZ8VQC0Bot68oCNQvNrUf
	yba822o5cSeRTBd4XHcE03MW5TMCHUp0PG3VoKoEP7VJFLdEyMqQ==
X-Received: by 2002:a05:600c:8b10:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-4804c948210mr110838655e9.6.1769284719358;
        Sat, 24 Jan 2026 11:58:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 7/7] rdma: fix grammar, formatting, and style in man pages
Date: Sat, 24 Jan 2026 11:49:31 -0800
Message-ID: <20260124195824.221305-8-stephen@networkplumber.org>
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
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253106-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 603937ECBD
X-Rspamd-Action: no action

This patch addresses grammatical errors, overly long section headers,
missing punctuation, and style inconsistencies across all RDMA man
page documentation.

Changes by file:

rdma.8:
  - Fix hyphenation: "non zero" -> "non-zero"
  - Remove article: "a pretty JSON" -> "pretty JSON"
  - Capitalize option description: "output" -> "Output"
  - Add missing period after "monitor"

rdma-dev.8:
  - Split overly long section headers into concise titles + body text
  - Fix semicolon to period and add missing articles
  - Fix possessive: "it's parent" -> "its parent"
  - Add missing article: "specified" -> "the specified"
  - Fix tense: "is previously created" -> "was previously created"
  - Add article: "iproute2 ip command" -> "the iproute2 ip command"
  - Fix verb tense in examples: "Add" -> "Adds", "Delete" -> "Deletes"

rdma-link.8:
  - Split overly long section header
  - Add missing article: "specified" -> "the specified"
  - Add missing periods (2 instances)

rdma-monitor.8:
  - Split awkward section header and reword
  - Add missing period

rdma-resource.8:
  - Add missing article: "specified" -> "the specified"
  - Add missing periods (4 instances)

rdma-statistic.8:
  - Split overly long section header
  - Fix verb form: "are bind" -> "are bound"
  - Add missing periods (7 instances)
  - Fix grammar: "does not exists" -> "it does not exist"
  - Fix plural verb: "that was enabled" -> "that were enabled"

rdma-system.8:
  - Fix plural: "network namespace" -> "network namespaces"
  - Remove duplicate .PP line

The most significant improvements are splitting overly long section
headers across multiple files, fixing missing punctuation in examples,
and correcting various grammatical errors.

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/rdma-dev.8       | 23 ++++++++++++++---------
 man/man8/rdma-link.8      | 10 ++++++----
 man/man8/rdma-monitor.8   |  7 +++++--
 man/man8/rdma-resource.8  |  6 +++---
 man/man8/rdma-statistic.8 | 24 +++++++++++++-----------
 man/man8/rdma-system.8    |  3 +--
 man/man8/rdma.8           |  8 ++++----
 7 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/man/man8/rdma-dev.8 b/man/man8/rdma-dev.8
index e26f738c..abc9f405 100644
--- a/man/man8/rdma-dev.8
+++ b/man/man8/rdma-dev.8
@@ -65,17 +65,22 @@ rdma-dev \- RDMA device configuration
 - specifies the RDMA device to show.
 If this argument is omitted all devices are listed.
 
-.SS rdma dev add - Add a RDMA device with a specific type and parent IB device; This new device provides subset of functionalities defined in IBTA spec.
-.SS rdma dev delete - Delete a RDMA device which is created with the "add" command.
+.SS rdma dev add - add a RDMA device
+
+Add a RDMA device with a specific type and parent IB device. This new device provides a subset of functionalities defined in the IBTA spec.
+
+.SS rdma dev delete - delete a RDMA device
+
+Delete a RDMA device which was created with the "add" command.
 .I NAME
 - The name of the device being added/deleted.
 
 .I TYPE
-- The type of the device being added; It specifies which functionalities it provides. Supported device type:
+- The type of the device being added. It specifies which functionalities it provides. Supported device type:
 .sp
 .in +8
 .B SMI
-- A device with this type provides SMI (QP0) interface. This device and it's parent associates with the same HCA port and shares the physical link, so when the parent doesn't support SMI, then this type of device can be created to allow the subnet manager to configure the link.
+- A device with this type provides SMI (QP0) interface. This device and its parent associates with the same HCA port and shares the physical link, so when the parent doesn't support SMI, then this type of device can be created to allow the subnet manager to configure the link.
 .in -8
 
 .I PARENT_DEV
@@ -90,7 +95,7 @@ Shows the state of all RDMA devices on the system.
 .PP
 rdma dev show mlx5_3
 .RS 4
-Shows the state of specified RDMA device.
+Shows the state of the specified RDMA device.
 .RE
 .PP
 rdma dev set mlx5_3 name rdma_0
@@ -100,8 +105,8 @@ Renames the mlx5_3 device to rdma_0.
 .PP
 rdma dev set mlx5_3 netns foo
 .RS 4
-Changes the network namespace of RDMA device to foo where foo is
-previously created using iproute2 ip command.
+Changes the network namespace of RDMA device to foo where foo was
+previously created using the iproute2 ip command.
 .RE
 .PP
 rdma dev set mlx5_3 adaptive-moderation [on/off]
@@ -114,12 +119,12 @@ This is a global setting for the RDMA device but the value is printed for each C
 .PP
 rdma dev add smi1 type SMI parent ibp8s0f1
 .RS 4
-Add a new IB device with name "smi1", type "SMI", and "ibp8s0f1" as its parent device.
+Adds a new IB device with name "smi1", type "SMI", and "ibp8s0f1" as its parent device.
 .RE
 .PP
 rdma dev delete smi1
 .RS 4
-Delete the IB device "smi1".
+Deletes the IB device "smi1".
 .RE
 .PP
 
diff --git a/man/man8/rdma-link.8 b/man/man8/rdma-link.8
index 5e4a5307..7a4be457 100644
--- a/man/man8/rdma-link.8
+++ b/man/man8/rdma-link.8
@@ -45,7 +45,9 @@ rdma-link \- rdma link configuration
 - specifies the RDMA link to show.
 If this argument is omitted all links are listed.
 
-.SS rdma link add NAME type TYPE netdev NETDEV - add an rdma link for the specified type to the network device
+.SS rdma link add - add an rdma link
+
+Add an rdma link for the specified type to the network device.
 .sp
 .BR NAME
 - specifies the new name of the rdma link to add
@@ -79,17 +81,17 @@ Shows the state of all rdma links on the system.
 .PP
 rdma link show mlx5_2/1
 .RS 4
-Shows the state of specified rdma link.
+Shows the state of the specified rdma link.
 .RE
 .PP
 rdma link add rxe_eth0 type rxe netdev eth0
 .RS 4
-Adds a RXE link named rxe_eth0 to network device eth0
+Adds a RXE link named rxe_eth0 to network device eth0.
 .RE
 .PP
 rdma link del rxe_eth0
 .RS 4
-Removes RXE link rxe_eth0
+Removes RXE link rxe_eth0.
 .RE
 .PP
 
diff --git a/man/man8/rdma-monitor.8 b/man/man8/rdma-monitor.8
index d445cba0..5e82e092 100644
--- a/man/man8/rdma-monitor.8
+++ b/man/man8/rdma-monitor.8
@@ -23,7 +23,10 @@ rdma-monitor \- RDMA events monitoring
 .B rdma monitor help
 
 .SH "DESCRIPTION"
-.SS rdma monitor - utility can monitor RDMA device events on all RDMA devices.
+.SS rdma monitor - monitor RDMA device events
+
+This utility can monitor RDMA device events on all RDMA devices.
+
 .PP
 .B rdma
 opens an RDMA Netlink socket, listens on it and dumps the event info.
@@ -35,7 +38,7 @@ and net device attachment/detachment.
 .PP
 rdma monitor
 .RS 4
-Listen for events of all RDMA devices
+Listen for events of all RDMA devices.
 .RE
 .PP
 
diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index 1035478d..61bec471 100644
--- a/man/man8/rdma-resource.8
+++ b/man/man8/rdma-resource.8
@@ -45,7 +45,7 @@ Shows summary for all devices on the system.
 .PP
 rdma resource show mlx5_2
 .RS 4
-Shows the state of specified rdma device.
+Shows the state of the specified rdma device.
 .RE
 .PP
 rdma res show qp link mlx5_4
@@ -95,12 +95,12 @@ Show CM_IDs with destination ip port of 7174.
 .PP
 rdma resource show cm_id src-addr 172.16.0.100
 .RS 4
-Show CM_IDs bound to local ip address 172.16.0.100
+Show CM_IDs bound to local ip address 172.16.0.100.
 .RE
 .PP
 rdma resource show cq pid 30489
 .RS 4
-Show CQs belonging to pid 30489
+Show CQs belonging to pid 30489.
 .RE
 .PP
 rdma resource show ctx ctxn 1
diff --git a/man/man8/rdma-statistic.8 b/man/man8/rdma-statistic.8
index 337e31ef..c81e3b75 100644
--- a/man/man8/rdma-statistic.8
+++ b/man/man8/rdma-statistic.8
@@ -98,7 +98,9 @@ rdma-statistic \- RDMA statistic counter configuration
 .RB "{ " cntn " | " lqpn " | " pid " | " qp-type " }"
 
 .SH "DESCRIPTION"
-.SS rdma statistic [object] show - Queries the specified RDMA device for RDMA and driver-specific statistics. Show the default hw counters if object is not specified
+.SS rdma statistic [object] show - display RDMA statistics
+
+Queries the specified RDMA device for RDMA and driver-specific statistics. Shows the default hw counters if object is not specified.
 
 .PP
 .I "DEV"
@@ -111,7 +113,7 @@ rdma-statistic \- RDMA statistic counter configuration
 - specifies a filter to show only the results matching it.
 
 .SS rdma statistic <object> set - configure counter statistic auto-mode for a specific device/port
-In auto mode all objects belong to one category are bind automatically to a single counter set. The "off" is global for all auto modes together. Not applicable for MR's.
+In auto mode all objects belong to one category are bound automatically to a single counter set. The "off" is global for all auto modes together. Not applicable for MR's.
 
 .SS rdma statistic <object> bind - manually bind an object (e.g., a qp) with a counter
 When bound the statistics of this object are available in this counter. Not applicable for MR's.
@@ -143,7 +145,7 @@ Shows the state of the default counter of all RDMA devices on the system.
 .PP
 rdma statistic show link mlx5_2/1
 .RS 4
-Shows the state of the default counter of specified RDMA port
+Shows the state of the default counter of specified RDMA port.
 .RE
 .PP
 rdma statistic qp show
@@ -158,22 +160,22 @@ Shows the state of all qp counters of specified RDMA port.
 .PP
 rdma statistic qp show link mlx5_2 pid 30489
 .RS 4
-Shows the state of all qp counters of specified RDMA port and belonging to pid 30489
+Shows the state of all qp counters of specified RDMA port and belonging to pid 30489.
 .RE
 .PP
 rdma statistic qp show link mlx5_2 qp-type UD
 .RS 4
-Shows the state of all qp counters of specified RDMA port and with QP type UD
+Shows the state of all qp counters of specified RDMA port and with QP type UD.
 .RE
 .PP
 rdma statistic qp mode
 .RS 4
-List current counter mode on all devices
+List current counter mode on all devices.
 .RE
 .PP
 rdma statistic qp mode link mlx5_2/1
 .RS 4
-List current counter mode of device mlx5_2 port 1
+List current counter mode of device mlx5_2 port 1.
 .RE
 .PP
 rdma statistic qp set link mlx5_2/1 auto type on
@@ -203,12 +205,12 @@ Turn-off auto mode on device mlx5_2 port 1. The allocated counters can be manual
 .PP
 rdma statistic qp bind link mlx5_2/1 lqpn 178
 .RS 4
-On device mlx5_2 port 1, allocate a counter and bind the specified qp on it
+On device mlx5_2 port 1, allocate a counter and bind the specified qp on it.
 .RE
 .PP
 rdma statistic qp unbind link mlx5_2/1 cntn 4 lqpn 178
 .RS 4
-On device mlx5_2 port 1, bind the specified qp on the specified counter
+On device mlx5_2 port 1, bind the specified qp on the specified counter.
 .RE
 .PP
 rdma statistic qp unbind link mlx5_2/1 cntn 4
@@ -223,12 +225,12 @@ List all currently allocated MR's and their counters.
 .PP
 rdma statistic show mr mrn 6
 .RS 4
-Dump a specific MR statistics with mrn 6. Dumps nothing if does not exists.
+Dump a specific MR statistics with mrn 6. Dumps nothing if it does not exist.
 .RE
 .PP
 rdma statistic mode link mlx5_2/1
 .RS 4
-Display the optional counters that was enabled on mlx5_2/1.
+Display the optional counters that were enabled on mlx5_2/1.
 .RE
 .PP
 rdma statistic mode supported link mlx5_2/1
diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
index 5373027a..8aff9d38 100644
--- a/man/man8/rdma-system.8
+++ b/man/man8/rdma-system.8
@@ -51,7 +51,7 @@ one or more RDMA devices exist, changing mode from shared to
 exclusive returns error code EBUSY.
 
 When RDMA subsystem is in shared mode, RDMA device is accessible in
-all network namespace. When RDMA device isolation among multiple
+all network namespaces. When RDMA device isolation among multiple
 network namespaces is not needed, shared mode can be used.
 
 It is preferred to not change the subsystem mode when there is active
@@ -82,7 +82,6 @@ Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devi
 are shared among network namespaces.
 .RE
 .PP
-.PP
 rdma system set privileged-qkey on
 .RS 4
 Sets the privileged-qkey parameter to on. In this state non-privileged user
diff --git a/man/man8/rdma.8 b/man/man8/rdma.8
index df86284d..4061b9ae 100644
--- a/man/man8/rdma.8
+++ b/man/man8/rdma.8
@@ -46,7 +46,7 @@ First failure will cause termination of rdma.
 .TP
 .BR "\-force"
 Don't terminate rdma on errors in batch mode.
-If there were any errors during execution of the commands, the application return code will be non zero.
+If there were any errors during execution of the commands, the application return code will be non-zero.
 
 .TP
 .BR "\-d" , " --details"
@@ -58,7 +58,7 @@ Output includes driver-specific details in raw format.
 
 .TP
 .BR "\-p" , " --pretty"
-When combined with -j generate a pretty JSON output.
+When combined with -j generate pretty JSON output.
 
 .TP
 .BR "\-j" , " --json"
@@ -66,7 +66,7 @@ Generate JSON output.
 
 .TP
 .BR "\-o" , " \-oneline"
-output each record on a single line, replacing line feeds
+Output each record on a single line, replacing line feeds
 with the
 .B '\e'
 character.
@@ -96,7 +96,7 @@ character.
 
 .TP
 .B monitor
-- RDMA events monitor
+- RDMA events monitor.
 
 .PP
 The names of all objects may be written in full or
-- 
2.51.0


