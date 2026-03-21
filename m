Return-Path: <netdev+bounces-270251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD4xLbX2vmmFmQMAu9opvQ
	(envelope-from <netdev+bounces-270251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D12E7133
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D94A53011C65
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861A3043DC;
	Sat, 21 Mar 2026 19:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66E17A586;
	Sat, 21 Mar 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122674; cv=none; b=o9urhrolMJFKCogfV06GOIoY7XCtNKFX3pWmv/xoZ/zoyMLr7PLzBa8KA63+POaQY4vmqqZ2MiXFI6ug28GUEEqWxVEu7omZsTdToz2q0260QalrstgdbM9RSG57iHctj2FXxSrNasVdfEDx0u68eTpZCAfF6sq2lfIqVQRn7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122674; c=relaxed/simple;
	bh=gzsj3c+gVrsMfK/04FnnaKeoX2trnctuidWuHjdeU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI4KmmJ9ay0L9t2wn/E9s5oh35PX+OW3EC9z2DnQNG8gcPLChBK9IJ5SuWTTj6rXdUJjzVvA2skuuTSGWaAwdsbP6h+2CNp9WM6U1oz8T5XOxGFcveB14AZG3J751su9F89XfZ0WqkiinoQUvq/yXisTqwnna8NDOF0L4Q1q3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w42Li-000000000mW-2hvM;
	Sat, 21 Mar 2026 19:51:06 +0000
Date: Sat, 21 Mar 2026 19:51:01 +0000
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
Message-ID: <ab72pS8weYdWu-YK@makrotopia.org>
References: <cover.1774070039.git.daniel@makrotopia.org>
 <af6911188ee6becb9100d4bf13d0820e5bf9eaca.1774070039.git.daniel@makrotopia.org>
 <c5f29b9b-9447-488e-b8cc-e2f7e7cbf1a8@lunn.ch>
 <ab6-5XnC6Z3TdytJ@makrotopia.org>
 <fa518f5d-8b68-459e-9d69-b8702a0b6b57@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa518f5d-8b68-459e-9d69-b8702a0b6b57@lunn.ch>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-270251-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 333D12E7133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 08:29:20PM +0100, Andrew Lunn wrote:
> > > This is the question, what to do when you see a checksum failure? The
> > > basic assumption is MDIO is reliable. PHYs don't do any sort of
> > > checksums, nor any other switches using MDIO. Why would you want
> > > checksums?
> > > 
> > > To detect the hardware is broken? If so, is returning EIO sufficient?
> > > Would it not be better to admin down all the interfaces?
> > > 
> > > To allow the MDIO clock to run at a higher frequency, at the limit of
> > > the bus, so you get occasionally failures? If so, should you not
> > > retry? But are the commands idempotent? Can you safely retry?
> > > 
> > 
> > Your guesses are all correct, and your concerns are justified.
> > 
> > Let me explain the whole picture:
> > The switch driver transfers many rather large data structures over
> > MDIO, and lacking support for interrupts (firmware doesn't support),
> > this is often even interleaved with polling 8 PHYs and at least one
> > PCS. To not have things get very slow (and then even sometimes see
> > -ETIMEDOUT breaking the PHY state machine if timing is unlucky), it
> > is common to overclock the MDIO bus to 20 MHz instead of the 2.5 MHz
> > default (the switch claims to support up to 25 MHz, but 20 Mhz is
> > sufficient and conservative enough).
> > 
> > That, combined with higher temperature of the switch IC (but still
> > within the spec'ed range), can lead to bit-errors -- which, in case
> > they remain unnoticed can introduce subtle (security relevant) issues
> > such as bridging ports which should not be bridged or flooding to a
> > port on which flooding should be disabled.
> 
> O.K. "Interesting" design.

🤐

> 
> You could solve the PHY timeout issue by claiming to support PHY
> interrupts, doing the polling in the DSA driver, and raise an
> interrupt if the conditions are met. The mv88e6xxx driver does
> something like this. It has an interrupt controller which the PHYs are
> connect to. Some designs have the switch interrupt output connected to
> a GPIO and so can do real interrupts. Some don't. Rather than have all
> the internal PHYs polled one per second by phylib, the mv88e6xxx polls
> the interrupt status register every 1/5 of a second and raises the
> interrupts instead. Bot faster, and less MDIO transfers.

Sadly, the firmware doesn't provide any API for that. The *hardware*
would likely be capable, even has an external pin to signal interrupts
to the host. But no firmware API to setup/mask interrupts, nor to read
or clear the interrupt status.

Raw access to the relevant hardware registers representing the
interrupt controller also isn't an option, as the only documented raw
register access interface only covers the switch engine itself, and
another (undocumented) more broad debugging register access API only
allows write operations on a very limited range of registers (and the
firmware applies bitmasks for each of them individually) basically
covering the GPIO and LED controller parts...

Plus, most likely interrupts of the built-in PHYs are as broken as for
all other GPY2xx PHYs (see PHY driver comments), because it's more or
less the same IP.

tl;dr: Due to firmware and hardware limitation that's not an option.

> I assume the vendor driver does not attempt a retry?

The vendor driver doesn't retry, it merely reports CRC errors.
I thought about it, and retrying would be an option, as on pure WRITE
operations the host could retry sending (as the original request is
dropped by the firmware in case of a CRC error), and READ operations
could only repeat the data retreaval part, but not the actual command
itself. However, I don't think any of that is worth the added complexity.
If the we end up with CRC errors, something is very wrong, most likely
overheat, so trying to forcefully continue normal operation imho isn't
even a good idea even if somehow possible.

> 
> > Setting all interfaces to admin-down is probably the best compromise
> > in a case like this, as it would also reduce the energy consumption
> > and hence heat emission of the IC (as all built-in PHYs are then down;
> > that's where most of the heat comes from) and prevent damage -- I've
> > only observed CRC errors with the heatsink removed and artifically
> > overheating the IC...
> 
> So in the normal use cases you don't expect CRC errors. That seems
> like it should driver the design. Consider any CRCs as fatal and
> shutdown.

Ack, I also think that's the most reasonable thing to do.

As the shutdown itself can trigger more CRC errors (PHYs being put
into PDOWN, for example, will cause dozends of MDIO operations to
indirectly access the internal MDIO bus via the firmware interface...)
I will guard this using an atomic flag to prevent the ongoing shutdown
from triggering another shutdown...

