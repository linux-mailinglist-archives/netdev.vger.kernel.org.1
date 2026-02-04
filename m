Return-Path: <netdev+bounces-256546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP/oD6nBgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:48:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2293E15CC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE8A30073E3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B022C11FA;
	Wed,  4 Feb 2026 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWo51G/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B11E86E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176934; cv=pass; b=LDKdcXOZbCGRjuKLE4+zuuNi95zdLMsUTXlfsljLg3sXbG3soKoO1L7YnvqDK+VICghmYKZXeefBDhs04K2D1fdCvvxddXwbHQ1lthYL9mlHjaBGkRwn8oloId5dXOpyeLrYzZI1HrYcNX7e18EQyURPhMwYOF6Dq9Hfl0CcMXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176934; c=relaxed/simple;
	bh=uLLMBWLIDDT5SqH7t36Vle/i0dDcCJNJBxb7YsvANDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrneGex5NTv7TjU6T9gAdirZdBR0zzt2CxTUG+d/5eX0AHYiU1Ph0t1aUB5XAPf0AqRzoILWowEvCyp5ZvgEdmf+SyZhXNcHuyo4C62Aa/cLsVV+7Nnkx0pn1V11HPBL5oQ0Yhjz46hPhs0MlW6Q7XT2FmN94PTdW+VkQfNrmaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWo51G/m; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-89469143ebcso56964496d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770176932; cv=none;
        d=google.com; s=arc-20240605;
        b=gz/h4RetXw1NrpClmhbEe1wOv6z0ph3hzGW949rcTF0H1mGp6oyqX2sw20QUZFiblB
         rt5SBz6yebE/0KHadXTVTMBceaD481aFlbS8JFPHfOdfE0lx96T9BSt+/YijFOOIhwIZ
         PFBJG1phJ2KlELiwQn1wWVh7Twr4vkcvImNIDDtNcDBV/gfhsuk9fkQdjdS63jAk+78x
         droYTwv0xx81ndeiSGm5TTWKkgk2HACigmESvr70rCo0LZJQ2JYA/GA2LAusE0BWiBNO
         imKeJ16SsURkt6eUPcmJ75GjVmkOXVgUk2nHOMJODfxUhT+x+/qrPPeUvKPokeVeTqJP
         cHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uLLMBWLIDDT5SqH7t36Vle/i0dDcCJNJBxb7YsvANDI=;
        fh=upRh+IWAyOUrJ72rL7/yl/BSThx7bXVy+MwbdnEwyW8=;
        b=E8MQKX85J0QUXkz6DZlZ1oCJaVVk9oKDwIecpOGO32s/CzXAC9/7wj20W9p3jzfEOj
         7qCN2imhCtEUUdGx7RbUYzTDAVV4aLtUZDZPDDE1+g0mLsdGIPgEPH7cVE8LZtPGd68l
         3hryKsCRQNNMi4LxIHC8o2agSKSF+iUjN8Qgwbvktiq91EkVtEFPG+RFC8K7+cyOYeLp
         ARRjUIWLNVKY6AxyeEqfSBa86eP0TXn0pwFSfWq4YwnZrfg6AN+4VpACCyYg5L8d+BU4
         Ba6NXhGj0uBadXLEI71qA8gTBgHsyBdBiNZuUUnuhilZyhl9E/p9+uiDuE3Kr9AZaxtf
         CdnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770176932; x=1770781732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLLMBWLIDDT5SqH7t36Vle/i0dDcCJNJBxb7YsvANDI=;
        b=mWo51G/mDAY20nn1T4MJRp1jd0G5acwgYarmAzAA5RORz3oROyOseodYSfROtg7jGJ
         iC3oHoQTE7CcWy3/L2j5ZbArTxNQB4RKpcpWHwwYgr2v9+KK0LUxhqwl0imO/+dfok1U
         48CPei+UqBQxYui1r0QjnVdkdsAasIej0CD4/mZaprPylw+uRnOEslQ4wMQB/uSCMpWQ
         eZle+bRfvxLivYg6UYwa4ixVd5URNGTLvG21ZpZVNw/DNutUVMBseiPCfcRwgzVQGtjA
         fTboTRi/edJtV6CAZIhvEZ8t+A4KPEfEcksf7brNvR/UsKYs1107PJG9TKn6h5YKULN9
         v3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770176932; x=1770781732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLLMBWLIDDT5SqH7t36Vle/i0dDcCJNJBxb7YsvANDI=;
        b=P3RT1BABOIEkoOcn+CqlNnzCEPQ9HHJ21fp19QKTYu96uqqTwoiCRCT0YAkmdUlcey
         +rHDRXfRkOD81MydMJvrnsmpB7Je3Zdmn3yakWpf3ttfmifZkh45HP9uhqfNV8UgPOey
         XJCC5QZf+zubmDNfBjJEgO+TuavlRoTrtVzk2/BSRLT53VaBLBN0chka8tJsyNbreUBT
         tXUVofIShnuZsy/EzDrj+kJ45f7J+es4B5Akh92uRHa5rFQMmChG8RhgOQoPa9+9rTAd
         xTZ8BgB+iMnnhNk9xZGMWKJm6WobFZXyzV/ayj9yDg+QBBKWibM3FFz21c+Q9sERwqWu
         u1xw==
