Return-Path: <netdev+bounces-27800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96C77D381
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6C92815FD
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423818C01;
	Tue, 15 Aug 2023 19:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871F18AE8
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:37 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ADE10FF;
	Tue, 15 Aug 2023 12:43:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31969580797so3072197f8f.3;
        Tue, 15 Aug 2023 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128614; x=1692733414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DnSCiXvfY5FNrAsfEnGGwj0Odz/F6bzy+R7iZsmgtU=;
        b=chjSy1zu7IvSWCjU6mmwv27pLw8Bx+hR4eyw9HrcLXlYD+Aq+gARv2l4KOf7zXeN78
         jdMxccODxelQ2om08AXLyaPT77bNgLKRK7nqCV+wUAPzufNhXhV/C3YO/9Fjl0EakYhd
         UPI0lTGD9kvd769ih754rWAwGklwvH9qoU2CU4QHpUdvkz+nXtG2BUmoW5jlAuxR1Nxj
         087F1DHjIGxkYYo+xQjwOGAIP4qenGwoS/IhCbRymChplDKuUFuI4WJVCsnVG4h03Rvh
         Q/2839VEAgd5WtAJlq5bt37mgDUYlNtBUpxvyw6r0i7OM6eQDCMaXRhrEikzGBwwzb8i
         dnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128614; x=1692733414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DnSCiXvfY5FNrAsfEnGGwj0Odz/F6bzy+R7iZsmgtU=;
        b=DUzVsd6H/+G8YWMyZer1o8fkgRUxPNR73kvdRLAsBerKcIYC/AFEKkpGaVSaTgVfzg
         AoWv2F2y3SLEdQFwFPyFqAUhoyyjV7ITjvnXCgQDtENeMQlEbJvAjsdscGc4ygFkiQ+e
         JOt8ZNuKFj7IUVDv2WAgIDV1dSmV54RRZKvSx1AAlDTIqM5KNc4xfUinJ1tn4hPJSzVM
         h1rhhDVwyMzbhIvhakRvrzM6Z/Lsl9pbYINXZ8F9c9e+VUYEkQ6ks5nhGlZaW4mQXXdz
         eiU14Vc8gJrt3+BqZMpnxD0EhoDjo9qYT0CoBj0IwbnzDkESWpHnCGJjyGfS1SE+GAEu
         LE1Q==
X-Gm-Message-State: AOJu0YychAE1be7HmghgskTZg3uaKb4W5ieo0yqdw9w1Ji5iXxe+63JW
	Gd4ViJuO/KVkn3fyD/v0xTAI0l5N+l7b3+9V
X-Google-Smtp-Source: AGHT+IEL7AohZuGVmOsqi0DMyxeaMXnJ69Ncu7JR7wTgQPHZ/tuHkm/1pWcRUDsxtblA3fkzSuHx0Q==
X-Received: by 2002:a5d:6202:0:b0:313:dee2:e052 with SMTP id y2-20020a5d6202000000b00313dee2e052mr9129260wru.26.1692128614424;
        Tue, 15 Aug 2023 12:43:34 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:33 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 03/10] doc/netlink: Document the netlink-raw schema extensions
Date: Tue, 15 Aug 2023 20:42:47 +0100
Message-ID: <20230815194254.89570-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815194254.89570-1-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add description of netlink-raw specific attributes to the ynl spec
documentation and refer to the classic netlink documentation.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/userspace-api/netlink/intro.rst |  2 ++
 Documentation/userspace-api/netlink/specs.rst | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentation/userspace-api/netlink/intro.rst
index 0955e9f203d3..3ea70ad53c58 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -528,6 +528,8 @@ families may, however, require a larger buffer. 32kB buffer is recommended
 for most efficient handling of dumps (larger buffer fits more dumped
 objects and therefore fewer recvmsg() calls are needed).
 
+.. _classic_netlink:
+
 Classic Netlink
 ===============
 
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index dde70f9674d4..98978a014488 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -490,3 +490,20 @@ struct data.
  - ``fixed-header`` - name of the struct definition to be used for the fixed
    header data. This can be specified as a default for all operations and on a
    per-operation basis.
+
+netlink-raw
+===========
+
+The netlink-raw schema extends the genetlink-legacy schema with properties that
+are needed to specify the protocol numbers and multicast IDs used by raw netlink
+families. See :ref:`classic_netlink` for more information.
+
+Globals
+-------
+
+ - ``protonum`` - Protocol number to use when opening a netlink socket.
+
+Multicast group properties
+--------------------------
+
+ - ``value`` - ID to use for multicast group registration.
-- 
2.41.0


