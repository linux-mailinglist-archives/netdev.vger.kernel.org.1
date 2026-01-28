Return-Path: <netdev+bounces-254287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCnbABAfemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46247A2E29
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82AF2302795F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3335B136;
	Wed, 28 Jan 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UqXrIQ1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38235971A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610896; cv=pass; b=cYvGhX6VO3Mbqps6mnHtPfvJgNKN9A9ssCly5kSBh9NrVjQonWAGurTF/cogejrskYy2yw7YHAa65uF9+ocGwt9ReqwNgHmf8txc7lO8BlffCDji/3aDAsSp+KSd5EFVV/qI/WhEh6CqaXRe9KyIoHM61s1zVEyE/6hkWtL1Zsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610896; c=relaxed/simple;
	bh=UYjDQFIXwCpEoQ5tqr1aJ0ZE8sXdCkFKLSofbuf8EMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJbgDRWiNYunerTL+XaIMzABCDByTBVH3Be+fHamjKPe2CJnItDqpyQoLH8J95EE5qsUaA6G6klYcy9i6zzZOqcZaQx8memfqtEzx+qmrqxo1zofxVn8HyRgq9RDoRVmEuRj2eaTwy/tJG9fYd/wiWioOajX8KvQUkEB2+p73vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UqXrIQ1A; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b71320f501so13988518eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769610894; cv=none;
        d=google.com; s=arc-20240605;
        b=YDjlCeFTlxp88XpGyfU2BQrzrSyy3z4g061p9NNw8dRbnQ8YGlSEEIcWt7a+XuGK/G
         CFAg9AGB4Dj9rLqUzL96RN/Ar3w6ab2VnUQwcaRgJ2W35LDkQVghLOoJZLQhlt2kwyXA
         3VweSvo/8iZ5deQK2FpUjwdMTtURLpChkGF3TxhkIw8VqnV/RMi4uKFb9sDQNW0bBFvi
         4idP6LvParsZhnPdd7ARzVGeYwbOYZaKYRFxGhXLkCNlDiSPhD56PsbExD3lkDugfU8i
         1w1H/ucjFuHwL5g/Ewe1VAHo5LPCAtKD0AR48rHE8SBpK2mX6Rm41gFgYi+hXVG7mRWr
         3iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddA/+oHzfXwIvJwF7dTojsUX4x8Sl87piJCxJWIc4B8=;
        fh=9X39RBC9qn11JwcaUTrAd27FesVVH5MhLaBEY8a4Pj4=;
        b=Ag5RzT2fNldBJFXWuwc80mR5jleO36CKkyQL0vSEywzmoRDtWLB0mcllY8uTa1+rX2
         I1hHCiMF5X4Iaj9gauXwpC4EWbqkq/9p/fnyYXJyr2yOR/7jhsP9+03TjAFbTeYTCVcl
         qj3qNoTJUcs4d5SyoZ08HPMwhHqufmVjbxM8ffTMYtLaKPf618rebQzu+0wlNBDUJEr7
         YSib8sEjfXJPucRGVHV7ge8t+zond9b2NpmkbwaTeRm+thejF/wfWGLXVfrnmEETyDqS
         zP6dtC7X27P17JM9Yb86kBKaYjC7RnpWwvI4mYrPRgcsJd3Xqp3yAFC9F8UNPR78TK/X
         qFVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1769610894; x=1770215694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddA/+oHzfXwIvJwF7dTojsUX4x8Sl87piJCxJWIc4B8=;
        b=UqXrIQ1AU/OxF98jy/HlObYW4wCsdGOlBdk86k9ShIs3rAIBH99zADkASuSJRXeA9w
         XETptTjCBEVH8g2TNbbwtI4/UBy4HMyTtyyNg/Tm5j6OBVrX2odIRF+HVwVWWzxA31T+
         SWBwC6U5gwR6uBZQ8eeiHBTk1KgsCA4zGijrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610894; x=1770215694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddA/+oHzfXwIvJwF7dTojsUX4x8Sl87piJCxJWIc4B8=;
        b=t1c9tXzeWXmkavroVusMaiMHSMtODXVlo7qr719XuYdfwsH2gIRHcqm5YVilOZqXtZ
         ijf6BaWO/CUgLRCtcpL872WPDmD/QZ9Sw4MfRMnUw2PvbO8hkoV5ZgZXtuJPZ0madIta
         gRLrzuFO2eX9wSAeeyfcTZr0ugmmleEzj+tnvZSIHmcolMQH8JCXJe6gWCEyuVkSorGR
         e4g/Rrg1ScAFACJDwIrPMfHtl505I9kyDKsQcx1636gfvkdXSEHwXmj6AIQpmHff4e6j
         3Z1eua9Y85kTB1p3kSr6VvxCFB6ZsDanOWB23MxwB6rZFV5qxDvV4OqmgHpAtwQgE4M9
         ogcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2+gmWOd8AsdfA++jMuxMt/BbFhZNTy/gc0O0vYroGNLfB7mj+B9EmEummBHQtx+91LKrarjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NfXt6IihnJMNXqmIcVQZFkcYMzR87MLaNyl9N7SB9vWTVd+T
	J7mAwNynQL5VKMuVh0uLSS53JIGKxOATSHPAWZQ8a4hML2B4Boin7twp8f0nKo/TFSoKfxeoA3B
	1rkZvJwlp+c4nDnl2ebgGj50rPFad9jovyl5IvePCxw==
