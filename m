Return-Path: <netdev+bounces-294903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xbmZHruKIGqD4wAAu9opvQ
	(envelope-from <netdev+bounces-294903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC263B0F5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:12:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=Nfy5H6n0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294903-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55A8F307C6E2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D83FE652;
	Wed,  3 Jun 2026 20:12:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5ED39E9BD;
	Wed,  3 Jun 2026 20:12:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517536; cv=none; b=XrMc5ShDPZRIUlAe45adHzuIR0OENPigNyw/1pFyr9byJBdf/vEvVTMpZW1egv3pwdRj+tYvHxjcS4RP2RgDo7VZkpqs14z8AhXBDTKT5Qstgm7f9dHu6cO0Tk23IIXaH4vvP1aHn/FB/y7LSHGiOhBFsuqY6K0Tr949lm1r7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517536; c=relaxed/simple;
	bh=2knHxY5vSjk3O5pcSBk0V3WKjnVRps5mVeqti3A9Hi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7EZmSyOqVyHKLAxJLED/YNC2edNV787M2DGfjVVcH/qJKaJXvlyaAgE2JTQcid2Wovc8N7F7htCasTARYUmCSu176aPfjj+TuQVfJfnE/d/4mFWYrCeO1aKXriEpGGB9AgQ/yA6nAn4DIFg8dCpE7vD/V2XRWuTSaiWTrN+OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nfy5H6n0; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2knHxY5vSjk3O5pcSBk0V3WKjnVRps5mVeqti3A9Hi4=;
	t=1780517534; x=1781727134; b=Nfy5H6n0NKix9ffg+A78TOF8rzgdvqCMs6TgS1JWrgZCdZk
	tMR3Kdwxl/ZWCE21ptwkf7AOuSjYTHGXd1MAYH+Bkmf69V0n7hZ1kKafCehkJ0xYwnMSkpFnbnZJT
	mBPWz4LgMVrdXnPwRf20wUvhFHifrepqRNZnUB9Ih2zkFBKVneFpiOkgxu3NWGxeOXEVO+Tj24Z5z
	TMWf4+Zhv3Vc0+4jquDuzMof22hR1f3d8FpOZUkBcpv0sV97nQQCWj3IwkX2bfyy4LQchafviRuXP
	C7K2kEkjXkdT9dJtVBjq4W56bnTTagR4vGNge5T0q5NBZMM2UqaYXCXsXbRjae4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUrwb-0000000HKFJ-2F4b;
	Wed, 03 Jun 2026 22:12:05 +0200
Message-ID: <c78c1ff315ec96795461f100064bc42c524a67e3.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, 	workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Wed, 03 Jun 2026 22:12:04 +0200
In-Reply-To: <20260603162943.2406080-1-kuba@kernel.org>
References: <20260603162943.2406080-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CCC263B0F5

On Wed, 2026-06-03 at 09:29 -0700, Jakub Kicinski wrote:
>=20
> +Additionally, netdev does not consider bugs to be ``net``-worthy
> +if they fulfill **all** of the following criteria:
> + - bug is in a hardware device driver;
> + - bug is either a missing error handling or is part of the error handli=
ng flow;

Do you really want to be this specific?

Take this fix for example that I mentioned the other day:
https://patchwork.kernel.org/project/linux-wireless/patch/20260531145435.70=
1703-1-runyu.xiao@seu.edu.cn/

It doesn't formally fall under that definition, but I think it should,
it's a silly thing to send to stable etc.

This isn't even a USB device where you could reasonably argue that
someone might plug in a random one and it could be programmed to look
like the device in question and misbehave. Sure, you can build PCIe
hardware too that can do that, technically, and there's technically
external PCIe via Thunderbolt, but it's still far harder to actually do
anything with.

> + - bug was discovered by a static analysis / AI tool;

I'm not (yet?) convinced that this bullet point is right.

It risks getting into an argument about how much the LLM did to discover
it, or if the actual discovery was a manual process after the LLM
pointed out issues, or whatever ...

Maybe more importantly, why should that even change the result?

It's true that today the reason to start spelling this out more clearly
is AI related, but that's really because of (a) the scale, and (b) many
of the people running the LLMs not being aware of (and frankly often not
really caring about) the community norms. I'm not convinced that the
"silliness" of a change should be measured by how it originated.

> + - bug was triggered/observed only with kernel changes or fault injectio=
n.

Given this fourth bullet point, we'd still accept fixes for such driver
problems that people actually run into, while excluding "theoretical"
things that are discovered by "reading the code".

johannes

