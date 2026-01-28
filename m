Return-Path: <netdev+bounces-254453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGDuMtl5emkC7AEAu9opvQ
	(envelope-from <netdev+bounces-254453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:04:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B34A8EAC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 222E1300728F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964A376BF2;
	Wed, 28 Jan 2026 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mydLqzA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B1374181
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634258; cv=pass; b=ihLry1lTx/FpYxGnMxZCOvtmmu8N1DmVzsjFvnTD5tztfVpuyHPqr+c8fCuC2qnKbmF+t2LSyQJ2CDhecT2FOK80hKpWNMihzJFA0vIT4Zb03mF3Dyw0f9ZKl0GIOzrpluawdOYzLzfEllFlHURoC4Uqu6Yr/QqNsdz90aiKyaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634258; c=relaxed/simple;
	bh=BygABrZs+wt84ZiF/+S94JaIE9wJlUmfQCMn9on8jek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APJzpBu5t45RftxObxWfK9jPe79R+X5pJn7uPKEf+Iu3CAufpJE856CRwiA8mAOay+KCs7i3RPku2jw3RUBnNqNVDMUeUWA32LBKDPgSNOeRoA5IET+LoXUfTCwYzEDalnMzna/rZchrcTQOUuiEV/z41JuXdqrPfi0NpWyl2p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mydLqzA+; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b71515d8adso332612eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634256; cv=none;
        d=google.com; s=arc-20240605;
        b=I/lDmjzdjOVNXNdkbQQZkI9GZ/P1beuJMOoBc618Yw51Yv4T9sGVcbylgX3OIcV5zD
         wYIKD26+IDKkFGTS2Zxt0r5CpKcvoLOPyD9z3VppAPq0ZOkPbzqCYEF4NXm2z0QvmqVt
         QXcXUlCwntHTGaUYxFdyLC6VA4xIhRrrAINTbEplTgdlXH1ipjb9SH4hII1c+FrtbatG
         8RCfm47KlD9Td+1dnH44GK43xyj5MSKb34Xr7lP9gl+ss1IrMsL9DTBbfRYxlQ44Tjw4
         XCGMDLvuT1I+MWhjk93XwYjIX2XerTjRl/JFFfixogMUlNLhy5zgrnwrTw7mdkMgmp9/
         ks3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+V9f1KpRq1EFF7gJxUeGto+TPrHemnbiENvZwSi9QY=;
        fh=E70+97TVQv50oxdXS3uCo7ZTykUJbEsNEWFehBDzmT8=;
        b=bSxjilFGld5H2qJhgb5GxrvMEBbuavvnXLFtC2HYyE9I+Cd9mlFroEcIciKwxHZN1B
         1X50MeeVz68N2srvsucUtAzfNWGvR+abxCuuFFByE+w/zagNLTCaSjMEzuYz2qriRtjD
         2WR2BF8YoePV5nQLPZoMXJSYws/M2czWNcwEPAQ/Zp7bXzjfwPSSkxu6a18A9Vljdf/u
         EIdP9C+093et0xEFOxAGy3NUY/lpyWAfx5H+o5l4BxnTINe+l85yKNRsLIv8O1zkzJQI
         DbXd4LZ4eU7jWUcSESq5PDFZYqK3vbWEX54R/nfKU6KC0bOrfz0yG6oNudLfYonM6i5P
         nnag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1769634256; x=1770239056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+V9f1KpRq1EFF7gJxUeGto+TPrHemnbiENvZwSi9QY=;
        b=mydLqzA++kYyj284CLdZz9NBqCLCMhnC5r/DN+2kmu1ctDIi0mi1XWYdBeWoklrAaO
         80Alzso06c43UMJjR44rxFoe+rIAvYp0sEt4ebfLZHpA+aJXU51PUuGGmuuPuI6/qd+M
         TO4X20jkQZIEqVKP/mhKyrxlfebEoFKRX2dvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634256; x=1770239056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+V9f1KpRq1EFF7gJxUeGto+TPrHemnbiENvZwSi9QY=;
        b=E4wZJAwxWxqTYxxXb7xXSIpsV53qVsLE+tEKFXHRwGRwd1mIzliVAl2mReuz+PO3kg
         aWQfQ2/fKJrb9yKTLHHWehvqNExpELa74gTCjJa81emEyBAk0daigggo98EXIt9HY2xu
         I7ckKD5sPb07EjUhb2rPU/pfI3yKzPoF0oJe96fWKUV6usZrRj5B36+ry+XPvQL4L638
         sOJoIu3d2Nt84io8jQTdpHrYKNM7y1nLFuyhGu7frMfC+cBYr4XDpaMdBmqZG1Q6ACb9
         +qdfgSinPcLdvNdtWuzK10HjQ6LR2TtsB/s3Re09ASHnJf/mtfMYGF/lg1FrDszVp5st
         QpEA==
X-Forwarded-Encrypted: i=1; AJvYcCUxgGeXBtLaROnVXZNhmdg9smpjXkkslAaRpdDvxVk9V5Vkxyc4vOtnBS2kXnccDpBuDYvcgJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykp8dfnpjykndofjMJFJIlVV0LCK2gqlhOtlqKkxYltrkMm5ho
	p1n580T0dzN2QXi9EWDgiwYkymft9XXKWl3q8SdW8kfLhNa588tRyu0wmA4JVnXIKZlD060+32l
	P6XsTejWqQtiRYJrEmw2Ko6zuJ0xmvwYng32jmTkxFg==
X-Gm-Gg: AZuq6aKln0+IOPn3ldTrja+sVravdJEkhuO0tbBXuJSHC6FcPR3gCvHcJsl7lZDm3lF
	+TYsi82NuVELwXy/GakHhFf2SksMp1G+31K5kMiFbTiFBmKTo08m5jZhJAr8JVuLaIlreVptQJv
	gn8cqn5gQ3+bhlvJRzy451zDlC4WsAblxSO4DW6YrLWa7taWfcGt+ZZK5VsRSMBF2jAnIvcvj34
	1Ai+q8rFZ7JbZAu/CH5vN7WWPNFgMwe7uLoWw5rK28eOEGHHtacM4TNX8JyE86FFdy2VIL1WmGR
	BDfNcUgCrPUH0Rjqro9/qVkRKA==
X-Received: by 2002:a05:7300:bc99:b0:2ae:614a:330e with SMTP id
 5a478bee46e88-2b78da0d5f8mr4150693eec.41.1769634256264; Wed, 28 Jan 2026
 13:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch> <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk> <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch>
In-Reply-To: <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 Jan 2026 22:04:03 +0100
X-Gm-Features: AZwV_QjeVK6653l_oKvazr-qVIRp2OY5CRy56KYjvXXmGOXOKRv3DL9zvmlu5TU
Message-ID: <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marco Felsch <m.felsch@pengutronix.de>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amarulasolutions.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,armlinux.org.uk,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lunn.ch:email,amarulasolutions.com:email,amarulasolutions.com:url,amarulasolutions.com:dkim]
X-Rspamd-Queue-Id: D7B34A8EAC
X-Rspamd-Action: no action

Hi

On Wed, Jan 28, 2026 at 9:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The issue was with the out-of-band reset coming from the FEC driver
> > which doesn't honor the phy state-machine.
>
> Could you explain this is more details. Is the FEC doing something
> wrong?

The fact that the phy should be reset when the clk is provided to it, is no=
t
connected at all with the fec. I think that fec_main does not register itse=
lf
as clock provider, You "should" define the phy to have a clock if this is n=
eeded
during the restoration and we should not give any "magic" at controller lev=
el.

* Marco * Your commit bedd8d78aba300860cec3f85d6ff549b3b7f2679 is clear
and I have tried to use it but if I remember the problem is the clock
is provided
by the ethernet controller.

Michael


>
>         Andrew



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

