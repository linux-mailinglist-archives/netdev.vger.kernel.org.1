Return-Path: <netdev+bounces-40159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE67C6040
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246401C20B03
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BACA249ED;
	Wed, 11 Oct 2023 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/xRp+KT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CF249E2
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:20:16 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF6A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:20:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a4cbdad3fso400623276.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697062813; x=1697667613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Z96mQSNwBQxmdfHTfVSOBB7yU8CSx8L0b3jKxEJcSo=;
        b=t/xRp+KTkHXq8Zld68JmaIzatv4ge2hi3hStZct8v/vgd5cKy+VFYjtbiq32MFWdQr
         xT+YGEQvzbhLbQPgd/xjR10kHAnLFNnPSXND3Oc6RR2ChgZrvNjYay3ABUQWubbYrnkU
         WFX9M7ybiEY1cmr3U29xAk9dR9EpQ0AjtWOHv3e2tts4/VSjOTILeifRdAJwI6hsBrK9
         hXPvfy7sclOVx4Zm/yYoCtbfvuheL7UaRJCUWGED/PFEpgxeSkPXl/h1Pi1fcY89oZY9
         tjNfSiunez2m5mur/NMFXbIw9Bs0QTD8piG1hJNZmtrKWkqEEmp4/fr5Lc6w+kXnuJPH
         7P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062813; x=1697667613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Z96mQSNwBQxmdfHTfVSOBB7yU8CSx8L0b3jKxEJcSo=;
        b=dRLwOpD78ca5rr2+ndboYY8egGWDsvxA+IpJt/6yv+6zNTcJSEMit+3eb66/j8KtL9
         dPH+PzqNkRwkKH7r5uQ7bwbQUph2Rhd3nqKnP5aw3y5feKxSoF9SC5PUBqakg2GZjQ5E
         pQVht8nNMA+PVRCavNduvAh2OIwLXYmP3Xr7K86AuopyQZcix8zDA6Id/2f/nKrGDgW9
         1ckBdgwrvhFxMzckRAmi/a7CiI2TRTwAosVdRRPAF51fkoQxEl3kKLBkkucfdai33fJV
         O4oJQWwxCIYRFxKwCmrODitJyMcL3WtE4usXKiHoJx/OJnrxDtCU4E1m6jxQBpMFHY0U
         A9dQ==
X-Gm-Message-State: AOJu0Yy6eVdc30/Qx5aiqmf1SOdjBZLywgINWGwU+o+FV5Op0ZthCamK
	rHXoHQdcnueYMrx18hsRBBsOhD6LsTECJVJDYw==
X-Google-Smtp-Source: AGHT+IGd5Zu1czxmjeL92aynbzUWAyCyWUMLzy4yM/u30YUbNTfHqpMJqGR4vyeCgOUkYHcW+xZmuu5thXi55bh27Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:a89:b0:d9a:5e10:c34d with
 SMTP id cd9-20020a0569020a8900b00d9a5e10c34dmr122450ybb.11.1697062813111;
 Wed, 11 Oct 2023 15:20:13 -0700 (PDT)
Date: Wed, 11 Oct 2023 22:20:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJkfJ2UC/x2NQQrCMBBFr1Jm7UAm1oVeRUQ0+aYDkraTtCild
 7d18eC/zX8LFZii0KVZyDBr0T5vIoeGQvfICaxxc/LOH8WJcKmWw/DlaDrDCmdURu1g+xjffdL AI+LOPeI5JQ7sReLp3HonaGl7Hgwv/fyr19u6/gDruxsxhQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697062812; l=3458;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fcCFEgzIEgjdRagOjBJiBiruUTRZY6XKVFUfoSVmwHk=; b=aYtaA7N793tac2LBAe3z26VJ83HnPC3XYeXKcuGTOdnHD3nZAM+z+JKRjHuFt+Elo3vhm+wOG
 /yIou6N7Ph6BRinJjrPjxnxkxoggxVG9baAO0ZIlWMuNMFUZlG1R4cS
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v1-1-60c9ca2d54a2@google.com>
Subject: [PATCH] qed: replace uses of strncpy
From: Justin Stitt <justinstitt@google.com>
To: Ariel Elior <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This patch eliminates three uses of strncpy():

Firstly, `dest` is expected to be NUL-terminated which is evident by the
manual setting of a NUL-byte at size - 1. For this use specifically,
strscpy() is a viable replacement due to the fact that it guarantees
NUL-termination on the destination buffer.

The next two changes utilizes snprintf() to make the copying behavior
more obvious. Previously, strncpy() was used to overwrite the first 3
characters of mem_name and type_name by setting a length argument less
than the size of the buffers themselves. This enables, in a roundabout
way, creating a string like "ASD_BIG_RAM" or "ASD_RAM". Let's just use
snprintf() with a precision specifier to hold the name prefix to exactly
3 characters long.

To be clear, there are no buffer overread bugs in the current code as
the sizes and offsets are carefully managed such that buffers are
NUL-terminated. However, with these changes, the code is now more robust
and less ambiguous (and hopefully easier to read).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index cdcead614e9f..0a4fd1b04353 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -3192,8 +3192,8 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
 {
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
 	u32 block_size, ram_size, offset = 0, reg_val, i;
-	char mem_name[12] = "???_BIG_RAM";
-	char type_name[8] = "???_RAM";
+	char mem_name[12];
+	char type_name[8];
 	struct big_ram_defs *big_ram;
 
 	big_ram = &s_big_ram_defs[big_ram_id];
@@ -3204,8 +3204,11 @@ static u32 qed_grc_dump_big_ram(struct qed_hwfn *p_hwfn,
 		     BIT(big_ram->is_256b_bit_offset[dev_data->chip_id]) ? 256
 									 : 128;
 
-	strncpy(type_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
-	strncpy(mem_name, big_ram->instance_name, BIG_RAM_NAME_LEN);
+	snprintf(mem_name, sizeof(mem_name), "%.*s_BIG_RAM",
+		 BIG_RAM_NAME_LEN, big_ram->instance_name);
+
+	snprintf(type_name, sizeof(type_name), "%.*s_RAM",
+		 BIG_RAM_NAME_LEN, big_ram->instance_name);
 
 	/* Dump memory header */
 	offset += qed_grc_dump_mem_hdr(p_hwfn,
@@ -6359,8 +6362,7 @@ static void qed_read_str_from_buf(void *buf, u32 *offset, u32 size, char *dest)
 {
 	const char *source_str = &((const char *)buf)[*offset];
 
-	strncpy(dest, source_str, size);
-	dest[size - 1] = '\0';
+	strscpy(dest, source_str, size);
 	*offset += size;
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-211d594201e4

Best regards,
--
Justin Stitt <justinstitt@google.com>


