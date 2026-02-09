Return-Path: <netdev+bounces-257965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gERYBtwUimlrGAAAu9opvQ
	(envelope-from <netdev+bounces-257965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1270112E2D
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 972173001319
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51B1FE44B;
	Mon,  9 Feb 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OMMtwfPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485381DE2C9
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656985; cv=pass; b=GAxErVUCm0ffDEWR+G55wsc4vXnVEacYZ9n9R4eP2cOHqdL0HCZLeoUedWPj/aNLsGEgXxu+2c/xO3fXxhKGXMarhHFPV37r/Jei+eXMPanpyFZxYNu5E9NzHmp/jH54e1jUyxD7s7IYzxd3mvtFDHikuUVsaaWZmuaFGJ/oDjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656985; c=relaxed/simple;
	bh=JFlifGuVFCLnYdGOZ6pZKybsaMV8im6ar4/2XY72zYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0+fT+EmqCoDtuAjc5DT5xlU1/CUlYfbASx0D6rXpjS8kRInAciR1NO1YJDXKDt3ghZ2J/fVj8PfwCLzWSwwR7w9OaHoe/3pvOiLwlIYKAKrdPgZOWdzso/bYhgHO+dqqR1bULAhEissqo1q9gHUq+aP5/WRmwTZ5hFfWrPWlME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OMMtwfPx; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6de0527ce1so1213205a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 09:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770656984; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtWjuuEeCH/MWRelmPRiQ5igu69ZjW1SBWvjGMkyTyS3+2KwnylwDlHkYi1UXdp6i/
         0nGLd2Zttl8WdrHrzJC3dwfZsqpW3QdsGQZPCW8J7ZLatSjZqY0dRiZG4fNGx8BbzYzr
         XbdCvRKhAlOqDBIPPepelCp/r+87QAl23idm8GQYhbN4p6sXaoV2LNP0bHyoaWWUGMKR
         hmXEYKnxe40Cqrtiu0AP8KOF/9w9FNVfyj3yRAdtzAHHPxqFIjkpsZ/Wws2hXf0Bw+zA
         atdEDqQ63xiTrQ6vS6hBXLlMODM+uST7skkTTHhqINpAN0Jzx0nnc1ERj3PE2dmrEOmo
         SUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        fh=ZtJO7kpycYdAJ3FKqMuERPRJ64n5ocEx6/t/XkT4cYM=;
        b=CePJz1eUMlhTUyJYQ56RUvxRGyTQd8cnLzM8PAxlO8gGjeG6LtNmE4AJPNOc0BrZM/
         N1OKdytv7Ky6RvSjlMSUEr0wNiTIR06bbT+j/s1fAnZJZnZ/fXPD5CXbG1bTHVqhD9Ov
         iUFpGju1JcuMrf2ZURbh7Aqjf6ec0lJr05JNct/A4xRIjEk5DYAOmvuWA6NluTE6UQmR
         88/Q5h6nuUfFfqd4nn0g/ldSkVqAjind0HfPfD7azawPRnfpjqgEHecUrZBkpCbrlv/i
         GJMGVA+FHcDV3eYkZ67tivnoyR/X012cWMvPn2gxrPJg/t7ldtrRwL6cYaLj4BBzEdAU
         zevA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770656984; x=1771261784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        b=OMMtwfPxokmIr4erA9uXa5IKJDMvVqCvYFMlrdd/P+VSxURw0Xfq7lcG0p5VbeL+8h
         dJcB7yISXoad+q10Oe+si7KDnBAHModISOIzzonFbKA2AqaGX12jRb14GsKqiraMPGrQ
         /x24vEQnFBtd9gMHBCrc56Koj8g4ubeSfUEPYHsNEOdFnblPfVXoCVQBPHzH0kJg4EWP
         8zKuxiPpR6Y16e3Giw8LCgwkS0X3ZUWZtNw02mCy9pBAc2oV2Uhp1S/1HUTBxSFO/hXo
         5MyvgqbzMeUJ26/yxQvcKPSEOZx8DgL40aMYbAWBBzesMcz7x7NKFCtBPileo5etWq1+
         dFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656984; x=1771261784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        b=KrEn3/yrbXVQSEAtPMAHQR2/iS7QUea+LZDCVfMew0tcLLb1jZdRFtWbMLy3Jk3/9w
         +KIJNzY3a1KkZVyumYPwpZ3YaB0AUNUSqSXZ3KiO2Y3stRoeGF2KtXBSTAt0q6u+lhXR
         CPR8qyxBceRPk4DJOjdHse8ervkoavZejkMDIURMAbTMNnmP4t+pJtl3ED9yePyEKp8I
         7+HDbzWdCdibE0Sv9Mw3AzcPfH7s58xjwyMCgar80zj1UkwmlwTMQBboZYRgChf4baCG
         RfRLUmSprOoVTqEoJWWZa2I1Nvj06oXYZ153Jw1qUgTuLl+O55nds9RRQWvscDI5FdtK
         c9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLs3H8aCO9W33t227J8m2vgo+pPcLxK8ak/PkxFnmIJANg/MJahnjSS2Nl2yPKFq5worZNY0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1y91uEPlE18s1sBmhfdxRcnB6VrEnzD752ZZp6VpZTXdDx8R9
	0n1iyL5vN2R1a9SxEWN+uRJNEXj45iLp2thSlN0aDK0hDYSJLXFCavfY4TMJaYrEStDAZUzaSlf
	O24DNMXk96/HP0w8rOxoRnotMbvSadTiNtclPBW2p
X-Gm-Gg: AZuq6aKtLYNr4awv+vvSn3f8kxQ0l2v0WXZRq1fjtx6w9r5ZdK5hv9AuLkM82DGT3Yd
	qlrq8xd4ckwSM6FKodwMXFYrpR7o09JXsZgldA+y8+/IKdwqhLrIKAwtvia3Tz6Tq1wI5K2Ydbb
	G6CRwQSF4DcuZv+4laItuDP4qQKl6EMW1bUrxQ18rfC4poXWirc76c1XlE/4WGs4yoc626zObkZ
	Uo7D3mzMeDJGdie3C+INQuGoioCRIOIqZDfO1x2B5hsNojSkaoaOUkY+YkJGjw2BWy3wqAZJLHk
	Xki9ng==
X-Received: by 2002:a05:6a20:4393:b0:38b:dd94:936d with SMTP id
 adf61e73a8af0-393acff6da0mr10644453637.21.1770656984440; Mon, 09 Feb 2026
 09:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119203457.97676-2-gnoack3000@gmail.com> <20260119203457.97676-4-gnoack3000@gmail.com>
 <aYMenaSmBkAsFowd@google.com>
In-Reply-To: <aYMenaSmBkAsFowd@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Feb 2026 12:09:32 -0500
X-Gm-Features: AZwV_QgXAhkJahS5lX2x7F9Z3bi4SFggQTKqzh3gTIRBGye7w374wNJUHDc47-8
Message-ID: <CAHC9VhQvsdmzQcQwpFeHnspySPe3GbwXMMo5tBB2rQzUneO4FQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lsm: Add hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, Tingmao Wang <m@maowtm.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257965-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,canonical.com,maowtm.org,digikod.net,namei.org,hallyn.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Queue-Id: B1270112E2D
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 5:25=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Paul:
>
> You have previously said that you would like hooks to be generic and
> ideally reflect the arguments of the same function that they are
> called from [3].

To clarify, I didn't say that it is generally ideal for the LSM hook
to reflect the arguments of the calling function; while that might be
a good starting point, we have plenty of examples where that is not
desirable.  In this particular case I said it seems like it would be a
good idea to pass the "type" and "flags" parameters from the caller to
the LSM hook.

> Q: Would it be acceptable to change the hook arguments, if we can then
> avoid passing additional data between hooks through that side-storage?

If you're passing the sock, I think we can skip passing the type,
however, I could envision someone wanting the path in addition to just
the sock, but let's wait to hear back from the AppArmor folks.

--=20
paul-moore.com

