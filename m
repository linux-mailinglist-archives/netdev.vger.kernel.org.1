Return-Path: <netdev+bounces-93447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF88BBCB5
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5EC1F21C24
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24F3FB96;
	Sat,  4 May 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1+wXKsJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01A39AF0;
	Sat,  4 May 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836710; cv=none; b=kGsCtaxrKWoO74TnsGzyD+kZI/GS9Rb+X+kTfOCJVM1vmruDdj6mLlJ2WPmpwZ3bXjbd/xhf4DfFmdITPzyO27eeIy+b4yTwrCEfgVlch8SM3noEfe0JjpnZjNRb9V/np3/3C1Wm5nxwo0846AcPteM6aF87bGT4WIhwSTDo7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836710; c=relaxed/simple;
	bh=jBU5Uk9ZV/k58g1mXZ+jsPR6WwfvODudSHq5ZSNDRY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X1Q2BXvcVBh6GxfN3kw82VAeMU5E/UjasMncv4oWIYS2gtkDa3k2D3XX+lkS3zdCk6ew0pRNRRbnMS5awLu2r9Q/jKZLegOvKygYyH8nfR1ff9mCi8nK+DRza4gbwAShJ7bJYwtCAJ2UmHIwXiA7UhJKvDgMxTXrsEq4DAMyGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1+wXKsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE216C072AA;
	Sat,  4 May 2024 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714836709;
	bh=jBU5Uk9ZV/k58g1mXZ+jsPR6WwfvODudSHq5ZSNDRY0=;
	h=From:Date:Subject:To:Cc:From;
	b=U1+wXKsJsogfpRN4K8jwS1sHKHAkTlcs8rDHFjXc73KmHdxwPitv/seR67DSI3XI5
	 n2RLRAa8P9UQ6y8FUaVC2fgYzkrVbiIoYDT9d+hFgWjEZIYtDj51LnSRJ6n8O+DZ9E
	 3KDWWJ3qCD9objc5ZLU8AZWs3PIl43s4fqSrQyR6322FOssLHFGcrGlWpYKnX+1qJO
	 hQyitYmBmMG9lkmBgi2N2osfntGhzkWvaefnsYamtcOl9pQ04IHPIV/n7McM44K4p7
	 Xg9WjTOHTlPZkm2mdfKwTcsZAuCpqVQtXSWPPiylgIEPrid08Rgb7w9wU09e7rKkwq
	 96FQK5AqqdSOw==
From: Simon Horman <horms@kernel.org>
Date: Sat, 04 May 2024 16:31:47 +0100
Subject: [PATCH] ptp: clockmatrix: Start comments with '/*'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-clockmatrix-kernel-doc-v1-1-acb07a33bb17@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOJUNmYC/x3MQQqDMBBA0avIrB2ImlDpVYqLMBntEJuUiYggu
 XtDl2/x/w2FVbjAs7tB+ZQiOTUMfQf09mljlNAMoxmtccYi7Znixx8qF0bWxDuGTPiw3g00T8G
 FGVr8VV7l+o9fS60/ND7kkWgAAAA=
To: Lee Jones <lee@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Several comments in idt8a340_reg.h start with '/**',
which denotes the start of a Kernel doc,
but are otherwise not Kernel docs.

Resolve this conflict by starting these comments with '/*' instead.

Flagged by ./scripts/kernel-doc -none

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/linux/mfd/idt8a340_reg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index 0c706085c205..53a222605526 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -61,7 +61,7 @@
 #define HW_Q8_CTRL_SPARE  (0xa7d4)
 #define HW_Q11_CTRL_SPARE (0xa7ec)
 
-/**
+/*
  * Select FOD5 as sync_trigger for Q8 divider.
  * Transition from logic zero to one
  * sets trigger to sync Q8 divider.
@@ -70,7 +70,7 @@
  */
 #define Q9_TO_Q8_SYNC_TRIG  BIT(1)
 
-/**
+/*
  * Enable FOD5 as driver for clock and sync for Q8 divider.
  * Enable fanout buffer for FOD5.
  *
@@ -78,7 +78,7 @@
  */
 #define Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
 
-/**
+/*
  * Select FOD6 as sync_trigger for Q11 divider.
  * Transition from logic zero to one
  * sets trigger to sync Q11 divider.
@@ -87,7 +87,7 @@
  */
 #define Q10_TO_Q11_SYNC_TRIG  BIT(1)
 
-/**
+/*
  * Enable FOD6 as driver for clock and sync for Q11 divider.
  * Enable fanout buffer for FOD6.
  *


