Return-Path: <netdev+bounces-115646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC894757B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9473C28496B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1551448D2;
	Mon,  5 Aug 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ehzcHu/o"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080651422D8
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840130; cv=none; b=u+IqSNLO9eXomrzr09EFYpEK6Wr6+ZRdkX+nAN7lHzg30e5JJw3XzyT+xWntW8+J7UlCRUUb51p9NQCPOvoYC/Bh6nz2tgpyYPOVP9fJOd9Hx6QoHKYqeDb0B8l5aNZXMlk/E+JOgspTipv/eiwNZSuVw5v+sJsu4TvDCEtfwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840130; c=relaxed/simple;
	bh=UF7et2QqACNgp6O1SUQXlgg+/VGMgi+IZGWPoTIYheU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrSGyRPpnk57tnbsdMNLHhykBASyoXeEirbLZakbzYdTnt+L365NTN2DxDIi7Pzq6myIPV4E0wd54TUgVqOt5ByImoNbv/P3wHGkXFzowZ7k4HuGvNiizZww0ltefqE+Ecxvstv2xdCMRbII2L1qZEkTYRX7cmiSif3fnmlud/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ehzcHu/o; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id arOns5eD41n2IarOnsUUL2; Mon, 05 Aug 2024 08:40:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722840055;
	bh=bhu0kj/E+bTLzKxE31tljXZoIT0Y2DQ63u7XVU/JDPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ehzcHu/oAgH+tJ/8KcriYSs256oALIWR7NiwC25+g8kjWSAuXtxBPK8jP6uoIWYEX
	 m8K9a8b+oSN0bX1ZgBFfvaWs6rZYxWOOpVkrGWsEvV6FUdXsJM7fMap3f6yPEVp7WQ
	 zU/SehWywmRy1ZoSMB27mvnmi9pt7nvyRpCGDEE2VIOZkMbhaDt0n/eAA0rVX7EYaG
	 vitndP/CswLd1ezgrPSET3uqUDBtWAmKJYaVC4bjFqSx9EADHBfB8iXf8buvw52QLc
	 21Xw1i4Lk3/ZTSEuKoPAUAWASMoK4EwJ9IJtyfzPJCJPicCvtcG9vnT8lTsf7xeLrq
	 1fdKgLL3K3WDQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Aug 2024 08:40:55 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: stas.yakovlev@gmail.com,
	kvalo@kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-staging@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/3] Constify struct lib80211_crypto_ops
Date: Mon,  5 Aug 2024 08:40:36 +0200
Message-ID: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This serie constify struct lib80211_crypto_ops. This sutructure is
mostly some function pointers, so having it in a read-only section
when possible is safer.


The 1st patch, update some function prototypes and data structures in
lib80211.

The 2nd patch constifies some struct lib80211_crypto_ops in lib80211.
This moves some data to a read-only section, so increase overall
security.

The 3rd patch does the same for staging/rtl8192e.

Note that the functions have looked in staging/rtl8192e look really
similar to the ones in lib80211. Maybe it could be removed in favor of
the latter.


Each patch in the serie has been compile tested only.


Changes in v2:
  - patch 1: Update ipw2x00/libipw_wx.c as well   [Simon Horman]
  - patch 2, 3 : no changes


Christophe JAILLET (3):
  lib80211: Handle const struct lib80211_crypto_ops in lib80211
  lib80211: Constify struct lib80211_crypto_ops
  staging: rtl8192e: Constify struct lib80211_crypto_ops

 drivers/net/wireless/intel/ipw2x00/libipw_wx.c |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c   |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c   |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c    |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c           |  2 +-
 include/net/lib80211.h                         |  8 ++++----
 net/wireless/lib80211.c                        | 10 +++++-----
 net/wireless/lib80211_crypt_ccmp.c             |  2 +-
 net/wireless/lib80211_crypt_tkip.c             |  2 +-
 net/wireless/lib80211_crypt_wep.c              |  2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.45.2


