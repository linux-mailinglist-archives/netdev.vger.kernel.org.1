Return-Path: <netdev+bounces-296956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rhTLAl/KJ2oV2QIAu9opvQ
	(envelope-from <netdev+bounces-296956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1365D96B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rjLa+0BQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F7F3305E44B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD643E7BB3;
	Tue,  9 Jun 2026 08:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A33E1208
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:03:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992205; cv=pass; b=Ko+UWnklG98CAbgUZC4wIrzuUjePLkfE9fgvFyo/csfMgxG2DzSL1Dft7p+7FkfY80xeFyda/cQmgOw/g53+ucQ+wCiDeiAvHs4xgely30CFuonYduhGiXJbiuCgkz/NR6TmkR2AE9LEl14Q77zm4Oxg6k/UadWBWHbD8fcKt4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992205; c=relaxed/simple;
	bh=uNQjE/8wBhknRDHIPA6k8po9uL135S6SxcAFqgvKz/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwZdRCKoJS5Qs5o40OuiDb/vx4G/sXY2y15XJe6tzeApEF63reoxod3EBbynt4ieCwDDasSoVOTX4v1voJkWzgVefdv9L4Aqfl6iQ/qx5RgsB5D61eJfc0GYarkbZ6NpSL6NQ+k3GUNFXz3HMLq4SIpEyAqxd2eiw6fY90UguA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjLa+0BQ; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa6cdebc33so4724987e87.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992202; cv=none;
        d=google.com; s=arc-20240605;
        b=TfbG7iis+IzLO+1qKkt0cpz0AlVUOnsAqj87CW7f17dhksajDmGhD2VwgtKpm6IQFS
         J8z/YmieJIawfG7wYLQgvo31u8hRBcmqM7+q4iUSiqvw/nzNxW8Petfy7C5ECwRJkalV
         JGrCLSOHyQZIB8AUMc1y9DvPRVFiC6symaTOeIrY72VHmMQhuodfXZIcMrIY/UEM2KzD
         IHmUQ540YhyktZ++MM2K0VJOy9+7n7qk+8Zet9BAtcbXN6b5Z18qTluQF1uTyf6wQkmv
         Kq2LBZLG60MoVIJW5J4z+JT+FbKobJ3WXiV373U+SeUcIni+6G+74G5ftx6CsB4nC+EV
         pFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/9Powe8xxemO5EeeDATV22PoAf3JTJH+LM6JsuiRgI=;
        fh=UUYap41MtF5LN64jB/WXidITVfbivjACv/JVPk3dDww=;
        b=SieDe31vJ5pdRQ1j/+a99HMh3NRIf7tc5quQ36nO2RgMGexqQc/x4jCq8fhgIEkQXs
         6Kpldm0MyJ9AQ16grpsw5r5svx+nRK/sUXuEMs/FvV5zWxLVCi2A9FdmhskPJ4giH/yL
         vL6lOR8XENeC40BQOlTskyRaIUawfPAWNLgebBbAYd+na74TIMhFCPeKjbQRg+Pk/teU
         1Zf0Vr8nwV9BkxiiJb1ityH1aVIhib6TmBQwxIAsgBHS17eMwS/J2ICyORDrDbpF6eRz
         EvYp1/eOF8TGTREZ9W4N2CUGhx2p49ujM7K4D3pKfdmeoaJNZdT35WdnGROc2uPvour1
         jHmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780992202; x=1781597002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/9Powe8xxemO5EeeDATV22PoAf3JTJH+LM6JsuiRgI=;
        b=rjLa+0BQvi0HEeIucDB49iqpu9W7upHplrFgMWjZVkU6nTS1iV2zZOVDM1IeYHLtH2
         5atmxlN/+n32/2+cn/6fRbYauc5IG5PJXsLFcYUj4YOCNIANdnGF+aMi061mGE/o3MdW
         vZPZGufWtj1Rcs2HCk5VoIKgCF0SZA0IO9xIsGCRFC9/5RR41WCLuiOlURK/7oNWNARi
         3OZrlp3xwkj+CF/SQoxg8t+kkv169GtIe+wGxacANrw9b2BxCHLXhZ+N/nirhm54LJXO
         MSXmvT5l7874gjR1szggWdJPS7r72K598GPmNrP0zLsQdeL0ZCu1SCbDvcqoAK4dD/B5
         liJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992202; x=1781597002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/9Powe8xxemO5EeeDATV22PoAf3JTJH+LM6JsuiRgI=;
        b=kXtlO/c+KhzvQy9lci/HBMEA3+c6oBSbFXgvw2qSdbWQQaAi31OG20aUTZpn9e10nm
         C3BNBNx/aYOO9qdr/Sykeb1VqOg39diV4tT5kPCcUU9BD6+GnsEgLJQDIS7cMRwAhvPQ
         B9sPFbhYMZTGf6hwcEniNeAQa+cAmQ/m2q8ek7uT1x4j0ihVbJ66c4KVyOHyyLBn/Vjq
         Y3p/2JCezmVNvmCxRrJk4fFk07yqDa8WCUcsJrlqa2dNyK3NvSHEhmpT5xUcVO7KXbMJ
         LUKvk2T/ct6pDdOvHVRqXN8NhVNAWVEn+wVeRnGUneyTSBGw1HYu7yCNh8Uq7X4yTyke
         WZUA==
X-Forwarded-Encrypted: i=1; AFNElJ83QUC6ImDYMBT4RnugWFXzXD0rmwlrPeul0VG9z8/MYxrWg1G+NXIQmLQg5u0iRfiH/kALIWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ofZ4vggGwvPRch1rgo3/+UdqMt/8JnbB+2Z8Kfhk5iqJOpzN
	kpW92P6WdzOsAvPiwz16PKQsVC3cHxfmxS4CD9E3j1NdSaOlppo2ByxhjKTUhCyr9mjx1Hej/WW
	Xu69L06HdOnWYGhp/fIz9Npul1InKunw=
X-Gm-Gg: Acq92OF+7sxPD9htRDzqx8cU12vMu1/qTxHD6AsPXimdRV29g48i76sJo7rC5xMjLmq
	LC7cCZjKeyMZyD2grH/plNh2sKWRVih3CGGeicYMeBkJmuTT4aATSt6ebmCIZy6Z12OT0hSCqWT
	HwIe3hEgLmGfd45UGbpsXVELGuz3nY+cIwuN8Iw6b1KC0BdNiC13gYM8M7hdcwb5f+0gNt+FgSY
	wGeUKjwPOXCYacL1gRo+GK0FfiXl14gea4ETXhFUFZyVBouA03vufNSEcXn78w16eBi/kHta+/C
	yNqk9aIb3Vwq5fUlQulEGHPzLpqSqc+VtCW0a16RyYH+N6WssmJXQMfcqeeo
X-Received: by 2002:a05:6512:234f:b0:5ad:abf:1e1c with SMTP id
 2adb3069b0e04-5ad0abf227dmr57745e87.3.1780992201741; Tue, 09 Jun 2026
 01:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605145759.59639-1-sigefriedhyy@gmail.com>
 <20260605145759.59639-3-sigefriedhyy@gmail.com> <20260609074447.GA663407@shredder>
In-Reply-To: <20260609074447.GA663407@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 9 Jun 2026 17:03:12 +0900
X-Gm-Features: AVVi8Cf-6Fl_ke5gQs6eGqn2zfLDqeg0_v6Phe-76p6Mk_KnWZUnKhrCzp5qr8Q
Message-ID: <CA+7S2vJcPCZkyPscizJpk09e+LNco7hg+9=3=vX-G6jszwva5w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] ipv6: mcast: annotate igmp6 timer expiry race
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CA1365D96B

On Tue, Jun 9, 2026 at 4:45=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Fri, Jun 05, 2026 at 11:57:59PM +0900, Yuyang Huang wrote:
> > /proc/net/igmp6 walks IPv6 multicast memberships under RCU and reads
> > mca_work.timer.expires to print the remaining multicast timer. The
> > delayed-work timer can be updated concurrently.
> >
> > Annotate the intentional lockless procfs snapshot with READ_ONCE().
> >
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> > ---
> >  net/ipv6/mcast.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index bd3972730aa0..184e57469086 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -2983,6 +2983,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq=
, void *v)
> >  {
> >       struct ifmcaddr6 *im =3D (struct ifmcaddr6 *)v;
> >       struct igmp6_mc_iter_state *state =3D igmp6_mc_seq_private(seq);
> > +     unsigned long expires =3D READ_ONCE(im->mca_work.timer.expires);
> >       unsigned int mca_flags =3D READ_ONCE(im->mca_flags);
>
> The comment from Sashiko about inverting the order looks valid. In the wr=
ite
> path, the MAF_TIMER_RUNNING flag is always set after modifying the timer:

Thanks for the comment, I will fix this in patch v2.

