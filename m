Return-Path: <netdev+bounces-287669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKCmHFWfBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:57:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5B5369A7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC1A830B6724
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012933E558E;
	Wed, 13 May 2026 15:35:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E048C40C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686554; cv=none; b=t0gVOVJVFvjJFXOcEF/yP52ui5u/gmIkWpyUsvcBYL+Y3Gg5GF+O2A507jDmnv0jJCnbdBT2sn09On1FunPe0NNGJa8l/MeaEcGA1zJvHs9BF3xwuz/7JGlhwQR4OI4lLRbyA1Uk8upDIkHTVYDx9ITHAsMLdvrhPiobBxaoOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686554; c=relaxed/simple;
	bh=MbMe/mygK1eYg3wRO5HZ52i+Mu+A2bu5L1l3HOhdADQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkJ+a3PC0+ZjT1flcV4a7kqemPW4n0Yb5JOzQcTZ8LBNnatUVs5T6X+l4ajWTnyMQwuQdYtqMH4bY/TtLq1Bm9Wi4aN/Kzg/29SXCGmBzmrHTMXWSCCIHh/u/Yh4tLZVegMneksqCBBO4PQU+4ZWqB1AGIQCyG95jWdwGj2mIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5753a289955so2285329e0c.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686549; x=1779291349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDnAYsDqfkn63HOuBNcLqNYcqNClUjY79NfZ7yIaClw=;
        b=QSz0YHgyQoS6d9WnwH1M3dkKa9sIOp+WJ741YpE7pIMd0uDlyzFF7xt6wkA/pEvOGz
         0550zart0S4a7fnfJEAss6gylNqFxxXHkBkY6ogReJ4bPgebrLLPtVsagrJVqqbhtNoK
         Tyw/kosx5fvQMLGUGdBtYsHnhh5JGMtnhR/RQvWvS5woO8I/GHOecnDaCQ5BWRr+MTZe
         gBT2p2jpSCSGdHqwCg0b+0ZDv4zEzYyWA96JkJmM5I7YzmXaqAcHJlYvDoSNRGha/5hn
         Lexvotxu3X8AyanzVCJ9y6wEtgytkqzTX8cIg4wdFkZAXXBuLnq7lkTObQTtPMyEXT56
         cPQw==
X-Gm-Message-State: AOJu0Yw29fJI3OVQXKmbp/bxJNf8rUzjV7Sft0xipTnTP0pz/IWG6JcN
	G4Wp5utQic9FjoAiiOjiClnhzwT0mplgFCgFR+KGNOBBoKqaY9o9IMKWFHw/G6mD
X-Gm-Gg: Acq92OFVZ2jo2mzdVELQRj1kqONR7/scpg3h3iiLaThUTXfQbnFPIStd7FYUqORR9Ow
	9qbzpMTWN1IFHFil2ceJrB+oJN3t6pWvSq2qwVyRXrIKcWSgrVlxVqUW5i6uJekclFWMKK1cNMX
	rPCozJf0WGsROqbWg18sBhwQz08giuAxpdOmpqEe5/jAChfflqxni/M7550pRfPcUnWYk3hOB8F
	nMPDywbzx0QE9kIDdLd9VXchplIAEl9u642Fe+Qo1uuetTTTwCfHG4JfcR8l1CcF74YA60Bw4sl
	8Dhq1IH61JNVcyyZVze9IR/9PzGgdTTt82ZbNYNt7sWo66YLwaLnZPN6WV4Emiov4+6CLNZLPT0
	5ZPtT9jbgV/P++5viR5p6toiLahNk6TxYyHZoNoJlzhNSj1pMwJ/J457lENcAAhOcx7sAAYkhVf
	5NgC8PEovyCCcGrmQYTf3sWpdWZ5VocV1DY09nDJHKcNQTcEYy3GUxZrWMMHh/fStWXhlKtae5s
	+g=
X-Received: by 2002:a05:6122:882:b0:56f:1c32:bd07 with SMTP id 71dfb90a1353d-575e6f22045mr2051185e0c.2.1778686548958;
        Wed, 13 May 2026 08:35:48 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ee065asm23100197e0c.15.2026.05.13.08.35.48
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 08:35:48 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-575124e716fso2510602e0c.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:35:48 -0700 (PDT)
X-Received: by 2002:a05:6122:221:b0:572:36f3:e792 with SMTP id
 71dfb90a1353d-575e70b2327mr1869164e0c.14.1778686548556; Wed, 13 May 2026
 08:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1afbbbc74669f053414dcbabd909e52e7eae66e0.1778678915.git.geert+renesas@glider.be>
 <fd5245fa-b46c-4f83-955a-dc0376610b89@linux.ibm.com>
In-Reply-To: <fd5245fa-b46c-4f83-955a-dc0376610b89@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 May 2026 17:35:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=LvYby2m9-WBpNjALE6Nit1aH6NX1mSmq-Y24Szy45Q@mail.gmail.com>
X-Gm-Features: AVHnY4IBPT8_PzFo_9_RTVPPLnbS2tpVbYfWlUHL4a-u5BXkMoBksIv0tgnktMM
Message-ID: <CAMuHMdV=LvYby2m9-WBpNjALE6Nit1aH6NX1mSmq-Y24Szy45Q@mail.gmail.com>
Subject: Re: [PATCH] [net] dibs: Improve DIBS prompts and help texts
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D9A5B5369A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287669-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Alexandra,

On Wed, 13 May 2026 at 16:20, Alexandra Winter <wintera@linux.ibm.com> wrote:
> On 13.05.26 15:29, Geert Uytterhoeven wrote:
> > The Kconfig prompts for the DIBS options read:
> >
> >     DIBS support (DIBS) [N/m/y/?]
> >       intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]
> >
> > Clarify the DIBS prompt by expanding the acronym.
>
> Thank you, yes that is an improvement.
>
> > Capitalize the first character of the DIBS_LO prompt, and always write
> > DIBS in full caps.
>
> dibs is a shim layer between other kernel components and code pieces are
> typically lowercase, same for sysfs paths. It is not some formal standard
> that is documented anywhere in uppercase. So I'd like to keep it lowercase
> in the help text.
>
> > While at it, join the first two lines of the DIBS help text into a real
> > sentence.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/dibs/Kconfig
> > +++ b/drivers/dibs/Kconfig
> > @@ -1,23 +1,23 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  config DIBS
> > -     tristate "DIBS support"
> > +     tristate "Direct Internal Buffer Sharing support"
> >       default n
> >       help
> > -       Direct Internal Buffer Sharing (DIBS)
> > -       A communication method that uses common physical (internal) memory
> > -       for synchronous direct access into a remote buffer.
> > +       Direct Internal Buffer Sharing (DIBS) is a communication method that
>
> I could consider changing this to (dibs), if people think that is easier to read.
> But I thought it more obvious this way.
>
> > +       uses common physical (internal) memory for synchronous direct access
> > +       into a remote buffer.
> >
> >         Select this option to provide the abstraction layer between
> > -       dibs devices and dibs clients like the SMC protocol.
> > -       The module name is dibs.
> > +       DIBS devices and DIBS clients like the SMC protocol.
> > +       The module name is DIBS.
>
> The module name is definitively dibs in lowercase.

My fault, that is indeed a silly mistake.
Will send v2 later, taking your comments into accoun.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

