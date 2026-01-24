Return-Path: <netdev+bounces-253101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBNtEYokdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA77EC97
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB3630067A6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F2273D81;
	Sat, 24 Jan 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nwrrw+uh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213D2749CF
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284715; cv=none; b=GgBTxdfBN7P7vOVxE08MAap3y8v3FYMnTbqxgFgEeFzuKAuDOqa+Xqu7/nmcZqdrwDfMrqpUa6b2HvA0JoXDtwhpeZ2FcG73G0BkIuAadtjz6T4C+oc2ou+ncfXVuPV+KR5lGiQbBTR1WeQmJ8C+NGPlG0+ydOa7W3UuZI09p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284715; c=relaxed/simple;
	bh=pKWQ07YHfgbTKp7qCV8BUVOpSQfOC3MbXlTzkrjpYp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN8hK1yEhbGQNCqhqME9f0BAawdequAHSt32XALzkTI+4Nwljbk+0dPcNW6VVbgzo+NB++yPyKmrwq2qEc7AdkvyTswDMF8EgbNjEv9DmABxU4d44Aqz4PaxY7ftcz9ozbD0Y5IzqCQJ/KfzgLd6ZudKskfSsBfpBnxLWpKxZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nwrrw+uh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so27013685e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284712; x=1769889512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RT1hIcEsV+PJCTdaY4Qvov/IZclbWeMFt6FmnF1fdc=;
        b=nwrrw+uhfqQKT3IXI4KYDFdI7Ag4xM/scwMMWAKkf1OZ2Y5oiLbJNptKUJoZaP4LPs
         7zDzudlvDF/64gCJI3AuH6/0O5ChdpwOb920vLz8YfRhk4fTsCku5SdB42W++pdzsEAS
         o0osFheH7Abt6LoEKvtImi/BfFTT8zPxrfpBS3N8yd/kcDxnGu6H0eIZREt9oDPYQL6p
         +SKmvgjHIPA/qtKTiHG5eVtzfk9A16CeeO2KE2kAcZT35uq/5UydOJrKwtjL+D6rej9V
         K2pHcEt5fkbDPlFiLvFPfc8IhOfXfpX4QqvKRGTyUR+DNoYElYH/i7GnCsKdGUAMo3lL
         KV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284712; x=1769889512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RT1hIcEsV+PJCTdaY4Qvov/IZclbWeMFt6FmnF1fdc=;
        b=UlX1UYz/Sa5zdxktLSZK9oVXdusZPLrf7RGriEy9iSMy8WVjaBGZtLs54MkS7CM3fX
         kmOSoqy/nOwvXVYlOvcu7n0SlA9Y1XmOhi1soU3oIltqKtVDAHxtSLzgfDvLw1yjEYeC
         Znl3YLTx6NdbUI2UxOlqZgHUWgvfeEHJqss3j+YpVRYeXGt0Q6cBnYpegILa2KmeUaV1
         HPriMB6LOE8d0tYcFWmuoEEWcLodXR6gIuj0KRHTvy+LMZUntTZL3yJOWlF84lyvvwZm
         Te7G69yEv6pxTT5BIwy9gCJT4fo7qLPh1olMtk6pcibGSiHHpb2Gxw4trga7ict5ZwLO
         3eog==
X-Gm-Message-State: AOJu0YxQvmQtGB5ggtIJNAyR21VA4vDn5uZkokBBBFzWi+o9ec2m6p4W
	6i5kYcRGbOxaAPxy8BS9KDpSlMKz96NiQIdoG58cVtaWA5jWmOtr7MPeHokfGm42oiv4WBlEP82
	AzPwu
