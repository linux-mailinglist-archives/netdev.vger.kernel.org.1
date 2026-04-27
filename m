Return-Path: <netdev+bounces-281438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L4+IPWm72mpDgEAu9opvQ
	(envelope-from <netdev+bounces-281438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3047847B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BDAA3074F6E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574243E6398;
	Mon, 27 Apr 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiKLCT+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AF328243
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313251; cv=pass; b=OiwoZhdBbEruxyRMvVK5SUHVwpwUdo9zhHehFWc2i5tCCZ9Awu9KsSWaxfRzewYqcAl9lL5Sl1EqeQb2ePEbZbFAQkm3bh9CQ2DCjj0A79sZ2JMsKwUniTIbaJzl3ZqHESd2ugGuY8BpPLVdMuFMAwy6Bnmc6Fng9dJQ4/pPHdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313251; c=relaxed/simple;
	bh=BctXO0XwXmOEKnMbMacAMYuXEIut1dU3hHVcre8CkYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UijKlHpDBrMA7s53Ud4UiCCaxrRAvA8fSNbmM8QbDCGCEdjTBU+duuhFn/OpTqZtBraU/3wlVjMIwyteTBYwKqGxVzImgr53128C4C1zyDuTHyCNL7siB4ly1jwYDRlZJI+hmSEE4mW0PZNzxn4wjXe3OA9vjLJo3Q8PesEyPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiKLCT+z; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso14647845a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777313248; cv=none;
        d=google.com; s=arc-20240605;
        b=Wsn3Y30GRVe8WUtQjGvKs94hdzz6OFP6CqjRJnAAuQK2Kpf5WVcw+X8HvT7PbxEvf+
         yUXWwBBeB7SdzPqFSRfA5094cQmQ0s2U3xaH61iwNoFtkzHHWVJS5c5RApBjdfnIHorE
         AGskl3M6WgUpbrIq4STH6cHxRA1znt3Wr5XF1ns8s2f9kIlUNe8+iommkQYI+dvQoDuk
         GqY8Op1WqM36vEiZIIn/GPvYu4enbyOOe04Pkt2q5kH1yboA0zOgN9XrlDJwtre3EE4D
         pl6Eb/yI8/Od6MXePfn3g5Ur81yMZrmMYgZJMf/xYFJXDb9TlniKVNpgBpatkf5gWqQY
         M0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BctXO0XwXmOEKnMbMacAMYuXEIut1dU3hHVcre8CkYs=;
        fh=7mYTX0A9Zft137EInx86/VIGDvpdlFo5DS0eXE+t4jo=;
        b=Ljecqa4rFZXLjtlG18tWAm0KEyDbyUxI5NqKJJm275IQLJkik+Z8U4Pv+FQYQ+2Hvm
         meq4Dm+cgI8kx1QcKTA9l2ztcH71ikaVNr+FS7W08OX+TkNImahpFi39RghJmTiwqbsA
         WS1ckGoAuNF6oQI3gKxO6UyukcTXAcC4cBHTvgu9O0fovNXCExkIAF5A03cM6UXD7sKs
         yg4Wwso2bLQMXhS9dHaBZSlMF556YDWPgQx2v7rWRIKhML/H1RZBT8H/ESkxvQS3Z/s8
         DAFKqaTMb36b9iBh0ELgaSBWBrEfR5rfY/OaSbiFozl+9imIt4AGyHwr2FL8rOKyPDXt
         cwUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777313248; x=1777918048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BctXO0XwXmOEKnMbMacAMYuXEIut1dU3hHVcre8CkYs=;
        b=RiKLCT+ztTQECqLQTBocc2A7JPsnWl+RaS4mvAdl1tRK+t3fmiJo1WaUC30cG7aRUi
         TVm++ql57vk6qYoEgpKP/WLqm39IjpyEwWinM6fzUrmWmE27e7seNwb/2w2nFmjKFi9L
         yvvXP36DBjAhv3QIP2FjAOLFTfEoZ5BQzYRAQYOuh3rL6QO33BLFfLdCZOWmuXQBzHWe
         XKLQ8WhbQmwY0QPKItknU96yITe+kI+pSPl9Q7aCqtc7kiVwXEP95i0G+z8OyscbXDOF
         wQIfpujf34yaLA3xCTXRAUSNUTlgbjTa1PFzn6AmAi2q2dPgSQsimH/uNXhT540XsLsO
         ezzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313248; x=1777918048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BctXO0XwXmOEKnMbMacAMYuXEIut1dU3hHVcre8CkYs=;
        b=AHu+Oq43/+9sHzCkq6E6jqkQ5U2nbIdsfNfo4uj+WfX4bDefUNwa6KLNYBN+1dqcpL
         c80NNAO8SFwPDpO9O7wPyUqfhXRYu2rC7DoBMaobOjfsNW5V2H5qVni4+eDJpgDlgT6Z
         CfVYnIzZkb+A/3A3nuJ5JIdJ2RFywsTiKUVa6CorripRw00hX5pjOgj9jYCkSwONr2jp
         mddiU8qypcNW0fV/8kwD+4N0fol6LU2TDrEnWpwvpue9UA7ofrVHxZyHJq9/SJAVrSjF
         z5+Ql2HHHGPDLucoVd0E7BKiUujpxnM1RKCMOGFQtrjNfz3aHFRzHAuV0dlMmPOiHGhO
         Rfdg==
X-Forwarded-Encrypted: i=1; AFNElJ8T+8s4X3c5+oD5PSS6YOFNScmSUSGLNGoatHTl6BV3kQXBMzVIL2iqHWKWU7RrnAsFMR3sdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJLgLT/aWuNqXU9XduIqsgODSgD8dUJaSpCQeTeWqk1mnZmDc
	dnMC9TBB8eoyMbIpq16apTxVdMQ6aK++d2lOy13zt1KQBVY4RS2yDHLcyGPemB34o3CMrINTntF
	3MYJY+sL7OaVH8uHDncB1J8MRXDxzjBs=
X-Gm-Gg: AeBDiesYgbZoajU2WJOPaAYdf/wwhENh/xKHVA+ubFy83eODacYsnXFw6d5JfanooRH
	OCM//Ld90yR4qx/+i2NgaOw3DOzy9UCLikn719Qh6HXhXsV0ZpHrT7U2F0+r4u06Z1j/HzpleDw
	aLtbQ+1Dpd1fplQMPhgSekD2L77cfTgA0rck21axhW02uOVDlOD9zwAZPbsf/u2Vfhkt3u/NqPF
	/mPayNOg8179m7mzvQ8lB6Fr4EuRR3d86T/oLcrbKlngNqFCV34lmS6mz/mjUGDxz4enXf/1JAQ
	GZH1OwMaMHeahlLTBrk=
X-Received: by 2002:a05:6402:b8b:b0:672:be92:e913 with SMTP id
 4fb4d7f45d1cf-679b6735df4mr120588a12.17.1777313247749; Mon, 27 Apr 2026
 11:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
 <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
 <CAD++jLkqcqUThJe+kJhR2hwyg1y_RWJc7yrM-kqMeiA4T-Jqig@mail.gmail.com> <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com>
In-Reply-To: <CAJq09z6O81Sev07pQiQzCXzbKC2JxBCjep6=tX2Noqd=pPW1KQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 27 Apr 2026 15:07:15 -0300
X-Gm-Features: AVHnY4IhJHKr-fUvf9JG6i9VWRxQFbnwvczqvFOpr6JFU5VtexK9iCd__hOGe5Y
Message-ID: <CAJq09z6PjXeDYhfo3=UmLyUhXyx5rPHCK4kBaMaJWNZNssjo2Q@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 13E3047847B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281438-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Linus,

> > I haven't yet wrapped my head around if the RTL8367 (no extra letters)
> > is more RTL8366RB-ish or more RTL8365MB-ish... take a look at the
> > old code if you can figure it out from register maps etc:
> > https://github.com/openwrt/openwrt/tree/main/target/linux/generic/files=
/drivers/net/phy
> > (maybe Gabor knows, put him on cc)

Regarding the RTL8367 (no extra letters), the RTL8367R is indeed a
member of that original family, rather than the "B" family as I
previously suggested. It uses Port 9 for the CPU, which is absent in
RTL8367B. Architecturally, it is definitely more RTL8365MB-ish.

The main challenge with the base RTL8367 is the lack of a public API.
Most vendors support it via binary managers (ASUS) or proprietary
kernel modules (TP-Link). The only available references I=E2=80=99ve found =
are
the OpenWrt swconfig driver you mentioned and some U-Boot
initialization code. I do have the rtl8367{b,c,d} APIs. While the
rtl8367b seems close to the original RTL8367, it has fewer ports. Does
anyone happen to have access to the original RTL8367 API
documentation?

In any case, I=E2=80=99ve successfully reverse-engineered the table access
functions and format, which are similar to the rtl8367b, to the point
where I have the rtl8365mb driver running on an RTL8367R. I also
managed to enable CPU tagging, and it is currently functional using
the rtl8_4 tag. The code still needs some cleanup, support for
additional features (like LEDs) and a lot of tests, but it=E2=80=99s lookin=
g
promising. Adding support for the RTL8367 variant should make adding
RTL8367B or RTL8367D support much easier in the future.

Regards,

Luiz

