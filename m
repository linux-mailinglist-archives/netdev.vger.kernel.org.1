Return-Path: <netdev+bounces-55855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F580C8D8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007F6B21467
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4738FA0;
	Mon, 11 Dec 2023 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxU29J/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278D38F9E
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2FC433C7;
	Mon, 11 Dec 2023 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296104;
	bh=u5sQodHmgeUGetU+YwflYVPLz9XrCKSXeVC0+jaT0C8=;
	h=From:To:Cc:Subject:Date:From;
	b=WxU29J/ASq61+lKcRhveSpg3ox9opLl6GR2u9wmJx5EMuTRey8Qx7MtGXU271uy2D
	 mMve/IEOxNrfailjU4yUe9G4cubJlXrUe8Xnjd+XW8ZiT+xbjsr/B9HyCs6gJWtw9G
	 fLV0mtT1BVg2QRwUsIo0KRD+HSelagcydSKxxAlbdYzG8l7VEgpHZfGQOicvHIQODC
	 NfeoDt3PY4unnALsBqEI9jPtEVqRO+f4v4kA84vkcLsazTPXk5vY3uz6UWumJcl2jr
	 uC8x/o0VTgQiTgyydHMxFHtrfXJYt+axZ71K34ADZfl4sYGVLto3jL28fepllrkGxd
	 vf37elW9+aJCg==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH 0/2] selftests: net: ethtool_mm: Support devices with higher rx-min-frag-size
Date: Mon, 11 Dec 2023 14:01:36 +0200
Message-Id: <20231211120138.5461-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some devices e.g. TI SoCs have an errata due to which they cannot support
rx-min-frag-size of ETH_ZLEN (60). Also some devices cannot report
individual pmac/emac stats.

Modify the test so it can pass for such devices.

cheers,
-roger

Roger Quadros (1):
  selftests: forwarding: ethtool_mm: support devices that don't support
    pmac stats

Vladimir Oltean (1):
  selftests: forwarding: ethtool_mm: support devices with higher
    rx-min-frag-size

 .../selftests/net/forwarding/ethtool_mm.sh    | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)


base-commit: 70028b2e51c61d8dda0a31985978f4745da6a11b
-- 
2.34.1


