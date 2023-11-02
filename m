Return-Path: <netdev+bounces-45822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D334F7DFCB9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8EE281D48
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D5224C0;
	Thu,  2 Nov 2023 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLHI+KrU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283721106
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:58:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BAF1A4
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:58:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5acac8b6575so20670147b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965924; x=1699570724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQWlqlKx7HVoISOZnXwD//BGCQLkTId8oEkXKIs8r4=;
        b=YLHI+KrUO9Y1tYOoXrPV6WRyVKUjrAM4mEnaYGB7H7ahmd5usktEtb0uWlEqr8yaMC
         jIxatlTMbGlQcAl8N8I7cXcNSez2ZjP+O/Magb0LsItIltdji+rD9gta/hapW2XEGrun
         edKDgLagqmvO2hyRkFR1zWsKkYMQsq6cAyclyXsMKjdzEUN6xCSgQTUX/+VysAPjigyI
         v/ik+5QVTf8xH759/Fk4VbIEuVXuEikX2TI2YsSoQBP1fe7qKOCnCv4IDlYKVekbdxVu
         40SEkU1w/qgsorV7jHDulnyr5HbQBQWya2b8Fgw/htAjFhjiUQYM+OLZiEQhNAPohlWP
         Xr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965924; x=1699570724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQWlqlKx7HVoISOZnXwD//BGCQLkTId8oEkXKIs8r4=;
        b=N2eqlddLLAMtR5IILDdqLHO5lJXR2ejSxeeAcKMXzYlAR4JFe2K0lb17feARilg7yo
         TBW84JS7g+gKK9bjpvja2Oqjtp/DOgbtc6ulpTIoV2aQKQQqhG1Gq2vvOnt4DCsJyuM1
         qxftZZoMxFBVTUddKgVvhpiQroxpXdJ1k4MBlr4O7KWkMIwJ3VTzSbgGDI3XVnQdULZB
         TxJLJ9pQ+hi2DAx/hJAqs0PMIIko/lqUEdFhnYk8pnWds/RLzB0QDn9lHcqAVHQqjDc/
         1BzQhNOi6Dq6TAb6ZOSKf9wM6TYzWm+O7klCyVHv6nQsZaJmPGAI48ar221xR8b5fwNn
         tN9g==
X-Gm-Message-State: AOJu0YyLqw0I9t49gs4tYBssumJJcDjgZOqXkFj83OJVSdHVJq9rQE+u
	Q0lyyHqxu4XW/PsxfItXMjsa354=
X-Google-Smtp-Source: AGHT+IGxEl/+xuhibdGZev48+wG7/mtLXtVNyeGjcD7sBqjMuhiBM+KGfxbvnH9d9S2CPir4NbnlgGQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:88d:b0:5a8:207a:143a with SMTP id
 cd13-20020a05690c088d00b005a8207a143amr26239ywb.0.1698965924683; Thu, 02 Nov
 2023 15:58:44 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:27 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-4-sdf@google.com>
Subject: [PATCH bpf-next v5 03/13] tools: ynl: Print xsk-features from the sample
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

In a similar fashion we do for the other bit masks.
Fix mask parsing (>= vs >) while we are it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index b828225daad0..591b90e21890 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -33,17 +33,23 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 		return;
 
 	printf("xdp-features (%llx):", d->xdp_features);
-	for (int i = 0; d->xdp_features > 1U << i; i++) {
+	for (int i = 0; d->xdp_features >= 1U << i; i++) {
 		if (d->xdp_features & (1U << i))
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
 	printf(" xdp-rx-metadata-features (%llx):", d->xdp_rx_metadata_features);
-	for (int i = 0; d->xdp_rx_metadata_features > 1U << i; i++) {
+	for (int i = 0; d->xdp_rx_metadata_features >= 1U << i; i++) {
 		if (d->xdp_rx_metadata_features & (1U << i))
 			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
 	}
 
+	printf(" xsk-features (%llx):", d->xsk_features);
+	for (int i = 0; d->xsk_features >= 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.869.gea05f2083d-goog


