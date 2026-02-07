Return-Path: <netdev+bounces-257769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOjmBit0h2kqYQQAu9opvQ
	(envelope-from <netdev+bounces-257769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 18:19:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00B106A65
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FBCA3001382
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11A27F73A;
	Sat,  7 Feb 2026 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ozuUbqpj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3A14A8B;
	Sat,  7 Feb 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484773; cv=none; b=PaLdgGZCaeCQdnhMiFEA4V1Av9QoDRPliOP64H/d4kc/vUGWg6gkNoeaLpmX9wo34iqneJhvs83zQ5F32IFvjp5UtK7UrgjrA4O4k9RFTcGJfZhzdxCfueuT93QVagJZQgZr9PGLof/xdjFfxCvZmFwvO0Y17kdLyd7CUSmm6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484773; c=relaxed/simple;
	bh=BMpRmfD1g0lbfx1D4PCIDSZbSDwGb/3Z6iPB3pU+rvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxkwOl92JeSfeF+RbDZK7l3Y4a8R2vxJNP1v33KDq2gmcIzspi0PQL0NVhoZn1oFD2m2vPNlKvmpoG6TL1rHOllaXyj9ZK67Kd4EZu4gZXcYoxEVuf1LJTaZ7EZL8U++wwWZOS/mFUShKArFxTZt58gXdz+SzhWdzeLDJw3v53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ozuUbqpj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1vRm/c/zeE2rytTMdro4Y4OpEv2ZCTvEFTK5hNlIUsU=; b=ozuUbqpj1rLOnjITi47GmO1E/x
	2sbsDYKZ38TPDatuXaspc5TtpZiW9wS20O1O5ozK9invAmfdN/JW28VPK0DZE6vBofHP5aMEU3sml
	dvru4rMss3L/OAUxtS7yuUXXV076EXdM/KiDop+OYeXtNGstKaLWncJS7sphN3kSfD1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1volxZ-006UWz-NN; Sat, 07 Feb 2026 18:19:05 +0100
Date: Sat, 7 Feb 2026 18:19:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <illusion.wang@nebula-matrix.com>
Cc: Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>,
	edumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIHY0IG5l?= =?utf-8?Q?t-next?=
 02/11] net/nebula-matrix: add our driver architecture
Message-ID: <bc3278d8-f614-4a38-ba2e-ebc90268b9c8@lunn.ch>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
 <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
 <769fbfa8-a881-403f-bc65-56c60c389185@lunn.ch>
 <8641f978-76d5-464f-a312-414bd913c918.illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8641f978-76d5-464f-a312-414bd913c918.illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-257769-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F00B106A65
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:26:35PM +0800, Illusion Wang wrote:
> Last time sam had a question
> "
> Thank you for your feedback. You might have misunderstood me.
> Our difficulties lie in the following:
> 1. Assuming only the mainline version changes the name (Assume name "nbl"),
>    and our regularly released driver doesn't change its name, then when
>    customers upgrade to a new kernel (containing the "nbl" driver),
>    and then want to update our regularly released driver (named "nbl_core"),
>    the module (ko) conflict will occur.
> 2. If both our mainline and regularly released drivers change their names,
>    then customers who are already using the "nbl_core" driver will also
>    encounter conflict issues when updating to the new driver "nbl".
> 
> Is it possible to do this: our net driver is also modified to be a driver based
> on the auxiliary bus, while the PCIe driver only handles PCIe-related processing,
> and these two drivers share a single kernel module (ko), namely "nbl_core"?"
> 
> There's no conclusion to this issue yet, so I haven't modified the 'core' parts for now
> (as mentioned in patch0)

This is all open source, you can do whatever you want with a fork of
Linux and out of tree drivers. Mainline has no influence about what
you do in your out of tree driver. So for Mainline, your out of tree
vendor driver does not really exist, any problems with it are yours to
solve.

However, Mainline cares about Mainline. We expect drivers which get
merged follow Mainline design principles, look like other mainline
drivers, and use naming consistent with other Mainline drivers.

You should also think about how this driver is going to be merged. It
is going to be in small pieces. It is very unlikely the first merged
patchset is actually useful for customers. You probably need quite a
few patchset merged before the driver is useful. If you have customers
who use Linus releases, they are going to have to deal with these WIP
driver. Such customers will be building the kernel themselves, so can
leave the in tree module out of the build. However, do most of your
customers use a distribution? A distribution is not going to update
its kernel until the next LTS kernel is release, sometime in
December. By then, you might have something usable in Mainline, and
the vendor driver is not needed. Or you might still be in the process
of rewriting the driver to Mainline standards and it is not
usable. Your customers then need to handle removing the mainline
driver and use the vendor driver. Again, that is not Mainlines
problem.

So, if your "core" driver is purely core, you can call it core, and
give it an empty tristate. The other drivers which are layered on top
of it can then select it.

If your "core" driver is actually an Ethernet driver, please drop the
name core.

     Andrew

