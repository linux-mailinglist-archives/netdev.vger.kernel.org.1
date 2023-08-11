Return-Path: <netdev+bounces-26649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB517787E2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45912281F90
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817C1C10;
	Fri, 11 Aug 2023 07:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DD1C03
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:13:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8D272D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:13:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 059741F88E;
	Fri, 11 Aug 2023 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1691738009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebA4pzUMN9yu/TlN3AQ7NuNjIzxGpgEPpLexWl7isgg=;
	b=yVQPByAiypSXlCoSdSkeO2kzL8rPcm/uaNB2Z16rF8fvr8HwEUXEXv3zdMHeYpyVECie15
	/BGJtH6obtMksszWe8IpVvmlQ+kPu6Lg1arBzVFByseoJDX630cUldq1LcrQduhQpm/Abd
	LUlfAQKpql2hyRVY7mjB9d6sh2ildNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1691738009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebA4pzUMN9yu/TlN3AQ7NuNjIzxGpgEPpLexWl7isgg=;
	b=xiBUgMlBRJyetu3ulx8W3YE/Mw9ay59yDwqwwffjY445Bkztb3/huSsHtHJ83D57R8VwKt
	O+YfpoLCt83oQ5Ag==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn1.nue.suse.de [10.163.31.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 289D42C142;
	Fri, 11 Aug 2023 07:13:28 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id D93132016F; Fri, 11 Aug 2023 09:13:24 +0200 (CEST)
Date: Fri, 11 Aug 2023 09:13:24 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	johannes@sipsolutions.net,
	Vladimir Oltean <vladimir.oltean@nxp.com>, gal@nvidia.com,
	tariqt@nvidia.com, lucien.xin@gmail.com, f.fainelli@gmail.com,
	andrew@lunn.ch, simon.horman@corigine.com, linux@rempel-privat.de
Subject: Re: [PATCH net-next v2 10/10] ethtool: netlink: always pass
 genl_info to .prepare_data
Message-ID: <20230811071324.gfkzlpb3gbwvuufm@lion.mk-sys.cz>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-11-kuba@kernel.org>
 <ZNXYZRNJkAqw686J@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ouoouoydx66bvl2"
Content-Disposition: inline
In-Reply-To: <ZNXYZRNJkAqw686J@nanopsycho>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--7ouoouoydx66bvl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 08:42:45AM +0200, Jiri Pirko wrote:
> Fri, Aug 11, 2023 at 01:38:45AM CEST, kuba@kernel.org wrote:
> >@@ -24,7 +24,7 @@ const struct nla_policy ethnl_wol_get_policy[] =3D {
> >=20
> > static int wol_prepare_data(const struct ethnl_req_info *req_base,
> > 			    struct ethnl_reply_data *reply_base,
> >-			    struct genl_info *info)
> >+			    const struct genl_info *info)
> > {
> > 	struct wol_reply_data *data =3D WOL_REPDATA(reply_base);
> > 	struct net_device *dev =3D reply_base->dev;
> >@@ -39,7 +39,8 @@ static int wol_prepare_data(const struct ethnl_req_inf=
o *req_base,
> > 	dev->ethtool_ops->get_wol(dev, &data->wol);
> > 	ethnl_ops_complete(dev);
> > 	/* do not include password in notifications */
> >-	data->show_sopass =3D info && (data->wol.supported & WAKE_MAGICSECURE);
> >+	data->show_sopass =3D genl_info_is_ntf(info) &&
> >+		(data->wol.supported & WAKE_MAGICSECURE);
>=20
> I believe that you are missing "!" here:
> 	data->show_sopass =3D !genl_info_is_ntf(info) &&
> 		(data->wol.supported & WAKE_MAGICSECURE);

Agreed.

> But, you are changing the output for dumpit if I'm not mistaken.
> ethnl_default_dump_one() currently calls this with info=3D=3DNULL too, not
> only ethnl_default_notify().

I would rather see this as a fix. Not showing the password in dumps made
little sense as it meant the dump output was different from single
device queries. It was the price to pay for inability to distinguish
between a dump and a notification.

IIRC the early versions submitted went even further and did not set
GENL_UNS_ADMIN_PERM for ETHTOOL_MSG_WOL_GET and only omitted the
password when the request came from an unprivileged process (so that
unprivileged processes could still query the rest of WoL information)
but this was dropped during the review as an unnecessary complication.

> Anyway, the genl_info_is_ntf() itself seems a bit odd to me. The only
> user is here and I doubt there ever going to be any other. This
> conditional per-op attr fill seems a bit odd.
>=20
> Can't you handle this in side ethtool somehow? IDK :/

I don't think so. The point here is that notification can be seen by any
unprivileged process so as long as we agree that those should not see
the wake up passwords, we must not include the password in them. While
ethtool could certanly drop the password from its output, any other
utility parsing the notifications (or even patched ethtool) could still
show it to anyone.

Michal

--7ouoouoydx66bvl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmTV35AACgkQ538sG/LR
dpWZrAf9F+6zccw3pVO1OFj8PPR+sF/xijmeZMZy+ojTGydVdMHkbC2iNm4uu7Rs
VdjSQiRdtOnc1mUKIKE7U+a9L/+lk7bnQMoKnfO/hW+hi1KyZ9PXDz7IUgZo5z4o
AKT9QnxF9gt1WzRELu8GgqNAJ+XQUPB+NhZLTJ8tkyo+U2zBP0oojOVhuHgQ0SyN
G6toVzoQJzfLA6heM5/lqCLsncvM+2uIp1iVbFC6m+eOKo7g4pj4HfbCfAPf7F5q
ycCC6Hwj6XXn6RBY/l3loXfziDNfO5lLd6o81sa+JHzwaH9pmqTuXYVn6t7o6ARN
pLwoOfhxdWfaXmjcJU/G9NXDIrqpMg==
=0DlM
-----END PGP SIGNATURE-----

--7ouoouoydx66bvl2--

