Return-Path: <netdev+bounces-47219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE957E8F27
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF61F20EF8
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE16ABD;
	Sun, 12 Nov 2023 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019726D3F
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 08:26:28 +0000 (UTC)
Received: from relay.sandelman.ca (relay.cooperix.net [IPv6:2a01:7e00:e000:2bb::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E12D73
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 00:26:27 -0800 (PST)
Received: from dyas.sandelman.ca (unknown [213.235.133.39])
	by relay.sandelman.ca (Postfix) with ESMTPS id A33651F427;
	Sun, 12 Nov 2023 08:26:25 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id 90137A1BCE; Sun, 12 Nov 2023 09:26:24 +0100 (CET)
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id 8DE8BA1BB0;
	Sun, 12 Nov 2023 09:26:24 +0100 (CET)
From: Michael Richardson <mcr@sandelman.ca>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
    netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 4/8] iptfs: sysctl: allow configuration of global default values
In-reply-to: <20231110113719.3055788-5-chopps@chopps.org>
References: <20231110113719.3055788-1-chopps@chopps.org> <20231110113719.3055788-5-chopps@chopps.org>
Comments: In-reply-to Christian Hopps via Devel <devel@linux-ipsec.org>
   message dated "Fri, 10 Nov 2023 06:37:15 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 12 Nov 2023 09:26:24 +0100
Message-ID: <3808085.1699777584@dyas>

--=-=-=
Content-Type: text/plain


>>>>> Christian Hopps <chopps@labn.net> writes:
Christian Hopps via Devel <devel@linux-ipsec.org> wrote:
    > Add sysctls for the changing the IPTFS default SA values.

Add sysctls for the changing the IPTFS default SA values.

+xfrm_iptfs_idelay - UNSIGNED INTEGER
+        The default IPTFS initial output delay. The initial output delay is the
+        amount of time prior to servicing the output queue after queueing the
+        first packet on said queue.

I'm guessing this is in miliseconds, but the documentation here does not say.

+xfrm_iptfs_rewin - UNSIGNED INTEGER
+        The default IPTFS reorder window size. The reorder window size dictates
+        the maximum number of IPTFS tunnel packets in a sequence that may arrive
+        out of order.
+
+        Default 3.

Why three?
Is there some experimental reason to pick three?
It seems that maybe the reorder window size could have been a per-SA attribute.

I read through the rest of the patches, and they seem great, but I didn't
read with a lot of comprehension.  I found the explanatory comments and
diagrams very well done!


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmVQjDAACgkQcAKuwszY
gEOWDQwAydOsFa+0dHUW/J3YLuOzrbtH1ROR1N4ve9QSnf+wwxCdZINkP9uHewgQ
uP5EQQN0QhMDlJpcBEnV0mSmV7sw5mZpTdv6fhNHWLpf0n7/kxVXEq9zZL6gsB/e
OMYYXyQhVfJgatGdhkLfz5pOcdZ6Kwqgg0gggaBCpEKDvDST05DMFJsrRRMOH2E9
8trM9qkBtgk+GYna3DUO77ryOiRqSYVhTJi5A0vKV8U/03wBNH4DsfeJY7pmYwOs
CDjCjn1G7xUGey11VVBqtuH2dl6ZjMqmehoVq0B1E14uT5P1L19pVAJYm4p6rMo4
25AA98x/hhwBu8cOOvT02Yzq0lJ4bzRkXoZ4CyBqhgEobS7FNwo8RdwWbID8KldL
6zJE3F5pX9hp4zSA3bn2KaI353CXNnfwRS0dCEIy5jYKCtrEeRBG2bR0sw1/SGWL
gYR38p2zp5h83+bR1SpADCwis4k585iKCsrpW+f0dPi2I8++a6pQll7wlZigjmF7
i90epEao
=JVNM
-----END PGP SIGNATURE-----
--=-=-=--

