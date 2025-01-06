Return-Path: <netdev+bounces-155528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7CA02E51
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D8188608E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5E14037F;
	Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXSFIRjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99470824
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182467; cv=none; b=VFlG3YyL4+VnGYZPv+cnvbJzqNmX1+mFLRkvHoumCq+UrnLXoId9B/C1vRdlKjI8Gh4TcQuwjy/9MruBHs2x5rWtNUcfpk6RRprw08LNpT3siZk4hwA3tV/p5tCbx5T10/rANuoxIOUb+wdsJ0vaHm6CASuCJReA2Ytu/iTl0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182467; c=relaxed/simple;
	bh=o88mEBkqcX49MiGIJ0Vbncz0sdQZ12DWr7PW0n9cOwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNGiDfqfyYS+IIrePalScqBSG3dMO0khyXf1hsxeKKKd+i6QVzmea80VGQM92GVbKt4PIEVEiQiqCBQSCKzSoUoMWMPJNy4ldbAGqL373jssGLpwo9Anwg2sAfRTtAuxhhgHjmWWY0Cl8mJUGSH8fxW7XxlsIbHiBfODW+AmvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXSFIRjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB03C4CED2;
	Mon,  6 Jan 2025 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182467;
	bh=o88mEBkqcX49MiGIJ0Vbncz0sdQZ12DWr7PW0n9cOwI=;
	h=From:To:Cc:Subject:Date:From;
	b=JXSFIRjlaogRhI/297LZ+6a9uE4CdKekCN9I4ysLTypKdpNkycK1gJKg2mNGgrOr0
	 5ZfO5nsJ63KLZyc/AwqfSFxDCZtmMcna/UQMT53NPPCi1pVnre9xlIVD877wXzWOR/
	 W8+1ZGaj8yQbfSR0CXeGJGW1CfzBs+3IDNIlpu0Marpw0mD97TpT3Qgq5sOON9A039
	 pFYYqeB0kie4z63cQV7sJ4amcSxsiqJZYX3v3ky8bN/hlwvgYbNVmBLlXeCGT0So9Q
	 zsPA3Oe6qeyZqsYUjNiDWUT3x2tURA9ZgujmAwHSrCjvPi/rf3R6j0c/Yt1+bWU8aj
	 Lz5hkWHl8Reyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/8] MAINTAINERS: spring 2025 cleanup of networking maintainers
Date: Mon,  6 Jan 2025 08:53:56 -0800
Message-ID: <20250106165404.1832481-1-kuba@kernel.org>
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

Jakub Kicinski (8):
  MAINTAINERS: mark Synopsys DW XPCS as Orphan
  MAINTAINERS: mark Microchip LAN78xx as Orphan
  MAINTAINERS: remove Andy Gospodarek from bonding
  MAINTAINERS: mark stmmac ethernet as an Orphan
  MAINTAINERS: remove Mark Lee from MediaTek Ethernet
  MAINTAINERS: remove Ying Xue from TIPC
  MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
  MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC

 CREDITS     |  8 ++++++++
 MAINTAINERS | 17 +++--------------
 2 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.47.1


