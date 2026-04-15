Return-Path: <netdev+bounces-278849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAnVMCjN32lwZAAAu9opvQ
	(envelope-from <netdev+bounces-278849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:38:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A015406DA9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353C5302689F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC743DFC85;
	Wed, 15 Apr 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkJFzCy7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5B314B9A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274725; cv=pass; b=u/jMWTYGTdgGhqmeK4v6c9YC21FfEyJPM6/Z1jwxaz7uqyZ3q6WcTFCoGBdJ7kjX6qaOeE/tRMjRgpVlvQ3zBsADXCupieFsM8MiumOdcUojzsfnwb0H3dUGDIUlZ524gIM5l06fAadAoYelxPeEXgMhX9W70kT/DlbVjktHyNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274725; c=relaxed/simple;
	bh=KHv/gxEwI20U718wg2muzGZhRAj4yw3xXpPOajzOexY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRU2BL8phVVXTCrtp9jVuy2+w2s9oGKGYwfB98YRM+OAqHIE+rC/HubMvTOjRZaTDso9yqRE9anT48qBGVh8sm79SFRwswlzFztxRrVec8S43jYgyMvz02M1LZfZr6va+gzqSa+PaR0CdTE38jedYyBNK1JwsRcNKkkgZFJ7Ib8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkJFzCy7; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso39523705e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776274722; cv=none;
        d=google.com; s=arc-20240605;
        b=R3mPYsrVdX7Ze2YHWjjVo24CUBcnV+7NXwgdR9Dp6M9cU4TzJc6IWxg7xlKpRJ6IgA
         4/b+wVs5QqJ8J3D5d/WedubL2htMDa1RsnyjG1URN+zq1r7walNzdNaUu/U7kNouR8Hr
         4gxmn8c0AlEZ3xEkDFMhb7Iv4v6bEQuaC/E3WIlayAUZ5yKCHtuGskKjeIxR1gR6mwjF
         KyJQv61hPQLeP9r/EztAdsTqpyBRNdc/5fKr3E60Kg6KGsRComSu98x0B4Q9OO/YrZ91
         rZdT+/8dWl4CkdR9W0uGF4ZBF62WmR2gzazLdkPVGiwB0HgY8SrQ5/iOvuX16vrz8ojW
         WRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zcbF3rKrTIYUlxquwtwJBdRMB8TU6zntVRfT41or7CA=;
        fh=gcEaXBPRD8JzfaK9ZiGo9gbDZAHx3IScGWy6yOHyCyU=;
        b=YVaYYIN0WTerSnEbWPjzfBxOioa+w2oI0LuKm3v+fDy3yzTTuexMhZJfQEsFZOP0bF
         0xghkdgCkIy8UeCGc8qwjG7DXRLvHk4a1NjwymKtyDjVzSyTHXEvPdaDjmFZk2O6GPjA
         hOsxKKyKOhkOdsAEftIymK9SU7AFjwNne/d2FHJXaq2LR/v9IqZ/iOax2FOuuFfU1DT1
         Vqi3XaeCEK0VmupO/zAET7OBnDMJp6TNjN+3DWsjuUNGsBbCyhuoSfXaVhVOUdv4lP1O
         N/Owgp8vwFieqMQxlETLfN+3LXq9Jk8PrD6r2pOiY3iWMx4j2K7Oy7PKc65mvYvkmeq+
         HUxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274722; x=1776879522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcbF3rKrTIYUlxquwtwJBdRMB8TU6zntVRfT41or7CA=;
        b=BkJFzCy717vpljN6YjOlcDkzpEJdhfaUDorWaAysrdlvVImV3nw22l5zYbE6bpug1f
         IwZenYk2eZJIe9TSRF1aIir6SPIFclfhLk5hQgfc1ym2+NCmp60sBpqKIYXf2h+WBBPF
         cFo0uJ6Rq7aDh3iVeYOmSVO14pzQgO7nY1hzFAtDAVFbijd2jbTw0xZy6ZYhAH9eDxsb
         x1EVeu3fsny7qfTvZKPWng1MVXDBDCsnLx4nu/f0+OxIsK7U1CwCN7FUzSgVs9WVEnMV
         4A94+nZRsaYLwnuAlz410p1VdQD2zNcLQ0gloTPZ3gAXpaVwho8EXf86W0yWkOuXDDLU
         c0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274722; x=1776879522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcbF3rKrTIYUlxquwtwJBdRMB8TU6zntVRfT41or7CA=;
        b=GL5f1zMBdrkjxKd9IYQl6Gs1Ov7Fe83RPwQ66XB6wKVumKLIM/abeimUUAIE5AuoRc
         Pephi1y2dPM1lI5iDdSk2Yx1GZxJ6amaxXrptLvjzmAaz27YFFsaQ2txUAY1zYYsJHVn
         Ge1Qxp2JMzjuYHV6vVaZFecjehl67sAZkTfB80QCm2UNc24RIeMnb9wSVCxGpiCGFeOK
         DbBjQzeA6yFriswaQQgFrqOvzAnHu3/wJ0zx5g0Al3TrjdgKRM9OfojtnMsw50wdy6vy
         TThxkLxC/chTt4sD6HJOzCL1MhzNUiydM6JIttCXzB1xEaq/S/hcklC49/QdEyOKweqp
         ELKA==
X-Forwarded-Encrypted: i=1; AFNElJ/peIsgQ6LTmH3+Z7q3y3MQ81hrLzthFf39cwIUTblJT2yN+8at1d28H6HCT1OLPmFTOO07jbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxpfFHkfSVyIbJydbbTuTTei5Af2OdI9OVufYKRngI8wnGRbZ
	0fBJX8ratRzHIgkOVON0Xy4h/cV+cEJgfIEWvtaCvBfbbOInx0cULE/zGCpqejGORDHftiKJmfP
	Yx/wIeN0Lbs68/eokhjhdJv0J/A23fMo=
X-Gm-Gg: AeBDies1vwFYwi4grpZ/8D8Ps/zQw8ENQO0vxVzgtzOf6bNhiU3HOUDZeqBDHng7ldx
	RttVIgeqPCYMl6RWLJqRp9jj8dWkbblafvUsmsG3HycLJ0wdttKFaajwp7IGbHO1vA7B+Rxakx2
	VsIrTdJUUifOewnT1WJN1XClL/vT5pYjgdJvpAUADmVSf2ANM3sCl52jy72oInwAKn5RfnHDbw6
	sh10yO3EyRRYMxsaCcunIDn9+BFovZZ2RZQm9kvPOAr4QxUutkUYwO7phxgOhNlDWC1NhYizZwf
	8b14V7rkLfBCcN5mOxV7ZgjH+u+ggB8JLAVXtjT6lRXX7PBlozk=
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-488d67e262cmr213788065e9.9.1776274721328; Wed, 15 Apr 2026
 10:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
 <20260413110222.49fc3759@kernel.org> <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
 <CAH5Ym4i7VV53hQGY3AjAUW3B8g_ffgmw69kPhPrk2CmcRbguuQ@mail.gmail.com>
 <ad5LlXzeQ8j14Mjg@shell.armlinux.org.uk> <ad7nsUQvksJF7JFK@shell.armlinux.org.uk>
 <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com> <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk>
In-Reply-To: <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 15 Apr 2026 10:38:29 -0700
X-Gm-Features: AQROBzAqIK7tccp5Nve5YPfldbVfMbcjsC1bB4J1LveWBztJraYfNbIwTcXSd7s
Message-ID: <CAH5Ym4jKdzDeYwCfkMLmUz0FsiD2vFwfuAvqFE=uvMtPmakeMQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A015406DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 5:44=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Apr 14, 2026 at 07:12:34PM -0700, Sam Edwards wrote:
> > On Tue, Apr 14, 2026 at 6:19=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > Okay, just a quick note to say that nvidia's 5.10.216-tegra kernel
> > > survives iperf3 -c -R to the imx6.
> >
> > Hi Russell,
> >
> > Aw, you beat me to it! I was about to report that 5.10.104-tegra is
> > unaffected. And my iperf3 server is a multi-GbE amd64 machine.
> >
> > > Dumping the registers and comparing, and then forcing the RQS and TQS
> > > values to 0x23 (+1 =3D 36, *256 =3D 9216 bytes) and 0x8f (+1 =3D 144,
> > > *256 =3D 36864 ytes) respectively seems to solve the problem. Under
> > > net-next, these both end up being 0xff (+1 =3D 256, *256 =3D 65536 by=
tes.)
> > > Suspiciously, 36 * 4 =3D 144, and I also see that this kernel program=
s
> > > all four of the MTL receive operation mode registers, but only the
> > > first MTL transmit operation mode register. However, DMA channels 1-3
> > > aren't initialised.
> >
> > Wow, great! I wonder if the problem is that the MTL FIFOs are smaller
> > than that, so when the DMA suffers a momentary hiccup, the FIFOs are
> > allowed to overflow, putting the hardware in a bad state.
> >
> > Though I suspect this is only half of the problem: do you still see
> > RBUs? Everything you've shared so far suggests the DMA failures are
> > _not_ because the rx ring is drying up.
>
> Yes. Note that RBUs will happen not because of DMA failures, but if
> the kernel fails to keep up with the packet rate. RBU means "we read
> the next descriptor, and it wasn't owned by hardware".

Are you speaking from observation, documentation, or understanding?
I'd define RBU the same way, but you reported:

```
[   55.766199] dwc-eth-dwmac 2490000.ethernet eth0: q0: receive buffer
unavailable: cur_rx=3D309 dirty_rx=3D309 last_cur_rx=3D245
last_cur_rx_post=3D309 last_dirty_rx=3D245 count=3D64 budget=3D64

cur_rx =3D=3D dirty_rx _should_ mean that we fully refilled the ring. [...]
[...]
Every ring entry contains the same RDES3 value, so it really is
completely full at the point RBU fires (bit 31 clear means software
owns the descriptor, and it's basically saying first/last segment,
RDES1 valid, buffer 1 length of 1518.
```

It would seem* that the kernel isn't really failing to keep up with
the packet rate. If RBU is firing with a ring that's not even close to
empty, that tells me there's another way for it to fire. So I suspect
the hardware designers implemented it to mean:
"We couldn't read the next descriptor, _or_ it wasn't owned by hardware."

(* However, if bit 31 is clear everywhere, wouldn't that mean the ring
is actually completely depleted, not full? If count=3D=3Dbudget, wouldn't
that mean the whole ring hasn't been visited, so we only refilled 64
entries and not necessarily the entire ring? Maybe the kernel isn't
keeping up after all.)

> That has:
>
>         const nveu32_t rx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] =3D {
>                 { FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
>                   FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
>                 { FIFO_SZ(36U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U),
>                   FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(2U), FIFO_SZ(16U) },
>         };
>         const nveu32_t tx_fifo_sz[2U][OSI_EQOS_MAX_NUM_QUEUES] =3D {
>                 { FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U), FIFO_SZ(9U),
>                   FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U), FIFO_SZ(1U) },
>                 { FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U),
>                   FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U), FIFO_SZ(8U) },
>         };
>
> where each of those values is the RQS/TQS value to use in KiB:
>
> #define FIFO_SZ(x)              ((((x) * 1024U) / 256U) - 1U)
>
> This doesn't correspond with the values I'm seeing programmed into
> the hardware under the 5.10.216-tegra kernel. I'm seeing TQS =3D 143
> (36KiB), and RQS =3D 35 (9KiB). Yes, these values exist in the tables
> above from a quick look, but they're not in the right place!

True, but:
a) I doubt 5.10.216-tegra includes exactly the same version of the
driver found in this random GitHub mirror. (My intent was only to
point out that they don't use 5.10's stmmac; I should have been more
clear that I wasn't trying to link the same version, sorry!)
b) This is vendor code; I don't know how good their testing/review
process is. It might not run the way it looks. The intent seems to be
for RQS > TQS (which makes intuitive sense), but as you're seeing the
registers programmed the other way 'round, they might have gotten them
subtly mixed up.

> Now, as for FIFO sizes, if we sum up all the entries, then we
> get:
>
> SUM(rx_fifo_size[0][]) =3D 60KiB
> SUM(rx_fifo_size[1][]) =3D 64KiB
> SUM(tx_fifo_size[0][]) =3D 60KiB
> SUM(tx_fifo_size[1][]) =3D 64KiB

I follow the math with 64KiB, but surely the 60KiB should be
9+9+9+9+1+1+1+1=3D40KiB? This seems to me that the "legacy EQOS" simply
shifts with smaller FIFOs. Since dwmac is licensed as a soft IP core,
perhaps the FIFO size is an elaboration parameter? That would mean
this isn't an issue with dwmac 5.0 broadly, but with Nvidia's specific
instantiation of it.