X-Gm-Gg: AZuq6aJYkVwyQpoDH5e4+KNKyl9VBghgNzu4SdMJJdUkD+aBlm9IXIp9relTastru1b
	0v0QFmbyGTuRhybnWGQ6muktB/r2GGXriOyIfo/mFq8e2yqyQVZkGmxAoEIb6aycejt4/cKwsyP
	cdmJSjsLD/lHZM3EiyvvTh8If95wDEhaxiqavUFz1rXtvXlczeUMMvXjEXuNW/NG7fKZTAY6eOy
	6W1i5TSJLyGGgHgX91lvdfGUbSBjX03D3wHMUwlQA5dwDFOAHCwzXqFePZNeHUJlDZJTudom7MO
	iqxZJpn0iEvS1IPA27UpeFlgET5S12Dw8f2YpIoZM601cWtCoLhBqUUXy7HayJc+Sqy8KjsZawP
	aDDe+VA8/TciUYAWr/YrzRmWNtNBgTXwBD4r8wVKEz9hHQYilkKYhLwGT96Z826mjgnM062vmxy
	glfDMeUqQ560tw3isaSIi2A8yfp2ZzXx2NU0qj8xChbgcBr1+b+A==
X-Received: by 2002:a05:600c:a309:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4804f51860amr76744275e9.32.1769284712115;
        Sat, 24 Jan 2026 11:58:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 2/7] devlink: fix grammar and style issues in man pages
Date: Sat, 24 Jan 2026 11:49:26 -0800
Message-ID: <20260124195824.221305-3-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-253101-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A4CA77EC97
X-Rspamd-Action: no action

This patch addresses various grammatical errors, style inconsistencies,
and clarity issues across the devlink man page documentation.

Changes by file:

devlink.8:
  - Add missing article "The" in -b option description
  - Add missing periods in object descriptions (region, health, trap)
  - Update synopsis to include all objects (rate, lc, dpipe)
  - Add descriptions for rate, lc, and dpipe objects
  - Add complete cross-references in SEE ALSO section

devlink-dev.8:
  - Change "HWs" to "hardware devices" for clarity
  - Fix verb form: "restart driver" -> "restarting the driver"
  - Fix plural agreement: "some driver" -> "some drivers"
  - Fix typo: "actrually" -> "actually"

devlink-port.8:
  - Capitalize "Set port type" parameter description
  - Fix preposition: "split to" -> "split into"
  - Fix punctuation: "on. or" -> "on, or"
  - Rewrite pfnum description for grammatical clarity
  - Fix plural agreement: "devices which supports" -> "devices which support"
  - Fix article: "a Ethernet" -> "an Ethernet"
  - Fix verb form: "restart driver" -> "restarting the driver"
  - Fix typo: "Unplit" -> "Unsplit"
  - Fix verb form: "active the function" -> "activate the function"

devlink-rate.8:
  - Fix plural agreement: "some driver" -> "some drivers"
  - Fix possessive pronouns: "it's" -> "its" (3 instances)
  - Fix plural: "leaf have" -> "leaves have"
  - Add article: "create leaf rate object" -> "create a leaf rate object"
  - Format "1to1" as "1-to-1"
  - Fix plural: "These parameter" -> "These parameters"
  - Add verb: "parent node applied" -> "parent node are applied"
  - Fix spelling: "behaviour" -> "behavior"
  - Improve phrasing: "treated as parent unset" -> "is treated as unsetting the parent"

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/devlink-dev.8  |  8 ++++----
 man/man8/devlink-port.8 | 18 +++++++++---------
 man/man8/devlink-rate.8 | 18 +++++++++---------
 man/man8/devlink.8      | 25 ++++++++++++++++++++-----
 4 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index e9d091df..d10b1f9a 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -127,7 +127,7 @@ Set eswitch mode
 
 .TP
 .BR inline-mode " { " none " | " link " | " network " | " transport " } "
-Some HWs need the VF driver to put part of the packet headers on the TX descriptor so the e-switch can do proper matching and steering.
+Some hardware devices need the VF driver to put part of the packet headers on the TX descriptor so the e-switch can do proper matching and steering.
 
 .I none
 - None
@@ -169,7 +169,7 @@ Configuration mode in which the new value is set.
 - Set new value while driver is running. This configuration mode doesn't require any reset to apply the new value.
 
 .I driverinit
-- Set new value which will be applied during driver initialization. This configuration mode requires restart driver by devlink reload command to apply the new value.
+- Set new value which will be applied during driver initialization. This configuration mode requires restarting the driver by devlink reload command to apply the new value.
 
 .I permanent
 - New value is written to device's non-volatile memory. This configuration mode requires hard reset to apply the new value.
