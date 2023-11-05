Return-Path: <netdev+bounces-46100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBF7E15E8
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911A6B20D55
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFB23C0;
	Sun,  5 Nov 2023 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="VlleZcuv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7895210B
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:50:26 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AABD
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 10:50:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so34213155ad.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699210224; x=1699815024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejr3g+vlHNwuKj9aOg9KeGPXVpxUuUKWq6Vn1gZl28U=;
        b=VlleZcuvq3m8TfeZd6euuD5qYUTarbrSOqHxxet57coyma9hctz3VAO4ydURrnSZon
         PqragfOdStxKZBIclE7E6L9Wab94rXEqGOoHT77iigl2GbIRHGdyBEkoNvNSJ91J3F/S
         89Xam12ySC0bjG0XolG7wkfmIzGzsIi8gHpcpjoex0N2O5S/IM3de61w9Syvh3y1Pmv/
         Gdd04d9Y/hlGd4K8jmZhDAWdvigFYoB3Vx1sV7/nIAng59ZEczveCQVj5Qy0BULXFT5e
         7803D2XxICVjqyB053m7akCuVdru0mJeD9ihMt2sUrFWKABwRASJZiL7H6xTcgPEMkrm
         pyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699210224; x=1699815024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ejr3g+vlHNwuKj9aOg9KeGPXVpxUuUKWq6Vn1gZl28U=;
        b=F+Ee3QOAWhPB6XZNgl+l1R+nJldK8ZDHv+g87s2ckOSdQaNH3w3gi9N8wG6YE+aMrb
         Ge2kR5A19Z8jE4lqhVmfYHd0Q5LjBKaY1wCPOVaNpTTUFaXT68szMVSQZ6wB7kDfIk+O
         9Y4JXHggc09n0FV43sRjDNckXWOXKS0sT+1gLiR3xJVSiiw9BoJLrSEDIsoTsAcUniLu
         f9s18K1lIjc1QRXFTvDdgVBsT/+hFAp5EujvTs3p4MliLWnqPSTYZya2CPGFRlOpc2NQ
         MbISlygcFhJmSw/Xl9tEtIqd75J5C+PLX6mj17EoC2z7Nn+zeGfErGqm+C/8zsl4o/+o
         Nx7g==
X-Gm-Message-State: AOJu0YzQpLnmk1Bn6JLXtsLFwIw7UNJ1s/FldRPnvdSfilLXoQ78SVrN
	+L/Fk9q8m1XqYkT50zITiIJ+a/5vXgOCw2ZkMCQ=
X-Google-Smtp-Source: AGHT+IG9XJMuEdIz+Tv8CdGz0HuVXm9nr119eK5H2qLB6pYSLv7h4hdFtAotRBBk0QMCIHb/Wb/RHA==
X-Received: by 2002:a17:903:244e:b0:1cc:70e4:28d7 with SMTP id l14-20020a170903244e00b001cc70e428d7mr19397832pls.10.1699210224560;
        Sun, 05 Nov 2023 10:50:24 -0800 (PST)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001ca4cc783b6sm4470695plg.36.2023.11.05.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:50:24 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [RFC Draft net-next] docs: netdev: add section on using lei to manage netdev mail volume
Date: Sun,  5 Nov 2023 10:50:14 -0800
Message-Id: <20231105185014.2523447-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As a beginner to netdev I found the volume of mail to be overwhelming. I only
want to focus on core netdev changes and ignore most driver changes. I found a
way to do this using lei, filtering the mailing list using lore's query
language and writing the results into an IMAP server.

This patch is an RFC draft of updating the maintainer-netdev documentation with
this information in the hope of helping out others in the future.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/process/maintainer-netdev.rst | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 7feacc20835e..93851783de6f 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -33,6 +33,45 @@ Aside from subsystems like those mentioned above, all network-related
 Linux development (i.e. RFC, review, comments, etc.) takes place on
 netdev.
 
+Managing emails
+~~~~~~~~~~~~~~~
+
+netdev is a busy mailing list with on average over 200 emails received per day,
+which can be overwhelming to beginners. Rather than subscribing to the entire
+list, considering using ``lei`` to only subscribe to topics that you are
+interested in. Konstantin Ryabitsev wrote excellent tutorials on using ``lei``:
+
+ - https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
+ - https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
+
+As a netdev beginner, you may want to filter out driver changes and only focus
+on core netdev changes. Try using the following query with ``lei q``::
+
+  lei q -o ~/Mail/netdev \
+    -I https://lore.kernel.org/all \
+    -t '(b:b/net/* AND tc:netdev@vger.kernel.org AND rt:2.week.ago..'
+
+This query will only match threads containing messages with patches that modify
+files in ``net/*``. For more information on the query language, see:
+
+  https://lore.kernel.org/linux-btrfs/_/text/help/
+
+By default ``lei`` will output to a Maildir, but it also supports Mbox and IMAP
+by adding a prefix to the output directory ``-o``. For a list of supported
+formats and prefix strings, see:
+
+  https://www.mankier.com/1/lei-q
+
+If you would like to use IMAP, Konstantin’s blog is slightly outdated and you
+no longer need to use here strings i.e. ``<<<`` or ``<<EOF``. You can simply
+point lei at an IMAP server e.g. ``imaps://imap.gmail.com``::
+
+  lei q -o imaps://imap.gmail.com/netdev \
+    -I https://lore.kernel.org/all \
+    -t '(b:b/net/* AND tc:netdev@vger.kernel.org AND rt:2.week.ago..'
+
+You need to set up ``git-credentials`` properly first.
+
 Development cycle
 -----------------
 
-- 
2.39.3


