Return-Path: <netdev+bounces-301478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yyR0EpLtOmpKLwgAu9opvQ
	(envelope-from <netdev+bounces-301478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:33:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28F6BA080
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:33:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="N/gAeghP";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301478-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB963008693
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF33A48D9;
	Tue, 23 Jun 2026 20:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B63A544D
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246779; cv=none; b=AYZ07tQWhT3TjdB9SS1zCgIID6P/3owyIIj6sGE1PVNUIcqzLMYyMyI3aojOskr1NnvNuaVrHtZ31AnJTAn5rQPujk5eEOWK/w9vvWcJ4IaGvjC7I3vaPXL1A4IV+NssL4hSlFXidYjVsXVMaVmpl6UWziwPI0tAKOLA2Gv4n6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246779; c=relaxed/simple;
	bh=5NFJnPlLc/vQFOiPNY0oyrs56OMvEhyinspiCApmcqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg5vPfD3cy67V0nDIWlSGc9AtX4k6JdaD+yv4X4d+xY0zUS7OFzz8wllwdDM4KQaPDGF2ZOJ+ivyHeUQolI52ugn7MFG98PzM1jmsygY1cywZ6cqgEflQb3CXMIpCgdSAxvHRuvfiqCo9iI97yk29MZuUv8BLEvOgZBK8ifPvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/gAeghP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC01F000E9;
	Tue, 23 Jun 2026 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246777;
	bh=ouMHGOvMc2V/MonYeZTIKoTCZTr7oOqL3Hc354KdZOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N/gAeghPXWBeOOzXW3MobOa/tkuES83zcd5MWcmhYfJrT45375eKspP20DNt/fq+8
	 9r79BBM2GV4GzdQofzhjudn6HhXfuQvX5WjygacOE1QINuHJT2cYaF9pZJRIsonKDz
	 TUpJU7hgm173+LuAaAtv6KYXU3z7P+CKf9XcQVsMtBN+PQpMNv3IBeBJ29gw3lJNyg
	 2+flqG/6SkILKa5URY89XXiVg3A+8Fq7StR+5quae5c6Col4I1Dbu7DwDtgRaIck5W
	 TT1aZ7Rz9tno+F1irbgeS+e5TXTiaTyP49sj5KFBL0E9qmjnVMhZbZSCPTLhXhqElp
	 sPPjTrLCOrpGA==
Date: Tue, 23 Jun 2026 22:32:55 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leto.liu@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	brown.huang@airoha.com
Subject: Re: [PATCH net v2] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Message-ID: <ajrtd5WA2GFzQyV9@lore-desk>
References: <20260622-airoha_qdma_set_trtcm_param-retry-fix-v2-1-95a83ac99dbd@kernel.org>
 <20260623105341.1076863-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UkOWUaq6LIU/PkBM"
Content-Disposition: inline
In-Reply-To: <20260623105341.1076863-3-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301478-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leto.liu@airoha.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:brown.huang@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A28F6BA080


--UkOWUaq6LIU/PkBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 23, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
>=20
> Simon says: I'd appreciate it if you could look over the first two issues
>             flagged below in the context of this patch. While the third
> 	    and final issue looks like it is in possible separate follow-up
> 	    territory.
>=20
> ---
> net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
>    =20
> This patch introduces a retry loop to airoha_qdma_set_trtcm_param() to mi=
tigate
> bus timeouts when configuring QDMA parameters. It attempts to verify that=
 the
> configuration is correctly applied to the hardware.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 3370c3df7c107..bb5c0599a4eed 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2673,14 +2673,30 @@ static int airoha_qdma_set_trtcm_param(struct a=
iroha_qdma *qdma, int channel,
> >  		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
> >  		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
> >  		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
> > +	int i;
> > =20
> > -	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> > -	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> > +	for (i =3D 0; i < 100; i++) {
> > +		u32 data;
> > =20
> > -	return read_poll_timeout(airoha_qdma_rr, val,
> > -				 val & TRTCM_PARAM_RW_DONE_MASK,
> > -				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
> > -				 qdma, REG_TRTCM_CFG_PARAM(addr));
> > +		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> > +		wmb();
> > +		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> > +
> > +		if (read_poll_timeout(airoha_qdma_rr, data,
> > +				      data & TRTCM_PARAM_RW_DONE_MASK,
> > +				      USEC_PER_MSEC, 10 * USEC_PER_MSEC,
> > +				      true, qdma, REG_TRTCM_CFG_PARAM(addr)))
> > +			return -ETIMEDOUT;
>=20
> [Severity: High]
> If a bus timeout causes the write phase's read_poll_timeout() in
> airoha_qdma_set_trtcm_param() to fail, this immediately returns -ETIMEDOU=
T,
> aborting the 100-iteration retry loop.
>=20
> Doesn't this defeat the mitigation?

I agree we just run 'continue' here instead of returing -ETIMEDOUT

>=20
> > +
> > +		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
> > +						mode, &data, NULL))
> > +			continue;
>=20
> [Severity: High]
> If airoha_qdma_get_trtcm_param() times out during the verification phase,=
 it
> indicates the hardware hasn't finished the read command (DONE bit is stil=
l 0).
>=20
> The continue statement then immediately starts the next iteration, writin=
g new
> commands to DATA_LOW and CFG_PARAM.
>=20
> Can writing to command registers while the hardware state machine is acti=
vely
> busy violate hardware protocols and lead to unrecoverable lockups?

