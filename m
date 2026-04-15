Return-Path: <netdev+bounces-278871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEfcKYv632ntbAAAu9opvQ
	(envelope-from <netdev+bounces-278871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DF407BD7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB81B306A1ED
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF6387569;
	Wed, 15 Apr 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDiv3p0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28616356A08
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286268; cv=pass; b=WLLcoOVwENhfVs0sRo9aXItD0IaqimLfZxdj4m5ctGeP8JFrX7lVSFCOVZE0jMphN3u0zsaH+TiqgcfhOmGkNdgO+QAxZawuZ2OwBQjyJShMrFS/rhZ55tLXWTCcDXq6eXrXg9C124zRKBxEIbHjRtLSTukpYaPDAVY2W6i0AcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286268; c=relaxed/simple;
	bh=A7UDYGzKJJe/bdquUBaYKdQJ1gprhVLDRlL+WM3sRcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKP/4ExnawtRzAju/zZg+DOz/xIwMa10hFdLVaJI7s4L/v/wy9JfnU+Iqw1DQm+i3MAuwy+tcX0HBWcvc2BHeN+rAKOwhb4uvhEib39QJr78WRlYXB6hH0FnnOTt3sCAFxOGJ4WEvdo8PZ2cWg3N6iS/VBN6fHSD/MQhlbvVG9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDiv3p0j; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d64313c39so4236892f8f.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776286265; cv=none;
        d=google.com; s=arc-20240605;
        b=Vm0EXVwGZ4PPD5YMN7hhDYTALWuZsJgUfs7FRS1g0KQWS+dZn4a8EKlc6Q4OiDOc8b
         bZ+U0wHSmngb1ZoBBcZgf3SMaAp0RVknGfxtR/GiUG6t8E3YIOzXBLwDV7LY/0oKrYYk
         M3VPiMPRfO5dXLQO8FnmkrDnlF2E/PUZWXiUdRU6oMkqxeZOQg/Q5aj1teBUqIZi2wQ5
         v3Aqjyz6RulJb1UDWiLYb9UwBXNo0HDI8Q7YHpVD8MA3eD2m70IGoYGFKldSeduDHk3D
         CS46tBZbC1OPlVTTIDi6dxgcmiASUL/QaVITULOOvAXZijI0OjxKTkppYsSkM4kXzUoL
         4tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7UDYGzKJJe/bdquUBaYKdQJ1gprhVLDRlL+WM3sRcQ=;
        fh=Wbf4VEHKu/Lwd9UGciA9YQO8vHfoTjBrJO1Of/3eZN0=;
        b=UKi+dyxCFe8ak8qQQWx7hnOmxwcCIPeM7cC7KS8goBcq54JsnCjrG59R91z66s9ozF
         N1+wUENsIEGj35MCcFij2JqEbc0F6hSPky55Qv0Gy5p0yFDlSvb7JYL9uXBZ+yZwyE7n
         UAG+KDEj7he6EvZ3kwLgBFRawctiq3bXMG5CzFeWkDg1VKhh/ts7AyvvNUo0arlb80LX
         uppGM7GE2OijcKc1NLknar8IumxKwduZhfaffRO4K5zcftcdquQefS/3IEuEwbAXtlzv
         O9AygCsYXUTvPrhHaw0Tz5VG+Vs4UjOWcRb2TCrHBo2yG3nxZjC3glPYbtouiiBrl9WP
         mNOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286265; x=1776891065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7UDYGzKJJe/bdquUBaYKdQJ1gprhVLDRlL+WM3sRcQ=;
        b=NDiv3p0j4o9tVgEcnwffw04PMWvw3UcB8ZJkQeCLbCtyvRqAlX1lzvfejJk/Dp7iL5
         XxIfqR85pVjL1BVOehYeOlE815WP+V7nf3WoI/1WJH5FN1EgAtYe0L0JtInC9sVXbQ07
         weI2hYzIqHudB/we8kATtpIz0znhQT7OlIq1aQwAtV+uteHhHoH9hHD/l7jRT9VRD6/Y
         xFv1M3idjCPEKuLJOj4woHirzisMOtG8LeQW3Bd1XtOAGqNTWuy51jWZvtabStTDA00K
         JVDMaVwV7Z0celiJ04OPOYZfOJ4FootuNR1J62c9GmTCu+8tmygB3wA7Mo6xcYAURLlr
         i5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286265; x=1776891065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7UDYGzKJJe/bdquUBaYKdQJ1gprhVLDRlL+WM3sRcQ=;
        b=JtqWruKO3ifNnU0QAG1kLeaR2+ff+dJh6yEh/BFDpYoInVhXAN2ZEPuvUIgTchaV56
         6RnYcf2URVq4aZemwqLGxYFPIyWBFOfXzc1SbJeGwAZkTr9X4F/6EI01M/LgxaKD8vF+
         vSjanne5Qd2ft6QhR8RPspAieugsu/SC1NOq09TKv5DcGb6ZyjCQ8HYCNc0xsNAN+kWg
         f52LcsIDKRrpCEKKBgbZMEYwWnzTNCB1kFkFo9kq83ZwBvHYdvi6+pGY2HVp9XULZoXJ
         Ltw0+QO6fc0asnrRyQ+gKna02lDQgtQjd+K6wWo8AA51E58fLRU3TtkCtMbsAMkN/qvc
         CynQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zK5QoPwqCd3MGjLEJwWGDxZYL6/33fvlXo85hxJWY53xHxfb+NreJ9x1hn4dHJZFK10v8WVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2mEMhty+xOyyDXZ7YQSChSnRT1klTMKVi+j7RPqy6x/rg1mb
	Py8eaRmNqTS8UXcXAwUAWwu5eMR4vxfNAH9OaJ4us7mL6MRDNT6TrJZ+ccy0oK0hLI2N7SEoHOF
	CLwZDcNcxELwZ3GPuwMp/q3blEryhePo=
X-Gm-Gg: AeBDiesim2An0z9wUMXj+skgqvcPMq42+zF+1Rbu5HI0zJqoN23P4yjnRCzsbPxbKUV
	2LMKy38dR23SQFRp5FkRjoTYpaYkm9iJqjBJhLjzeyQ01sTfBki10VhrufpnetQdGx6s/k2MY8Q
	nWe1F3LEBms4Y9WXQsycXbuaSnEUINFFWfBam+Nz3toNW8cWlWjDTEq06Q+bepWgc/eZKXcpBDV
	tioPi0dgdziBfsIXcJYDeiJLCprh/g1AV4SZXJ0MVthJtd1bl+NmAd82+ySmKNaA/OtMHcx/WLI
	8gpWXcNI3PGwUDOU/zsWkKF6zTmcn5b/Tnhp/smf8/ZKVpy1Nyo=
X-Received: by 2002:a05:6000:220b:b0:43d:30b4:1859 with SMTP id
 ffacd0b85a97d-43d64235cf5mr34620475f8f.7.1776286265230; Wed, 15 Apr 2026
 13:51:05 -0700 (PDT)
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
 <CAH5Ym4jA8w9=UxMT4vKJpnXkuDHtkFtMcg4u2sy_0S+8wgy-9w@mail.gmail.com>
 <ad-ID2WaPgPJqdsa@shell.armlinux.org.uk> <CAH5Ym4jKdzDeYwCfkMLmUz0FsiD2vFwfuAvqFE=uvMtPmakeMQ@mail.gmail.com>
 <ad_o4aDP0UBY_8i4@shell.armlinux.org.uk>
In-Reply-To: <ad_o4aDP0UBY_8i4@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 15 Apr 2026 13:50:53 -0700
X-Gm-Features: AQROBzD5XBS99VCDwyzmkg2_ABsUHqZK9kvqTm38xxMES7dhJirfHEs2edhZQVs
Message-ID: <CAH5Ym4j3GePEMEMmg1Z27gYfQ0N8Sc1BMW1rnvNZ4aLQ+cfFyQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 293DF407BD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:37=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> It's not a question about how I define RBU - this is defined by Synopsys
> and I'm using it *exactly* that way as stated in the documentation.
>
> "This bit indicates that the host owns the Next Descriptor in the
> Receive List and the DMA cannot acquire it. The Receive Process is
> suspended. ... This bit is set only when the previous Receive
> Descriptor is owned by the DMA."
>
> In other words, DMA has processed the previous receive descriptor which
> _was_ owned by the hardware, written back to clear the OWN bit, and
> then fetches the next descriptor and finds that the OWN bit is also
> clear.

I'm only trying to leave open the possibility that the Synopsys
technical writer and the hardware implementation team weren't
communicating clearly. We already have a situation where RPS isn't
behaving as documented (even if that's likely just hardware
misconfiguration), so while I'm currently pretty sure RBU carries no
other (actual) meaning than "DMA caught up to OWN=3D0," I'm only about
75% confident.

> > It would seem* that the kernel isn't really failing to keep up with
> > the packet rate. If RBU is firing with a ring that's not even close to
> > empty, that tells me there's another way for it to fire. So I suspect
> > the hardware designers implemented it to mean:
> > "We couldn't read the next descriptor, _or_ it wasn't owned by hardware=
."
> >
> > (* However, if bit 31 is clear everywhere, wouldn't that mean the ring
> > is actually completely depleted, not full? If count=3D=3Dbudget, wouldn=
't
> > that mean the whole ring hasn't been visited, so we only refilled 64
> > entries and not necessarily the entire ring? Maybe the kernel isn't
> > keeping up after all.)
>
> Ah, I think that's where our terminology differs.
>
> You seem to define full as "populated with empty buffers". I define
> full to mean "the hardware has filled every buffer with a packet that
> it has received and handed it over to software to process." Note even
> the terminology there - filling buffers with data. That ultimately
> ends up filling the ring, and when completely filled, it is full.
>
> I think of buffers like buckets. If a buffer contains no data, it
> is empty. If a buffer contains data, it has been filled or is full.
> Apply that to a list of buffers and you get the same thing. Many
> ethernet driver documentation uses this same terminology, so I
> thought it would be widely understood.

Ah okay, I was beginning to suspect the same. In my defense: though I
also think of buffers in the same way, this driver calls the process
of supplying empty buffers "refilling," which is also the terminology
we've both been using throughout this exchange, and when something is
"completely refilled" I generally call it "full." But I'm realizing
now that the bidirectional (submissions+completions) nature of this
ring means that "full" and "empty" aren't really well-defined
concepts. I'll try to read more carefully (and switch to saying
"completely dirty" and "completely clean") going forward.