X-Gm-Gg: AZuq6aIMUP1jVdDL5lzvhDQhOfxD8hcnHD8LFZr8R5uGXcXSar9JAKCetem2zHdLrjb
	v/CYtsq2JVBAkXq4p3mWPGkDsMkrb2KOhwH9WEkpeHdYxaLhle9+GtnoqUOpazU/gySl+Mj+viJ
	qVDy+yn93vWrw8n9KiY9HTpp6lQ2jPVvCvR/ayz/vpaqX7dzIONldBCFTPYXpDYy6Rxgsc6kbhU
	stPXm6DXLiK78sKqVtFsBUx9RxD1uKPknvDYWn+nn7VABHi3DfpWHSGnHCvAxmg9NOCa2hxJQQ4
	Bnwau6Va7TeHLh8RRSR3mkArbQ==
X-Received: by 2002:a05:7300:72c5:b0:2b7:12f8:5eea with SMTP id
 5a478bee46e88-2b78d8cb620mr4125308eec.9.1769610894061; Wed, 28 Jan 2026
 06:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch> <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
In-Reply-To: <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 Jan 2026 15:34:42 +0100
X-Gm-Features: AZwV_Qj2aNMpO47jDQm3Eisz5zUz-ZfU1MKosTGtsmCW07HfyD4XHqQHwTnx1Cg
Message-ID: <CAOf5uw=J_Vj2aOFJi2jyfj_7osZgv9BB=2P=KZ76qV_mwJfHQA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amarulasolutions.com:email,amarulasolutions.com:url,amarulasolutions.com:dkim,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 46247A2E29
X-Rspamd-Action: no action

Hi Russell

On Wed, Jan 28, 2026 at 2:58=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jan 28, 2026 at 02:33:24PM +0100, Michael Nazzareno Trimarchi wro=
te:
> > Hi Andrew
> >
> > On Wed, Jan 28, 2026 at 2:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Wed, Jan 28, 2026 at 10:46:41AM +0100, Michael Trimarchi wrote:
> > > > The current implementation of phy_reset_after_clk_enable requires M=
AC drivers
> > > > (like fec_main.c) to manually track PHY probing states and trigger =
resets
> > > > at specific points in their clock management flow and was created j=
ust for a SoC
> > > > vendor.
> > >
> > > We try to keep workarounds for specific SoC vendors out of the core,
> > > when possible. It just makes the core more complex for an edge case
> > > which most people don't care about. It is better to hide the
> > > complexity away in the driver which needs it.
> >
> > We should not merge things in the core that are for one Soc and
> > after d65af21842f8a7821fc3b28dc043c2f92b2b312c, I need to anyway to do:
> >
> > net: phy: smsc: Fix functionality of lan8710 in combination with NXP fe=
c
> >
> > Revert "net: phy: smsc: LAN8710/20: remove PHY_RST_AFTER_CLK_EN flag"
> > d65af21842
>
> That commit is an example of a poor commit description. It doesn't
> describe the problem, nor which hardware this affects, so when we end
> up with this kind of situation, we're lacking the context behind why
> the change was made.
>
> So, how do we know that reverting that commit is not going to cause a
> regression for whatever platform the patch was proposed for?
>
> If you read the preceeding commit (which is referenced by the commit
> you intend to revert) itgives more information about the problem, and
> I would expect that reverting it will cause a regression with
> interrupts.

First the PHY_RST_AFTER_CLK_EN was introduced just for the phy that
needs a specific reset  sequence and we need to guarantee that the
clock to the phy is
active during the reset. Now phy clock can be provided even by the
fec_main and the code
there was written really to support in my opinion some reference
design they had at that time.
The entire code that I suggest to re-think is on top of this use case.
For the platform I get this problem
was an imx6ull and reverting that patch that triggered the nxp code
was the only way to have the
reset properly across the clock reset sequence. During this revert I
found this code and I have tried
to figure out it was possible to just let this specific flag used only
on the phy level.

>
> Adding Marco to this thread for comment.
>
> Also, maybe you could clearly state what the issue that you are trying
> to address - why do you need special reset handling for the combination
> of FEC + this PHY. Consider including that description in the commit
> message for any proposed solution so that - as is the case here looking
> back at Macro's commit - we can see _why_ the change is being made.
>

Michael

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!



--
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

