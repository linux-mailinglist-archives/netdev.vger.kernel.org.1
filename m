Return-Path: <netdev+bounces-305134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3TNEIYzYS2pYbQEAu9opvQ
	(envelope-from <netdev+bounces-305134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:32:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EE77134FD
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pKYVNxOv;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305134-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305134-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5800031278F2
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC639EF20;
	Mon,  6 Jul 2026 16:08:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34EE4014A5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:08:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354108; cv=pass; b=Qyt7dMUztA/6b+RwR5Y5ex5ElKcXwo+TQTvQRzFt//IfhdgFWCLTIcO44SWQiIVotMvZ+McPiqFwKJowgXt7LzMoHMvRsFYXSYXisxWY0XFYEQbgOOC7JuhT4ENKXaXbtLIVpCszxV0kvYQwmi9h61zdYMQWLM55zNC7oBDqbDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354108; c=relaxed/simple;
	bh=/pcx26yWnumVx7kvmlQ1tjZLX4dp/hJE1UQTW/08s3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1j2jLlHlZEVbo4qcOlcbyF+dVuupTsBCVrs2Ds6vplZbAxl0917/ItZ0kY5V8kKELVA0sllS0zZ/hY53/iPqIhPtg6Qu/KYJpOW7hQPEBIO7Ou0HY2R9KQydNhb3uZfod3bGZbn0lWxQBZe0seV3OlGLuDMOhjke/vtXufcFw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKYVNxOv; arc=pass smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-380f3c1b087so236491a91.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783354106; cv=none;
        d=google.com; s=arc-20260327;
        b=bZOjz0d5lerRFkMj3o7w8GGEfYCrFsCwibHqoYHTVS+O5mSMMSIjy1gsXvOx16FwM/
         LQ20p6epKQYoIYY1FAkjDGCnFI+/StrMzyRwQ1iCDS/pr+Br5Osbfe6ZYb1Swl/ke7or
         OGlRLYY9Mn1MPIIIrdJaLQ0+hIh/1R2Y56Ny/5DtP1l7jbKBkJ7Mnf/bxpqpYNjDb+U7
         zdLyhqZEqMfFJKydpLbk5qOowGgN9DwXFGxSQevVpC9iD/edRhfVJ3SOn8dQUL4X26F7
         T6oJtQJDoqz7lSNYJvoMU5kZKm3SAwPM4lCXvKNJj6Itb6bru34lc1BgyfznhebfP5Y8
         mHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AoVUa+xESZdLy2HdVHs5BYMFE3jPA/o/dkMFEG3S7gE=;
        fh=/jNq4QdmlUn/EdZCW1jynhF2aHgBlJz6Ocz++E50Nig=;
        b=D4fgwcD3Iwd0IO7fjh88axKtdkq4LyQQvsXwnQWDwFo35QGZNjeRAMjREUapt09Y+Y
         LWMpe6jGOIpaPTcWHb7qAQaTFBnnOnETcGKUofVat/g6ZgpQ8JMMXTr+pbfx8/ilAziP
         7yLVH6lA5ir5eE9/G3bfLumqr3GwM/3e3FitFefS5TJwFNNboKWeVHjUSswb395tT9vr
         GUlGDP0H7fzrv4phOGATAB1FseqlGCKEBC0sfd+U9pB2T/josjytw5Qop2a3WqkCjRpN
         c9yoqkBBOyDtwybBK1aEYL/iCFWUnKBc44IFJcAoAXcREADlUPFN834lIiF12JoJMd6r
         bg4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783354106; x=1783958906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AoVUa+xESZdLy2HdVHs5BYMFE3jPA/o/dkMFEG3S7gE=;
        b=pKYVNxOvc6quWOgMSwTscwMPsrz4xsQPSkK936SenxfKWROmEiJBacNZGNBiSg+NoH
         AUwK/T7n0/HPI/3DVVIUfl92biUNT+GrTowCmVPDUaT9Ax2aiW3sEsOO5voQImNSUcsE
         ZTobhKAhDhIy6ibKxPMiQPnxS9yWozCbdUO3l0Hp4muNbs8xiY73scCac8tGD+Mzwl1S
         aN7Jp7xxHl+IZEMtu3OwnSmZoqfeHiG2pNf3daAaAeUJHO/ehDqKjjiJbDQP6KpZNtLH
         VrkM9UO74p+E8KvV7QntukMbw7GBmc+WtlapnWgvTqoRg8Qxk9di2+wT36p/z9r00tlE
         M4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354106; x=1783958906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoVUa+xESZdLy2HdVHs5BYMFE3jPA/o/dkMFEG3S7gE=;
        b=Xf8LGlOaprSctRpVWh/dgOzcSbC3P0gHWcIzsM4zfSx2WZNFd5j6wL84bareIlxvz2
         VBhfDzeAPvhih6ft6KBIkfC+bRcb8qvq5bScEZvQjog7vYDh8nmhuyA847CRn85M3WNk
         dJnzFGlZDnmCXtqHGrBYf57n/T+PXSZorHzbwrOHODU75FmvwxyhqyD4ZsaPCuik5wxS
         DZcZdSox+Aj1cAUMQUTyi59v8/k3J8LQubXDGtZI7PuskhPsS51PDiojiC5wTINEdhk9
         5DSWYWxqw0Ir0i/OpK/RoYTkQTIFwitGyw/2wonYzjpeLDTCYgGeBQ6QDZ9BYJUV2fZK
         ct/A==
X-Forwarded-Encrypted: i=1; AHgh+RpLI7DC/PrpQQuQWJzKECk9WA1qXURiIJmD70ZRtnqwKiEslJaLCStKks7Zq8C+tSZtRWUeFFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlHsEOyvU5TSq0m5Hei08RwoznF2rRd56YOSmZg9aNcYO/wbw
	bng1YCF27j7jenCT2GJ65aqRJazqjcQn9/TpZhXist6tFEZcnvJ/KaHyOcNiFSGefSyANA8KlEK
	iFoGYw6f8CqdoOEEHYZnliDTTVqiOrpw=
X-Gm-Gg: AfdE7ckTsHSbMJ4lwwFJOEAnYTXbvN7b3CM16b6axFUK7k0V2Gb1LqhtG0mcfmAobrE
	ZlBhpAGv974Wh6Hd4Atxwr+lSkNO6cwetXkPiy2JswNCqdA9zP66hBj3roJeoclP1l/XCUweWO9
	rr1F3LMqcJPSHe/9s5JoQcGR1tdte8LoutFMJ7lpFvbIVt1MGUx4K+d/7kh0/c/9iCjkbkys8cQ
	Bmcqo2ck5H+W2zU240lD2G5IwPLyDl8uj90AchuvKYpqQnCRQveQkHFj32ntiO3eJq1uLlSDK9W
	5sq91juHtUSzL8+RjabrVo82khMWH9dJwoJmeoNkM3+SjU0qkgGV4wvCcCVtc/ns1lQfHPbv9YB
	j2D6yYS/g6E7RI50ppmGXnp0=
X-Received: by 2002:a17:90a:e703:b0:37f:fc3a:382d with SMTP id
 98e67ed59e1d1-3829f4f05f3mr6252856a91.6.1783354106006; Mon, 06 Jul 2026
 09:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev> <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
 <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net> <c1d24c8b-1c1d-4784-88a6-3cbb519d0406@lunn.ch>
In-Reply-To: <c1d24c8b-1c1d-4784-88a6-3cbb519d0406@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Jul 2026 18:08:12 +0200
X-Gm-Features: AVVi8CdBSCoos-8Xf_1FW4B4T0T9EY3XoD_ftwX1kAKbHtdENbzPvjUg2ExMSZo
Message-ID: <CANiq72kHVkG3MbyUH82WwmhPXQrSe6ZJaqMrdOV-05Kg60NfgA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import style
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Guru Das Srinagesh <linux@gurudas.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305134-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:gary@garyguo.net,m:ojeda@kernel.org,m:linux@gurudas.dev,m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,gurudas.dev,gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,rust-lang.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5EE77134FD

On Mon, Jul 6, 2026 at 5:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> How often does the style edition change? Is there a 2026? How much
> changes in each one?

Every 3 years or so. For 2024, not much changes -- you can easily try
yourself passing the `--style-edition` flag. From a quick look, it is
almost all just the import sorting:

  https://doc.rust-lang.org/style-guide/editions.html

> features. Style patches are mostly a waste of reviewer/maintainer
> time, because some actually break stuff, so need to be reviewed just

Yes, we don't particularly like those either, but this is not like
those: it is not a manual process, and very, very unlikely to
functionally break anything (and trivially reviewed, from my
inspection above).

Just to clarify further: if we decided to do this, which is not a
given, this would be a treewide change done at once (because
formatting is enforced treewide), and nothing you would need to
review.

Cheers,
Miguel

