Return-Path: <netdev+bounces-299689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S1z3Nf+aMGoiVAUAu9opvQ
	(envelope-from <netdev+bounces-299689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:38:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392568AF9F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:38:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ibT+z5tE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299689-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299689-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAAB3301C90E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCE267B07;
	Tue, 16 Jun 2026 00:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01F26B2D2;
	Tue, 16 Jun 2026 00:37:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570268; cv=none; b=ENN+xgovl59HAHWUuSX7pLBHL3sqtzlyW30bAw+z7kaA8uuyfPAuflwlAGp7SLlqeukX64baJ7MSh2UsmUB+RactRCZYY+rWJFQ9EtWq7tZrs+0xpiAmY7oidNphKDwRk0rokqKB5+GWXXNsChLpal9j8j6yzqPpTDbPTCJdN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570268; c=relaxed/simple;
	bh=ASJfppA+6eTAEZarFOaL9yPaJb/AgRBOnp6y+Cgb71c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y49/PaYb5g49kh5D+W0O4b9Ox1F78kxIUGSPQMD+N7uA3y+5xC+mCEZg9H4YifzY2BvJLJob/HcdqB/XTnXkkFW/M/rJdRPDZ4O/QIGbP9OSWjBhoidcFPRrwRZ/1h5lLzAEZtc9gX7BY3RmtPZI1c5Lt9opj1TmjbE6bQG+atE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibT+z5tE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149631F00A3A;
	Tue, 16 Jun 2026 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570266;
	bh=mzrw+jOAyMuxBknT4Ni/z4o9wNs1vXrwxYnS8K6qi0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ibT+z5tEsLWd2CDY5/NJICcmXgIvJb74812uQ/V5tw3hA2kQORXZlymuOV9D9syjf
	 JYstXnnciwsVMMQlEWNPmNyRfH75pTAUVulE7oYWGdlA5d1EHHDkFzKO9hLFix2XnK
	 Gc2orTxnSTlxHbB+xXbbT3/Y/22yhc463KggjFI0ijnlbUSzsr+uyphZyK4FjYB0d4
	 u0os6VvxrSwIrpuywLYf7URzgS+xgUTAu/tPRzN7VfXVK9T0SFY2JLKOnogKDEp5Qm
	 ggDExek5gloqPS//80ET9te49Z3F9dqubNsFthVyipma/D73bFDftAKImnmddGRPg5
	 LL+4DyzLjpJ5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
Date: Mon, 15 Jun 2026 17:37:45 -0700
Message-ID: <20260616003745.1104749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-6-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299689-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5392568AF9F

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mdio: realtek-rtl9300: Add c45 over c22 mitigation

This patch adds a per-port state machine that disables hardware MAC polling
around a register 13/14/13/14 c45-over-c22 MMD access sequence so the
sequence cannot be interrupted by a parallel polling read.  Polling is
disabled when the first MII_MMD_CTRL access is seen and re-enabled when
the four-step sequence completes or unexpected input is detected.

A few questions on the new state-machine corner cases below.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index a7fd075947b6..e206ee3e2b1c 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -254,6 +257,43 @@ static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int port, b
>  				  BIT(port % 32), active);
>  }
>  
> +static int otto_emdio_mmd_prefix(struct otto_emdio_priv *priv, int port, int regnum)
> +{
> +	u8 newstate, *state = &priv->mmd_state[port];
> +	int expected, ret = 0;
> +
> +	if (!priv->init_done)
> +		return 0;
> +	/*
> +	 * Disabled polling might produce link flapping and false notification interrupts on the
> +	 * MAC layer. In this case disable c45 over c22 MMD access because chances are high that
> +	 * the register 13/14/13/14 sequence is intercepted by a parallel hardware access. As
> +	 * a workaround the PHY must provide its own mmd read/write() callbacks and redirect to
> +	 * normal c22 registers. See rtlgen_read_mmd().
> +	 */
> +	if (priv->info->link_flap)
> +		return (regnum == MII_MMD_DATA || regnum == MII_MMD_CTRL) ? -EIO : 0;
> +
> +	expected = (*state & 1) ? MII_MMD_DATA : MII_MMD_CTRL;
> +	newstate = regnum == expected ? *state + 1 : 0;
> +
> +	if (newstate == 1 || newstate < *state)
> +		ret = otto_emdio_set_port_polling(priv, port, !newstate);
> +	*state = newstate;
> +
> +	return ret;
> +}
> +
> +static int otto_emdio_mmd_postfix(struct otto_emdio_priv *priv, int port, int regnum)
> +{
> +	if (priv->mmd_state[port] != 4)
> +		return 0;
> +
> +	priv->mmd_state[port] = 0;
> +
> +	return otto_emdio_set_port_polling(priv, port, true);
> +}

