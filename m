Return-Path: <netdev+bounces-260126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LNdBU+MnGmdJQQAu9opvQ
	(envelope-from <netdev+bounces-260126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:20:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BEF17AA73
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB44E31B1119
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230332A3C6;
	Mon, 23 Feb 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNqVJA9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB0329E46;
	Mon, 23 Feb 2026 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866717; cv=none; b=mMudwG/iQOszZJxtKZTBLrcXMSpsfl4lVUFyAgcDq6PfzujUyqOsP/myoxvxJ+ZK5bSy3RpVq//pUCmahXdpahhlOwg3hHr0BeJRymsnhdyTExTNAfTJU6wgGVn7pX/uKur98Ydi0iQ/MqVDT49v0pEgqtVFfyFG8l6Sy8aUGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866717; c=relaxed/simple;
	bh=yjmlAKXLz9VGGwKtdqReHY7E2dURU/svgnzBRJY8ND0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv1iP6XqVqH9U7XcDRu+eaSzuWdird6O04weK8g+5w29WeGDfwC8d78l8xhoSm6DM3H2tUdHsPfCDueZulIra8TVm8GKxeNfD0ewaxbeC8O9E0LBjEOjEJSsCpcBCJq67dOZCENzHd6loBxiuyXC4d0F9A3O5P2bUDdu2Gpn2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNqVJA9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709F9C116C6;
	Mon, 23 Feb 2026 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866716;
	bh=yjmlAKXLz9VGGwKtdqReHY7E2dURU/svgnzBRJY8ND0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNqVJA9aXljg/05FnhqGrVfPGaGndVN//YG8WZxBi8WmGQxJnQULX3r4n2ksAZk5t
	 uva9rbjs52C9aMeXl3oWjrIiOTHSQ7ZgQbVvhaimr6KGOTtB1/U2No+HrPcq9ucTlu
	 2SqeCSo4N4y9c7THlT0QKsFhw4KaT+0tr0ZyNNdsCQM6tSCRCPB96ZM17B4bMesqHw
	 lOL327QqPw2kt6UupK1wALVSug+DySLfoDfVktoUMzi7LDdqFWv2qs8ANDVXGgn8HW
	 wSB50W3Lg3zh2sPs9s2FrI6I840BMu+jFpEqnxr343X1Ot5MRVg0OOEO5amK/9WBdx
	 sVNC4cMmLy18A==
Date: Mon, 23 Feb 2026 18:11:54 +0100
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
Message-ID: <aZyKWoxnywXKWth9@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org>
 <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lh4l9TWd5fblWGcQ"
Content-Disposition: inline
In-Reply-To: <20260219091344.1d8517f3@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0BEF17AA73
X-Rspamd-Action: no action


--lh4l9TWd5fblWGcQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 19 Feb 2026 12:04:56 +0100 Lorenzo Bianconi wrote:
> > > On Tue, 17 Feb 2026 09:33:56 +0100 Lorenzo Bianconi wrote: =20
> > > > + * In case of success, ``ip_summed`` is set to the RX checksum res=
ult. Possible
> > > > + * values are:
> > > > + * ``XDP_CHECKSUM_NONE``
> > > > + * ``XDP_CHECKSUM_UNNECESSARY``
> > > > + * ``XDP_CHECKSUM_COMPLETE``
> > > > + *
> > > > + * In case of success, ``cksum_meta`` contains the hw computed che=
cksum value
> > > > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > > > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM=
_NONE`` =20
> > >=20
> > > It's fairly common for NICs to report both csum complete and
> > > unnecessary. Which one should the driver return in that case? =20
> >=20
> > Do you mean what is value for cksum_meta if we do not report csum_level=
 for
> > XDP_CHECKSUM_UNNECESSARY/CHECKSUM_UNNECESSARY use-case? (as suggested by
> > Stanislav).
>=20
> More fundamentally whether the API is right.
>=20
> > My original idea is:
> > - if the hw reports CHECKSUM_COMPLETE:
> >   - ip_summed =3D XDP_CHECKSUM_COMPLETE
> >   - cksum_meta contains the checksum computed by the hw
> > - if the hw reports CHECKSUM_UNNECESSARY
> >   - ip_summed =3D XDP_CHECKSUM_UNNECESSARY
> >   - cksum_meta =3D csum_level <-- Stanislav suggests to drop this one
> > - if the hw reports CHECKSUM_NONE
> >   - ip_summed =3D XDP_CHECKSUM_NONE
> >   - cksum_meta =3D 0
>=20
> Off the top of my head drivers prefer reporting UNNECESSARY when they
> have both, and reserve COMPLETE for cases where L4 could not be found
> or is incorrect. Why don't we report both? We're using 3 args, we still
> have 3 to go. We could turn ip_summed into a bitmap and have explicit
> output args for both level and csum complete value?

Ack, thx for the explanation. Just for sake of understanding, is there
any NIC capable of reporting both csum_value and csum for the same packet
in the DMA descriptor? Or is this change needed to be future-proof?

>=20
> One more thing I'd like us to at least have a plan for at this stage
> is how to deal with COMPLETE + modified packet + XDP_PASS.
> Right now some drivers discard COMPLETE when XDP is attached since
> they can't be sure if XDP modifies the packet. Other drivers don't
> and we end up with bad csum splat. Do we have a recommendation on
> the correct behavior? If not - should we have a kfunc to adjust /
> discard csum complete explicitly?

At the moment there is no way to store the csum value we got running
bpf_xdp_metadata_rx_checksum() in order to be consumed during
xdp_buff/xdp_frame to skb conversion (this info can just be consumed in the
ebpf program bound to the NIC) but I guess the issue you pointed out can be
solved in the verifier during program load time. What do you think?

Regards,
Lorenzo


--lh4l9TWd5fblWGcQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaZyKWgAKCRA6cBh0uS2t
rHNBAP9ouJdti/YCdFjO7itL0UdmYksYWGbYroEEhW17p936FAEAlB7ZtUPKoY/y
NW9uhOZQbwVMVAX/rQD+HOzSllyTogw=
=F4hR
-----END PGP SIGNATURE-----

--lh4l9TWd5fblWGcQ--

