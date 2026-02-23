Return-Path: <netdev+bounces-260072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5yAe1rnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:02:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1A178625
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1803173644
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41B265CC2;
	Mon, 23 Feb 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g+tOsEHg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A626C3BD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858575; cv=none; b=JMHuJU66QJYzPG7ig3el7Ujwu+CGCtRqMQdypuMVJVx63aKB4ixdBNpjXlg9kiF7bJR+8yTSLtSlzmttEclSmQLWDm9LTFKpw+95AtBwQ8I7R/3ouASOQ06pmu0VxI6IqrszooLe56pmzBMFgHB0nl22zPCvx1vOkbonqNqAqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858575; c=relaxed/simple;
	bh=hBarFku/NZ5VcK9jJF/ZiUUmnwkStNaXa4hon2vHBNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7ExzKr7933UPrXzoNfHCBEqkMPkdvppN2mmRWkIzi3RsuB0BaSoXU1AMRlQMo45kB9zHygUut+wW52NQrGkrdxZxc2KL4E/6z4A5m+9lZ+F967+Fil/q+CR/Jzkyp5CFxbHr+frgWxHn8jbR++YYxhjjCfOk1fMrSWaWdBegiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g+tOsEHg; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so3324254f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858571; x=1772463371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByyfeUF5rDOxJ1k2Wdi0Qfn68cRBhkzv9N49WEg4HfE=;
        b=g+tOsEHg9Q0kmEH8wP+w+LyKe9PB7yF5Ax7WCbMCXUuIkaRxi4aE4l6rQkd6TSWZq8
         WQugVU6VAXe7I/skN205rxYb823xRgTPSZYrrATXK9iDh7OOgyRHuBCDZnKzkQ4ln6Yi
         K8/d5a2vhMTc2f6HlPSsb2r/OxwNVWiyvgE5ZOMJ41TsqrzkL45kXeCDNG+cvr8TctJ+
         4e5kvNONO1moGx9pUCRsETCvtTsSkl/o3eU9EugLjRLaugAMSSivbX0wyx7bctzVwvdf
         SKtch2DKqgH2L8XYT2VDA4gJM2Nf2/Cp/VWgNOiJ+WSjYl5HAL2E9InDqOkfazZ2egMx
         hsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858571; x=1772463371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ByyfeUF5rDOxJ1k2Wdi0Qfn68cRBhkzv9N49WEg4HfE=;
        b=hI8nQ1E0SafIaazgyZNjgv11es5iDLGYRAp0VnQZIz3JCfDvYsTC3HtXKR6NWU0dOI
         PCHpSWt2htAHDp4MCVmua9FiC5r6PjgddoMGo0n2t2tvr6c2Nzo74BzDO+3wdF9tjiHR
         5CzpEsrRlawQAQmyOgP+aRMrhW6f+WV0EpAhKbiMfsOOprxtHGmAUpbhmFtKNgbrJF3H
         VJ1b4Xsfsn7LyBrwynBKAHOtrPfos2ysxn2PhaQup1M+zUvJyUrCWafHyr98Pw5vSVXD
         rJPNZ5LEWHsAYRQNj3xXRNJrgnuwEoYdHdRUwbsO9KeB465sfsRsLx5fY7fzIN8ggyq+
         YhLg==
X-Gm-Message-State: AOJu0YzVNUdBi8TPMiUOcjjH5RqTiHHN72u+rTMC5usWCARpSs+nqv3w
	UplieiszfuONigbAU4V9AmcAnfALIRymv8vpucu4I4FL31L2dj+zJVh1T6q/1/JyFiXJElGz7Xr
	WIG/5+0w=
X-Gm-Gg: ATEYQzyOImL60V9HwzeDZqoO3H/TbvubIEe3GcTYtVJYRSXOrpNx7vSxJwhQ/0MaJgD
	+VEc2eewgOATJk2qlF02TMOPVgs29AfYXCliCxGJlEm2USJVWQYwT1LEDzaiWQvxGoenEaH514U
	9Hf+1ISDmvY0q6GSAoOtGwAETP3bRxW4inVobBR3iYTUGi3MQ43pWk3a3snrvaxg3FQgsUGOts0
	1r2l523rjg1QS80zhNOn3hXGPzu7FnTcKpBnnYoZVPtWiwC9+H3IGQszp1qGvFnmpx5IW7+tfUa
	yYa0ymA/sjJpXkSugMWgDGOqHw5mBy5dDrum/JoxQHCQ//HVddYHXp3BjpMkmd0muc/2lNHFu/j
	Lv2ZvN1RTfbIs/K04wBh9kvJEw4HQVPs5ZJPCCkmvIoUMRt69uGkfVn084wrOOV7OYB43o1GVPL
	P5alCAQC0da8jzsnm4CuhsYP6f
X-Received: by 2002:a05:6000:4201:b0:3ec:db87:e5f4 with SMTP id ffacd0b85a97d-4396f15d10cmr15553913f8f.7.1771858570504;
        Mon, 23 Feb 2026 06:56:10 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19710320f8f.6.2026.02.23.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:10 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 09/10] documentation: networking: add shared devlink documentation
Date: Mon, 23 Feb 2026 15:55:56 +0100
Message-ID: <20260223145557.248679-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223145557.248679-1-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260072-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 62C1A178625
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 89 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..b2a1bd37564f
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Devlink Shared Instances
+============================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share an additional devlink instance for chip-wide operations. This
+is implemented within individual drivers alongside the individual PF devlink
+instances, not replacing them.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+The shared devlink instance is not backed by any struct *device*.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation uses:
+
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+API Functions
+-------------
+
+The following functions are provided for managing shared devlink instances:
+
+* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
+* ``devlink_shd_put()``: Release a reference on a shared devlink instance
+* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Get or create shared instance** using ``devlink_shd_get()``:
+
+   * The function looks up existing instance by identifier
+   * If none exists, creates new instance:
+     - Allocates and registers devlink instance
+     - Adds to global shared instances list
+     - Increments reference count
+
+4. **Set nested devlink instance** for the PF devlink instance using
+   ``devl_nested_devlink_set()`` before registering the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed
+2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include:
+
+* **PCI VPD serial numbers**: Extract from PCI VPD
+* **Device tree properties**: Read chip identifier from device tree
+* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
+
+Locking
+-------
+
+A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
+
+Reference Counting
+------------------
+
+Each shared devlink instance maintains a reference count (``refcount_t refcount``).
+The reference count is incremented when ``devlink_shd_get()`` is called and decremented
+when ``devlink_shd_put()`` is called. When the reference count reaches zero, the shared
+instance is automatically destroyed.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.51.1


