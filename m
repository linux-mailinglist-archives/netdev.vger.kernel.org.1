Return-Path: <netdev+bounces-258499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNuqFr43jmkyBAEAu9opvQ
	(envelope-from <netdev+bounces-258499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3037130F18
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8033034B25
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A9630DEA0;
	Thu, 12 Feb 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxL4nfmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC52FE563
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928059; cv=none; b=dRP+B8IZmhMz5cYimvWZe8o1UdsPCdeuiwMgKQ0ID2mQEPOjy1je86qGrX7NBL39pv5Yw9rFgKHdvIZhYAPhrFTfEDcGCmNvZGdaE6a2ZQeHF1pGRCxoZ1sF2v4Xf75iHs/xjyJo92Z3G2R82KnPQRqg9zalr3nNM3ClF58/4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928059; c=relaxed/simple;
	bh=J4Y5Jn+w9Ak/XRIwt0mRrwcfv2Qb0Cu96Q/t7iDLWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8dJF22T+TddwGg0/peqCW+GQuPlU5HZT5kndd2qo+Ry7LVucinULfc6pEeE6+PCPJJCaci+lfE9bNXDFNZNDpcQjgwWrY6iSiqeC6KWfwMRCwEca7I+LjEoan89+F6PPGa0LPgXJo7ytXTZrcYuaQcbBhN7V7WfhEYMkUHk5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxL4nfmU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43590777e22so167708f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770928057; x=1771532857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riAIkwRPK1ClY6t6QyRKnEm0O30sm+ttRS6W/MFrtOU=;
        b=kxL4nfmU7rI4fOeCdfV0PKA0ijdrJgkBn2YKps0YlfgD71r6y7QiU9j8JlFs/cwesI
         cHap8TM7IAeH5gYow68QrqD8Z/qEfYbawXMvG5hFhUvyEKqnwuqT8POa+5VeJk79g0gN
         JqZN1gEla/ngV1m4PncGk9r66gu/hmhxc4wkyEYAuavAZxaS4TOeEotVqeg1OnpbFa7Q
         /SEngrwIlkEs9hd5pXn7IkI6460SKDPNxlOoU8J5KKuI2wliwUX5xa3vipXVKDr6X9of
         ticrwG9fM1icLcyqFU3U2SyJ8NfTLFG2kLxEW5vRyLIOC3EZoI/ktzICWM6fe9791kzD
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770928057; x=1771532857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=riAIkwRPK1ClY6t6QyRKnEm0O30sm+ttRS6W/MFrtOU=;
        b=kTIgiscXbcCwOILeetqw0iX/whSZXbJ0TjStD9QnDGjxYXZc81Of3mlcUwehSpyv6g
         prRr2y6UrkhERZYNETjpjbG43z34ALF6E/WhRpZNl2oY7q0dTnIwgd7wPM1C0DPWMJ/p
         1chsD3Pz5KuaHmnUQ033avOrQKGgdza6NnbfmNvmObfxHNL5Ll/uln0Bn3IdEzhIZNFP
         V8ZARWEw5AApXADQyLqjPTIQ47v808HywGz0NXRdjkLHJZJ07ZAu3zCMggaJyttvQKEx
         Yih1mBMWxBl3G/+ankFVseFGCM6lJLPIahQNQiuNO3mdRBcP8mdxJkUerfdHndEDrYke
         ERmg==
X-Forwarded-Encrypted: i=1; AJvYcCXzNn2tz8CSqdYLYSIo3w7zTvH02HNJZrFEfGlMBk79sPt2RNpivUBFZOQtHlAdmqfGMe9LX4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoydG+VvfHlno30hsmfkvImen6+uLqCP7bSIFxXLP31PNrqkb7
	/hYMOLY7QrDwSRknbCik6Yimq0gDiXGFs854D0pykaWnr21ckzbOP0zZ
X-Gm-Gg: AZuq6aL2cBPFnPp1gv45rz25OjHvxCz7oQvu8t3RRchybA+5rsDC3I7dhIoc3ysv5rQ
	cQwctwwN0Jv82feRbAvz7d9P1Ks8kRDI84Lb+8lg+/oYSQ64roPlrtBj1G5N63iL3DymK5tpx6R
	qEHe1HiY3hcRZOjVAZtazkJiqAIpRkV8WjyN85JR3WNuCAvYBsj6ew0gIfOmDWPgVjwog13duSv
	QaudetVCr9nLYhOapolhd0weuxdtFkVvKToo1c5NxrjfRjWLwIDPrCmGG5dHb2gTfzoFnSxGtw+
	L+1uNTz5CqaH4t+LUkrhJMmDXzUJpYcdooTtuqnl/MzPAcIPUsP3PX91yrxvI3AyniqcK1WXWh8
	qROrzpHplVtCp/qleuDbAnsIkQoJqE609FdjYObkfq5wd83as2nni6HNaoRlPLYbj5WqLbYJK0p
	PrSLkgDsVhRQkSK51JE6VPXwtuVPVsdO1n5/pBDTMyazYv9PjGTqVg/qu8
X-Received: by 2002:a05:6000:2c10:b0:435:b068:d3be with SMTP id ffacd0b85a97d-43796ad6e74mr333255f8f.41.1770928056296;
        Thu, 12 Feb 2026 12:27:36 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac92sm441784f8f.1.2026.02.12.12.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:27:35 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 287BCBE2DE0; Thu, 12 Feb 2026 21:27:34 +0100 (CET)
Date: Thu, 12 Feb 2026 21:27:33 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jon Penn <jpenn@bentonvillek12.org>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>, 1126499@bugs.debian.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
Message-ID: <aY43tezcIO5DDE2B@eldamar.lan>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
 <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
 <aYYwvGbStTFvof4E@eldamar.lan>
 <9d240ea8-7e55-4be2-b99b-3f2657c5f8c8@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d240ea8-7e55-4be2-b99b-3f2657c5f8c8@openvpn.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eldamar.lan:mid]
