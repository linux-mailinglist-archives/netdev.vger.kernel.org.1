Return-Path: <netdev+bounces-283542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGNHFafg9mmbZQIAu9opvQ
	(envelope-from <netdev+bounces-283542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 07:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAAC4B4821
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 042F43001CCC
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CC39A816;
	Sun,  3 May 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gpEkbVw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E3346A13;
	Sun,  3 May 2026 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787040; cv=none; b=P0liO2wTAVWppI+gMPN28iJA3evjGDnMa67CCBExIcO1/D1UgxcI9zLe0K7aHVWYfy/NhWPcYoGVTZhuFoTDASyho/+OGVVcz4gUYjAgM421EXreObbOtyBEZ+RAdnx72oiI8m/FmUcWTlpBoZG+bJ8s1pdxHPNC7PVxo/CISLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787040; c=relaxed/simple;
	bh=ktQFx+wmauplAHJrVf0ni9I6Q0rTlKQem2m0emsUYHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYUz8h2oH5n9CiOdRtPbGJhuVSmd/77SYjDKSP1OZXDJlP0lceV3IEk/IKSSP2hS8xA0qQlX4RFwPh+keCOXtOPjr0SL9Ewz+tw0HdynVPOFodKR5s9i3x1EZXskGU+6cnuRbP+ZZvyiqbZNi9W+Hqch19kKampimLQPjAjrY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gpEkbVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB1FC2BCB4;
	Sun,  3 May 2026 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777787039;
	bh=ktQFx+wmauplAHJrVf0ni9I6Q0rTlKQem2m0emsUYHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1gpEkbVwZu5/SY1Et6mDcSa3zISYgnrl0ejJM+f7e8sgngWc2G0egYZ4Qjl1kDS8S
	 DEWJm/mdrOtGg7YJs5TnIGdb7gn+vPQSmgZoDZYDWgTS2hJVpiWIMLXM5amr9XPghV
	 Y5v/2I8yJyeLgRio6GXEPMUQZAsI1hxEXgrPnKe4=
Date: Sun, 3 May 2026 07:43:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
Message-ID: <2026050340-kilogram-prissy-a833@gregkh>
References: <20260503030801.14080-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503030801.14080-1-enelsonmoore@gmail.com>
X-Rspamd-Queue-Id: 4DAAC4B4821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283542-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 08:07:38PM -0700, Ethan Nelson-Moore wrote:
> The synclink_gt driver was marked as broken in commit 426263d5fb40
> ("tty: synclink_gt: mark as BROKEN") in July 2023 because it had severe
> structural problems and there had been no evidence of users since 2016.
> Since then, no meaningful improvements have been made to the driver,
> and it is unlikely that will ever happen due to the lack of interest.
> Drop the driver and references to it in comments and documentation.
> Retain include/uapi/linux/synclink.h to avoid breaking userspace
> software.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> Changes from v1:
> - Retain UAPI header - the linux-raw-sys Rust crate generates bindings
> for it [1]

Then that means someone uses it somewhere.  Don't generate bindings for
something that will break because it is no longer in the tree :(

If no one does use it, then please get that project to fix their code so
that we don't break their build.

thanks,

greg k-h

