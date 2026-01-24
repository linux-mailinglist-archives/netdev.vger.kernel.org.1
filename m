Return-Path: <netdev+bounces-253105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNaQKcEkdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:00:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB77ECB4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549213034E2F
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D3279908;
	Sat, 24 Jan 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aibV65B1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E07272E6D
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284721; cv=none; b=HBcHY3RUyYp+qXlT86/HgCYHMjZ8GfoHPUhvyZgBWqVN21cxHIhL5jnAYwcbbYJF0+xYKfLDVg8ucPYXgAI379GQPWVdJS0Y7taUKJpxnh1BLb463O5/Hxtyb9FpognaZEh31CSDwSL5UoDybkB3JblTvQSwXhhZmq+Xn9WVW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284721; c=relaxed/simple;
	bh=L6Wd2BhERuSKnYfF//DEgQAZKxfuFznfnyuKYLzpGxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVcI4tb2xzpjrqY9ykDLqspGYDJHJl7uAPM1RdQofQmD8j3c65CDITnSt+vNHuylTrtoUuuwfinornK9suWNZarqzybiQ1WLeD4dw85wZhJOyiBLbda9w4AMrByU8QZo7s9Y1UH7h0r6UeHQvSWxJyMUr//cYhkv8vUi8aTy2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aibV65B1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480142406b3so22333585e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284718; x=1769889518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGXDTtcUfov4xDNOXudgc+xFFCq1pXc8ESe99K20ts8=;
        b=aibV65B16WSIGF/8vIcJ7BWAVUIw3GRdZDDCI4jApzudrt6d9ZUD96JeuWzaAVtRSs
         tCjWpRqf6XC6ywbg+qSDUcy1c7lNmrCuR1A7TmQgiqWDZYvDeOhgER7qqrJPbuj+u9hr
         GvYjtPUPnXBpBRpqu6hBQuOShEisPHMNR1hwlpQ5/jAZranekcPwVc9GhsOr0/kJafSS
         Wgml2aevMQdFZWg3plq60tQjc5gcw3r5N9IYtKdkY6ntkl4MBWM3ck+ndwt4TlyEE++r
         1aGp43+Ezt40dXQbaMKFqr66+xffeGXQt0LwSlF/Aoq4GvxIHzgDTQIdvC3M+/TL0cDs
         FmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284718; x=1769889518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGXDTtcUfov4xDNOXudgc+xFFCq1pXc8ESe99K20ts8=;
        b=i+QpEG0egSi473R7d5mnTJUSzghYph1tI035rGF1SH0e237JW2nXXKhUn3tWzzNw8J
         cz52n2lFHGx/5+H4c+C6QvqH4R033aUS/uUhQ2dfYm9aXZU14qq9quw6XHZ0gB1LpsKK
         L4N6rGt2Jn0GL7cr3kIZzcV057fo6h1Jy3AuEku5Pv0qU3L5ciqDPhJdtRQjNiWxW9+t
         62++qOSv1+k1dKarHdRUT6LifjnjGckPYemY2osXeMnKtPTs1HOOsn8OuPVz+3Nu4RYk
         WAJpEzCb2H6oCvNkbFz4WUN4PDh3mLWE2JtTQdJf5tAo6914f1IGuXDC5vWkQVWsrqjH
         C+kA==
X-Gm-Message-State: AOJu0YxJNGN+p7SzYiM2VECiXOId391h8jBKZXsG0vRyjOiZjW9iPw2m
	Uxy8KtgJhnMwQ5FtbrEq2Ioi0OUYUbIKC1JnvW1mhhv7NSVkgRSQY22LM7qYn4Zcoxhb/FCidIi
	BAh4m
X-Gm-Gg: AZuq6aKXv33zW5uNRjTc3OFIy9IrrslWCAe5FtG1mCZltO2c+4SYpQ5XtOW7ptSzdIW
	esxFpbbk/FHd1fBHaAgTlT9C3CQngp8oc/t2lSe1wbuAXLBmaReIHpTjItFSt0dh9N9nZwrkjgL
	qCr9W0zytbpr7ACWvilBmVvJuZCnA18HJQqx427jzUwObNjGXUw6oaOsbieKX6BZxRD2CRIWso/
	rFxrWq36VVo7gd4QFkAmgWzJYOYoAxAMEemddUoqEr5UH7wH7yzxKk2L2G0MaUK+S6AM+CLtCtO
	hS3WNfJF5819Q6wRbo68oPFQ1KHMasHw/dFa5iZ+J89yRrC64vaVAeWMwXg28h5epyXnuA56sMa
	aXhXN3iEb+i9D9A49uVy2Pfpx2mRI2cyEkqMCSzARjWnCH+slrAP7cVl8CAe8XeEPaNh3lYCtme
	JeWdHMqtZD5d2SWc4n38aCA1R2+ROwaWj+kLhRMh2CU+Gb+CeiAw==
X-Received: by 2002:a05:600c:4693:b0:480:1f6b:d495 with SMTP id 5b1f17b1804b1-4804c9bf396mr105605955e9.32.1769284717918;
        Sat, 24 Jan 2026 11:58:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 6/7] vdpa: fix grammar, titles, and formatting in man pages
Date: Sat, 24 Jan 2026 11:49:30 -0800
Message-ID: <20260124195824.221305-7-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253105-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F3DB77ECB4
X-Rspamd-Action: no action

This patch addresses grammatical errors, copy-paste errors from devlink
documentation, and formatting issues across the vdpa man page documentation.

Changes by file:

