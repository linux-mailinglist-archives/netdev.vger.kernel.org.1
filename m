Return-Path: <netdev+bounces-233467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5832C13DE8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4655934CC74
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9402DEA68;
	Tue, 28 Oct 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YAEFTtg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BA2D8DC4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644434; cv=none; b=KVeKwpm1PGr/YO2zx4OnqUIN2dElYqtR5N8A9DCy70FLSND/mC0cWWmdJ4JxtloSrq27+kPHCtqDM6uDJ7sKftt/GfaPrcO2E5NcaiBdN2LQH9GUjhpjgpczx0FtHouD+k9t0ZZzkQI1L9hE2mY1qM88R+8sJBQzMBNzE/i/HKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644434; c=relaxed/simple;
	bh=V8j65SOO1XNIOxHlyX5EvJnpYhjr76yB+DF2LkTgbt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaMNzr29jX8/EHI6SENaatLhCm0TQIVabR7pMKxWKN/sQeHjhQsIst6RhOB8LgiGyMbppzqZLJZwH/ShLuS1GQuRNk8wulVpvESqjSgF22lTccw2uPjIbuFJN+hSE1X0tZ+VBg9ODV7nnTQIwrFkdD6b39JBNzRS5b6T8fLCWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YAEFTtg5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CA5704E41392;
	Tue, 28 Oct 2025 09:40:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F877606AB;
	Tue, 28 Oct 2025 09:40:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D321E102F745D;
	Tue, 28 Oct 2025 10:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761644428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7tog9ATOqjdT69ppkB7eZMWw/raJkyaZ+PiXi+5XdFg=;
	b=YAEFTtg50sX/SwV19Cr2g4RzkCiwolVwPaFrMuaLa4RcZlNf0XSuIbdESV4QoxKuqLP4pb
	7jjqUdYyQnZ6+j9NlyoAfMVySwWP1pBK7fqrPVSGxlYYk87Yhtr+CYPY+zDaOeLuXqy4ge
	rZxOiQmvCin6K0E3ahmd9rHAfe/uwSe+a8+zLDs+VXaksTbL3kx0m6E1wMN5kFJI2WrZqM
	Y916JsyV8uXz3m9jaUvfLe8Y378YXeNOJs5IXcruqiunZnYLOU5pnOzavbwi9EDXt6lJP/
	MXJMCQWLw/Xo/5hMS1B0h4tIz6LMnJbV5Hd1290SsPymH3SwEVQC9Y9NPghy1Q==
Date: Tue, 28 Oct 2025 10:40:14 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251028104014.42dadb1e@kmaincent-XPS-13-7390>
In-Reply-To: <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 26 Oct 2025 17:57:12 +0100
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Sat, Oct 04, 2025 at 08:27:15PM GMT, Vadim Fedorenko wrote:
> > The kernel supports configuring HW time stamping modes via netlink
> > messages, but previous implementation added support for HW time stamping
> > source configuration. Add support to configure TX/RX time stamping.
> >=20
> > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev> =20
>=20
> As far as I can see, you only allow one bit to be set in each of=20
> ETHTOOL_A_TSCONFIG_TX_TYPES and ETHTOOL_A_TSCONFIG_RX_FILTERS. If only
> one bit is supposed to be set, why are they passed as bitmaps?
> (The netlink interface only mirrors what (read-only) ioctl interface
> did.)

Because I used the same design as tsinfo but indeed maybe that is not the b=
est
choice and we shouldn't use bitmap. However, if we change this as it is uAP=
I we
will need to write a Linux fix to totally remove the bitmap support before =
we
see any tools using it.

Regards,