@@ -198,9 +198,9 @@ If this argument is omitted
 action will be used.
 Note that even though user asks for a specific action, the driver implementation
 might require to perform another action alongside with it. For example, some
-driver do not support driver reinitialization being performed without fw
+drivers do not support driver reinitialization being performed without fw
 activation. Therefore, the devlink reload command returns the list of actions
-which were actrually performed.
+which were actually performed.
 
 .I driver_reinit
 - Driver entities re-initialization, applying devlink-param and
diff --git a/man/man8/devlink-port.8 b/man/man8/devlink-port.8
index 6f582260..a74ffecc 100644
--- a/man/man8/devlink-port.8
+++ b/man/man8/devlink-port.8
@@ -125,7 +125,7 @@ BUS_NAME/BUS_ADDRESS/PORT_INDEX
 
 .TP
 .BR type " { " eth " | " ib " | " auto " } "
-set port type
+Set port type.
 
 .I eth
 - Ethernet
@@ -144,7 +144,7 @@ set port type
 
 .TP
 .BI count " COUNT"
-number of ports to split to.
+Number of ports to split into.
 
 .SS devlink port unsplit - unsplit previously split devlink port
 Could be performed on any split port of the same split group.
@@ -168,7 +168,7 @@ Is an alias for
 .SS devlink port add - add a devlink port
 .PP
 .I "DEV"
-- specifies the devlink device to operate on. or
+- specifies the devlink device to operate on, or
 
 .PP
 .I "DEV/PORT_INDEX"
@@ -187,12 +187,12 @@ set port flavour
 
 .TP
 .BI pfnum " PFNUMBER "
-Specifies PCI pfnumber to use on which a SF device to create
+Specifies the PCI PF number on which to create an SF device.
 
 .TP
 .BI sfnum " SFNUMBER "
 Specifies sfnumber to assign to the device of the SF.
-This field is optional for those devices which supports auto assignment of the
+This field is optional for those devices which support auto assignment of the
 SF number.
 
 .TP
@@ -210,7 +210,7 @@ external controller.
 
 .TP
 .BI hw_addr " ADDR"
-Hardware address of the function to set. This is a Ethernet MAC address when
+Hardware address of the function to set. This is an Ethernet MAC address when
 port type is Ethernet.
 
 .TP
@@ -273,7 +273,7 @@ Configuration mode in which the new value is set.
 - Set new value while driver is running. This configuration mode doesn't require any reset to apply the new value.
 
 .I driverinit
-- Set new value which will be applied during driver initialization. This configuration mode requires restart driver by devlink reload command to apply the new value.
+- Set new value which will be applied during driver initialization. This configuration mode requires restarting the driver by devlink reload command to apply the new value.
 
 .I permanent
 - New value is written to device's non-volatile memory. This configuration mode requires hard reset to apply the new value.
@@ -317,7 +317,7 @@ Split the specified devlink port into four ports.
 .PP
 devlink port unsplit pci/0000:01:00.0/1
 .RS 4
-Unplit the specified previously split devlink port.
+Unsplit the specified previously split devlink port.
 .RE
 .PP
 devlink port health show
@@ -391,7 +391,7 @@ This will set the maximum number of IO event queues of the function to 4.
 .PP
 devlink port function set pci/0000:01:00.0/1 hw_addr 00:00:00:11:22:33 state active
 .RS 4
-Configure hardware address and also active the function. When a function is
+Configure hardware address and also activate the function. When a function is
 activated together with other configuration in a single command, all the
 configuration is applied first before changing the state to active.
 .RE
diff --git a/man/man8/devlink-rate.8 b/man/man8/devlink-rate.8
index 47e2ebc5..1689cba9 100644
--- a/man/man8/devlink-rate.8
+++ b/man/man8/devlink-rate.8
@@ -54,9 +54,9 @@ object can be presented by one of the two types:
 .TP 8
 .B leaf
 Represents a single devlink port; created/destroyed by the driver and bound to
