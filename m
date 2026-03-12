Return-Path: <netdev+bounces-266986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHZ7KfiQsml5NgAAu9opvQ
	(envelope-from <netdev+bounces-266986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:10:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E52701CC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03C62321DA81
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EC3C3456;
	Thu, 12 Mar 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qj8Mfr9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4913C0631
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309871; cv=none; b=W6jb+g6t8f0gg/Dlab0TWWaHqGnEoUN95EafiJCN3QBTJDRAQJP19dl4LNcJAL7v2+ul+sRapL856DJO0OM8jASm8j1TfJTZZYm/Wv20O4hJv4UqV3cawQndhAPZkt/Y/R0Ka6QeAHFw17V/iaVF7XPyhcRpuy6XKWDrQxsnBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309871; c=relaxed/simple;
	bh=suAlp0+6vIiTYE/DszDuVSfJ/B/GhkXRhq5R0j4plyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPW6EP7TSJinekrVV4M+WUyzHt2GxxsQ2nVEj73gHSNXZkNXyFlsHiByBa6cSv52cqVd9GqmtD9dyttUrgQinzhy2NbqPVgE1Fa7O9vn9WjFK2BmFkEpB5HPiE6kctx+ETUs2JNPIWuuNQVfEpYrJ8vNKQp8aSCx0SQKv8k9i5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qj8Mfr9U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so1029993f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309864; x=1773914664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=Qj8Mfr9UwfhRSIgZUQHCZrKZIc0JzTFDaGraVvYFVfiMJeR8SifuCWCbXYITEiPNQS
         0DVGihRcwAKCf9yQciNxuEBl0hi9rx9W5AfHTg5G2AgxZbtwux/rXKdserotbDESUpcc
         hL4gfiQ7Ua6vVNv+5VdsZ+vPgedQhBmJ+BWMC2mFYOnMh3Pwsc1OLa5gAAMK6DMZPi1d
         u5AVVnOMBRnT7hBZip+cSKjEYlAVLUECpjQgReDTnKyx//W2UcST2Ye4czr7hXc+/C+7
         zgDfE9/lR2BDsNGQWPDc/eeb2HSARLJjToo8NDIdosm4igl4SY0zP61MCRbG0o7RTFmT
         8ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309864; x=1773914664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=M67XTH0LZ+A9hmPHd+SZiBNOqKm1clDkhaxQDUtx6hLyNELJtwgHvVd9HbyekVL8mP
         0AlXpcXKVF8EehJiCM4eOW46hzF4CkzNU4waC3IVWhEEMYniXTbQMUDlVGwqTHheBy6I
         Jvnkc2/Nz1kCD7xo1LN0d/oGAF/riIUrZChnLbDlx2W+m4c/q6aMQV5Or+QmvY5bhw0Q
         72MlEnixdxFzG/A/I+VYhnqh6KMztoXyUDLBL2Sv2rKh9vzdNM6YAEiWQMB9lvtJosM8
         BbJEakwGLlnZvMoNZnRXZEj3Ltey1yfjNfAxMrYVHTooxQfdw+daHgauAo/ryxU8vyll
         976g==
X-Gm-Message-State: AOJu0YxVpe1S4BHYB+QYZ8sQ0CRV03fKPqbooc74tw4Q6Fe/NkN4Sz3X
	8J0fNiLb+K2UWkWOhhd4fLEovuPdg34T9qFI49HcBFgvalcSv4kdQt8J3YsJa63n+onR2VHEnXV
	RbBCjmoubbA==
X-Gm-Gg: ATEYQzwOZcNfeEWi8DeDdVrDN4fq8MYM+FulFW3n96YLJVtQwENUoSrP9oSiRHVYdrP
	a+9lDhUHFCFQi9DSWO9PWuvyURL6b30BD1MdndlCCMlK7ATQwKVAzaT5NTjRjXfw/oWSDCuTas0
	gQQC/HU30lpfq/5T/htw1PiBBCkyDrxINB4TUqdv9ZM26jrGT9Q/Lj2VI71K+Er8YBY4CtCIQBO
	d5aMUnjzkXc/3qXz2yKKohRyeQrlcPRU+NGtEWDEb+/jKD3QkN4FkDlXXpOuMUt1ZFSS7Hxenuf
	JVB+UNdSJejs61QDUGjxmQC2e1ZjsV0Wy7LNBpmR0pcCOzyHBi+N36D1grpzQ1hzVryaM9OkTAw
	flVid8nJXkABKAHrNrze+s18O3bLNF0D6SIeso9U66W97hkBQFn+xmyIh9RmvnDyFbVDPX+fRNI
	iuspNUAIV3oOB0aA==
X-Received: by 2002:a05:6000:40db:b0:439:af81:1b2f with SMTP id ffacd0b85a97d-439f821fa57mr10881376f8f.46.1773309863778;
        Thu, 12 Mar 2026 03:04:23 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b22e7sm7506007f8f.16.2026.03.12.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:23 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/13] documentation: networking: add shared devlink documentation
Date: Thu, 12 Mar 2026 11:04:06 +0100
Message-ID: <20260312100407.551173-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266986-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 491E52701CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- describing 2 models of use os shared device, with and without per-PF
  instances
v1->v2:
- fixed number of "="'s
---
 .../networking/devlink/devlink-shared.rst     | 97 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..16bf6a7d25d9
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Devlink Shared Instances
+========================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share a devlink instance for chip-wide operations.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+There are two possible usage models:
+
+1. The shared devlink instance is used alongside individual PF devlink
+   instances, providing chip-wide configuration in addition to per-PF
+   configuration.
+2. The shared devlink instance is the only devlink instance, without
+   per-PF instances.
+
+It is up to the driver to decide which usage model to use.
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


