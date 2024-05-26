Return-Path: <netdev+bounces-98094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C58CF504
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA1D1C209B4
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D475102F;
	Sun, 26 May 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DD05jLrF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5129CE0;
	Sun, 26 May 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744340; cv=none; b=mkQj19Ne5/FovghpqKH66IQdqnrvCJw26MxX6pyMpBGcwSGyZQFk1SOb1sQKqCUNI9W/Xd+dX0Z/yB7ko83wRAyh6LY6Tdo68RuMuK+YX8qwiHD6cYUv1UVYBFRpktWOIDuB8kB3MCruU+A1byUahqmRH7DpnYf7b1b1+gmW6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744340; c=relaxed/simple;
	bh=6vNY3CnMdtIcOsaHyfoxAPe/v03zK24DjJJUQbJ4JoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhKogUcIqYn0WYcpW6pnMd2+9zRSE7hqSCaYXIzddeDVmUw2+w8EX3MkxS7vMwGSTMvEAR3iI4eYd2H5ZNG5JSs+BUlfbU21lmP9CnT4oMaA7sy8pznHhWhGyMBrFSwzWUO0wZiF5nUf5oPtp3fuuHCNx/1nz0Faio4kUMyFWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DD05jLrF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=HVlKaRLAGrgFec1JknWv2UFP5BkmnoVF2cCKocvFN4A=; b=DD05jLrFimfSkp/F
	1qx8bGz1IGzJ7y2BmLRqfjERLn95mQbliR8X5T+PL4D0NGewJ0D1ozH9Z5YJTDVNSvB257FijSDeP
	jhpvI9ACtUQgbWpzYmt1N3Gf/mkaIucanyq5gjWBTZYxLE75oaQzehIKOnCR0Gvjl1u8VXAVeRHYI
	dxcho4sBray+37kqNe1uVXJnsgrMHyq6RycVt7tv06g3za0Irn9VnJstSU8UTSUoS7K8uoBVvhkFp
	G0u1xU2O5QC55bMxzz7c8c36XN/gtFETGjANTZv2Bs+MaPyUWzFBwtbkNC+B56iQ/LduZs/HcavQV
	/s4IrbY452Mz3bpDIw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBHcR-002aYf-0o;
	Sun, 26 May 2024 17:25:15 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ionut@badula.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/4] net: ethernet: dead struct removals
Date: Sun, 26 May 2024 18:24:24 +0100
Message-ID: <20240526172428.134726-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This removes a bunch of dead struct's from drivers/net/ethernet.
Note the ne2k-pci one is marked obsolete so you might not want
to apply it; but since I'd already done it by the time checkpatch
told me, I included it on the end of the set.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (4):
  net: ethernet: starfire: remove unused structs
  net: ethernet: liquidio: remove unused structs
  net: ethernet: mlx4: remove unused struct 'mlx4_port_config'
  net: ethernet: 8390: ne2k-pci: remove unused struct 'ne2k_pci_card'

 drivers/net/ethernet/8390/ne2k-pci.c               | 11 -----------
 drivers/net/ethernet/adaptec/starfire.c            |  8 --------
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  6 ------
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c |  5 -----
 drivers/net/ethernet/mellanox/mlx4/main.c          |  6 ------
 5 files changed, 36 deletions(-)

-- 
2.45.1


