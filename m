Return-Path: <netdev+bounces-284238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI+YOy2a+Wm2+AIAu9opvQ
	(envelope-from <netdev+bounces-284238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:20:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304B4C7C9D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE4C630058ED
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6073CAE9C;
	Tue,  5 May 2026 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cZQ14Rtb"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD3363099;
	Tue,  5 May 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965611; cv=none; b=AJ0AgLghnOxQs7MGlYIu3vkcfetRpKAuRyl1VXIVwSKS5qAncJarXqqVye3lwmXTv5XYTlSI9tI3VyRjxIjCROnKJSsT0TxZDXPw3uxJ9Zy0R/k0eaRHUfcngqorF+5WepYMTsku7/jxYBjUb5Yb2U98Fc22dXmCGcMcJ7ZLytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965611; c=relaxed/simple;
	bh=PicwdBP0JfTSl6AEfOGSVzgTCX5drmXttqy1jdBqVB8=;
	h=From:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCsaJsivYAyKqHoJEGCH8ObVd1MACbBT8F07wNJDykzMRpB/9O84U/9em90guuWu+QqN3WZEeApqGVORRoVcQJnRRB4XZGqCQ1NQmZofshjQ2X+VbZmTlnUNRQ0LRQwH/AZiCdCMtalFIjTJKLsRbNozK4UycbUeYLFuQw1TMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cZQ14Rtb; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id B605D1FF78;
	Tue, 05 May 2026 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777965607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fL32qZR4EjAXe3TAAd7RYHVKie8aNkXlAebWfVDPCMY=;
	b=cZQ14Rtb11tsmY5pOztp0q0o0oS4sFxL0TAEmP3R+NQgnWBzMZzZ86EMThVP/5aC2ugeO2
	UVhdX5uxuIUbiNexOXgurQbhQOi+aL5d7UXtA7gdYHhR56ZDANv5oVisSrh2CoPwhEepgr
	7HoM3xKLyl4mpQQ3IU0df279yhJGgLo=
From: Sven Eckelmann <sven@narfation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Joe Perches <joe@perches.com>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 09:20:03 +0200
Message-ID: <2313096.ZfL8zNpBrT@ripper>
In-Reply-To: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
References:
 <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <2262783.irdbgypaU6@sven-l14>
 <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5684451.29KlJPOoH8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 9304B4C7C9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	MISSING_TO(2.00)[];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284238-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,redhat.com,vger.kernel.org,lzu.edu.cn,gmail.com,perches.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,narfation.org:dkim]

--nextPart5684451.29KlJPOoH8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 09:20:03 +0200
Message-ID: <2313096.ZfL8zNpBrT@ripper>
In-Reply-To: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
MIME-Version: 1.0

On Tuesday, 5 May 2026 07:21:13 CEST Matthieu Baerts wrote:
[...]
> >>> Are you CCing netdev to get this reviewed by Sashiko?
> >>> Please don't..
> >>> We delegate code to sub-sub-systems to lower the patch volume :(
> >>>
> >>
> >> Because of `b4 prep --auto-to-cc`. Will now manually remove you.
> >
> > To speed up the discussion: @Konstantin, is there a way in b4 to say "stop at
> > the sub-sub-systems" when doing `b4 prep --auto-to-cc`? I am just trying to get the
> > `b4` workflow somehow working with the netdev requirements.
> 
> Maybe a new option could be added, but that seems difficult to guess
> where to stop, and to which subsystems to apply this.
> 
> Can you not simply omit using `b4 prep --auto-to-cc` when working
> with "internal" patches?

Yes, no, maybe :)
I will for the moment ignore the .b4-config part and talk about it at the end 
of the mail.

b4 is trying to (afaik) to have a good common work flow for kernel related 
projects (and more). Independent of my role (if I am the maintainer or just 
another contributor), it will nag before a send: "Hey, please run 
--auto-to-cc, --check, --check-deps before you submit this patch(set) - you 
know how embarrassing it is when you notice some obvious problem 2 seconds 
after the SMTP server accepted your mail."

And I agree with this and also try to convince people to try b4 because I 
think it is really helpful. Or at least ask them to use
`./scripts/get_maintainer.pl` and NOT send patches with the prefix "net" or 
"net-next" when it actually targets our tree. But as it turns out, these 
recommendation seem to have been wrong and I am sorry about this.

And I know, b4 is a good tool but adding a bazillion options just for every 
special case doesn't make a lot of sense and might make it a worse tool. I was 
therefore more thinking about `scripts/get_maintainer.pl`  (see `b4.send-auto-
cc-cmd`) which also called by b4 with various options to avoid adding too many 
people.

I don't say that any of these tools need to change. I am guessing more that I 
have to adjust something (MAINTAINERS, ...) to avoid that people are sending 
batman-adv sub-sub-system patches directly to netdev. I am just not aware of 
what this should be. But it sounds to me like there is at least a need for it 
(from the netdev maintainers perspective).

> On my side, that's what I'm doing. I added a .b4-config file with this
> content, not to have to specify --set-prefix nor --to:

Regarding the .b4-config - yes, this is helpful and I should add it to 
batctl.git. I was more thinking about the normal contributor to 
net/batman-adv/. Regardless of this person taking as base net/net-next.git or 
our repo.

The fixes from Ren Wei (and associates) and some other people were sent with 
"net" in the prefix, were Cc'ing netdev and didn't seem to use our tree as 
base. This is of course not correct and they should have targeted our tree 
instead. I didn't complain because the fix was otherwise extremely helpful and 
I though that there was no harm done. As it looks now, I should have and I am 
sorry for not communicating this.

And I am at the moment not sure how to fix this without overloading 
contributers with "when you are contributing to some sub-subsystem of netdev 
..., but when you are contributing to ext4, other rules apply .... don't 
forget about i2c rules for patch submission, ...".

But maybe I am just ignorant and this is already quite simple (and there are 
no special "netdev" rules) - I am just not aware of it. In this case, please 
point me in the right direction, just to avoid reproducing wrong 
recommendations to other people.

Regards,
	Sven
--nextPart5684451.29KlJPOoH8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafmaJAAKCRBND3cr0xT1
y5EVAQCL6cCO5uvV8uTUmhJ0tiNf07SLl6FS3xSUNi1VBKZbAgEAo1uRDmRptc+C
WXuyR9rM4H1zxEEq2TOrVCaHEOwRuAA=
=1OEj
-----END PGP SIGNATURE-----

--nextPart5684451.29KlJPOoH8--




