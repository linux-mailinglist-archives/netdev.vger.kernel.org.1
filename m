Return-Path: <netdev+bounces-262117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGcQAIbYoml06AQAu9opvQ
	(envelope-from <netdev+bounces-262117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:59:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D81C2B13
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2290E303B2F3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671043CECD;
	Sat, 28 Feb 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz3ojnSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFE1E98E3;
	Sat, 28 Feb 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772279936; cv=none; b=ZQB/9OWDgLe/nh0hHx6tEcxMhnJHpJyUMxISxlziDo1pxuITGQrfX2nWR2N0xBYXufKdlUthHtzWNTzKasnJ0vlxbVY93NZOodY6giwQmFFWloHF82gRb6PQ+L3ptFL1Ns0xCp9zz6dUlukqkuFbAwkyT1ypl48ttD73FQkekhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772279936; c=relaxed/simple;
	bh=SA4eviJ/yZpyCZ7RPvowxWRJiO91Y0GTqAPs96rzHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujo2MJRPz4fCzC542bPAypthZHlNQEtBZ7zAickwP61uc3dHg/2Bx0JP2yuI2Xw7c2F3a8V7/ELcDFql6emkVVdLdtwZZrnskMNEoQ1Pb575uvuz7iqVejqkCLAvtha3ntcMwM0UFQNyVnOTWCnAcGryEvsG9ReIzhqgwXG7k7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz3ojnSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19DAC116D0;
	Sat, 28 Feb 2026 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772279936;
	bh=SA4eviJ/yZpyCZ7RPvowxWRJiO91Y0GTqAPs96rzHJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fz3ojnSEYFMcEgZJjq4mQUrWrDU3Tq7qRuMBtK0kB6Rt/zxOJel2Gu9YaosO6Ug6F
	 8C8YvGmh+ZSlAKQb2mILbGWXAUW4ufmFh+fOsdtbbo5yStug7IZ6K3Yb1EKcPEYmEw
	 FNFeGHA0YghHdjL48ZxJ7A8rk9Wk471f7TxTMEsiS7IwtvHtDN95LVNIpc5sx7258p
	 5CD8U8wHZK+CFn7wViJEB/MA7QvNxhfBAdhA4cp1zY3rl4LY5mYmOXgOHnj0V8ZxoB
	 CQ7Qkh3Lmfw81RRL6gVP4oSHtB2WR33hCgei/6GU08EPMPY9PFkvpyLNLGC1O3BAYe
	 A2r8i7UILNcxw==
Date: Sat, 28 Feb 2026 12:58:53 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aaLYfWnuuf_ne72u@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org>
 <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org>
 <aZyKWoxnywXKWth9@lore-desk>
 <20260223151845.06db43b0@kernel.org>
 <aaGaaExy63bGa7Or@lore-desk>
 <20260227153231.78d16b69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zJe+viDHT4x8TgXE"
Content-Disposition: inline
In-Reply-To: <20260227153231.78d16b69@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-262117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B13D81C2B13
X-Rspamd-Action: no action


--zJe+viDHT4x8TgXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 27 Feb 2026 14:21:44 +0100 Lorenzo Bianconi wrote:
> > > > At the moment there is no way to store the csum value we got running
> > > > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > > > xdp_buff/xdp_frame to skb conversion (this info can just be consume=
d in the
> > > > ebpf program bound to the NIC) but =20
> > >=20
> > > I think the scope here is much narrower than the xdp_buf to xdp_frame
> > > to skb conversion. We are just pass information between the program a=
nd
> > > driver which owns xdp_buff. Very similar to your new xmo.
> > >=20
> > > We could either tell the driver to discard the csum complete or even
> > > add a helper to "adjust" the the csum value. Similar to the helper
> > > we have to adjust the csum in TC / skb context. =20
> >=20
> > IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update=
 (or
> > invalidate) the checksum value (if the packet has been modified by the =
eBPF
> > program bounded to the NIC) and report the updated checksum to the driv=
er if
> > the XDP verdict is XDP_PASS. Correct?
> >=20
> > I guess we could have two approaches here:
> > - Write the new checksum value into the xdp_metadata area (if available)
> >   where the driver can load it and update the checksum value before
> >   allocating the skb.
> >   The main downside of this approach is we need modify each driver.
> > - Add a new xmo callback used to set the checksum value and report it
> >   from the eBPF program into a specific memory area provided by the dri=
ver
> >   (e.g. DMA descriptor) that is used to build the skb.
> > =20
> > What do you think?
>=20
> Exactly. The invalidation is easier 'cause using a single bit in the
> flags should be uncontroversial. If we want to be able to repair /
> provide the csum complete then we have to pick one of the two options
> you outlined. As you may suspect from previous discussions I favor=20
> the latter. But we'd probably have to have a PoC with either one and
> see where the consensus falls.

ack, I will work on a PoC.

>=20
> Actually, thinking about it more, I guess this is not just a
> CSUM_COMPLETE issue. XDP_PASS will also risk reporting invalid
> UNNECESSARY to the stack (e.g. when XDP stripped a UDP tunnel
> which which the NIC compute the UNNECESSARY but the packet inside
> the tunnel has an invalid csum).
>=20
> > Moreover, since we already have this issue upstream, do you think
> > this new feature must be part this series or can we do it with a
> > follow-up patch/series?
>=20
> We don't have to add the kfunc to adjust / invalidate the csum.
> But we should document how the drivers are expected to behave until
> such kfunc exists and we should add a selftest that checks the
> documented expectation.

I will add the required documentation and kselftest in the next iteration.

Regards,
Lorenzo


--zJe+viDHT4x8TgXE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaLYfQAKCRA6cBh0uS2t
rK8NAQCa3BtPt0r6O4Rd1WSKMud4jYbuc+yFGRH5iD2pYIy4DQEAjp1slS4Z4kQg
Efic0WsT4AYh9Xf0lUF6VupLvRIrWAE=
=4fhS
-----END PGP SIGNATURE-----

--zJe+viDHT4x8TgXE--

