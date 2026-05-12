Return-Path: <netdev+bounces-287236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJlxIYJZA2r75AEAu9opvQ
	(envelope-from <netdev+bounces-287236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:46:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A49525019
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5633A3031002
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41F3CF973;
	Tue, 12 May 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2NYidZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE553CC33B;
	Tue, 12 May 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604109; cv=none; b=NigdRGYwSiuANwu4ufAW8N2AOLJuWu6OC5gBDeBuuC7fRJV5SwPkh/Egw5O1HqJErBzse1tQxyUytMRlOJplu3C+ERqlLJI8qe6D/kq6BWBZaTa+W3AAkoq587kFY8qI7r5m1z9Dh5BuThitjQzaYVcJ1nqNPISKOVRwprIhJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604109; c=relaxed/simple;
	bh=sDKzjJIoYemAJXB0W41Wl/AHU3Mk0E8Z74IrAA+yBzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYv19KttIGWnkmNQvp7nEZFNmQjE0R0JUk61eCgcDneQyoJh0pIOiTrkmZLuxB8Bg/79J7Lpbx9P9NIZ1TUA0HIaOXP7cuA6wT5SAlIuNBq1E47fc6jK4s2O49YJX4vxyGOmbgZ2SyLpmSdIeEcBaIwht57WOgBAIrn4c8/XTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2NYidZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3FFC2BCB0;
	Tue, 12 May 2026 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604109;
	bh=sDKzjJIoYemAJXB0W41Wl/AHU3Mk0E8Z74IrAA+yBzM=;
	h=From:To:Cc:Subject:Date:From;
	b=a2NYidZh74SgSqPwDv3IvNoJ0jciR/ctWViZLCnsSv8BWvXaO9VKNhV5uJ5tHaBcG
	 LmFOBFosv1ccL/RE74UCto2/FqKRe7jJYWIfiZ7/oOclH/u95OL95LI9+ORAHni4KQ
	 dms+DoqGKgagm0+d5SwoxHktkzqQ220VXDjGZuaY+lJpdUIoAKB8RDBD0VkofAUseX
	 cUhDZ1WuygSkYEB/Ng6FUO3thO3KtyovMb0WMkk/vYK0NFCtvByvNW7IRhh4uUFHco
	 XNXjWJPVyIc31S9UEh/oSVliWfGl64Kdcg8MHA+Li2uk5loHKD6rwXZ/sxn9Pm/6dJ
	 8dq1QWoW4R3Fw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nick Shi <nick.shi@broadcom.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ptp: vmw: Drop ptp_vmw_acpi_device
Date: Tue, 12 May 2026 18:41:45 +0200
Message-ID: <24384916.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E9A49525019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-287236-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Static variable ptp_vmw_acpi_device in the ptp_vmw driver is assigned,
but never used, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/ptp/ptp_vmw.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -18,7 +18,6 @@
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
-static struct acpi_device *ptp_vmw_acpi_device;
 static struct ptp_clock *ptp_vmw_clock;
 
 
@@ -91,8 +90,6 @@ static int ptp_vmw_acpi_probe(struct pla
 		pr_err("failed to register ptp clock\n");
 		return PTR_ERR(ptp_vmw_clock);
 	}
-
-	ptp_vmw_acpi_device = ACPI_COMPANION(&pdev->dev);
 	return 0;
 }
 




