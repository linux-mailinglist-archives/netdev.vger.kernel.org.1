Return-Path: <netdev+bounces-290859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPFHCrlqEGrnXAYAu9opvQ
	(envelope-from <netdev+bounces-290859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3015B64CB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 417DA3077E1C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FB47A0DC;
	Fri, 22 May 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqEkLykT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC844CAF5
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459957; cv=none; b=TN+ND/HbVgkKhGjmvKAsMDfmQLYas4c9bF27flc7MiqAfVeevl78Vb7lWLqxrbePhYAClrZnlhv3e+vUvb5HXmpniCHvU6tnhxZIM3WNLNRy3FB8CcAwvN0TRK6o6DuJfOiXS+AGWPIc0L45NaV164CBzkZKXjyfUZ5wmuGVUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459957; c=relaxed/simple;
	bh=p4R7AdYgnpQrXWvTjnkiC+swEt56EoTqiSQYtt6zCYY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NZSCf9AnO24t0H63Oiax6WemlXhRNBpuv3S4kj13KpBmjS+NkVHFyFmp/QeNhso3J5QpTcCNZBinzaTTHNkYiRL16HkQLyubJarpr7mV9VwwnLIAzGWC7ZKGmVmJjNyc5/Hw0NCAqYmKWMtFVxRlDSS2MX49DZprf4i7dMEU3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqEkLykT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa2691db86so5516758e87.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459954; x=1780064754; darn=vger.kernel.org;
        h=mime-version:references:subject:cc:to:from:date:user-agent
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f7YU/70ppJUKskEkIhiqn0JkkkPomh77HSx0vSTwI4M=;
        b=CqEkLykTxtLpLjLC1lP+YTRLKJZPC9UIXtHaNL7o8tW1Qs3SfvqT2NybWA/z3oZGQ/
         1SM8beWPTj+EyUZMdrTjruMp1UXfU9YxDf4bZVyKBv8N0q/80N5D1bdWAFXNHAqZ17OJ
         JgOdO3+eBFST4Px4JDCUxgmIiCbMfxv2ia09XfSjEqY2He/08wx5tzhGshc0K4x+FL2W
         0Dck6JS2NoHdSlK06tIzoFpK5EUzDjSqDg3z7rfdq8fXT9GVOyiERVTnxXY9nUs6MHsF
         2Fefn+WdaqG90i03rIS5aba137pditPAFYXMKT8sUUjPGkmcgwBW9bBjteexVQiXaA2i
         TOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459954; x=1780064754;
        h=mime-version:references:subject:cc:to:from:date:user-agent
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7YU/70ppJUKskEkIhiqn0JkkkPomh77HSx0vSTwI4M=;
        b=fsslXUZ+Q3baJtdjmQfL4uKLwTSNKlaI5w7u18nRcgLWNTTMR0uKXhOuAmbOAff+VC
         AxEcaOylyXPqL8vZp0qOvA+8aQ4xTZd9HFZesm//Kwks/8ipg5W1ashuYZlGKYQCyqt2
         A+31tZSLyytbmgboxzIm1OHxPbcyfNL1qbMixqHBy0FQWN+z/mNrIKl+ZdT1LEvg0UZm
         bDIvpe7kZnjfR6aP3UkMSq7g4D8ahctZgI6ZGrRaYqEpnwYoJ3m7DdGO2FsGYsY8dkAd
         GgYywxP1AeQtsEF9Fh3H/KyDriQJ5/HftJwxxXp0R7rBP/siPCpIW22YDhy1NxHI7nHx
         jwug==
X-Forwarded-Encrypted: i=1; AFNElJ84oV5hrU1T8Up4uF6/zaGrt9303h55YqV1Mpd0SYUudnCHRyKDovExy634YEhDSuVzBloXxCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0G5UlN0K7lpaPPWeNJ519UeyrrWorShUrOHWSkOiklog43Yt
	5SzmuqBZ2xqj2OX0/CYzHIsyZZyktwWbhgI0ZFyeSnji/TKNEon7x667
X-Gm-Gg: Acq92OEUkgNO9VJKfp1wIF9KW5DgjNtKQIbaZZbRwf5M0T7bMh2n4RRaUpfHHM/y5T4
	hZJcExJG2pXVZrDTAlUuRnzJ5PCcfrVt36jAJGQo3+PUOwjX3rLxc0NtfM1g/f50SRd43sY/+Bd
	pnF0StiCN3pFqFXG/0RbTQbB5LDxZk8DPiHva3lXQNFc2oSLDB7ZQduDaBYwtzcaJmpaZuUfjiW
	aa5Pz3R9MlHs6eInEHQfZsDkB1KpnejU/eeTk6ghNU1oO2fivxGjPjxTfh7pCiw6fe7ee6WlR7K
	4UxDoa7hEOWPfSO2b+Y89SB40cCS3ME/1MfHHTs7fuCMy9KpVJjBk2qBxl0j7qNPzQHvjVzgwTC
	9lazeV92ruULseeaVpcne2OkrRukQrtkVkLcofFyqKuHHN8pLgqD1bKni26bvlHY96mAZNgf0IN
	1ly78xHPTwNdRh7+fgSD/7mD2x
X-Received: by 2002:a05:6512:4058:10b0:5a2:abe6:7bcd with SMTP id 2adb3069b0e04-5aa3237b9ebmr1055166e87.19.1779459953313;
        Fri, 22 May 2026 07:25:53 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb379csm452765e87.3.2026.05.22.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:25:52 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 558B05A0023; Fri, 22 May 2026 17:25:17 +0300 (MSK)
Message-ID: <20260522142517.498632593@gmail.com>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 17:22:40 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch 1/2] ice: Use ICE_FW_RECOVERY_MODE state to track recovery mode
References: <20260522142239.628965142@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-290859-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BB3015B64CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If card is in recovery mode and we remove it physically then during
ice_remove() we read device register to fetch its state again which
is wrong since the device is no longer present. Fix it marking the
device state with ICE_FW_RECOVERY_MODE bit.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice.h
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice.h
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice.h
@@ -310,6 +310,7 @@ enum ice_pf_state {
 	ICE_PHY_INIT_COMPLETE,
 	ICE_FD_VF_FLUSH_CTX,		/* set at FD Rx IRQ or timeout */
 	ICE_AUX_ERR_PENDING,
+	ICE_FW_RECOVERY_MODE,	/* Firmware in recovery mode */
 	ICE_STATE_NBITS		/* must be last */
 };
 
Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice_main.c
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice_main.c
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5121,6 +5121,8 @@ static int ice_probe_recovery_mode(struc
 
 	dev_err(dev, "Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode\n");
 
+	set_bit(ICE_FW_RECOVERY_MODE, pf->state);
+
 	INIT_HLIST_HEAD(&pf->aq_wait_list);
 	spin_lock_init(&pf->aq_wait_lock);
 	init_waitqueue_head(&pf->aq_wait_queue);
@@ -5366,7 +5368,12 @@ static void ice_remove(struct pci_dev *p
 		msleep(100);
 	}
 
-	if (ice_is_recovery_mode(&pf->hw)) {
+	/*
+	 * .remove() may be called when adapter is physically
+	 * unplugged so we can't read the fw state but use
+	 * the flag instead.
+	 */
+	if (test_bit(ICE_FW_RECOVERY_MODE, pf->state)) {
 		ice_service_task_stop(pf);
 		scoped_guard(devl, priv_to_devlink(pf)) {
 			ice_deinit_devlink(pf);


