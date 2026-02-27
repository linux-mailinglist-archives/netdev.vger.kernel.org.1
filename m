Return-Path: <netdev+bounces-261838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DHSEXCaoWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:21:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29B1B78DA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28DDC300D55E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC99221FCF;
	Fri, 27 Feb 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA4Idsw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD3217F27;
	Fri, 27 Feb 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198507; cv=none; b=RMthDo6i2J+U6PmtP/ZCgCdTsRh7kvbR/ssqthAh9Fv4XMEHTgsp+PoV4Gw1IHzICkweA3urv6NIxjWfo9I8+CPCTElqDZfbhgEMCDUUdmZzMYSzVtTxZ535Vf4KlfllbXqR4SGOvAJkNk733qvWh9ZIMidracIhoriZhS93XYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198507; c=relaxed/simple;
	bh=RxKqxEY0Xu8EuSp7+bKFB2HeqvW76FbZw8P16BHa8oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4WtxIBd1EBy6ZGZwANpvId9btCkUEC/wmezmFF8+1FR6/1LGWoSN5CJHtbUPyKZmgaW4tv+/vukPyO6pphtsqDAWrLOx6EvD17vvzGQeR/oMDT1sCB4DbxHLhCkyKe2WK8zxzk1my7RNVvscfEHB0/LSsWSNCYgHIezepbS5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA4Idsw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4354BC116C6;
	Fri, 27 Feb 2026 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198506;
	bh=RxKqxEY0Xu8EuSp7+bKFB2HeqvW76FbZw8P16BHa8oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eA4Idsw1g4sl/MtQ/mfXzuFUUwt6ojhVGvS8BJ7642ce6l4mCGyqq7peIYz210mjA
	 JGBIqKUalyg4EgBes27actsgQoPNUhFCqA5qXEJBt+0+saaNaB0gEaxIQoPIfuTAtd
	 8EYZPxVB8QctXCRh+pukcmgcI5ykwBdqTjSlcgvLNW/kh0o7i/1AYo3Ux2aAzLjEqo
	 wp9qhfx3uvEgvuKtsIM1Ke8TGFtxrQqcN0eVbneaon0BD+zyrdfwy7Y7t500W23oo0
	 QJvfKIhB0EdYrtIzQf7Bz6Tl9mYswQ0vMYYDbNrG2vYO/MOcucodVFjLYyBPVvjKD5
	 LCpNRGUNFDb8g==
Date: Fri, 27 Feb 2026 14:21:44 +0100
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
Message-ID: <aaGaaExy63bGa7Or@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org>
 <aZbuWBnmh_SQJyVf@lore-desk>
 <20260219091344.1d8517f3@kernel.org>
 <aZyKWoxnywXKWth9@lore-desk>
 <20260223151845.06db43b0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X5UIePTG9Ua3mURR"
Content-Disposition: inline
In-Reply-To: <20260223151845.06db43b0@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F29B1B78DA
X-Rspamd-Action: no action


--X5UIePTG9Ua3mURR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 23 Feb 2026 18:11:54 +0100 Lorenzo Bianconi wrote:
> > > Off the top of my head drivers prefer reporting UNNECESSARY when they
> > > have both, and reserve COMPLETE for cases where L4 could not be found
> > > or is incorrect. Why don't we report both? We're using 3 args, we sti=
ll
> > > have 3 to go. We could turn ip_summed into a bitmap and have explicit
> > > output args for both level and csum complete value? =20
> >=20
> > Ack, thx for the explanation. Just for sake of understanding, is there
> > any NIC capable of reporting both csum_value and csum for the same pack=
et
> > in the DMA descriptor? Or is this change needed to be future-proof?
>=20
> Both nfp and fbnic definitely can. Off the top of my head - mlx5 also
> can, but I haven't double checked.

ack, thx for pointing this out, I was not aware of it. I will modify the AP=
Is
in order to add the capability to report both cksum and csum_level for a gi=
ven
packet.

>=20
> > > One more thing I'd like us to at least have a plan for at this stage
> > > is how to deal with COMPLETE + modified packet + XDP_PASS.
> > > Right now some drivers discard COMPLETE when XDP is attached since
> > > they can't be sure if XDP modifies the packet. Other drivers don't
> > > and we end up with bad csum splat. Do we have a recommendation on
> > > the correct behavior? If not - should we have a kfunc to adjust /
> > > discard csum complete explicitly? =20
> >=20
> > At the moment there is no way to store the csum value we got running
> > bpf_xdp_metadata_rx_checksum() in order to be consumed during
> > xdp_buff/xdp_frame to skb conversion (this info can just be consumed in=
 the
> > ebpf program bound to the NIC) but
>=20
> I think the scope here is much narrower than the xdp_buf to xdp_frame
> to skb conversion. We are just pass information between the program and
> driver which owns xdp_buff. Very similar to your new xmo.
>=20
> We could either tell the driver to discard the csum complete or even
> add a helper to "adjust" the the csum value. Similar to the helper
> we have to adjust the csum in TC / skb context.

IIUC, for the CSUM_COMPLETE case, we want to add a kfunc used to update (or
invalidate) the checksum value (if the packet has been modified by the eBPF
program bounded to the NIC) and report the updated checksum to the driver if
the XDP verdict is XDP_PASS. Correct?

I guess we could have two approaches here:
- Write the new checksum value into the xdp_metadata area (if available)
  where the driver can load it and update the checksum value before
  allocating the skb.
  The main downside of this approach is we need modify each driver.
- Add a new xmo callback used to set the checksum value and report it
  from the eBPF program into a specific memory area provided by the driver
  (e.g. DMA descriptor) that is used to build the skb.
=20
What do you think?

Moreover, since we already have this issue upstream, do you think this new =
feature must
be part this series or can we do it with a follow-up patch/series?

Regards,
Lorenzo

>=20
> > I guess the issue you pointed out can be solved in the verifier
> > during program load time. What do you think?
>=20
> It could, but at the verifier level we'd probably have to be fairly
> coarse-grained. Any write to the packet data would mean csum complete
> cannot be trusted, that's not too hard. But also any tail call / fentry?
> I'm not really up to date on the latest in program chaining in BPF but
> I think a lot of real-life deployments would use either chaining or
> fentry. So in practice it may be a lot of complexity for having csum
> complete always disabled w/ XDP, in practice.
>=20
> Up to you. I'm totally okay to just say** that drivers should never
> report csum complete with XDP (until appropriate API is built).
> Perhaps this will force those who care about XDP+csum_complete to
> tell us what their requirements are?
>=20
> [**] "just say" =3D=3D document and add driver kselftest that validates it

--X5UIePTG9Ua3mURR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaGaaAAKCRA6cBh0uS2t
rKZWAQCkjxOiPEXrSTZT3qkJeVaUw7n0juwuC4GXrIPIsv9pgwD/QH7+ttDrkbKB
iSiyRZHPZpFfG0J6K+i2c23A6SEVsws=
=6+Zv
-----END PGP SIGNATURE-----

--X5UIePTG9Ua3mURR--

