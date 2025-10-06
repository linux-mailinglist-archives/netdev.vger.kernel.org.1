Return-Path: <netdev+bounces-227959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45FBBE142
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC1A74E0539
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721AE280A56;
	Mon,  6 Oct 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vGgvXSed"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148127FB1B
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754722; cv=none; b=cWYX5OKrM4rh8lkaamZjmzzv49Oxuwx9/VDwc7nBq3zWnfgN0kjr+1GmkP29NuyDG9ty3A8TjMF/y87odOF8tIyGpSKPmZXj2Hyo+30ziX6vSyHv6CQZNjjKrBwD6akCJc9WezIdqp+IQ/sBMKrlkBGQhBPAcpjhFakOguw4t5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754722; c=relaxed/simple;
	bh=sWPslBsN5hc3ULoneItTOnD97gyjMeTkJ4nI8P7dKh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InOWUGISltPY1cEpaE1qjWyfHMf3mtdhhc3AwvuzaBXz4hoPErxfncXn9ACI+dStV/qqendJ22dBs/su+kxG/PpNaRervsfneBgKJH0+g8eQ5UgPF5H1dqycVvtWFru/nIyTVgpGQkPIjIChLH4lq86WDSJJaO24+ctdMngMrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vGgvXSed; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4E91BC085C8;
	Mon,  6 Oct 2025 12:44:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8397B606B7;
	Mon,  6 Oct 2025 12:45:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63071102F1D5F;
	Mon,  6 Oct 2025 14:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759754717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QY3EhRBdg0foChJZcUR2FWrAbIHm9R/2j5cxkdXdIGs=;
	b=vGgvXSedoQpNSpn59CJt1A1n0aNFMZGLwd7ZvcAivNzwh7JcqKVJbvNIfHeJajviCgU+Ou
	twSWb0idI0eexBou5+SJ+13BHrHr/S4vBIhO9TC2Xg2CXjLQWhlkzm4xCCOVPWjXHr6isd
	JMvPX8oOO1ndo2sDXjSK1mWx31JxsQpdJBews9U4KuCMZUIGcPOls/j3duEEXfSve1gIvP
	Nm9WdVZcdXYyJPDd8CFBPPnuaQ/4e3CsmSfj+I82Yd3/UdZrP2nXP8R6oEZQbPtuK0UOa5
	ffGcRrdWPRBziQ6rOntbksjaFLV1n2EKcv82q/R9INT3tO1gPFFDITnxdN+yOg==
Date: Mon, 6 Oct 2025 14:45:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: mkubecek@suse.cz, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251006144512.003d4d13@kmaincent-XPS-13-7390>
In-Reply-To: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
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

On Sat,  4 Oct 2025 20:27:15 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The kernel supports configuring HW time stamping modes via netlink
> messages, but previous implementation added support for HW time stamping
> source configuration. Add support to configure TX/RX time stamping.

For the information, I didn't add this support because it kind of conflict =
with
ptp4l which is already configuring this. So if you set it with ethtool, run=
ning
ptp4l will change it. I am not really a PTP user so maybe I missed cases wh=
ere
we need these hwtstamp config change without using ptp4l.

> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  ethtool.8.in       | 12 ++++++-
>  ethtool.c          |  1 +
>  netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/ethtool.8.in b/ethtool.8.in
> index 553592b..e9eb2d7 100644
> --- a/ethtool.8.in
> +++ b/ethtool.8.in
> @@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardw=
are
> settings .IR N
>  .BI qualifier
>  .IR precise|approx ]
> +.RB [ tx
> +.IR TX-TYPE ]
> +.RB [ rx-filter
> +.IR RX-FILTER ]
>  .HP
>  .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
>  .I devname
> @@ -1286,7 +1290,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA
> point. Show the selected time stamping PTP hardware clock configuration.
>  .TP
>  .B \-\-set\-hwtimestamp\-cfg
> -Select the device's time stamping PTP hardware clock.
> +Sets the device's time stamping PTP hardware clock configuration.
>  .RS 4
>  .TP
>  .BI index \ N
> @@ -1295,6 +1299,12 @@ Index of the ptp hardware clock
>  .BI qualifier \ precise | approx
>  Qualifier of the ptp hardware clock. Mainly "precise" the default one is
>  for IEEE 1588 quality and "approx" is for NICs DMA point.
> +.TP
> +.BI tx \ TX-TYPE
> +Type of TX time stamping to configure
> +.TP
> +.BI rx-filter \ RX-FILTER
> +Type of RX time stamping filter to configure
>  .RE
>  .TP
>  .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
> diff --git a/ethtool.c b/ethtool.c
> index 948d551..2e03b74 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6063,6 +6063,7 @@ static const struct option args[] =3D {
>  		.nlfunc	=3D nl_stsconfig,
>  		.help	=3D "Select hardware time stamping",
>  		.xhelp	=3D "		[ index N qualifier
> precise|approx ]\n"
> +			  "		[ tx TX-TYPE ] [ rx-filter
> RX-FILTER ]\n" },
>  	{
>  		.opts	=3D "-x|--show-rxfh-indir|--show-rxfh",
> diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
> index d427c7b..7dee4d1 100644
> --- a/netlink/tsconfig.c
> +++ b/netlink/tsconfig.c
> @@ -17,6 +17,7 @@
>  #include "netlink.h"
>  #include "bitset.h"
>  #include "parser.h"
> +#include "strset.h"
>  #include "ts.h"
> =20
>  /* TSCONFIG_GET */
> @@ -94,6 +95,67 @@ int nl_gtsconfig(struct cmd_context *ctx)
> =20
>  /* TSCONFIG_SET */
> =20
> +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
> +			 const void *data __maybe_unused,
> +			 struct nl_msg_buff *msgbuff,
> +			 void *dest __maybe_unused)
> +{
> +	const struct stringset *values;
> +	const char *arg =3D *nlctx->argp;
> +	unsigned int count, i;
> +
> +	nlctx->argp++;
> +	nlctx->argc--;
> +	if (netlink_init_ethnl2_socket(nlctx) < 0)
> +		return -EIO;
> +
> +	switch (type) {
> +	case ETHTOOL_A_TSCONFIG_TX_TYPES:
> +		values =3D global_stringset(ETH_SS_TS_TX_TYPES,
> nlctx->ethnl2_socket);
> +		break;
> +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
> +		values =3D global_stringset(ETH_SS_TS_RX_FILTERS,
> nlctx->ethnl2_socket);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	count =3D get_count(values);
> +	for (i =3D 0; i < count; i++) {
> +		const char *name =3D get_string(values, i);
> +
> +		if (!strcmp(name, arg))
> +			break;
> +	}
> +
> +	if (i !=3D count) {

Maybe you could use the equal condition instead of having all inside the if:
if (i =3D=3D count)
	return -EINVAL;

> +		struct nlattr *bits_attr, *bit_attr;
> +
> +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
> +			return -EMSGSIZE;
> +
> +		bits_attr =3D ethnla_nest_start(msgbuff,
> ETHTOOL_A_BITSET_BITS);
> +		if (!bits_attr)
> +			return -EMSGSIZE;
> +
> +		bit_attr =3D ethnla_nest_start(msgbuff,
> ETHTOOL_A_BITSET_BITS_BIT);
> +		if (!bit_attr) {
> +			ethnla_nest_cancel(msgbuff, bits_attr);
> +			return -EMSGSIZE;
> +		}
> +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
> +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE,
> true)) {
> +			ethnla_nest_cancel(msgbuff, bits_attr);
> +			ethnla_nest_cancel(msgbuff, bit_attr);
> +			return -EMSGSIZE;
> +		}
> +		mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
> +		mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  static const struct param_parser stsconfig_params[] =3D {
>  	{
>  		.arg		=3D "index",
> @@ -109,6 +171,20 @@ static const struct param_parser stsconfig_params[] =
=3D {
>  		.handler	=3D tsinfo_qualifier_parser,
>  		.min_argc	=3D 1,
>  	},
> +	{
> +		.arg		=3D "tx",
> +		.type		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> +		.handler	=3D tsconfig_txrx_parser,
> +		.group		=3D ETHTOOL_A_TSCONFIG_TX_TYPES,
> +		.min_argc	=3D 1,
> +	},
> +	{
> +		.arg		=3D "rx-filter",
> +		.type		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> +		.handler	=3D tsconfig_txrx_parser,
> +		.group		=3D ETHTOOL_A_TSCONFIG_RX_FILTERS,
> +		.min_argc	=3D 1,
> +	},
>  	{}
>  };
> =20
> @@ -134,7 +210,7 @@ int nl_stsconfig(struct cmd_context *ctx)
>  	if (ret < 0)
>  		return ret;
>  	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
> -			       ctx->devname, 0))
> +			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
>  		return -EMSGSIZE;
> =20
>  	ret =3D nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST,
> NULL);



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

