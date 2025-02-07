Return-Path: <netdev+bounces-164131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00CFA2CB75
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F816B51F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A071A3171;
	Fri,  7 Feb 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1zgiNS+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A21A254C;
	Fri,  7 Feb 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952998; cv=none; b=NIEe6mWffIHxXypX0KOpPZjjStAl7geFUWdy/AFbO9x8KAPRUOw2eU9kc0CjlvCSUN+uEKHO90ztS2pAbl+Y1GyHSGreRBg7qfi2uF9a+PpUR6EgMlO5FLULUx3Ix3Yies2gUCKisKEMNEpFN5/wosSsV3LH5h2P/0bBaETxOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952998; c=relaxed/simple;
	bh=8KSVAGGYFXCoPPmxpLraYt7JRaWHOY4JjqgymOmrNnQ=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=Qc0zziemFOeIU4JGlDWWNRhrrUELgiOLErXpMzHi8+oW5PTBXkEKDEYFjUs8/ZNvCZfy+S5YbuL10zLflriZ/Lw/bOdURUBhWpHxra2rxEnnduLPeLz09MEvApJibw3mUF+S0x6w2mZzSLbPR8sJnUqaqAnJZLZSrziS3uMKNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1zgiNS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23315C4CED1;
	Fri,  7 Feb 2025 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738952997;
	bh=8KSVAGGYFXCoPPmxpLraYt7JRaWHOY4JjqgymOmrNnQ=;
	h=From:Subject:To:Cc:Date:From;
	b=e1zgiNS+g6yvR/SOMrAUJcT+H/P20HxfuQqiYmHTa8Iu7OG60Ft8ARWiRP2ufFEZR
	 KZLZ3Fb3oenALT/Zy63SOwhFACRVOBW8LP/VhaOT6E6pkLiPqw6du5PpRoJYNr8iBw
	 gfm0Ay8KTGlcMCdqQfkG2HakAeez4/sGs5TvlK5usYsFjJ1GB7uFIZEt+9lKqU8Agf
	 Gwz13EvIbDRqAw/TwLLfPIsZCPZy54d9CgxiCq0Xlq/zXyKsUw1i5hnEq14jR9dTRq
	 aHkz4MI+k6vTylMcOk04+hVupITIoeahlGHZPXBnwO+mzJ1RwOnZr33QJxs7xNwGad
	 B8r1jsIsH+bFQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2025-02-07
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20250207182957.23315C4CED1@smtp.kernel.org>
Date: Fri,  7 Feb 2025 18:29:56 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a:

  bonding: Correctly support GSO ESP offload (2025-01-28 13:20:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-02-07

for you to fetch changes up to b76adb9758f8eaaf22b824d0bcdd694551ce0557:

  MAINTAINERS: wifi: remove Kalle (2025-02-06 22:30:26 +0200)

----------------------------------------------------------------
wireless fixes for v6.14-rc3

We have only one fix for ath12k and one fix for brcmfmac. Also this
will be my last pull request as I'm stepping down as wireless driver
maintainer.

----------------------------------------------------------------
Aditya Garg (1):
      wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware

Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

Kalle Valo (3):
      Merge tag 'ath-current-20250124' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      MAINTAINERS: wifi: ath: remove Kalle
      MAINTAINERS: wifi: remove Kalle

 .mailmap                                           |  1 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |  1 -
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  1 -
 .../bindings/net/wireless/qcom,ath11k.yaml         |  1 -
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  1 -
 .../bindings/net/wireless/qcom,ath12k.yaml         |  1 -
 MAINTAINERS                                        |  6 +--
 drivers/net/wireless/ath/ath12k/wmi.c              | 61 ++++++++++++++++------
 drivers/net/wireless/ath/ath12k/wmi.h              |  1 -
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  4 +-
 10 files changed, 49 insertions(+), 29 deletions(-)


