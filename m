Return-Path: <netdev+bounces-85113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B489981D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90060B20F26
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6D3DB97;
	Fri,  5 Apr 2024 08:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4C134AC
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306413; cv=none; b=eLHogAWmUH9TGXmdaSetI1ElIirccw0BqFaNrHHZ5OLtoI7YtZ9qWFQ9RctqtbIBL8Ys7TsKXGXscR3l2LfeVhucGN6bb3qFPpYu6ZRhSuIpHz4Ecmf/rh3WxBO9tYquLJ2KXMc8aVbCeZLdE2LyehZEZfBOkEh0Xwk1VEyL/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306413; c=relaxed/simple;
	bh=v21Cx4WJ/mAe++dRt8WwFR/4+n+yLxsc6/SCegAQdDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PxsvzxvZG4tX3k8B2S59TiLDSlbVRaazMXBPJP1IfEiVlTvNPVQWNAbnGXFJgIcC0LPyDMiRD0U/ZZDD6RZV48Tfzac90YsZU6cls/KKdqTldZ9UT+o+G+B2lOAFj1gQ4FksXswiFxYq7mL6OvapKunSeYvyAZDMeeFlL+NQSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5de1fdf8.dip0.t-ipconnect.de [93.225.253.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id CB7E1FA100;
	Fri,  5 Apr 2024 10:31:28 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2024-04-05
Date: Fri,  5 Apr 2024 10:31:24 +0200
Message-Id: <20240405083125.18528-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20240405

for you to fetch changes up to b1f532a3b1e6d2e5559c7ace49322922637a28aa:

  batman-adv: Avoid infinite loop trying to resize local TT (2024-03-29 20:18:43 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - void infinite loop trying to resize local TT, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