X-Forwarded-Encrypted: i=1; AJvYcCWycHNhc1nFw7g5poDvR7le80SbRTxs6VfIRq/YHX9cRhExsWhS/IxJaDrJ9hdep5dmPyouzcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVmSu90Ck6eIpxbaZxMe/+m+zJYvnVCYk/ggLONJcFFY00NbJ
	lr3FFUqf5I9jOH/1hXTqT+Zep9BvziAYWxU1TLDI6QQz2WpDeR74d+RNvYUpYtPV82h6GMLZFqG
	F2nDzEVuogiDiS+i3qq//wx69h/cL7EE=
X-Gm-Gg: AZuq6aKgNrRvK6GLhVBDom94SgZSCbHW4JGPNJ3dnJNEAWyNWSZIsDej0UtuCgMGAAH
	NLVPJ1PH/lDSxULYYGO2OQ4kJ4D3xo7wsXr101Oz2WxRj1fYmN0vc0tBdf2xMhcTZmxPLmm3G4r
	ecUgJOI08ftfk/LU+Pr1Vz57Eo/fjs7kAvLE4cxzQsP6mcYGWb9qkQi6Iypkb03wZU04sYwSXpH
	DSZwoLmSQnEzS/cwIIyY4sGQV815UU80tVhkz03BQwIGldCDJU8iC/aF0TTDmSN3u2uZy6goiL0
	73j1AB3qsOOcRsCob8AwzgxpadlRugvvgoiQl+JoFq7b8RO4+e5PwSrVqJRsv+S04e4=
X-Received: by 2002:a05:6214:1bc5:b0:880:1be2:82d4 with SMTP id
 6a1803df08f44-89522119a79mr23496026d6.26.1770176932276; Tue, 03 Feb 2026
 19:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203013517.26170-1-enelsonmoore@gmail.com>
 <aYGw80IvE0TG7WOx@smile.fi.intel.com> <CADkSEUgmX1tk-qJ7ee=P3EYcvriW91nVJZ6AFDpVEVjj7O8pJg@mail.gmail.com>
 <aYHEplTvRrfhCRQu@smile.fi.intel.com>
In-Reply-To: <aYHEplTvRrfhCRQu@smile.fi.intel.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 19:48:41 -0800
X-Gm-Features: AZwV_QgYJisyZb-ild0a9N_26R6AL-RAurLEwPs-lXJwQCftr7xNpwqmfzaHQyY
Message-ID: <CADkSEUjackVDC4+rti_V4XxjZ18YkD_6jdx7vKKkjRErExG0kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Steve Glendinning <steve.glendinning@shawell.net>, 
	Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Max Schulze <max.schulze@online.de>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256546-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B2293E15CC
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 1:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> I'm not sure. This makes it harder to read for no benefit. All non-static
> functions are part of the API.
While I can't fault your reasoning, respectfully, I think that
removing "extern" would just be pointless code churn.

Ethan

