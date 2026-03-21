Return-Path: <netdev+bounces-270230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMO0DPW+vmmFZwMAu9opvQ
	(envelope-from <netdev+bounces-270230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:53:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A0B2E639C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 770A330173B2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC63394469;
	Sat, 21 Mar 2026 15:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A663932DB;
	Sat, 21 Mar 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108401; cv=none; b=HaKRNBmJsbr3zWjykE9NzvDEl/oyagOjJTOT3SP7sYD6Dbb118fIDaHrdZednkfU8CRG+62pePyyLcJN3OtrsdLX+1c3lYMb+xQMVCs6sk6yEnlvg08zesQ4I79n8wnZyiQAIVUkvup5FPF4bLXE1iU6KQLkEWAud3ajX7OHibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108401; c=relaxed/simple;
	bh=4zGS4/JUtw122vjazkGgwRk2/SX5TUDZtxucIEAE0Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcH0s2dpXDgZPMMQDrLoB+zlZsnbQbL1lLexTMsDRC36qqQ3f6to3JyNC5d1aFPJDuNpvo98eRZq1JB2zdzsb0rhA7WljBB32HSIwDxuswzqtSji+PFVko+xds3w55gjxfOaxmQc3c8hdzCP2lorLbnBxEWNrN8g+YlAGISIj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w3ydU-0000000007O-2sLt;
	Sat, 21 Mar 2026 15:53:12 +0000
Date: Sat, 21 Mar 2026 15:53:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: mxl862xx: add CRC for MDIO
 communication
Message-ID: <ab6-5XnC6Z3TdytJ@makrotopia.org>
References: <cover.1774070039.git.daniel@makrotopia.org>
 <af6911188ee6becb9100d4bf13d0820e5bf9eaca.1774070039.git.daniel@makrotopia.org>
 <c5f29b9b-9447-488e-b8cc-e2f7e7cbf1a8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f29b9b-9447-488e-b8cc-e2f7e7cbf1a8@lunn.ch>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-270230-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid]
X-Rspamd-Queue-Id: A4A0B2E639C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 04:24:06PM +0100, Andrew Lunn wrote:
> > +/* Firmware CRC error codes (outside normal Zephyr errno range). */
> > +#define MXL862XX_FW_CRC6_ERR		(-1024)
> > +#define MXL862XX_FW_CRC16_ERR		(-1023)
> > +
> > +/* 3GPP CRC-6 lookup table (polynomial 0x6F).
> > + * Matches the firmware's default CRC-6 implementation.
> > + */
> > +static const u8 mxl862xx_crc6_table[256] = {
> > +	0x00, 0x2f, 0x31, 0x1e, 0x0d, 0x22, 0x3c, 0x13,
> > +	0x1a, 0x35, 0x2b, 0x04, 0x17, 0x38, 0x26, 0x09,
> 
> I had a quick look around and count not find this table anywhere
> else. Mellanox has a different CRC-6 polynomial. Until somebody else
> needs this, i think it is O.K. here. But sometime in the future it
> might be moved into lib/crc.
> 
> > +	ret = mxl862xx_crc6_verify(ctrl_enc, len_enc, &fw_result);
> > +	if (ret < 0) {
> > +		dev_err(&priv->mdiodev->dev,
> > +			"CRC-6 error on response to CMD %04x\n", cmd);
> > +		return -EIO;
> > +	}
> 
> This is the question, what to do when you see a checksum failure? The
> basic assumption is MDIO is reliable. PHYs don't do any sort of
> checksums, nor any other switches using MDIO. Why would you want
> checksums?
> 
> To detect the hardware is broken? If so, is returning EIO sufficient?
> Would it not be better to admin down all the interfaces?
> 
> To allow the MDIO clock to run at a higher frequency, at the limit of
> the bus, so you get occasionally failures? If so, should you not
> retry? But are the commands idempotent? Can you safely retry?
> 

Your guesses are all correct, and your concerns are justified.

Let me explain the whole picture:
The switch driver transfers many rather large data structures over
MDIO, and lacking support for interrupts (firmware doesn't support),
this is often even interleaved with polling 8 PHYs and at least one
PCS. To not have things get very slow (and then even sometimes see
-ETIMEDOUT breaking the PHY state machine if timing is unlucky), it
is common to overclock the MDIO bus to 20 MHz instead of the 2.5 MHz
default (the switch claims to support up to 25 MHz, but 20 Mhz is
sufficient and conservative enough).

That, combined with higher temperature of the switch IC (but still
within the spec'ed range), can lead to bit-errors -- which, in case
they remain unnoticed can introduce subtle (security relevant) issues
such as bridging ports which should not be bridged or flooding to a
port on which flooding should be disabled.

At this point I just wanted to make errors visible at all.

In case of the switch reporting back a CRC error for data received,
a limited number of retries would be ok in every case.
However, the same is not true for the opposite direction, ie. an
error detected by the Linux host for data received from the switch:
In case one of the *_ALLOC API calls we cannot simply repeat the
call, and as the data was corrupted, we wouldn't even know how to
undo the failed call. Resetting the switch and replaying the
complete state would be the only way to avoid a firmware resource
leak in this case.

Setting all interfaces to admin-down is probably the best compromise
in a case like this, as it would also reduce the energy consumption
and hence heat emission of the IC (as all built-in PHYs are then down;
that's where most of the heat comes from) and prevent damage -- I've
only observed CRC errors with the heatsink removed and artifically
overheating the IC...

