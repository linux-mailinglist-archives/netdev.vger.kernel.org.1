Return-Path: <netdev+bounces-268353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLFeJrScuGkzggEAu9opvQ
	(envelope-from <netdev+bounces-268353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:13:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05EE2A2324
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897583009CF8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F41531C1;
	Tue, 17 Mar 2026 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLWuFyMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A92A1CF
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706406; cv=none; b=AqGCisef28jiEcPzVx/Aiy7fTxu8A1VrqK9wVHVo98Mryyglwb6qNeZTNolUxh7eE4AnXwMDL8yEsQ1mj3k6BUINTiUZRqlypTnxe7js+uNznC1AOS6LWTDUvJ3Wl6YWbBMpunfdXULeCrndbcoqE8Y8OSLJWBYrSm5jDscWGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706406; c=relaxed/simple;
	bh=Kn3hnu/kLCbXlV8YMtYksGThcWoS4aEUofiHoSMyjcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw4dxM19viMBi6RGmC+HFoMCCRwp7a0XT2rR9HsmHm6rg0nBPWzichOeZUkaovG5oMTK/ldS9m+JyMkZk8HgR5hQ0b/taz05XxODPbVL+PY+Qj3pVEQmU8yG7xlhT98SdVx421+B1hXyJXCDmFfY/NcFfNrX1Y4vzHmbMNgT/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLWuFyMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D03C19421
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706405;
	bh=Kn3hnu/kLCbXlV8YMtYksGThcWoS4aEUofiHoSMyjcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DLWuFyMQwRBw5QfxxZ9pDNRCM7ePNYEUYJSI8OtmacY7caIsqPhh7HVesTEWfOJIc
	 qRwfqeeFUgmuEl0VUYPsaNIXVQlVQOsOZ001680+VJnWrM0BirrXFZgku3dPY0aPPw
	 fiewEoChiNUAP17jexi2qrcg7rhQA8h0Ds2mR4EqEY8YpeOXmSMyLIWEwHW1/pAIIf
	 dKMhJ5dMUeLACw0vwbVSFm9j945KpG3vfgHoTwzjzUTMluNHDy5llb4P8zyTRB1k39
	 GnC3UmFZKAF5vbP8A2nKjh2/tNuA5sjkebFiJYWfg8NGFc1Zi30QSpftH1BPD3/HfX
	 dbZaVxa+pnLYw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7982c3b7dfcso48622897b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSSiGRP0LmyQFKe8edXGqWOpksmyIw+7Wh9KXCTg+ZD3p8YOxmrC4JbUzYolsR4YduEDAkzM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68phvgJobo2CeFMUTdE0oEOMd6vKaSyHPSbz+6hBm+J9xCgQS
	mRptaJfs+RshdEWztfsNNlkjcnpdo8ZTTwm1wN7ZpODDJDruEIY5JwXQZdW8XvXzxlcfqNDQtRT
	7KD4Xie961N1WGMfKpB7lhJ4EiTijZ4E=
X-Received: by 2002:a05:690c:3387:b0:799:266:83cf with SMTP id
 00721157ae682-79a1c1b51acmr158135067b3.43.1773706404888; Mon, 16 Mar 2026
 17:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com> <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com> <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
In-Reply-To: <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Mar 2026 01:13:14 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
X-Gm-Features: AaiRm539yxW1CnWC8D8QmZdr1BxL5U68_GUe3uuuPSgXK1xikaSSDcXUyqDMApY
Message-ID: <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during suspend/resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	antonio.borneo@foss.st.com, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268353-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F05EE2A2324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 1:37=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Sat, Mar 14, 2026 at 12:44:56AM +0100, Linus Walleij wrote:
> > On Fri, Mar 13, 2026 at 12:08=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
> > > > In the deepest low-power modes, the pinctrl configuration is lost
> > > > and is never restored if the interface is down.
> > > > This commit ensures that the pinctrl state is set in all cases.
> > >
> > > Shouldn't the pin state be restored by the pinctrl layer?
> >
> > What we have in the device core only applies "init" and "default"
> > states, and provides these handles for transitioning to "sleep"
> > and "default" again (like a state machine).
>
> What I was meaning is that - for a driver using the "default" state,
> if the hardware loses the pinctrl state during sleep, isn't it the
> responsibility of the pinctrl driver to restore the state rather
> than leaving it in whatever states it happens to be when the SoC
> comes back from suspend?

Aha I understand.

Some pin controllers are aware of the different states from an
electronic point of view, so different states are programmed into
the hardware for suspend/sleep and "active". This programming
can be both implicit (fixed in the pin controller hardware) or
programmable by the operating system. Then a hardware
line tells the pin controller when the system goes to sleep so it
autonomously apply some sleep mode settings to the pins
and reverse this back when waking up. These pin controllers
themselves are "always on", in a specific power domain that
never shuts down so they can keep track of this.

In other cases the pin controller lacks this autonomous ability
and then each driver need to transition its pin state to the
right one when going to sleep and coming back up.

In some further cases the pin controller does some power
management but it's sub-optimal such as leaving I2C bus lines
floating on pull-up when they should be pulled to VDD
to minimize leaks during sleep (for example). The default
is OK but with some pin control state intervention we can do
better, sometimes.

> If that is not the case, then don't we have a major issue where
> drivers using pinctrl but do not issue any pinctrl calls in the
> resume function are buggy?

Sadly, in my experience, the power management features of an
SoC is the last step or an "afterthought" when companies
upstream their changes to the Linux kernel, this comes last
and often never. The code is there in the downstream (vendor)
kernels. Running the mainline kernel works but eats power :(

I think what we see when we do:
$ git grep  pinctrl_pm_select_sleep_state |wc -l
107
are the companies that have actually gotten around to do this
properly and test it. There are some very generic hardware blocks
such as the designware USB controller in that list.

Some SoCs may benefit from autonomous power state control
in the hardware, all ACPI platforms for example, I *think* have
the ambition that firmware/BIOS deals with this and we need not
think about it. For devicetree I think it depends, it's up to the
SoC how much is autonomous and how much needs to be
initiated by the driver.

Yours,
Linus Walleij

