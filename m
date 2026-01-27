Return-Path: <netdev+bounces-253832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNoeHFKneGnVrgEAu9opvQ
	(envelope-from <netdev+bounces-253832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:53:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1C93E72
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887D130226AD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AA34AB0B;
	Tue, 27 Jan 2026 11:53:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9215307494;
	Tue, 27 Jan 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514831; cv=none; b=JLf/xOq42E6q938sBTrq0ubkMKKOKKjNJ+W7p52KaS/7Xu78oj0/E9E6B7FOMpYF+y6Fz4mO0Rirk7qbCiN7gYxAsqRyRKTyw4gPPMzeg0fldgHT0IgT9Yfgn0cPf0rQuyst7eodiqdkytRYEg9ZHGNK9G9Tw9I7lkB3xQS0slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514831; c=relaxed/simple;
	bh=0uuzltDyeIqpzLEcuqA6to0AWPnwQPXq94CKfGDwwaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLrQIKQMEPFUTI25RlL5R7D1s7TroeACDGFWKkW5UpzmLen5hvDyNMP7es+PI/vIZVnTb8RI5Krd5yMlTuord2FNUJIqlUuNyIZhCUMJOFXZGLjXZauXhvJ6MKodP5GXIBFv8z5rylzfMBy0zY2rXhFF7Ljvai/QOAWPQeWeXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkhdV-000000008UM-0oiX;
	Tue, 27 Jan 2026 11:53:33 +0000
Date: Tue, 27 Jan 2026 11:53:28 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXinOE7KIFIm5dUK@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253832-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: C9D1C93E72
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:41:00AM +0100, Paolo Abeni wrote:
> On 1/22/26 4:42 AM, Daniel Golle wrote:
> > +static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
> > +			     bool quiet)
> > +{
> > +	int ret;
> > +
> > +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
> > +				 cmd | CTRL_BUSY_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_busy_wait(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_LEN_RET);
> > +	/* handle errors returned by the firmware as -EIO
> > +	 * The firmware is based on Zephyr OS and uses the errors as
> > +	 * defined in errno.h of Zephyr OS. See
> > +	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
> > +	 */
> > +	if ((s16)ret < 0) {
> 
> The cast is likely not needed above? if `ret` values < S16_MIN are
> possible this will return such values to the caller without the IO err
> printk.

Right, it should rather be

if (ret > S16_MAX && ret <= U16_MAX)

to really only catch the range of numbers which are negative 16-bit
signed values represented as positive 32-bit signed values.

mxl862xx_reg_read() primarily returns a signed 32-bit integer, as it is
basically just a wrapper around __mdiodev_c45_read(). Negative values of
that 32-bit integer mean that the MDIO Clause-45 read has somehow
failed, ie. it's the error the MDIO bus .read_c45() operation has
returned.

In case __mdiodev_c45_read() succeeds it returns the 16-bit value of the
register read. In this case, those 16-bit should be interpreted as a
16-bit signed integer here. A negative value denotes an error returned
from the firmware running on the switch (see comment above the code).

> 
> > +		if (!quiet)
> > +			dev_err(&priv->mdiodev->dev,
> > +				"CMD %04x returned error %d\n", cmd, (s16)ret);
> > +		return -EIO;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
> > +		      u16 size, bool read, bool quiet)
> > +{
> > +	__le16 *data = _data;
> > +	u16 max, i;
> > +	int ret, cmd_ret;
> 
> Minor nit: reverse christmas tree above.

Oh right.... I anyway found another minor issue, so I'm going to send
v9 with the above as well as the other minor issue fixed.

> BTW the initial port isolation LGTM, but I would appreciate some DSA
> expert second opinion.

+1

