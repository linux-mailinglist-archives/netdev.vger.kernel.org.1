Return-Path: <netdev+bounces-260588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC/3I4XQnWkaSQQAu9opvQ
	(envelope-from <netdev+bounces-260588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:23:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BF189C31
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BBB302BF61
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CBE3A63E7;
	Tue, 24 Feb 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfHhBxwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3E73A1E96
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950210; cv=pass; b=JYhBP+vF9gMbiA+b+Wfa8L1etyPiA8OdrOz7T0RKDdXFjunSICJVtxdXADmJeFFskW9+3eEyXbsaPj4HY1sqwXzV5qNTujQYbJDtvpqyou205OT0UzS6/CslsO/3IWKj+f3/KKHvuoTox6MzlNckPs+OEG6WAGVP929shMGToIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950210; c=relaxed/simple;
	bh=ZqJufl22SDOPAyHAbjNV+mtVnTAnC3F95iDjVkPYjsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQo/bf5kfp+4rdenPeqlms51w1ZZleJHFr3A5rwCB9MnQBOjsOf/KpfpP0t+CAG1D3RFe670zz6xFJtPNv/QQRO1IFGl0mlYQw/+1rPNDb9rL+Ko+J1pZ5IJP9GlFsHk4XC6DuaMl4RHOgnqW4hX5NT/8WQrLOUOMTmkwlTHd+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfHhBxwa; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bda3b4318dso271866eec.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950208; cv=none;
        d=google.com; s=arc-20240605;
        b=T9N8ZMALa3ed99dBU8W+x753fm0+v0wcee27WA+zlE6M3Ee0RUVz40Ck1c78It0L4G
         9u4P2cJt7N+umnNI8iJe3MaCcwiTZbLq4ladYs+N7wLqjzsJQ2C/C8iK06N67JlzRESh
         mY2gWj4aWF1Wpm0rxIks9PQ9ZatFU6ycmCCgexcJfC29jcsWTOit8esx5WTOUv+V5tlp
         fhopVVCgMzdHKttXtuK+te9QhLLtfWS+l7WOhEEs0QuIBza7HrrUjRF1bBkKbchSVD/k
         05eYVdsLZQG2pcZlymPnQDdQRlyAMSvXtxBkwHWCUptZ52wGXuRpXeqQrQQljVvjqtrF
         fQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqJufl22SDOPAyHAbjNV+mtVnTAnC3F95iDjVkPYjsc=;
        fh=1JI0VPul/uzv7Lii9zU89ToLHi5S93U/kTULOcCO2Fg=;
        b=jw0BgyitN9tsTZ8eJKlvmWriFutNTTwM/Lhqr9Kioxos8iUuHwlwYTg1pTmwlDsNCs
         cAMRnjXVvRixPS2vIUh9mewQjD6kYoGqd/X1ruzpeqril+lyZUSkpYcjvykpLRambIOp
         1G4Bj8Bb7W4HUmBe7xcKLQVjBDjWFZmpdOS9lQ2ONDpEUgJHbiFECAJFdS+Q/b4UAa/m
         lpRFlo2BcfC3M4PI+fJWD7t5V0xXgfART4h+56kU/Fsnkj3Dmc6Ru6PYwZ/5SkcuPhRS
         TDpwysjpd/8ur7femRn2eqe5Bt8QMXC3/GZ0mTEWepFSy0ufzZoKbyAfdMoXUqTrnoHv
         gyBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950208; x=1772555008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqJufl22SDOPAyHAbjNV+mtVnTAnC3F95iDjVkPYjsc=;
        b=NfHhBxwaHqxl4hP4LhBuPbhxDtmpiUFDuF5vJRhyFz5nkOHWcUGkUm5MX9wTLP0seS
         GJ8KrR/HdE1e8GbmYgRb02OmbqlXHHSdRM4WcXsysG7svjxujS5yIR2K9DqfRXtKORVb
         IU4/zVkixcIXv9DqCAYhKaQ7d3zdGMJAfNwCDvkvotzDm9yS3LlLkeY3BsxT5Bp2nOsf
         bmKZiBAO/cyIW6Y+sBWEDKvpaXzaixEvOyVU5AbZrbif99YUrZau0afZWmQiXKFuXZrr
         VrC8SELGZwndi17J9h79PV/iXdD39izMmg4yTxXleGzGtm5DtnpHZFzEvZ0EZje3h7YW
         Yk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950208; x=1772555008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqJufl22SDOPAyHAbjNV+mtVnTAnC3F95iDjVkPYjsc=;
        b=X/ScEJrLlpHz/qJGPEzWI0dkW4h3KyVQZrrqJZsSZZBArP+Ub26vt5rX00gq+9QpZ/
         wCoVusx5x2fT4iZ9mwp1wuUbdyt3jds7kCfYfKHVskWI+YxVQkcTWt4bizYbKD4b6XwC
         WqLRolfwGIDO6oOOOIHg+0Xnz6nBWe8Ow06f4mdEZ79zVuxhS3DH5a8uhVSF+dpJkfKM
         KeuVWCp+OXINxWCbqzJxHqSTZZLTiqBpcDL/Lwi4PppQWaiRQSNymWMR3V9KbS2Tbr4Y
         4t0sRR26YZ9ILd1x//DXU3+Lb2uByTPnEMFSO+wNviIpQ+/BH3IP36oUNXjf0VjSa5le
         /t/w==
X-Forwarded-Encrypted: i=1; AJvYcCULE9jgLrukMM7a7K2IoF6oU8o9C+76kqlw//G0voqmbrPib/mGfz6izMv6LxBdvvZg1hbBkyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/CCd0GDtylxXzMiZ0wXMnjGduVWgTMgTY8AmRq8e4huNaBRE
	6OMpC1sN2p3faKB5pxEwcGgV1t7JiuAQ8ERfPKftWvFDHLUiVWY1bnaGjPHwadl2pfHg59122fZ
	KHQ9T1VwhIUANxJ6bWf49/78s/ATlVtk=
X-Gm-Gg: ATEYQzxlG4w6HEzVHTbipB/EsCVPGLjXnoC9jhn6KhlTLEp6iiWunW3MSBQb1DPD6sP
	bcMPkkchEvb3VhGmcQuKrz2L0CXWZ93KDbM5U/4liAFFAPqcl50Xjp59TK6ST6GKOH6g8LEY9Pa
	pPDgbj00I9CmvY8GKLP3FvdaBdJWPr+Sma6bdhjWV/mAOAcTTc6LLoioEATCox7qobUldAAMrJh
	QvHl1JQQ8Bu++BSfTQ8F1XjFXWbxf3JfK0u8gNRbqrDNW3ZXdSbvpKxmltkUwU/WwhT/PKmPMPH
	VE4YTJMnZJaqtCb6jSqXRM+R5SzWZfPYm6uJGswpjt7Qev0n/4P7D2pmmhLFeirjFKmiR8ZjLLW
	fedTQHRCNuwVXlE0+OMdV/xS+aJRl
X-Received: by 2002:a05:7300:dc8e:b0:2ba:7013:2b94 with SMTP id
 5a478bee46e88-2bd7bd5a668mr2692037eec.4.1771950207813; Tue, 24 Feb 2026
 08:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223220504.2102-1-iprintercanon@gmail.com> <20260224043211.1747-1-iprintercanon@gmail.com>
In-Reply-To: <20260224043211.1747-1-iprintercanon@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Feb 2026 17:23:15 +0100
X-Gm-Features: AaiRm53w0bVWON5EvGEnE-QSWW26Y5D2UjioC8X6mMuMoDlaoNudcBlKEg6cgtQ
Message-ID: <CANiq72n9=xwb+HVkSDc9+6HGQA0-vw46OUHJ5PouhGgiFbcYBA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: phy: add Rust reference driver for ET1011C
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Russell King <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260588-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F6BF189C31
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 5:32=E2=80=AFAM Artem Lytkin <iprintercanon@gmail.c=
om> wrote:
>
> This series adds a Rust reference driver for the LSI ET1011C PHY,
> following the pattern established by the existing Rust Asix PHY driver
> (ax88796b_rust.rs).

It is great to see more Rust code, and I am glad the "Rust reference
driver" model is useful here. But reference drivers, in principle, are
meant to bootstrap the abstractions and so on. The cover letter says
"following the pattern established", but the idea is not to duplicate
every C driver.

Since there is already a PHY one, is this meant to bootstrap the two
new APIs? Or something else?

Of course, it is up to the maintainers, i.e. if they want/need to have
more reference drivers, that is great. But I think it would be good to
clarify.

Thanks!

Cheers,
Miguel

