Return-Path: <netdev+bounces-135753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1099F135
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC71C231C7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97E1E6DEE;
	Tue, 15 Oct 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCRyRkyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF11E6311
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006221; cv=none; b=qv4+GaFxBNeM5IZKdn/V4WGV1ab+VgL7psqGmUEQtYW3oGpJna0GHrrJjg2BlEoAIkcmmyHVkfU11pMLdY9qRf81FGj15XsT/zD77d1Q0KVFWPyl1Bo1d+zW74NUOUlfhIkPSVlKz/x+qZv6Z4aTpcPgnVbtXaYS88AVf5z3MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006221; c=relaxed/simple;
	bh=FPDIVTyhh1Du23CmqEwzFbDltHeaLTnwT3HliqoeoT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWt+bTJ+zIlgch47rQ1JT3Bbq7Ue3Q8MEIeB6oWChD6T1LAHz/3hq+aHa6aLz5QeHThOex8SGC29I0gaYJ+zhxVmDT74EisMOSXZurSulBeKiyVSZn+l2m+IyPi32AIhLYIXBabaxSfbpGbDnaG+5v7GR5VSyKGMQw4Wuc/8I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCRyRkyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85175C4CEC6;
	Tue, 15 Oct 2024 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006220;
	bh=FPDIVTyhh1Du23CmqEwzFbDltHeaLTnwT3HliqoeoT8=;
	h=From:To:Cc:Subject:Date:From;
	b=bCRyRkyYFN71pSP9CA+wXwr34jvg99XjOFVAUprchLcp+HQVk/t0E0FMNjy6zHwaT
	 Qx5rSghU1g5NH70MPhZ6ZaqnkTE5tcbtylxbrlGomjDZaeE14xW0jWH6JNq0jwNcFR
	 3kCaqF7M7G+sO6oNezjLMpC6xohEljavc9Ro07bW4U0lrK2oKFhitkh94VesAIurjE
	 uYyVCUSKXoXG3896Gk+saQXkD1kqOdWjM9O0PEvZcj49e+RTqFdsGDPCm2iI/8YYGj
	 DkoCMU8zd3uCWADXUn3kGRQ8/0Yk4QW5//g7tcJ+yKzCJDVoTojxx1yLzyBbeh+VM7
	 RlmwDcGJwK3Yw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add Simon as an official reviewer
Date: Tue, 15 Oct 2024 08:30:05 -0700
Message-ID: <20241015153005.2854018-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simon has been diligently and consistently reviewing networking
changes for at least as long as our development statistics
go back. Often if not usually topping the list of reviewers.
Make his role official.

Acked-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 831c72532a0b..76c8b4b5e2ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16171,6 +16171,7 @@ M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
 M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
+R:	Simon Horman <horms@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 P:	Documentation/process/maintainer-netdev.rst
-- 
2.46.2


