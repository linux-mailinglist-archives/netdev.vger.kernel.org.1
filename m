Return-Path: <netdev+bounces-275157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJDKCMT8z2nt2AYAu9opvQ
	(envelope-from <netdev+bounces-275157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB03971ED
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29768304CEA0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85323D34B9;
	Fri,  3 Apr 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mh84Q3qV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E72FD665
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238166; cv=none; b=oqA3kYdiO7ngvM54IpwPcDnhfMWpJtokQfOhNSK6K85IFiQUipyYoQpHkdEa90n0/OebJk+eovo386CnAzcSl81JbChDLdnw5RFLtigCSCxROQXveipsTb0mH0L5IHK9eiHyqdbdTmcRp8x71EBp9ZKt+4lxvCSfz0VbtJcNqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238166; c=relaxed/simple;
	bh=tAGSpXhdVDSX8wYYXotCgauFP4oRTrKJ6O66vUCaq0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FWZqplQ4pHHrct8M1YUs54H0kmu6a+/llKXtKKgzsYldCxMR5GS4q+Ey4DEOq/KP8hojLNPCJY3ou2PcWCxZbNAyBy8MglwX8YZH58wEDfIC1rRhd1+Y921AmH533TsA7iDSACK4IJQY9OajwPz0Y0K9/BTe79f1KM2ups7RigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mh84Q3qV; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-5094e1d17d3so22476151cf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238164; x=1775842964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SvahecaH4ymg3e/cRaPdM/4xoBXYGz6dVojdP7GAtmY=;
        b=hP5/JaaPVXiJUUGXrXjq86FHKslpMR1jlVjQtuSbJi26Rt7r/M0Uqf3bcNuwWgyP3/
         k0WDMWcDwusZEPr/FGpgRHSgqavFeiRZ2R1id8lEYZMJNIM4hlmykW1fDsfo8LLC/hF9
         iYT/6hHrX+CTZ4Zjg2rOlK198dgcAuV/amDc41xEmHwV6eH1yh+BOgOm1cQeiW6sQ7v7
         C3EwhXiusH1Tmcph8n9I3ksIVEpt71YQlunL0OlO8pX0dPW0vNvb/PIo/QLhZt2M0ESC
         yWVNsGpA+p7RFIXavdSPd9wcXGaJAMw/Cfp/MfJqczFBeCNDwG4yV5MsIP9JqS9FehWJ
         owQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOEStpSYX+PZrDvV5ZjYtP3K89HIuNF7FjRnkwXBZrZSlZoa0xzp+88Gld/iCLkk5zSh5BPxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0nZdWZGtsdpdJIvZSeprUf32+inLTWxVVoK9Q+SbctK+T1hX
	7N9vWYec6r89fY4uWqOTBy6qY4QyE7qBa648+xZdRoesVkYa9Ij0SGt6UuVCdYBramOtAKpS03e
	IJWPeig4Q8f51baot2Sr7ZvsRFZa0Zj0f/CN57Gb6e78RN7NHZSZogJ8LArNN8V6655bFbknH5l
	JfTwWPjvU89LptDEFzSIv17zmqRMvaIxfo/kx0A6ymW5IWghH6PXLlv7WNHjdp2lg8FNi8D1C/P
	QUPquk3gLE=
X-Gm-Gg: ATEYQzy4K20Krb7pZTvsSLxhvGrs/miKAYhYxPtVxVD68mrWmU7pSrZxCE6rLej5Uiu
	I8abG4RPbyTejzKEbYTWwiiIFdkpPzfogzeDoiisdYOrlenYwgAZGGGdvRWAKwoWMtpG92mrHTw
	p09rBlu8gb3CQq4ISLPNI8xJ6iShXyjLXCtBZUbZTTKxNMLlMOD8rxUaaDkmKq6grBXgwbAH9Mk
	JUhP9eJk/vLbpY9Gk7vidSLwh2ZUdtitl6RJ+0LHZLZR30BpkgzGRwl6LLaN8A2LmsEeXKrnsca
	IFgDEbX49RxjvI1ZcFCmUz0a7lKtVbzLwxGpA/PhP78uj39HVVCTdX2kr3nJ+QVmk4J+jUpdaD4
	wmSX+ke2BtrmSfuVOjSfjs7oDi5M+Fp68DZKDa4izRtVTctBluBvkuVXZ311LblxyW7K2BoSWre
	27JOewcOmQO5kULd0wKFncCEDJzzp5gTx6hiqo2QwccXCF87rTnq2PpaG+
X-Received: by 2002:ac8:7e91:0:b0:4ff:c08a:52c4 with SMTP id d75a77b69052e-50d62772eb2mr59928001cf.18.1775238163958;
        Fri, 03 Apr 2026 10:42:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50d712c0eccsm443721cf.21.2026.04.03.10.42.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 10:42:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-127133794b6so3166825c88.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775238162; x=1775842962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvahecaH4ymg3e/cRaPdM/4xoBXYGz6dVojdP7GAtmY=;
        b=Mh84Q3qVVrGxGiFZ62hu3GdzXTPhhpgeamzbxS+OX/9ry1Qz2DxGhCoc5zH1wcKt42
         /1/sessotTZ0YuIOXVL2hbSYE/GQb7GAcU1e5hls+m0LJpEC7KDSBdOfZgXuON+amPdf
         ldKsSHB9vplgt2FRb43GZ5YgvPPZdY5PlkqxM=
X-Forwarded-Encrypted: i=1; AJvYcCVYGio86LVBv5iiaSQC7rNCeveSFsEn8FSBdxKfBCfqRZjOCm6+8nkL41UUxkRdw2X/+cZ0Qp4=@vger.kernel.org
X-Received: by 2002:a05:7022:929:b0:119:e56c:18be with SMTP id a92af1059eb24-12bfb7986f7mr1657144c88.38.1775238161764;
        Fri, 03 Apr 2026 10:42:41 -0700 (PDT)
X-Received: by 2002:a05:7022:929:b0:119:e56c:18be with SMTP id a92af1059eb24-12bfb7986f7mr1657126c88.38.1775238161050;
        Fri, 03 Apr 2026 10:42:41 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e4e3sm4660164c88.1.2026.04.03.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:42:40 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: mkubecek@suse.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] ethtool: Add 2 new link_ext_state names
Date: Fri,  3 Apr 2026 10:42:00 -0700
Message-ID: <20260403174200.1180275-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275157-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77FB03971ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the corresponding names for 2 recently added ethtool_link_ext_state
enums from kernel commit bc87b14594e3:

ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION
ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN

for OTP (one-time-programmable) speed restrictions and
BMC (Baseboard management controller) forcing the link down.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 netlink/settings.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/netlink/settings.c b/netlink/settings.c
index 05d215e..b5e44f2 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -671,6 +671,8 @@ static const char *const names_link_ext_state[] = {
 	[ETHTOOL_LINK_EXT_STATE_POWER_BUDGET_EXCEEDED]	= "Power budget exceeded",
 	[ETHTOOL_LINK_EXT_STATE_OVERHEAT]		= "Overheat",
 	[ETHTOOL_LINK_EXT_STATE_MODULE]			= "Module",
+	[ETHTOOL_LINK_EXT_STATE_OTP_SPEED_VIOLATION]	= "OTP speed violation",
+	[ETHTOOL_LINK_EXT_STATE_BMC_REQUEST_DOWN]	= "BMC request down",
 };
 
 static const char *const names_autoneg_link_ext_substate[] = {
-- 
2.51.0


