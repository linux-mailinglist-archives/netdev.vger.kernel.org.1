Return-Path: <netdev+bounces-37544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0D7B5DDF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AF6351C2040F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB020B0E;
	Mon,  2 Oct 2023 23:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7C1F952
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:49:52 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80017BD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:49:50 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAFE6421D3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696290588;
	bh=AjavhkXEqqoxJ4mo7EqqEJ3v6qKyv49UU0GhFeQVQ6U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=KkWiQYLpLknrtNofKbk4aYU0yh05StmflDdLhZsaJ5cXdI5mbV0X6xTrLOzqdFdFC
	 uQ8k0JVKFW+OSUkta3gYN2o4HOdUhJvKArQmHmQdIsz9WxqzIgKf0xYyeKWOBqFHvo
	 AlitRsVmkPGXT2Orcf7eJJJt1Ddm6b+2g0XjlECQPN/Mpo5HG4F3lKkNZKkj5W+EI6
	 6MayH1DCCy81clOJK/MsgzIEc6L3ZvWkrIdwwBWOviAQsPBLpFq8o40ueVbOqITuXB
	 K55OtKCElrBen/HkJcuCEHNeZi6qbgmjmeNkYScGSvPoAJC6O+2FI6G8iQFFZGWz7z
	 Uz9Hb23mDPmBg==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-57b78a20341so455312eaf.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 16:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696290587; x=1696895387;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjavhkXEqqoxJ4mo7EqqEJ3v6qKyv49UU0GhFeQVQ6U=;
        b=L+B86hiFGX3uoAY88uBQ0D6fWu2L+5tuNHz933PAfatX8i3zafbvjhhi80wJTcAjCP
         zbWhJSY3p2oGIH4w8dFYkckeKKQaucd7aOE7hv8lW1t3f4vEyflHnuGCSDOiLfHi0u7L
         taj23UoN44bzlLsUDq9x7+UJD7VWouaGw7pkQMCiqP2ItlEKn9SIvBBV4SKJf+Uyy4iC
         048lPWPy39qqqGYBs4eun/SlDhSXLR2MWzz3wftwPLArC+Jnc/79bWpHy8Cdr/d8S+1i
         KYlgKQrbVsTBLBOfNVbcWUEMLuqyxUt4CWkdYYd5/xuulmGmYguxepiEFG5GRwSoySoE
         4eMQ==
X-Gm-Message-State: AOJu0Yzv661Njhurox41SKUw6WtZuyocOQ6978lLz7YMAShu4ZigjKf2
	AXFtO1CZkdI595oGds9+YfbhfUHdVKpGexx/jcieRFkvHrD8y8Q2vH2mqKJImBWLmOm1Wydqb39
	J2Vt6xFsTu2YGcM2KvRf3pjSGXB2+Nexd2w==
X-Received: by 2002:a05:6358:885:b0:143:7d73:6e66 with SMTP id m5-20020a056358088500b001437d736e66mr15071590rwj.1.1696290587488;
        Mon, 02 Oct 2023 16:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxwIqMeEy5Bt05d/eyb63qXsAy1I0+XnX4JXJlzbSFzbibgmnr1DZBWve3KuOEFy+L0HDH1w==
X-Received: by 2002:a05:6358:885:b0:143:7d73:6e66 with SMTP id m5-20020a056358088500b001437d736e66mr15071572rwj.1.1696290587159;
        Mon, 02 Oct 2023 16:49:47 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id r13-20020aa78b8d000000b0068fe39e6a46sm56681pfd.112.2023.10.02.16.49.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 16:49:46 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 3FF125FEAC; Mon,  2 Oct 2023 16:49:46 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 38C939FAAE;
	Mon,  2 Oct 2023 16:49:46 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
cc: intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org,
    pmenzel@molgen.mpg.de, netdev@vger.kernel.org, jkc@redhat.com,
    Vishal Agrawal <vagrawal@redhat.com>,
    Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: reset first in crash dump kernels
In-reply-to: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
References: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
Comments: In-reply-to Jesse Brandeburg <jesse.brandeburg@intel.com>
   message dated "Mon, 02 Oct 2023 13:02:32 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17922.1696290586.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Oct 2023 16:49:46 -0700
Message-ID: <17923.1696290586@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

>When the system boots into the crash dump kernel after a panic, the ice
>networking device may still have pending transactions that can cause erro=
rs
>or machine checks when the device is re-enabled. This can prevent the cra=
sh
>dump kernel from loading the driver or collecting the crash data.
>
>To avoid this issue, perform a function level reset (FLR) on the ice devi=
ce
>via PCIe config space before enabling it on the crash kernel. This will
>clear any outstanding transactions and stop all queues and interrupts.
>Restore the config space after the FLR, otherwise it was found in testing
>that the driver wouldn't load successfully.

	How does this differ from ading "reset_devices" to the crash
kernel command line, per Documentation/admin-guide/kdump/kdump.rst?

	-J

>The following sequence causes the original issue:
>- Load the ice driver with modprobe ice
>- Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num=
_vfs
>- Trigger a crash with echo c > /proc/sysrq-trigger
>- Load the ice driver again (or let it load automatically) with modprobe =
ice
>- The system crashes again during pcim_enable_device()
>
>Reported-by: Vishal Agrawal <vagrawal@redhat.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>---
>v2: respond to list comments and update commit message
>v1: initial version
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
>index c8286adae946..6550c46e4e36 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -6,6 +6,7 @@
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =

> #include <generated/utsrelease.h>
>+#include <linux/crash_dump.h>
> #include "ice.h"
> #include "ice_base.h"
> #include "ice_lib.h"
>@@ -5014,6 +5015,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_d=
evice_id __always_unused *ent)
> 		return -EINVAL;
> 	}
> =

>+	/* when under a kdump kernel initiate a reset before enabling the
>+	 * device in order to clear out any pending DMA transactions. These
>+	 * transactions can cause some systems to machine check when doing
>+	 * the pcim_enable_device() below.
>+	 */
>+	if (is_kdump_kernel()) {
>+		pci_save_state(pdev);
>+		pci_clear_master(pdev);
>+		err =3D pcie_flr(pdev);
>+		if (err)
>+			return err;
>+		pci_restore_state(pdev);
>+	}
>+
> 	/* this driver uses devres, see
> 	 * Documentation/driver-api/driver-model/devres.rst
> 	 */
>
>base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
>-- =

>2.39.3
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

