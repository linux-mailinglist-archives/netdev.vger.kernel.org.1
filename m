Return-Path: <netdev+bounces-268195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOvhL6wluGmNZgEAu9opvQ
	(envelope-from <netdev+bounces-268195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE429CB07
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E84D3038F0D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D63A2541;
	Mon, 16 Mar 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WdwfvKlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA363A1D0F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675866; cv=none; b=XVvE3cVnRycf5EFn8PzWBMTGaPtnE4nzLVQqPmgk7UmNaUsgjXGQAeatS9mEGO1dp0oFfgbACHGaHY3kxGef6Pyu2KmYLv1rddRaXacqWrXEUslcbbsSK1rmzGeaG9erbmN5rE2Nm5dcN9iaan5KQB6T6IOxYKWQAj3xSKBk1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675866; c=relaxed/simple;
	bh=DhSAWW7yXKQwhdDoIE29ZTxkDS3Ypu0PN4TvZoN24pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0S5HlcsAIFsHS5SL9sSZTEtJUMppW19QwH9VE/W98jNqztvTbflEf6KHq8Y5f0tolFX9agiSr5TPoFyjw/uQ9PW82P6JSyPBTOTMrM/3dkhEnNp+5/oXer2nhyQz7PYpqPxg9LYC/sl4d/n6QbzFmNBfQAT+5g1qJWAvpgoDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WdwfvKlM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48529c325f0so34006395e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773675861; x=1774280661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRhV2eIFfXHWWdGDRqPvlrS59XFmetyEjC6Y1O0GZwo=;
        b=WdwfvKlMlFr7LXGQ8S0cFd/l+F2oBIy2hSwRAnJyQwxTIIcNKbLZUWMlb+7BJEL/+Z
         ScXXixB6BAtQsZ7YEOwfsV73zNgjyk9vnmJ9VB8We7WcuXlnnZ39WMBycM0uci2D9K04
         boycCsLo1LJZSPDCUONnVLlYsz945Yh9AbULmwDsWh1WSxGEAut6QHeUgnaKMey3XDjN
         9OaVR3KXLvJbbo97zoIJT9x4ST/W3V/1RebNRK0+dc2AhR3qjeTIq/Y/mgc7nFpcemFo
         maNjl6MJ2DnDwc9R+SohjK78MQ7EW0r19UgMtutPYbg2pKMkX52ZoiOG10gmlIZbe3Iv
         wNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675861; x=1774280661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRhV2eIFfXHWWdGDRqPvlrS59XFmetyEjC6Y1O0GZwo=;
        b=bXDi/Pvg7Fw9PO1jIqvizJaGjRZE6393/7u1u8x/fBhVMEU/dpIJ1rtZkJml0BSmt0
         kHTdlyiCowZBrgdRPBT1DJPoNVPEJPPuGGEYRlTF6WkAKMVj/hvDDdKlD6HxKm5yggMK
         CwDoEi149OAxg2J8dWHuMp0KXBxwhYH1YxTge14SM/QfQPIVNDeg3UE3/xMizyd0ab02
         vl8r/wayz8DlR1eWoPCGYEIIak/IcPDzVvR5w6mdjsR6NXYSH4uVQcLOd85JpvRwBosg
         vS3xwzjzHPITyXbWJJQ/euiMBoCFnE9CQffoHbEHanr2s+tTqm46tWnLN62xtuGE3Unl
         Bg4g==
X-Gm-Message-State: AOJu0YzVJkCffrq730cifB1QdzfGPF7VHTcCQ0TVbts7sBG3uwnk3xcm
	jA+NftpSlpLgkD9PRwAo8dtilYRxfuHDTOgaAn7IvCXVzzpry6Fq7W+9lWiZcawgp0cwj5csTq2
	3ugKr3+A=
X-Gm-Gg: ATEYQzzAsMkkQJ1o2awdl1m1Jpwp45k6VdQAo2up/gXm/arz8tGTTecWLuKK87qr3wm
	trEhbQY6Mc+8Ok1hcQa8zKqOxjf0989fLvKTeehkGkQBJvWQPrPgoGsQWUnQS33FS9zftJFXrci
	VA7kaKir7CChKWWl6lg1BEsE8dCjAa2lxYjr5kkEy9oDUB8qd9szXcI/K2RfIQurVqoCwGbpkBV
	gQ61V/kgaNuLa+y37oYSHzRmDlIRdYOXGHdDfWqu/6/RtHq5SOHdY9yrnC7w70CFXn+p31Bt+G/
	4w0qjCgrPuC+31zGaypISWQYhUpelM+XCKjXRTNqswamOVImJJTnBM7opK8st7dWBwE58G4aQk2
	ZiXPLU+oGLRc9StKiE73yoHXZ4pAEuRTmcXg5D3PgMNM7cHp0kdxl20zt2oCIiUO4Ud+5MRw5Jp
	JeujRUDG/nFPSVE8kB2w==
X-Received: by 2002:a05:600c:3552:b0:485:46fd:100a with SMTP id 5b1f17b1804b1-4855670299dmr225248925e9.25.1773675860898;
        Mon, 16 Mar 2026 08:44:20 -0700 (PDT)
Received: from localhost ([213.195.231.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea96828sm2312435e9.5.2026.03.16.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:44:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [PATCH iproute2-next 1/3] update kernel headers
Date: Mon, 16 Mar 2026 16:44:16 +0100
Message-ID: <20260316154418.625026-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260316154418.625026-1-jiri@resnulli.us>
References: <20260316154418.625026-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 81DE429CB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 3a8f8a3cc342..8040b9f58a8a 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
@@ -642,6 +644,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
-- 
2.51.1


