Return-Path: <netdev+bounces-160597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8CA1A75C
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EBB7A1C5D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27240211A09;
	Thu, 23 Jan 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfgvDUM0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04116F4F1
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647743; cv=none; b=qSLAvG1lP5Do06BwAi1o6/AwyQfNhoRm9YTgz7suRJEpwOyx6M6KzMn/txhdvx/06ThZm8uzVsVZmXp8kZop77VfpDxVi/Obbu4b5yRtUlYw42NqXgnk4ecNMeA09jsyhM60Y3QhEPRl7n3KMliMAOkgwAignsIRxPV+nvngYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647743; c=relaxed/simple;
	bh=liUspjerF/BbL6p5ySEZyxh+EaClYLDlYCDDAQOWNi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahK/Bn6ELWxHh3Iy4Au6900RJ95ys5eiQI5EZike0EfJhhulBW8gyITk4uT2ClIkXyKK7PDvEI0w37mGIFd4UPHQbaQjEgB552Kvd5EVmANvc4zjIx+c88RBZKNw66b5PtQcDtzVOFpWsnVERRV5ya1jf0ypRfBspKPQY2Jc15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfgvDUM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F87C4CED3;
	Thu, 23 Jan 2025 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737647742;
	bh=liUspjerF/BbL6p5ySEZyxh+EaClYLDlYCDDAQOWNi4=;
	h=From:To:Cc:Subject:Date:From;
	b=bfgvDUM0jYtg/C6747062jIwKt1cyY5saE20o2k5u3biypg+kL6/2odGMFp6MkgwS
	 Wd/ELV2HibIdT8kDWiBFejUPa6eSUuiNwDpm1X/szCCa70V+mkBdi5khqRw0eyQP1G
	 ws2qpxvBP2idIiRHW6yJ90frOFwooG0A24USzE7KLNBEBFlriXJSYRL4TXmdMGnsUx
	 27vRZ+cMA1eABb/UoXyqbXnueCKh4t27nwzSnL1HCqWtzCf8eNjtYgOkZzbJHZwe0C
	 9zayNJ1p9qqsUmCLqoJWSq6CnVXMEpi3y9aYM1mZbIhy6YKzmrKsMkwDxL5WaV+KVN
	 LLbIcOmaQDTpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com,
	fercerpav@gmail.com
Subject: [PATCH net] MAINTAINERS: add Paul Fertser as a NC-SI reviewer
Date: Thu, 23 Jan 2025 07:55:40 -0800
Message-ID: <20250123155540.943243-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paul has been providing very solid reviews for NC-SI changes
lately, so much so I started CCing him on all NC-SI patches.
Make the designation official.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sam@mendozajonas.com
CC: fercerpav@gmail.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c024ca276e5c..d97df77a340d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16148,6 +16148,7 @@ F:	drivers/scsi/sun3_scsi_vme.c
 
 NCSI LIBRARY
 M:	Samuel Mendoza-Jonas <sam@mendozajonas.com>
+R:	Paul Fertser <fercerpav@gmail.com>
 S:	Maintained
 F:	net/ncsi/
 
-- 
2.48.1