X-Rspamd-Queue-Id: B3037130F18
X-Rspamd-Action: no action

Hi Jon,

On Fri, Feb 06, 2026 at 09:06:35PM +0100, Antonio Quartulli wrote:
> Hi Salvatore,
> 
> On 06/02/2026 19:19, Salvatore Bonaccorso wrote:
> > Hi Antonio,
> > 
> > On Mon, Feb 02, 2026 at 09:26:16AM +0100, Antonio Quartulli wrote:
> > > On 01/02/2026 17:23, Salvatore Bonaccorso wrote:
> > > > Control: forwarded -1 https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan
> > > > 
> > > > Hi Antonio and all,
> > > > 
> > > > In Debian we got the following report from Jon Penn using ovpn,
> > > > reported at https://bugs.debian.org/1126499
> > > 
> > > Hi all,
> > > 
> > > Thanks a lot for the report!
> > > We have a fix for this issue in our pipe already - I'll forward it to net
> > > ASAP.
> > 
> > Do you have patch already which you would appreciate if Jon Penn could
> > test and maybe add a Tested-by or is that not needed at this point as
> > things setting already?
> 
> This is the patch:
> 
> https://patchwork.openvpn.net/project/openvpn2/patch/20260202132309.567382-1-ralf@mandelbit.com/
> 
> Jon can definitely test the patch and give us his feedback.
> 
> However, being this part of the code very critical for socket handling, I am
> still spending some time with Ralf and Sabrina to make sure we are not
> introducing any subtle bug/side effect.
> 
> In any case, please feel free to test so we can confirm that the problem you
> reported is truly the same as the one we were already investigating.

Jon, were you able to test the patch referenced above by Antonio and
can you so confirm it fixes the issue for you as well?

Regards,
Salvatore

