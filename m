Return-Path: <netdev+bounces-222307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372BB53D48
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0282CAA55C0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1CE2D6E5C;
	Thu, 11 Sep 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA1B0L7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940D2D6E53
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623799; cv=none; b=gIvDkxEACvjZY8QtOo917ZgZIpU4HNLAWbfEEchDsXBX4zYwy06bcU0nHa0BPIt4PYucg2m1oThG+UnZ5KNi0hrYk/VCbT8aEypKeFA9UMu+20zbCapPWeAI0wL9Oob80L2r01rVdy8pG33OBJmRCLEgMHENrXXHyWe/1YD6qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623799; c=relaxed/simple;
	bh=vAUddV5DN/mgrfnHv70AaM53tKYLl8GmgrA+KorxpsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=juIMAGmoW/0wnrcK8KzkmhdYFw+34ezt2SzuFTkqYd31wpS5dnymBgk3uGpMJ4J19yULmDaG1P6LSK0dzW41pZmFJ9D0Hn1+efPhX2bqWhzSViMPj+KOTmufSeMVTJc27kJl0wyqFgofT9REj46F1xhqzXAKCaQrOqxR/I/6Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA1B0L7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BEBC4CEF0;
	Thu, 11 Sep 2025 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757623798;
	bh=vAUddV5DN/mgrfnHv70AaM53tKYLl8GmgrA+KorxpsE=;
	h=From:To:Cc:Subject:Date:From;
	b=vA1B0L7MvHrxvOYKBaxmt3heIzruVu38jfLyHcmGxct36BLBASL0nmh0PZ4/S+Ta1
	 7yXLUrx5APX0c7LkH4+0WOnF1eU0GjqKw9KhQRSn5MoMhpK/VUAgxalo+AHRd0OrB3
	 6W0m9sUOWzaL4WH3xVxCqJLUUGkmT7SxfDBIrr/gbcGw4R2F0qT1hZLZzRUoU0qcKl
	 gr970FVw4A6OEECBU0U1E1PZeQX8Un6zIz59VGAcpX4ufLuf3AU4BpbolQCmAlOtRB
	 Fo1r0GMj2av512go8mgtKKesLN+DixvDEuknWEYSEWAeR2XrpWEINm2KnwK924aQOD
	 mKf5gdtt5V6gg==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	jhs@mojatatu.com,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-main] Add tc entry to MAINTAINERS file
Date: Thu, 11 Sep 2025 14:49:56 -0600
Message-Id: <20250911204956.2252-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Jamal as a maintainer of tc files.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2daf2b686c3..51833ec12d2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -52,6 +52,10 @@ Remote DMA - rdma
 M: Leon Romanovsky <leon@kernel.org>
 F: rdma/*
 
+Traffic Control - tc
+M: Jamal Hadi Salim <jhs@mojatatu.com>
+F: tc/*
+
 Transparent Inter-Process Communication - tipc
 M: Jon Maloy <jmaloy@redhat.com>
 F: tipc/*
-- 
2.43.0