So the kernel is able to supply clean buffers without issue, but it
somehow falls behind the incoming packet rate and the DMA is left with
a completely dirty ring. I agree that stmmac_rx() is therefore just
not running fast enough: either it's got really bad scheduler jitter
for the ~6.3ms minimum it takes for 512x full-sized Ethernet frames to
arrive from the PHY (your scenario 1), or -- more likely -- the NAPI
budgets gradually fall behind the hardware (your scenario 2).

> Right, 40KiB. Sorry, I'm getting interrupted almost constantly while
> trying to do anything.
>
> However, I've tested with 0x7f in both fields, and it still falls flat
> on its face. I've also tried other values, but because I had to unplug
> the laptop from the nvidia board to use the laptop portably due to the
> medical emergency situation, that caused screen to quit, so I've lost
> all that. Chaos reigns supreme here :/

I'm sorry to hear about that, please prioritize you/yours and don't
feel like you owe me speedy replies.

> So, I'm not sure we understand what's going on - I don't think it's that
> the FIFOs are smaller than specified. I suspect that the 9KiB vs 36KiB
> results in some kind of throttling that prevents the condition which
> hangs the hardware.

I'll try playing with the FIFO configuration on my end to learn:
a) If a suitably-configured FIFO size makes the RPS status arrive as docume=
nted
b) If I can safely fill the FIFO slowly (by manually stalling the
driver and adding frames one at a time) and have it drain on resume
c) Whether the TQS value can be adjusted independently of this
problem's prevalence
d) The maximum RQS value that allows the problem to happen

> I'm not getting as much time as I'd like to really test out scenarios
> due to everything that is going on, and honestly I feel like just
> writing this week off now and giving up.

I have the same hardware, observe the same issue, and find this
interesting enough to keep plugging away at it. I would have no hard
feelings if you left me alone with this problem for a bit. :)

Be well,
Sam