vdpa.8:
  - Remove unnecessary article: "a pretty JSON output" -> "pretty JSON output"

vdpa-dev.8:
  - Fix incorrect title: "DEVLINK\-DEV" -> "VDPA\-DEV"
  - Fix file path: "virtio*h" -> "virtio*.h" (add missing period)
  - Fix capitalization and punctuation in macro description
  - Split overly long vstats section header into title + body
  - Fix spacing: "-Name" -> "- Name"
  - Fix article error: "the all vdpa devices" -> "all vdpa devices"
  - Add missing periods to example descriptions (2 instances)

vdpa-mgmtdev.8:
  - Fix incorrect title: "DEVLINK\-DEV" -> "VDPA\-MGMTDEV"
  - Fix NAME section: "vdpa-dev" -> "vdpa-mgmtdev"

The title corrections in vdpa-dev.8 and vdpa-mgmtdev.8 fix critical
copy-paste errors that would cause man page indexing problems and
confusion about which command is being documented.

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/vdpa-dev.8     | 18 ++++++++++--------
 man/man8/vdpa-mgmtdev.8 |  4 ++--
 man/man8/vdpa.8         |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
index 718f40b2..4e2522f0 100644
--- a/man/man8/vdpa-dev.8
+++ b/man/man8/vdpa-dev.8
@@ -1,4 +1,4 @@
-.TH DEVLINK\-DEV 8 "5 Jan 2021" "iproute2" "Linux"
+.TH VDPA\-DEV 8 "5 Jan 2021" "iproute2" "Linux"
 .SH NAME
 vdpa-dev \- vdpa device configuration
 .SH SYNOPSIS
@@ -84,9 +84,9 @@ Name of the management device to use for device addition.
 .BI device_features " DEVICE_FEATURES"
 Specifies the virtio device features bit-mask that is provisioned for the new vdpa device.
 
-The bits can be found under include/uapi/linux/virtio*h.
+The bits can be found under include/uapi/linux/virtio*.h.
 
-see macros such as VIRTIO_F_ and VIRTIO_XXX(e.g NET)_F_ for specific bit values.
+See macros such as VIRTIO_F_ and VIRTIO_XXX (e.g., NET)_F_ for specific bit values.
 
 This is optional.
 
@@ -116,7 +116,9 @@ Format is:
 .in +2
 VDPA_DEVICE_NAME
 
-.SS vdpa dev vstats show - shows vendor specific statistics for the given device and virtqueue index. The information is presented as name-value pairs where name is the name of the field and value is a numeric value for it.
+.SS vdpa dev vstats show - show vendor specific statistics
+
+Shows vendor specific statistics for the given device and virtqueue index. The information is presented as name-value pairs where name is the name of the field and value is a numeric value for it.
 
 .TP
 .BI "DEV"
@@ -129,7 +131,7 @@ VDPA_DEVICE_NAME
 .SS vdpa dev set - set the configuration to the vdpa device.
 
 .BI name " NAME"
--Name of the vdpa device to configure.
+- Name of the vdpa device to configure.
 
 .BI mac " MACADDR"
 - specifies the mac address for the vdpa device.
@@ -139,7 +141,7 @@ This is applicable only for the network type of vdpa device.
 .PP
 vdpa dev show
 .RS 4
-Shows the all vdpa devices on the system.
+Shows all vdpa devices on the system.
 .RE
 .PP
 vdpa dev show foo
@@ -154,7 +156,7 @@ Add the vdpa device named foo on the management device vdpa_sim_net.
 .PP
 vdpa dev add name foo mgmtdev vdpa_sim_net device_features 0x300020000
 .RS 4
-Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000
+Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000.
 .RE
 .PP
 vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55
@@ -169,7 +171,7 @@ Add the vdpa device named foo on the management device vdpa_sim_net with mac add
 .PP
 vdpa dev add name foo mgmtdev auxiliary/mlx5_core.sf.1 mac 00:11:22:33:44:55 max_vqp 8
 .RS 4
-Add the vdpa device named foo on the management device auxiliary/mlx5_core.sf.1 with mac address of 00:11:22:33:44:55 and max 8 virtqueue pairs
+Add the vdpa device named foo on the management device auxiliary/mlx5_core.sf.1 with mac address of 00:11:22:33:44:55 and max 8 virtqueue pairs.
 .RE
 .PP
 vdpa dev del foo
diff --git a/man/man8/vdpa-mgmtdev.8 b/man/man8/vdpa-mgmtdev.8
index cae2cbd0..9a7529fc 100644
--- a/man/man8/vdpa-mgmtdev.8
+++ b/man/man8/vdpa-mgmtdev.8
@@ -1,6 +1,6 @@
-.TH DEVLINK\-DEV 8 "5 Jan 2021" "iproute2" "Linux"
+.TH VDPA\-MGMTDEV 8 "5 Jan 2021" "iproute2" "Linux"
 .SH NAME
-vdpa-dev \- vdpa management device view
+vdpa-mgmtdev \- vdpa management device view
 .SH SYNOPSIS
 .sp
 .ad l
diff --git a/man/man8/vdpa.8 b/man/man8/vdpa.8
index d1aaecec..81725312 100644
--- a/man/man8/vdpa.8
+++ b/man/man8/vdpa.8
@@ -25,7 +25,7 @@ Generate JSON output.
 
 .TP
 .BR "\-p" , " --pretty"
-When combined with -j generate a pretty JSON output.
+When combined with -j generate pretty JSON output.
 
 .SS
 .I OBJECT
-- 
2.51.0


