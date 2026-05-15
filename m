Return-Path: <netdev+bounces-288379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJgBB3NPB2rBxgIAu9opvQ
	(envelope-from <netdev+bounces-288379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:53:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E5554189
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 157F53069A1F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200E3D3331;
	Fri, 15 May 2026 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA/ygI+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A53CE080;
	Fri, 15 May 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863339; cv=none; b=Jun/eVJJSf351nj8+gwUGxSu0poRub4HKtDuSerCWBxZwQU1mPCfv6UGk6tTxyuxfWWclGheFUah5FhClqqvtkCNcSHN/k3xq6/lyVaB+uT5DBuDk7Y5K+ym+yc4w3KEYMfs8Kpjc3kuXjmbmAxHPxkLt2xwD1M/Nzo9CWCDWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863339; c=relaxed/simple;
	bh=+by9VGMs1cPagtgQJQ25ByyxwRsRvF4tA32qBIVlrE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjQV/oELicCOH5A+Ko6btgU2IdusMMYcivtkUOi/OczuTzvHSisUHhdnAZdAsLa/eIcVyniMSgRZmK0lF8+LIS26xnm1WAazwGocUluKrY+ZOL+F4TWUuXpvtfhwhuvX8u/kxqYWEuLFtW7WcTJ/uPJtZuGF7QgiLPNEFHQqTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA/ygI+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CE8C2BCB0;
	Fri, 15 May 2026 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863338;
	bh=+by9VGMs1cPagtgQJQ25ByyxwRsRvF4tA32qBIVlrE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lA/ygI+v1N4XRm0r2uGzp1WTxiR8b56/G6PnbhZfTiyIl8mjiULkoCF5hxilWz7rU
	 SfSM9jOYxPCmstBZp/aNMkUSjqCUybcC5SFStcA0hIuVm4zgOI2WjmVGBH+A/UtG7G
	 37ClZheTJlAZj47ZiIq6Cxf0kb4OPU98xxa3+ZF7N6TB4TERxTyLpJTjD41OZyC9q3
	 SYGzErBzMuUkohEaNRtTXMuDP0vB9MfSB/CyYeHdb1fZtCs40oMrsoBgHgc5eux4t3
	 WR0RFAUzWPA6HUlAm1bWQgR/7Xo2120NYUa9gA++LmL5q8z0Z5T252xkJtG3A6aWKm
	 LE0jlB+80O49A==
Date: Fri, 15 May 2026 17:42:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Subject: Re: [PATCH net-next v7 1/2] net: sfp: apply I2C adapter quirks to
 limit block size
Message-ID: <20260515164213.GE227382@horms.kernel.org>
References: <20260507093301.1144740-2-jelonek.jonas@gmail.com>
 <20260510164726.1401317-1-horms@kernel.org>
 <5129a58d-8852-4395-85e1-8991934810b8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5129a58d-8852-4395-85e1-8991934810b8@gmail.com>
X-Rspamd-Queue-Id: 228E5554189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288379-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:33:47PM +0200, Jonas Jelonek wrote:
> Hi,
> 
> On 10.05.26 18:47, Simon Horman wrote:
> > [ ... ]
> >> +	if (i2c->quirks && i2c->quirks->max_read_len)
> >> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
> >> +	if (i2c->quirks && i2c->quirks->max_write_len)
> >> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);
> > Does applying max_write_len to max_block_size inadvertently throttle reads
> > and break hardware monitoring?
> >
> > The max_block_size dictates sfp->i2c_max_block_size, which subsequently sets
> > sfp->i2c_block_size. This block size is exclusively used by sfp_i2c_read()
> > to chunk read transfers. The write message in a chunked sfp_i2c_read()
> > operation is always exactly 1 byte (the register address), irrespective of
> > the read payload size. Restricting the read chunk size based on
> > max_write_len appears to cause unintended side effects.
> >
> > If an adapter has a max_write_len of 1, the i2c_block_size becomes 1. This
> > forces 1-byte read chunking and explicitly skips hwmon device registration
> > since sfp_hwmon_probe() requires an i2c_block_size >= 2.
> >
> > Will this change actually protect writes against the max_write_len quirk?
> >
> > Looking at sfp_i2c_write(), it ignores sfp->i2c_block_size and does not
> > implement chunking. It unconditionally allocates 1 + len bytes and submits
> > a single i2c_msg. Any write where 1 + len > max_write_len will still be
> > rejected by the I2C core.
> >
> 
> The concern is structurally valid - the single i2c_block_size does
> conflate the two direction caps, and on an adapter with
> max_write_len < max_read_len the read path would be throttled while
> sfp_i2c_write (which doesn't chunk) wouldn't actually be protected by
> the write clamp.
> 
> However, a sweep of drivers/i2c/busses/ shows no in-tree adapter
> currently sets max_write_len < max_read_len; the only asymmetric
> quirks go the other way (read-only caps, or read ≤ write). In every
> existing case min(max_read_len, max_write_len) collapses to the read
> cap, so the clamp behaves identically to the situation without this
> change.
> 
> Given that this only has theoretical implications and there won't be a
> real-world impact right now, I'd keep this as-is. But if handling this
> properly is desired, I can add another patch splitting the size caps
> per direction and adding proper handling to sfp_i2c_write.

Thanks, I'm also unsure if it's worth fixing if it doesn't effect anything
in practice.

> 
> >> +
> >> +	sfp->i2c_max_block_size = max_block_size;
> >>  	return 0;
> >>  }
> 
> Regards,
> Jonas Jelonek