> Michal
>=20
> > ---
> >  ethtool.8.in       | 12 ++++++-
> >  ethtool.c          |  1 +
> >  netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 89 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/ethtool.8.in b/ethtool.8.in
> > index 553592b..e9eb2d7 100644
> > --- a/ethtool.8.in
> > +++ b/ethtool.8.in
> > @@ -357,6 +357,10 @@ ethtool \- query or control network driver and
> > hardware settings .IR N
> >  .BI qualifier
> >  .IR precise|approx ]
> > +.RB [ tx
> > +.IR TX-TYPE ]
> > +.RB [ rx-filter
> > +.IR RX-FILTER ]
> >  .HP
> >  .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
> >  .I devname
> > @@ -1286,7 +1290,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA
> > point. Show the selected time stamping PTP hardware clock configuration.
> >  .TP
> >  .B \-\-set\-hwtimestamp\-cfg
> > -Select the device's time stamping PTP hardware clock.
> > +Sets the device's time stamping PTP hardware clock configuration.
> >  .RS 4
> >  .TP
> >  .BI index \ N
> > @@ -1295,6 +1299,12 @@ Index of the ptp hardware clock
> >  .BI qualifier \ precise | approx
> >  Qualifier of the ptp hardware clock. Mainly "precise" the default one =
is
> >  for IEEE 1588 quality and "approx" is for NICs DMA point.
> > +.TP
> > +.BI tx \ TX-TYPE
> > +Type of TX time stamping to configure
> > +.TP
> > +.BI rx-filter \ RX-FILTER
> > +Type of RX time stamping filter to configure
> >  .RE
> >  .TP
> >  .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
> > diff --git a/ethtool.c b/ethtool.c
> > index 948d551..2e03b74 100644
> > --- a/ethtool.c
> > +++ b/ethtool.c
> > @@ -6063,6 +6063,7 @@ static const struct option args[] =3D {
> >  		.nlfunc	=3D nl_stsconfig,
> >  		.help	=3D "Select hardware time stamping",
> >  		.xhelp	=3D "		[ index N qualifier
> > precise|approx ]\n"
> > +			  "		[ tx TX-TYPE ] [ rx-filter
> > RX-FILTER ]\n" },
> >  	{
> >  		.opts	=3D "-x|--show-rxfh-indir|--show-rxfh",
> > diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
> > index d427c7b..7dee4d1 100644
> > --- a/netlink/tsconfig.c
> > +++ b/netlink/tsconfig.c
> > @@ -17,6 +17,7 @@
> >  #include "netlink.h"
> >  #include "bitset.h"
> >  #include "parser.h"
> > +#include "strset.h"
> >  #include "ts.h"
> > =20
> >  /* TSCONFIG_GET */
> > @@ -94,6 +95,67 @@ int nl_gtsconfig(struct cmd_context *ctx)
> > =20
> >  /* TSCONFIG_SET */
> > =20
> > +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
> > +			 const void *data __maybe_unused,
> > +			 struct nl_msg_buff *msgbuff,
> > +			 void *dest __maybe_unused)
> > +{
> > +	const struct stringset *values;
> > +	const char *arg =3D *nlctx->argp;
> > +	unsigned int count, i;
> > +
> > +	nlctx->argp++;
> > +	nlctx->argc--;
> > +	if (netlink_init_ethnl2_socket(nlctx) < 0)
> > +		return -EIO;
> > +
> > +	switch (type) {
> > +	case ETHTOOL_A_TSCONFIG_TX_TYPES:
> > +		values =3D global_stringset(ETH_SS_TS_TX_TYPES,
> > nlctx->ethnl2_socket);
> > +		break;
> > +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
> > +		values =3D global_stringset(ETH_SS_TS_RX_FILTERS,
> > nlctx->ethnl2_socket);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	count =3D get_count(values);
> > +	for (i =3D 0; i < count; i++) {
> > +		const char *name =3D get_string(values, i);
> > +
> > +		if (!strcmp(name, arg))
> > +			break;
> > +	}
> > +
> > +	if (i !=3D count) {
> > +		struct nlattr *bits_attr, *bit_attr;
> > +
> > +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK,
> > true))
> > +			return -EMSGSIZE;
> > +
> > +		bits_attr =3D ethnla_nest_start(msgbuff,
> > ETHTOOL_A_BITSET_BITS);
> > +		if (!bits_attr)
> > +			return -EMSGSIZE;
> > +
> > +		bit_attr =3D ethnla_nest_start(msgbuff,
> > ETHTOOL_A_BITSET_BITS_BIT);
> > +		if (!bit_attr) {
> > +			ethnla_nest_cancel(msgbuff, bits_attr);
> > +			return -EMSGSIZE;
> > +		}
> > +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i)
> > ||
> > +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE,
> > true)) {
> > +			ethnla_nest_cancel(msgbuff, bits_attr);
> > +			ethnla_nest_cancel(msgbuff, bit_attr);
> > +			return -EMSGSIZE;
> > +		}
> > +		mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
> > +		mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> >  static const struct param_parser stsconfig_params[] =3D {
> >  	{
> >  		.arg		=3D "index",
> > @@ -109,6 +171,20 @@ static const struct param_parser stsconfig_params[=
] =3D {
> >  		.handler	=3D tsinfo_qualifier_parser,
> >  		.min_argc	=3D 1,
> >  	},
> > +	{
> > +		.arg		=3D "tx",
> > +		.type		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> > +		.handler	=3D tsconfig_txrx_parser,
> > +		.group		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> > +		.min_argc	=3D 1,
> > +	},
> > +	{
> > +		.arg		=3D "rx-filter",
> > +		.type		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> > +		.handler	=3D tsconfig_txrx_parser,
> > +		.group		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> > +		.min_argc	=3D 1,
> > +	},
> >  	{}
> >  };
> > =20
> > @@ -134,7 +210,7 @@ int nl_stsconfig(struct cmd_context *ctx)
> >  	if (ret < 0)
> >  		return ret;
> >  	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
> > -			       ctx->devname, 0))
> > +			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
> >  		return -EMSGSIZE;
> > =20
> >  	ret =3D nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST,
> > NULL); --=20
> > 2.47.3
> >  =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

