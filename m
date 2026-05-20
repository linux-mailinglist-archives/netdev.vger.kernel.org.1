Return-Path: <netdev+bounces-290125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPplEZ45Dmqu8wUAu9opvQ
	(envelope-from <netdev+bounces-290125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:45:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4745859C3FC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64A39312F7BF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC73F9280;
	Wed, 20 May 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkAza7Kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCF3CA4A8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315813; cv=none; b=itYsvy0kHRkjk72W42qIWiselAiAOZVMNkGCYY+Te7usjLMhIsmIuDtj/JNVc4G+fe/W8amb/26SM7wM5tESh7m9ioeSdQM7ollU82C5Op/Uk3+up2L4RjDh5jc4jfcOAwCdLQEOeZ6223DK9/CRLLpg1PzHwWFaJKsuPbG88GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315813; c=relaxed/simple;
	bh=JKCn/Wz6Euz2vV2rgLuJfAmhYMXsAB35B2YMpYvbl/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBDWEQvl7r4x5Svv/f8WMWWWiS7A6G+g+XL5BVZiRUyRsUTyYrRCpF3ysQ67s+EIC2xO86JYc0OhCJwrhOsynh21F0a9VGxgBsTlrduA3bzkzPAjdNZ8LxgAmDwvFJvmBtA9BG92K3sggYjdgL0hG8MNZFg0HftDVYZ8bM4JAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkAza7Kf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B231F00A39;
	Wed, 20 May 2026 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315811;
	bh=JKCn/Wz6Euz2vV2rgLuJfAmhYMXsAB35B2YMpYvbl/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PkAza7KfOOK2FtFpCl4ENyUVkHTj8cSdxSRgbg2CVBFu/kXjywjQjT7Vyt6D4ciEw
	 BjfKid8Gmhu29Gi1bvRYsaoxS+bDJ40W39vw3Ks8rxfBCpycKVEuZgKr2N5KXRebV7
	 lc4HCyJ8yeEGZqt03BIdtYetdQCdy7GAjXVTHEbmNwCEZyArbJdsw4NgaHFEF7SDee
	 lC+JXJVWZU1rHTuSXa9IzMqc4/KJ9djh6JFxO5yOk1mfUbjGxP226/2dzfO0+uN9Hl
	 fsvxH9cw6Q3VC6klihPDyKaq2bom2aLr9ATwht0xFqn5ULEEDrqcrtDzdcxFoVugth
	 ZpNhbTUKcMi3g==
Date: Wed, 20 May 2026 15:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction
 macros
Message-ID: <20260520152330.699e2ee7@kernel.org>
In-Reply-To: <CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
	<20260518010739.80979-5-enelsonmoore@gmail.com>
	<20260518182220.78a9ae80@kernel.org>
	<CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290125-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4745859C3FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 19:21:05 -0700 Ethan Nelson-Moore wrote:
> On Mon, May 18, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Sun, 17 May 2026 18:07:24 -0700 Ethan Nelson-Moore wrote: =20
> > > Now that the BUS_ALIGN variable has been removed, the
> > > arcnet_in/out/read/write* macros behave identically to the functions
> > > they wrap. Expand them and remove their definitions to make the code
> > > easier to maintain. =20
> >
> > This one reportedly transiently breaks the build. =20
>=20
> This is due to incorrect patch ordering on my part - if you apply the
> ISA/PCMCIA removal patch before the two I/O abstraction cleanup
> commits, the code compiles after every patch.
> i.e., use this patch order: 1 2 5 3 4 6 7

FWIW we're expecting repost, we can't fix the ordering on our end
to re-feed all the CIs. Build breakage prevents any deeper testing
from kicking off.

I'm writing for another reaons tho - I've been meaning to ask whether
you know of any reason to keep arcnet in tree in the first place?
We can start with this series, mostly asking about next steps
'cause some are posting fixes for arcnet and I'd rather delete it
than spend time making sense of this ancient unsafe code :/

