Return-Path: <netdev+bounces-252873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H+3GGmXc2mNxQAAu9opvQ
	(envelope-from <netdev+bounces-252873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:44:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD877ED1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 121EF3007AFC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44D31352A;
	Fri, 23 Jan 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDb2KnuG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE252DC763;
	Fri, 23 Jan 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183072; cv=none; b=XayqSarQtxL4G2TH+S/F/P6jY4a7bFwckXryoVM5rBGjshm3wHIsMwM6/pzpzUtQwUDbZEbW5KirNdhz3eiNWYQvEWwHEHpvvQ/NZ/s4O7IIy7nXXpkDINe83RPzcxQBaamwnF6l+KOokggYQ2qQNIhdYPXNwPSHROzQFKbh5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183072; c=relaxed/simple;
	bh=PI8U66nkmI69uDjXwlGAwVg6sJc6HZyC/Sm7bA+TuPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiwNeGorNM9/D6QW2eCdfWaxIqodHm20rriclOqjY/hiRv6vM1JLQvU0n3EkuIHKW6jX7F1jQGt/Z3Yh6HXg/SPlZzW259mPdcTZhyKh2KjVMjHL82kdwO6/vTo3a/IRghgmVJ6YJmRduuy9L19/FoL0Gy2i3EgoGJs8y3+B/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDb2KnuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56FC4CEF1;
	Fri, 23 Jan 2026 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183071;
	bh=PI8U66nkmI69uDjXwlGAwVg6sJc6HZyC/Sm7bA+TuPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDb2KnuGFQseZTkYNhCLW0+KaPv0xP4e3UdVruFz1cgmC8r6RE/BJbSDVAxEtkGWa
	 dSZ555ljpCwkFMymZNUwLWWSWiHE9Fkz362nOBD55WjdCrKADVKRQbq/ncxuk5ht6G
	 3y+40sVU5blFOUYHqw9LJEM2MNe3PLs/D5O8f/y/12Udkn+lsvzyZ5ur/wvMFFuvVW
	 8LdPLBtvWP4dudWVq3ee5q4u/nBnk5yDI8b6F32rcry2pa/Eou9/eUcauk1UZbEpHl
	 tdkfWoFlLciqeaa0tBVa6rT8SAuZODab0tU/N5lu+RF9orDfQf54W11dweJA/vokLw
	 tDyTWCT7oDXlA==
Date: Fri, 23 Jan 2026 15:44:25 +0000
From: Simon Horman <horms@kernel.org>
To: david.laight.linux@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH next 05/14] ixgbevf: Use C test for PAGE_SIZE >
 IXGBE_MAX_DATA_PER_TXD
Message-ID: <aXOXWWH7je3VKMn6@horms.kernel.org>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-6-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-6-david.laight.linux@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linutronix.de,infradead.org,efficios.com,arndb.de,vger.kernel.org,gmail.com,intel.com,wanadoo.fr,linux.intel.com,chromium.org,linux-foundation.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DCD877ED1
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 02:57:22PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Compile-time tests being added to BIT() make it an 'integer constant
> expression' rather than a pre-processor expression for W=1 builds.
> 
> This means BIT() can't be used in pre-processor conditional that
> checks 'PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD'.
> Change to use a normal 'if' statement, the compiler will optimise
> away the unwanted code.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Thanks David,

Other than the motivation above, I appreciate that this removes two
#ifdefs, improving readability (subjective) and compile coverage
(objective) of this code.

As an aside: I'm Not sure what your merge plan is for this patchset, and
only it and the cover letter hit my inbox, so I'm missing context.  But
from a Networking PoV it seems that it could be sent as a stand-alone patch
to the iwl tree.

Regardless, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

...

