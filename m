Return-Path: <netdev+bounces-50665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9E7F68CB
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5A91F207C9
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581731803D;
	Thu, 23 Nov 2023 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvMKqpfS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jq5aHo+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2585D5A
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:06:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A2864219F7
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700777185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4TVVvZtAGGu35ln9PqaSuzP2oIhqIimFPohsIcnljo=;
	b=wvMKqpfSyWJeZe8PPeFdRYA1Ij11YcnwVW0EK3xQd7buksz0tzBeYxyOCfM0PZ0yEqkxGq
	LLStt6IBXaqtE02CUit2ylHkQMPvG3hJBTCH9ycoxswDQu0FvlHti2at9Fm5qWLBDHx2h3
	MfURIKVcWORvgxYi+vYemX/sIl+RsSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700777185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s4TVVvZtAGGu35ln9PqaSuzP2oIhqIimFPohsIcnljo=;
	b=jq5aHo+czaOVBhn1Kp/4uAun5Y8LUGmwGgU1PMu+FraPAG0smlkppllgZwcBZ6Xq2Koc6q
	DeWb5KiVI94ZmEAA==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn2.nue.suse.de [10.163.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 9786F2C15F
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 22:06:25 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6E03A2016B; Thu, 23 Nov 2023 23:06:25 +0100 (CET)
Date: Thu, 23 Nov 2023 23:06:25 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.6 released
Message-ID: <20231123220625.q427zyjaogdmlf6d@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qn7fiwcfdbd6vqqj"
Content-Disposition: inline
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of mkubecek@suse.cz) smtp.mailfrom=mkubecek@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [14.42 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[netdev@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCPT_COUNT_ONE(0.00)[1];
	 DMARC_NA(1.20)[suse.cz];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.47)[79.21%]
X-Spam-Score: 14.42
X-Rspamd-Queue-Id: A2864219F7


--qn7fiwcfdbd6vqqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.6 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.6.tar.xz

Release notes:
	* Feature: support for more CMIS transceiver modules (-m)
	* Fix: fix build on systems with old kernel uapi headers

Michal

--qn7fiwcfdbd6vqqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmVfzN0ACgkQ538sG/LR
dpXfUgf8Ccbgn1ry0WCCFmqOuMjo8KlrhmB8OTqwQxG5ybqm6BwTSk+2PXzjFTma
K/lo1RIUXNgDRhrcVZcZVKGYElYe71yqUgQpKysaLzPh7faDnkNzXOjiB012uy7n
oEB4jNVpexXemlAd/hXvFll6zR+/fnN6FFmhze268wEntTXd+a/E8EswDs/8R3CG
odqHyq0TR7qn1C8bI2hZjlZ6K0UhiXRJa4LFHVJ5/5JkWlR+fzpr/Uaj8SZb459L
ZLiItYg1JdWEnd0La8dexUPzIeLNojVqZuCLVROMKdBeiZILgdqNKkbYk+3zTod+
TV3euEsLOpIDHs43OC9Q/k3sGqmBdA==
=Ot1m
-----END PGP SIGNATURE-----

--qn7fiwcfdbd6vqqj--