-the devlink port. As example, some driver may create leaf rate object for every
-devlink port associated with VF. Since leaf have 1to1 mapping to it's devlink
-port, in user space it is referred as corresponding devlink port
+the devlink port. As an example, some drivers may create a leaf rate object for every
+devlink port associated with VF. Since leaves have a 1-to-1 mapping to their devlink
+port, in user space they are referred to as corresponding devlink port
 \fIDEV/PORT_INDEX\fR;
 .TP 8
 .B node
@@ -65,7 +65,7 @@ below) and bound to the devlink device rather then to the devlink port. In
 userspace it is referred as \fIDEV/NODE_NAME\fR, where node name can be any,
 except decimal number, to avoid collisions with leafs.
 .PP
-Command output show rate object identifier, it's type and rate values along with
+Command output show rate object identifier, its type and rate values along with
 parent node name. Rate values printed in SI units which are more suitable to
 represent specific value. To print values in IEC units \fB-i\fR switch is
 used. JSON (\fB-j\fR) output always print rate values in bytes per second. Zero
@@ -101,7 +101,7 @@ probability that the node will get selected for scheduling.
 This arbitration scheme can be used simultaneously with the strict priority.
 As a node is configured with a higher rate it gets more BW relative to it's
 siblings. Values are relative like a percentage points, they basically tell
-how much BW should node take relative to it's siblings.
+how much BW should node take relative to its siblings.
 .PP
 .BI tc-bw " INDEX:N"
 - allows the user to assign relative bandwidth shares to specific traffic
@@ -157,13 +157,13 @@ maps to the defined traffic classes under the IEEE 802.1Qaz standard.
 .PP
 .TP 8
 .I N
-These parameter accept integer meaning weight or priority of a node.
+These parameters accept an integer meaning weight or priority of a node.
 .PP
 .BI parent " NODE_NAME \fR| " noparent
 - set rate object parent to existing node with name \fINODE_NAME\fR or unset
-parent. Rate limits of the parent node applied to all it's children. Actual
-behaviour is details of driver's implementation. Setting parent to empty ("")
-name due to the kernel logic treated as parent unset.
+parent. Rate limits of the parent node are applied to all its children. Actual
+behavior is a detail of the driver's implementation. Setting parent to empty ("")
+name due to the kernel logic is treated as unsetting the parent.
 
 .SS devlink port function rate add - create node rate object with specified parameters.
 Creates rate object of type node and sets parameters. Parameters same as for the
diff --git a/man/man8/devlink.8 b/man/man8/devlink.8
index de53061b..9f1c42fb 100644
--- a/man/man8/devlink.8
+++ b/man/man8/devlink.8
@@ -7,7 +7,7 @@ devlink \- Devlink tool
 .in +8
 .ti -8
 .B devlink
-.RI "[ " OPTIONS " ] { " dev | port | monitor | sb | resource | region | health | trap " } { " COMMAND " | "
+.RI "[ " OPTIONS " ] { " dev | port | monitor | sb | resource | region | health | trap | rate | lc | dpipe " } { " COMMAND " | "
 .BR help " }"
 .sp
 
@@ -28,7 +28,7 @@ utility and exit.
 .TP
 .BR "\-b", " \-batch " <FILENAME>
 Read commands from provided file or standard input and invoke them.
-First failure will cause termination of devlink.
+The first failure will cause termination of devlink.
 
 .TP
 .B \-force
@@ -92,15 +92,27 @@ Print dump numbers in hexadecimal format.
 
 .TP
 .B region
-- devlink address region access
+- devlink address region access.
 
 .TP
 .B health
-- devlink reporting and recovery
+- devlink reporting and recovery.
 
 .TP
 .B trap
-- devlink trap configuration
+- devlink trap configuration.
+
+.TP
+.B rate
+- devlink rate object configuration.
+
+.TP
+.B lc
+- devlink line card configuration.
+
+.TP
+.B dpipe
+- devlink datapath pipeline visualization.
 
 .SS
 .I COMMAND
@@ -135,6 +147,9 @@ Exit status is 0 if command was successful or a positive integer upon failure.
 .BR devlink-region (8),
 .BR devlink-health (8),
 .BR devlink-trap (8),
+.BR devlink-rate (8),
+.BR devlink-lc (8),
+.BR devlink-dpipe (8)
 .br
 
 .SH REPORTING BUGS
-- 
2.51.0


