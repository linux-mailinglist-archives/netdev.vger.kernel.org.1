Return-Path: <netdev+bounces-33398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3208779DBE9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1A21C21046
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48B946B;
	Tue, 12 Sep 2023 22:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E543361
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:33:38 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CFB10C8
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:33:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4C22221220
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1694558016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=07N8ZbZYDIOzmoE4ChCu2Vv60/7Dq8I529mdMvCQEpU=;
	b=ZLlb4es9PsDP/rfe+lQkzvUuF0VdCPJ9o4eFPvPumV+BaZXvz4JF9BQ5hAlfgDfNiae0Of
	2lrVoul/EMqx9aapKsDwPO3hQlnogaVrVzbua6CrMhT8Dw5Sponi08IkOTcvYj0Q8Q+OOK
	brCfbSlvF/j1DL/0DzFVIBnRzcGtb6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1694558016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=07N8ZbZYDIOzmoE4ChCu2Vv60/7Dq8I529mdMvCQEpU=;
	b=NnZZIHnubfy4K2T17Lh1f+U0nFo0h/7B9zOrg2zCO5WC45sMrDUo5v/dTrZXGcVIOBMDm0
	+8cOm7QmLhAstMAQ==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn1.prg.suse.de [10.100.225.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 38D972C142
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:33:36 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 1932E2016B; Wed, 13 Sep 2023 00:33:36 +0200 (CEST)
Date: Wed, 13 Sep 2023 00:33:36 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.5 released
Message-ID: <20230912223336.zywfpavr3ln3trp3@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3jop7z3dzqscgx2h"
Content-Disposition: inline


--3jop7z3dzqscgx2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.5 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.5.tar.xz

Release notes:
	* Feature: register dump for hns3 driver (-d)
	* Fix: fix fallback to ioctl for sset (-s)
	* Fix: fix empty slot search in rmgr (-N)

Michal

--3jop7z3dzqscgx2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUA5zsACgkQ538sG/LR
dpXnQwf/dCw/Cp1gVpxdoDnUTTyunmC44L+BD83x1Rf0PvBDpC8e/XK4xiGjHyYD
+fyB6a5VghcCgsvaJ5HlMa0UYtEU81Wpz57LMBC+s9Whvh8iqlvK06MzSx8ulKQ0
zIrk2mIrHUVdpUsvSroUmshob/l02Sr2Sr244wpTEyDdeDW76j5v5jsxAoNyWvUG
l0+ERnIn0n075NuQaQ9H9qq5+v4hm7aZktFQHJzjK044qXzJH8kvsf50IUBdD4GQ
1IJIcf7xxsB0RAQssThu2YrfFDtcRoqiNc3kdc49bMbG7s9Ip7JewMwyqhj9Teyg
cId4SExxQlPagpgIcIiOzhkY8Yukng==
=80Bx
-----END PGP SIGNATURE-----

--3jop7z3dzqscgx2h--

