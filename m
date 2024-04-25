Return-Path: <netdev+bounces-91237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F78B1D3F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888D11F23F33
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10EF8172E;
	Thu, 25 Apr 2024 09:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CE1DFE4;
	Thu, 25 Apr 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035731; cv=none; b=dvcdAI8gDt79GkdGDvRiyCfnLp+pxVOm9178q8WL+MUEjqIuq7NSnmioz06/s6Ia+AjYLauFvvE0OIuc25AkISGq8RI/jpjEz1FMPZZoTFxFw3ALlQB0Y3BtZDSvG04WN+tkInfTcNEMF704IG/NVbg5l6fMWAC+E0RWhGZayiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035731; c=relaxed/simple;
	bh=80Gn9/EKOHSsLUvQLQNdkQLytYBWuZSbdaKEw8CrbZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnFG/QsDk9pJLpfz+URPPBBOFBKhq1+TW2fJ0GR1aZEhVoe2ber2EtM19Dc2cGjfTflkrnYC2kTZnXIFvnRPtQxaOAlJvMiUbBoWslhaxomVGkP64RKYXLe1j+J1O2uV00gXhJj4/mMRMSF/Ltvpw1Xtr11hqgl+GQ7oGZd0lOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 0/2] Netfilter/IPVS fixes for net
Date: Thu, 25 Apr 2024 11:01:47 +0200
Message-Id: <20240425090149.1359547-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains two Netfilter/IPVS fixes for net:

Patch #1 fixes SCTP checksumming for IPVS with gso packets,
	 from Ismael Luceno.

Patch #2 honor dormant flag from netdev event path to fix a possible
	 double hook unregistration.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-04-25

Thanks.

----------------------------------------------------------------

The following changes since commit a9176f7c66f0f438dfd9a1a6c86ca7b73280a494:

  Merge branch 'mlxsw-fixes' (2024-04-19 20:43:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-04-25

for you to fetch changes up to 8e30abc9ace4f0add4cd761dfdbfaebae5632dd2:

  netfilter: nf_tables: honor table dormant flag from netdev release event path (2024-04-25 10:42:57 +0200)

----------------------------------------------------------------
netfilter pull request 24-04-25

----------------------------------------------------------------
Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

 net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
 net/netfilter/nft_chain_filter.c      | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

