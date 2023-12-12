Return-Path: <netdev+bounces-56339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1980E8E5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33BF1C20A41
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84245A101;
	Tue, 12 Dec 2023 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CiBren3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6F95
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so726690466b.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376259; x=1702981059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=CiBren3RGg4mshnxl+1u9smFN9yfniEWAN979GHLAgbm9HrPsRRa71h0Si+dUpk+2p
         8JKDcZ42lt2k8lv/0bHEXjLTCUJn8X5suiLT+E7R1v/Ow/1oIEEmr87eRm77TX9/L75P
         gqJwGtu1+6OQG2yB2fG6FVBFZHSJ6+z63lIZUUZpafKuCt3TTgkhz65YZkz7zyKeEJ64
         S/tvOIjyuRZfvoHeK657/4hmjFBBW7TE/HShAJESsFBjMhtaQ9AFwAJoVhkoLOJ+/zx0
         GQMf6DlpQ3pOulH/MkUt7XOW7/zOMzMkrMqTpvwBCrfn1zG84sMu157f8tkt/lC/T1Qq
         NC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376259; x=1702981059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33J8BP2HLxzySsghbviJPGk4M7islA6m5mnPAfoHhcc=;
        b=f/kE8Ce1ksOX+k8THMEQ86k175x54WhFTAwPiWSCsAve1YfSbWVxYFUmlktngRcLep
         yeu2cCMHYAtosQlSAFkUtbfNZ4TjO6dZAR8cO5/9NfMbDtWiy9iv12gq6vdWvbUclSfe
         LTzANdW535B36gVFgzulGF+Rzq4x1BkcQt3B3cn6iXIR8geKMUWSwHKMA9vHm1x3iNce
         Ja0pG2cIjks6HUPdUkYItx4n63e938Dc6bi15Yauj9lsQjNzOtGGpxslAiNedz7DRZQy
         ZsUQcMpH1MQZ7KSMMqvIXXjTz2AdNAB+ck5OJmHB9VC6XQdJU5mHpjKMJreduaXpE6eP
         dVTA==
X-Gm-Message-State: AOJu0Yzk/kQbF2m8UpPaUheh9wFE3Q0tPrj4jKP1LegClAhO7vtIf3cV
	xf2ZUsK6vO06eX4GCJr8r2wByT+W2LJl4OXaCLo=
X-Google-Smtp-Source: AGHT+IHko3KlqmwsuEfbz7gKz1U457yfEDEvJ5nHQ7y1DP7dk6hDyL0y29sVOs4gCOkTfre5RzdYKg==
X-Received: by 2002:a17:906:dfd0:b0:a19:a1ba:da41 with SMTP id jt16-20020a170906dfd000b00a19a1bada41mr3091607ejc.104.1702376259542;
        Tue, 12 Dec 2023 02:17:39 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm5976834ejd.20.2023.12.12.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:39 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v6 1/9] devlink: use devl_is_registered() helper instead xa_get_mark()
Date: Tue, 12 Dec 2023 11:17:28 +0100
Message-ID: <20231212101736.1112671-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of checking the xarray mark directly using xa_get_mark() helper
use devl_is_registered() helper which wraps it up. Note that there are
couple more users of xa_get_mark() left which are going to be handled
by the next patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c  | 4 ++--
 net/devlink/rate.c | 2 +-
 net/devlink/trap.c | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 918a0395b03e..3fe93c8a9fe2 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -202,7 +202,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_NEW && cmd != DEVLINK_CMD_DEL);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	WARN_ON(!devl_is_registered(devlink));
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -999,7 +999,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 		cmd != DEVLINK_CMD_FLASH_UPDATE_END &&
 		cmd != DEVLINK_CMD_FLASH_UPDATE_STATUS);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 94b289b93ff2..e2190cf22beb 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -146,7 +146,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 
 	WARN_ON(cmd != DEVLINK_CMD_RATE_NEW && cmd != DEVLINK_CMD_RATE_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index c26313e7ca08..908085e2c990 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1173,7 +1173,8 @@ devlink_trap_group_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_GROUP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_GROUP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1234,7 +1235,8 @@ static void devlink_trap_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -1710,7 +1712,8 @@ devlink_trap_policer_notify(struct devlink *devlink,
 
 	WARN_ON_ONCE(cmd != DEVLINK_CMD_TRAP_POLICER_NEW &&
 		     cmd != DEVLINK_CMD_TRAP_POLICER_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.43.0


