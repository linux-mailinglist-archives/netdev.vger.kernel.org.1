Return-Path: <netdev+bounces-223871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52338B7ECCE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EBD167085
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E462BEFFE;
	Wed, 17 Sep 2025 07:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655028CF41;
	Wed, 17 Sep 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092441; cv=none; b=clDByzk9OmjOz99dHrMpkk7Auk6rYaGKv7ZRYuuWtvvCE4LR2bezV8JR6du23ZXAVOTAX6J6wO97GDcD65g7UTHbf+B0/kijXRqeBAYR0mMuDxrnMrVUCwpgmBeUPm9XJxl2SMF7iQv62aVQxDGdFnH1U0MCwB5NkGQxFmH5oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092441; c=relaxed/simple;
	bh=0rx7sRVBfmTsQQRZiCNlXEGlShuA/08z1vTySs1d+D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IH23pkBAeqD3ScW9gvMK4nC2Vf8LYetCwKrwidcib50KoKo2NyvviuJoMroFaSEVW3UDTZTgndtNo6xB4cMvVBR2o86Bp/CwnaL1lDlYWmp7+eMlKvZ1vZN+4k3qMzkfv99/z3l5xid8wmMbRcqfbJ/6btUJt/6g/l+QDL0OgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23172db05;
	Wed, 17 Sep 2025 15:00:27 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: wens@kernel.org
Cc: andre.przywara@arm.com,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	jernej@kernel.org,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	samuel@sholland.org,
	wens@csie.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH net-next v6 2/6] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Wed, 17 Sep 2025 15:00:20 +0800
Message-Id: <20250917070020.728420-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250913101349.3932677-3-wens@kernel.org>
References: <20250913101349.3932677-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9956797fa103a2kunm2e50bc1654ced5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS01JVhlLT09IGU1NHh1CHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVJWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+

Hi,

I tested this on Radxa Cubie A5E and there seems to be a small issue:

When VLAN_8021Q is enabled (CONFIG_VLAN_8021Q=y), down the eth1 interface:

~ # ifconfig eth1 down
[   96.695463] dwmac-sun55i 4510000.ethernet eth1: Timeout accessing MAC_VLAN_Tag_Filter
[   96.703356] dwmac-sun55i 4510000.ethernet eth1: failed to kill vid 0081/0

Is this a known issue?

Thanks,
Chukun

