Return-Path: <netdev+bounces-34356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45E7A3648
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 17:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5B21C217EE
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CE4C77;
	Sun, 17 Sep 2023 15:32:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107110F9
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 15:32:56 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3EA173C;
	Sun, 17 Sep 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1694964617; x=1695223817;
	bh=14a9JoTKwLBMDvvPJuVuwcY6tE34u5ZiJcBdjh1EBjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s3TKwkmP5NMSXdFWXqh9NdWO5SVB0dgZaLDt2OO+ojJ/vDgcPXGJk4R3p9RCtLc5U
	 v6vi3Q37GVzkrKkxlpSut4qpHKC1zlGQRlSVgZdN+S4t83YCjX5T8raqpyI9aWaOQ+
	 dq8A2VlrGI/wPlL2NJe2/z9c39k6CIuQMUJDhlCGr1IN5Nx6YAV/oVqGA4w61FZi+q
	 p/vv8smcLI5XHAobznuoDIWxMTzhL5W/HzKKVNh5j+x8fkyq6ek26ge2KYO0QIGQa3
	 zk07gdfVADnMU+0lfUmGY5NONvLrF9O8Rk2qKcA4U/a8jth+5POby6pKyDB9QsvwM3
	 NKyEQ/BAY+W6w==
Date: Sun, 17 Sep 2023 15:30:10 +0000
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: Peter Lafreniere <peter@n8pjl.ca>, thomas@osterried.de, ralf@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH 2/3] MAINTAINERS: Update link for linux-ax25.org
Message-ID: <20230917152938.8231-3-peter@n8pjl.ca>
In-Reply-To: <20230917152938.8231-1-peter@n8pjl.ca>
References: <20230908113907.25053-1-peter@n8pjl.ca> <20230917152938.8231-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

http://linux-ax25.org has been down for nearly a year. Its official
replacement is https://linux-ax25.in-berlin.de. Update all links to the
new URL.

Link: https://marc.info/?m=3D166792551600315
Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a62f5a2a1c9e..1c52b7ddc2cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3344,7 +3344,7 @@ AX.25 NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/ax25.h
 F:=09include/uapi/linux/ax25.h
 F:=09net/ax25/
@@ -14749,7 +14749,7 @@ NETROM NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/netrom.h
 F:=09include/uapi/linux/netrom.h
 F:=09net/netrom/
@@ -18598,7 +18598,7 @@ ROSE NETWORK LAYER
 M:=09Ralf Baechle <ralf@linux-mips.org>
 L:=09linux-hams@vger.kernel.org
 S:=09Maintained
-W:=09http://www.linux-ax25.org/
+W:=09https://linux-ax25.in-berlin.de
 F:=09include/net/rose.h
 F:=09include/uapi/linux/rose.h
 F:=09net/rose/
--=20
2.42.0