[High]
Can otto_emdio_mmd_prefix() and otto_emdio_mmd_postfix() get out of sync
on a transient MDIO failure?

The prefix transitions state 0->1 on the first MII_MMD_CTRL access and
calls otto_emdio_set_port_polling(port, false).  In the c22 read/write
helpers below, if priv->info->read_c22() / write_c22() then returns an
error (otto_emdio_run_cmd() can return -ETIMEDOUT from
regmap_read_poll_timeout(), -ENXIO via cmd_fail, or any regmap_write()
error), the function returns immediately and never calls
otto_emdio_mmd_postfix().

Polling is left disabled, and *state stays non-zero.

On subsequent retries with regnums that still match the parity-based
expected value (the natural retry shape for an EEE 13/14/13/14
sequence), mmd_prefix keeps doing *state + 1 unbounded (state walks
through 5, 6, 7, ...).  mmd_postfix only re-enables polling when
mmd_state == 4 exactly:

	if (priv->mmd_state[port] != 4)
		return 0;

so once the counter overshoots 4 it stays disabled until either an
unrelated regnum forces newstate < *state in mmd_prefix, or the u8
wraps at 255->0.

The commit message says polling is re-enabled "as soon as the sequence
is finished or any other unexpected input is detected", but a transient
MDIO failure mid-sequence is neither.

Should the error paths in otto_emdio_read_c22() / otto_emdio_write_c22()
reset mmd_state and re-enable polling on a failed transfer?

> @@ -463,7 +503,15 @@ static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  		if (regnum == 31)
>  			return priv->page[port];
>  
> +		ret = otto_emdio_mmd_prefix(priv, port, regnum);
> +		if (ret)
> +			return ret;
> +
>  		ret = priv->info->read_c22(bus, port, regnum, &value);
> +		if (ret)
> +			return ret;
> +
> +		ret = otto_emdio_mmd_postfix(priv, port, regnum);
>  	}
>  
>  	return ret ? ret : value;

[Medium]
The regnum == 31 page-select path returns from inside the scoped_guard
before reaching mmd_prefix() / mmd_postfix():

		if (regnum == 31)
			return priv->page[port];

If a page-register access occurs while mmd_state is mid-sequence (1, 2,
or 3), the counter is not reset and the polling-disable bit is not
restored, even though a page write between MMD steps is exactly the
"unexpected input" the commit message describes.

Recovery only happens on the next non-13/14 access that falls through
mmd_prefix and triggers the newstate < *state branch.

Should the regnum == 31 path also reconcile mmd_state and re-enable
polling when a sequence is in progress?  The same question applies in
otto_emdio_write_c22().

[Low]
A separate observation about the read return path:

>  	return ret ? ret : value;

After a successful priv->info->read_c22() populates value, ret is
overwritten by mmd_postfix()'s return.  If
otto_emdio_set_port_polling(priv, port, true) inside mmd_postfix()
fails, the function returns that error even though the data transfer
succeeded, so the PHY layer discards correctly read data.  For
read-clear / latched status registers the hardware-side bits have
already been consumed.

Would it be preferable to treat a postfix failure as a polling-
bookkeeping issue (log and proceed) and still return the read value?

> @@ -487,7 +535,15 @@ static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regnum, u16
>  			return 0;
>  		}
>  
> -		return priv->info->write_c22(bus, port, regnum, value);
> +		ret = otto_emdio_mmd_prefix(priv, port, regnum);
> +		if (ret)
> +			return ret;
> +
> +		ret = priv->info->write_c22(bus, port, regnum, value);
> +		if (ret)
> +			return ret;
> +
> +		return otto_emdio_mmd_postfix(priv, port, regnum);
>  	}
>  }

The same shape exists for the write path: a postfix failure here turns
a successful write into a reported error and may cause an upper-layer
retry of an already-applied write.

