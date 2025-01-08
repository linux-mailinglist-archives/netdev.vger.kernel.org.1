Return-Path: <netdev+bounces-156313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A1A060D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E94A7A51E7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7741FECDE;
	Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGBtKq7a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDE1FC7C2
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351566; cv=none; b=cePJyQQyD5Cjldxo6Orgg6HFTOTWBZdVeOwXxm8+CMZu10hwWjUG0W7CZIgGVEDlnPmuvjvFW63p3wRHnpFksLQrjQQ2/67ZdEXWlbGEECs3RdSpl+vjW+krRNc+N6Pb4TmlOv6i0S6OmagVDwx/AIv/NneOaMHbG6NqlNQ1d7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351566; c=relaxed/simple;
	bh=1K8pW+qGNyxLybHkt+tB2pAMmSLDGc+rlc7wPrSww38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjtxUPPjI0sHca6ROjTRKI6sWOvGioVDw8UZb4oX6vUHpyCAoPQ+q8i+Gd2LtbmbIecdMq6Cp22p+9xB+VZ1iD6cJ+tkSkbXEXFLXaX8aBK7vn4+CUFhnPOaggreT1u1Y8Zb+G71eFpNJoZM3C++R7m0fVPOF2MZNNUHBaGt0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGBtKq7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F522C4CED3;
	Wed,  8 Jan 2025 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351566;
	bh=1K8pW+qGNyxLybHkt+tB2pAMmSLDGc+rlc7wPrSww38=;
	h=From:To:Cc:Subject:Date:From;
	b=iGBtKq7awQUv73WvsTw2fDRhJNsu6LZxyDsW+tTcYCpl5D17GsHkU2VU8CvG9WjeY
	 oZpiWDKrrJnEZxcNJAcKdZUtKHYigKzOH2Qo++wa8Sz0k4PI0KeK0KhlW9npItjhtP
	 UTi7dQZYYRGoYU1X3MtUM3K0BpyX7xjy6EoMyRutD1O5k157kTSkJnvN3+yyRGixeT
	 tkXoFCSXevlNhrWYq5GGDEPpaQkT4DK9XeiOY/NJJZu/POA62yB6UGgT4PNGRQ7l9X
	 ORxNQvBXIjF59meFQRqOPECBuX6jJRW/A7prLvtE7J6Lq+nmeMReWF1a4iUQ9ufHiy
	 0blZADOiXMb3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/8] MAINTAINERS: spring 2025 cleanup of networking maintainers
Date: Wed,  8 Jan 2025 07:52:34 -0800
Message-ID: <20250108155242.2575530-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annual cleanup of inactive maintainers. To identify inactive maintainers
we use Jon Corbet's maintainer analysis script from gitdm, and some manual
scanning of lore.

Please feel free to comment if you either disagree with the removal
or think it should be done differently!

v2:
 - [patch 2] add new maintainers for LAN78xx
 - [patch 3] move Andy to CREDITS
v1: https://lore.kernel.org/20250106165404.1832481-1-kuba@kernel.org

Jakub Kicinski (8):
  MAINTAINERS: mark Synopsys DW XPCS as Orphan
  MAINTAINERS: update maintainers for Microchip LAN78xx
  MAINTAINERS: remove Andy Gospodarek from bonding
  MAINTAINERS: mark stmmac ethernet as an Orphan
  MAINTAINERS: remove Mark Lee from MediaTek Ethernet
  MAINTAINERS: remove Ying Xue from TIPC
  MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
  MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC

 CREDITS     | 12 ++++++++++++
 MAINTAINERS | 16 ++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.47.1