@Brown and @Leto: can you please comment on this case?

>=20
> > +
> > +		if (data =3D=3D val)
> > +			return 0;
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but if the bus drops the comma=
nd
> write to REG_TRTCM_CFG_PARAM, the hardware never executes the command and=
 the
> TRTCM_PARAM_RW_DONE_MASK bit remains set from the previous operation.
>=20
> Consequently, read_poll_timeout() returns an immediate false success.
>=20
> If both the set and get command writes are dropped by the bus, the get
> operation will read back the newly written DATA_LOW register value.
>=20
> Will the data =3D=3D val check evaluate to true and falsely report succes=
s without
> the hardware ever processing the configuration?

This seems quite a 'pathological' scenario, is it really an issue?

Regards,
Lorenzo

>=20
> > +	}
> > +
> > +	return -EBUSY;
> >  }
> > =20
>=20
> [ ... ]
>=20
> >  static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int =
channel,
> >  					u32 addr, enum trtcm_mode_type mode,
> >  					bool enable, u32 enable_mask)
> >  {
> >  	u32 val;
> > =20
> >  	if (airoha_qdma_get_trtcm_param(qdma, channel, addr, TRTCM_MISC_MODE,
> >  					mode, &val, NULL))
> >  		return -EINVAL;
>=20
> [Severity: High]
> Standalone calls to airoha_qdma_get_trtcm_param(), like this one in
> airoha_qdma_set_trtcm_config(), lack a retry loop entirely.
>=20
> Does this leave read-modify-write cycles fully vulnerable to the same bus
> timeouts the patch attempts to mitigate?
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but the patch mitigates bus
> timeouts in airoha_qdma_set_trtcm_param() while entirely missing
> airoha_qdma_set_rl_param().
>=20
> The latter performs the exact same write-and-poll sequence on identical Q=
DMA
> configuration registers:
>=20
> drivers/net/ethernet/airoha/airoha_eth.c:airoha_qdma_set_rl_param() {
>     ...
>     return read_poll_timeout(..., val & RATE_LIMIT_PARAM_RW_DONE_MASK, ..=
=2E);
> }
>=20
> If bus timeouts affect QDMA access broadly as stated in the commit messag=
e, are
> the rate-limiting configuration paths randomly vulnerable to the same fai=
lures?
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but in airoha_tc_remove_htb_qu=
eue(),
> hardware teardown incorrectly uses queue + 1 instead of queue:
>=20
> drivers/net/ethernet/airoha/airoha_eth.c:airoha_tc_remove_htb_queue() {
>     ...
>     airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
>     ...
> }
>=20
> Does this leave the removed queue's hardware limits permanently active
> (resource leak) and inadvertently disable the rate limits for queue + 1,
> corrupting the QoS state of another active channel?

--UkOWUaq6LIU/PkBM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajrtdwAKCRA6cBh0uS2t
rOA7AQCVwcnGTvgsBMt3sEm3xy+Xm0d3pO8aN3W5C9mTe6BnwAD/YJ+REZqwrvs3
BpaC9wSWuXEuVLVX0mq5PSr7zq6ucQQ=
=Z/ww
-----END PGP SIGNATURE-----

--UkOWUaq6LIU/PkBM--

