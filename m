Return-Path: <netdev+bounces-257647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GVJKGsMwhmmcKQQAu9opvQ
	(envelope-from <netdev+bounces-257647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:19:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43A101B2E
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 19:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0CF30177BD
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584E2F49F4;
	Fri,  6 Feb 2026 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhzZv/vQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382142F361F
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401984; cv=none; b=ep2QTs5e96EopNV1fD0lm8PCqcvEeBrEKsCeUVRHxMQxFkyatI9frIFR/mGtWyZ4WYWdHNmhdc2azc41jiKQpgdldHTlIUvWGiLovhO2LubV17Fqy55tIw3CzJKQ/mXNM5c8saaVnUH745T+tLVscuHCd5Rk0JmmqN/YbKXRUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401984; c=relaxed/simple;
	bh=ZyptoeOR7+PIBoOmJ66KxMLBGTfIwrDAliRP0PVPe4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np47IrfjKE0ipF/4Gld5wxf9qwLKxuS7RsitmKMvB3mwMOEEd5KkegWAr5l1ICwB6CLdFbStm1vr5r1XT82ASdOL6rS0rBG4GEvQzKSHqHiNxCOIrWivCvYOlKs7f7fC0LXSbnE/7mL5dDWLwRV5/tj5Af/VPM1XBJdxhvp4NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhzZv/vQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362c932df8so607436f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770401982; x=1771006782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf8vLkJA7oG60mSHAbKvIAWnm+k9FjfvvsXQ5lO7hH0=;
        b=XhzZv/vQFVzb0hYPL9LD9weBDTCP3dp4qxsdRYZx14M4q/05C05IQNXHxNOomZFqZ4
         YbWDQlX0dqFtue7LT5UfCkGps8fQy91CU+W5IELOZD8Rs6Z4JW8as8FpRZKJFRujAL9f
         N+rYo0uJgTr74o/QDPzXeSITq4HC5sM6pnywwpOifs6gW8O+xo9s6vpKzF9Z/2wP+5Dg
         16Bl/Ds7hBp9y0ev+zDvjudImkZc1I3uggY7kvUDaxEaPTy21aT6gu8q6gMqzTRDZPYr
         tsrvcukRAW/I1HisfeaXOYE5dECp/iGPJOnztJQDAJJNWwyzER4q3D2xoVHmLxY2as7y
         vtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770401982; x=1771006782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bf8vLkJA7oG60mSHAbKvIAWnm+k9FjfvvsXQ5lO7hH0=;
        b=mog08sh3NpksUxhYInxprv/qaAurWr1fmJn56u8jdoTBB8hAKzvSc2EFM4BumVm70J
         /uAxlOfqLm3c1T46OFQkJ/sEdP01mE53zDvZ9Ixt4tK7L/xKBRJJQUu4eToTjMiHKoWo
         +ZSrgd0BZN8yJcgJUrJjJTjfWkvuVsmZ9vY63+N2UJKzWKLf/f6jxz+9Jywla/dOhtrY
         Od8E1Fy4ogwhuLoyYB3tPWc0/xeYAWjlLdJS/lPT1Som4VRCf4E59lVwknZ136Zbfpmh
         ShBLhzLDF3MOrXDp7srMA71kaIr+ije7GJrMRPHfqzwWBFp+5YXZPKH3SlbK+h9u7KiX
         EYrw==
X-Forwarded-Encrypted: i=1; AJvYcCWZObfux8NS3v8wx4Cz9+N1WtIjf6VnRc9PTG6iDsbQzSfW++kJcS3NfFhDp0yJh+HAoRNcWLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotceKz4Mqh2aGg+xmsi6h/BPZxuO7tytYP6cipYricbHvTQDU
	zC4xt5L+0fGQZpdA3MPC8i2fv74gmF834SP9raY2yY2oA8XVymmINJc9
X-Gm-Gg: AZuq6aL0JFVwo+j6DGDcJi34j9nHlvZPrp1n7M/GrVT2i0X9DQGxm8gKqhW3wJn0yOt
	yLlzVX0a6jpptxhWUCXCB58WsvM12Q/YeTAF5soh0hgEpHAbEb8IZr6k1GlbRx2KM6Tn2Fc0ijF
	YvHpQtQxgkvxj7Qb9a+KxG6n2rwDWjv3DiYfa+gltuWExm0phQexs9NBzs9OrfEYbgSG5X8OU4Z
	Ebb49CpLOrVZckRaxCDlxCyGK2GrbuDsbS0nCbgHMSA5u18e1Us7VIdueeNhB9eE2AtlOUCxOoP
	+cjcz2ATcm6+G5aeCpKw5F6oLfxt5Vm3lCjw/vg/btlyIsNQ5K/AptBTgFcYVpOcwP++jVcfFZ7
	JYvCJP9GurDHXuSzDAnT/FvDbrMKh8Xv0Fg6/oQw0BRTA2haknwwJ+Lj04gr1n6fxrKDPkII0J7
	8Ih14NHRA6gp3hm+igrtq8lK5d7uK6mNFIXpxoZRRaAmQJ
X-Received: by 2002:a05:6000:1849:b0:435:a647:a3b8 with SMTP id ffacd0b85a97d-436293b3a2bmr6232106f8f.36.1770401982167;
        Fri, 06 Feb 2026 10:19:42 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629664632sm7345067f8f.0.2026.02.06.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 10:19:41 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4C63BBE2EE7; Fri, 06 Feb 2026 19:19:40 +0100 (CET)
Date: Fri, 6 Feb 2026 19:19:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jon Penn <jpenn@bentonvillek12.org>,
	Sabrina Dubroca <sd@queasysnail.net>, 1126499@bugs.debian.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
Message-ID: <aYYwvGbStTFvof4E@eldamar.lan>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
 <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257647-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eldamar.lan:mid]
X-Rspamd-Queue-Id: BA43A101B2E
X-Rspamd-Action: no action

Hi Antonio,

On Mon, Feb 02, 2026 at 09:26:16AM +0100, Antonio Quartulli wrote:
> On 01/02/2026 17:23, Salvatore Bonaccorso wrote:
> > Control: forwarded -1 https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan
> > 
> > Hi Antonio and all,
> > 
> > In Debian we got the following report from Jon Penn using ovpn,
> > reported at https://bugs.debian.org/1126499
> 
> Hi all,
> 
> Thanks a lot for the report!
> We have a fix for this issue in our pipe already - I'll forward it to net
> ASAP.

Do you have patch already which you would appreciate if Jon Penn could
test and maybe add a Tested-by or is that not needed at this point as
things setting already?

Regards,
Salvatore

