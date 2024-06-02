Return-Path: <netdev+bounces-99984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3D8D7620
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC43E282584
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A240855;
	Sun,  2 Jun 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cBgnWd7W"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF23BBCB;
	Sun,  2 Jun 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717337947; cv=none; b=aFZthFnwWyNiyF2Re+Sfn5pY6R2T04w5wQuLROnwV/QYECaUpcEOx/FPgeImsw0fpET17Uq8+cY/lBV2ccL3cYlktGnrQ939HVTSfFAgiDQ1qLsRjvq/Oe4XQ1/JnseTm0xDIg1Dn2Jo1A5T1o9T75j+0xmiykjgLfnJZMKQPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717337947; c=relaxed/simple;
	bh=616g9PhgfscNJD37Ox3mo0av4VN7wRoUTxTISJCeSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrL7RJNipFtG1nmCH0iZRylbKmMhn4HuIU3B95BipClUJ0aVTy+X5Lk6Ir+fNO8JxdhJBGeiLXMJDcVJ/Sp4mwUSWFTqFy8IWB2Ji8s8dkWUeKBS83t8uxJH7qpVcPAbk/FviHZ67J/9A0ET5bUDYxAiuee6PVn124ywmLa5P+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cBgnWd7W; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id Dm2ns8x2vLmxrDm2osLKQn; Sun, 02 Jun 2024 16:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717337928;
	bh=o8RBOg2YVX5TQy4cE+lxZslyfDzc2SAKgZRk6xBA98A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cBgnWd7WnT6MnIPUJWlcVKcKzEravI82GDI9l1h2wBd8piCoOUEXvahpzMVhX0YYi
	 +c0dXsLxViMBiPEAZtQS6DUJinvg+F6UHeMIuW5L4wxb2+B8oRrIQOuQNIywRvBFN5
	 zb98sWqE6r+UCOikf2FAzKYXlhF3u28DKeRhGuWaFKz099oseE1fFYcBp/wkmIU5Hd
	 bLfY0tirZEd8fjG9z+slYw/X5tIX5WMhg2L/BzFRXPBCXCZbtenmDVlnCA2GvqBV6y
	 emC2yDWfTCip6MwsbpHXCgj3CPUNArawGtx11VxT796+4dcuVNOYYxAnDfpOp504iC
	 lMcr7btn/7Vng==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Jun 2024 16:18:48 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2 net-next] devlink: Constify struct devlink_dpipe_table_ops
Date: Sun,  2 Jun 2024 16:18:51 +0200
Message-ID: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 updates devl_dpipe_table_register() and struct
devlink_dpipe_table to accept "const struct devlink_dpipe_table_ops".

Then patch 2 updates the only user of this function.

This is compile tested only.

Christophe JAILLET (2):
  devlink: Constify the 'table_ops' parameter of
    devl_dpipe_table_register()
  mlxsw: spectrum_router: Constify struct devlink_dpipe_table_ops

 drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c | 8 ++++----
 include/net/devlink.h                                | 4 ++--
 net/devlink/dpipe.c                                  | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.45.1


