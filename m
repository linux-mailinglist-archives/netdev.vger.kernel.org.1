Return-Path: <netdev+bounces-14976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB30744BA5
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 00:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD001C208B7
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290FDF4D;
	Sat,  1 Jul 2023 22:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F82F32
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 22:43:11 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A610CE
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 15:43:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 8016D1F895
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688251387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=pDhrNAE+Wi59bBoPqy2hsaaTF03oKzjhH5ElME0Foh4=;
	b=3G/0J3oky4ei/cKQ/prb8TQhmH0hdDvZ6SycNXA+fA9xe+koth4GwP7sfJ/In7p69ZFahT
	I+l1Lhwy0LBdQY3agyjILd8LPAJQa7mqy+WtG3WQPKw7otIO2WV14nhIp2eXYEUvNrtaZd
	QtlRdptR9VL4LbG5dEkJOH+ymtyF4R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688251387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=pDhrNAE+Wi59bBoPqy2hsaaTF03oKzjhH5ElME0Foh4=;
	b=bs589+bWp59lLLpgUqWvHltRLRSuC9gV6L4qxI3J0K0eA51p6KMN4BKkFAVSu+dJPY1WLD
	QGf85VKrVk0v7zBA==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 7448E2C141
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 22:43:07 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 4FC5B60755; Sun,  2 Jul 2023 00:43:07 +0200 (CEST)
Date: Sun, 2 Jul 2023 00:43:07 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.4 released
Message-ID: <20230701224307.dcqapriuieos4l6w@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jqwu54ub2ijg6vb7"
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--jqwu54ub2ijg6vb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.4 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.4.tar.xz

Release notes:
        * Feature: get/set Tx push buffer length (-G)
        * Feature: sff-8636 and cmis: report LOL / LOS / Tx Fault (-m)
        * Fix: fix duplex setting parser (-s)
        * Misc: check and require C11 language standard
        * Misc: clean up obsolete pre-build checks

Michal

--jqwu54ub2ijg6vb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmSgq/cACgkQ538sG/LR
dpUu0QgAymsAIZDYTa6y7tnhMupFfM4UHqmHZ4SyOZmXtBxnyK2j6RhQKhE3O8oM
2SCmzaLKsjSfVAVzjSrNC3WFW24IE37okOou002+KvXxov2p34hnhO7HJkcqktlm
rM1NLcra+tEJavCp3BryF+eceWu9ksNZDgnw9lWM4U9KKxoL833oPbPON66/XNSd
ad9TtVKpteOHY14477VqTK90GIAyjrkkMYYqF0DLqjEtvfAB8Pr/O+/GDdOkHxhA
d+yD45cYNGaqrkeeCnuBkx+HQa/ZbNVm0RvyUHVftnThDBiEzcdkclcu1+hmnfGm
9UB3+OtXeaDQ3a+2Ha3LFVXD7E3leQ==
=/CiF
-----END PGP SIGNATURE-----

--jqwu54ub2ijg6vb7--

