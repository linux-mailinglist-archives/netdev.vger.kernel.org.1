Return-Path: <netdev+bounces-255253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZzFh8bfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:57:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC2BE96C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8683E300D449
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422536CDFA;
	Fri, 30 Jan 2026 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7O/++g5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73236A024
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806581; cv=pass; b=OZ2MC0u5AidIfO6cCxAt79GiE/jm73xsFdLHwQZC8MlbBrRF6Z38wii7NDKRoCJTriIftwSIRN4JxlUS6fz8eEHVZ9JpWRnSQiDHjkN6jU3FcMd9moTw2a6j39lukeCKKho3nZjHQAV9xPb3lgsBY/1dVttDogW8NjNy1rDmeeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806581; c=relaxed/simple;
	bh=Br6xQKyGbDO6MM0Z3TPAdS5EDwz4uZXbauI4tqlHtZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ovst0hdwoMVC/wg2d0SVZYJfSK+sz1ztNTTrwXKl0lQzv+7ku8HQg/z/xRZT5g5FZBB0IvJdmSOAXRnzf1bXX183v5UqC/cJyzly+UrmS6uv+YO7J3NPC3R0HT4w53EhimRAWK892b14/bofA4RR8zyiFOvwBfi9NtgBs8TV4jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7O/++g5; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a288811a4so25415276d6.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769806579; cv=none;
        d=google.com; s=arc-20240605;
        b=GprrwImENdk0OzVI5e5pMKvuSUwRrep5FEJ9M6aOKH0pIkJlv2NwmKv8eU1X9mdUSl
         cBtUlUa8vR+pqzSo2CWL3curqIWbllpwFMlT81/r/AIsFigsuxVe8zGYohJbrRPn0KRK
         oHKdhVCIiejERgg6RYIPTh214Ubowg/Jnxqf9W88nS6VWNh9SYNUhUQ6FEPFh5rpLLUe
         Nb7sjBS0EZxuoEgFLyECIRuhMlL4h7T6NznS51wAyqu4Hs6vQFYLbuI4Tt42Yemz9D9f
         N12YQMZHLVa4rVeqD5Yz6ZNSCS/+2aSTzb5Tk11pdYxBKsh+pfPjmFjwdolWfbJYok7V
         F3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WSV8/5N/+j/2QxAKyyJXPtuQTRJ1LNLrh8eDzw4eLyA=;
        fh=jJAW7ksWlK+xGhX346HiJms7vAScUqKaPhn4qeUPlV8=;
        b=U9ZiVvNA1PGg6qU+Re0OSDa+TWNFITMys9NUHwLMBsfKuZHaycc8iwIsFXIMsDPLNw
         DkGrm8d6B7ui5KL88Q0CZMpcuWwsNtBanhVLio9dm9TiwMXYKuus5yDILNBBULig8+zF
         WA1dM7wpyYyvuD1pGIFnuXYbBwMZdwf2OK242MeD/H1Rn+ssmLE1QuRwgeL1PDSKb8Od
         06+0M21FJCh+Xk7VAwyuXf9aDu1HdHQi+NMNoXbJe9tuRzi0KsFMMUrWDhjXAgWtQEkB
         Vmpk7n4WY35o30s7qOPjhqf+xeh8qwhjy2o7ATa0sGkJcFl7YX7sYt6lDRlIIm4AOsrB
         jwDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806579; x=1770411379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSV8/5N/+j/2QxAKyyJXPtuQTRJ1LNLrh8eDzw4eLyA=;
        b=O7O/++g5Xvn2LasG5S+ktz4GbT0JzPYjIxNJrEi4yi2DO8x4tiibM4yYziQRniCZ0+
         7qojDiuDtV5PWZf2UCIF72jY9fkQUJsWeejImTE4h6TV8uqyZfXiTyfBGtRWixMBW4db
         DmBzj1AHewFNcQiRbgCCTT8j7izBG3cDZWf8DR+ytnCTU4VZ+aYTYgllq5pOvd2yDtn0
         Bn59+Hke8Bc0RwWg0MTG1SBcbn33XlvRCcaOlMTId4n390KTTd4w53VEyON11br5QU+b
         dHrDCFTDVpC/ps/tTkIPsBFwPiyFFmb+9HTa1uOgf7CEWMCp7zyzBxh6P0XRPtkyrCYV
         P6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806579; x=1770411379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSV8/5N/+j/2QxAKyyJXPtuQTRJ1LNLrh8eDzw4eLyA=;
        b=pyaJdKd00/ptP6oxRFiq4PH11btsgte4ZfjLjUOve+Iz1RSPeOhlyL3ziulaDbMSJ1
         iotZ+4TPmjATwtC0eCtAA/sHXweeVejGbl+02n1sfd9lMBQXQqV5M8vraDdZ5EWfsAQH
         8bfQu1M8OYF0BWp8GWNSPOiQeLCOwfePffrxsfwb1un4myAtbeS5+cMLX5GdqX9lQNoR
         iIM/BYFA6RqIZtSAiaqFYv1Fa5w67j+R3Wqoq6fTccf9lh/90ScOVaYIwkggGXI7k8EY
         +ALIk1eVZQBav2qIWH+o8xi2fzPT8F9qOfDevz9YxU4Hm4CAw5DoEfaQOBrifoJhE/c1
         CdDg==
X-Forwarded-Encrypted: i=1; AJvYcCVFQ2odxeqXMlRoJ6lYj+Lh5hN8gTGVv1M8Q+MCWVB8hDmN9ZfUDjdVDWHpxMJaF6pBcQHQZA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlu0no61tfOZdvhNHRWhKvlDODpDgYIxoPwBbqOlDc7E6Z4XdA
	Gx9oau8HibMzlst/xIUpZvfGpmr6MtoWcYy8Z+QLT34QDZFCFLl8AONgfl74RtDNXE1dIdPC8pH
	zRM1OlhpCvyiaW7QAc+25UL8K0yfstYBr2t58Yq9n
X-Gm-Gg: AZuq6aIemMcZa2sPCG+dVsTVpI6GvAdOUVFou4acLKeLuOPRJMVR4Q1sGDM7G6s2G0i
	phMgl9PlsGmcR1+lAdTsTuIRTNBBBswjf6URUlj3UkZeFo+qrfw/xhHe8Lt/As92dyy7cXrzxP0
	IvgtNgGl9AQpikCCYoFZv1HcQjNNLkFK5BYFQyMc2rA2EvnSMffQR01Q4WhIXQ/4hWisyM2zr5F
	Z7V4qwlC2WhicIA80GtGi6RA/uc/aZuOt9D81FgPg9Ghs7AyCPp0RtVbib8oqw+q0oIRGA=
X-Received: by 2002:ad4:5f8d:0:b0:888:7e02:50c4 with SMTP id
 6a1803df08f44-894e9fa1e33mr57059526d6.24.1769806578764; Fri, 30 Jan 2026
 12:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
 <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com>
 <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com> <CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
In-Reply-To: <CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 21:56:07 +0100
X-Gm-Features: AZwV_QiRhQ8aUH7eQGfWhKSFr9vhFJUyAeNYpfqKMwJkIBSms32xB9wnb_LdUwA
Message-ID: <CANn89iJ=Gfjves4qN6hu_VRPSedVRosJsvEQC_irFnEJU_eMLg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Ankit Garg <nktgrg@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, 
	Sagi Shahar <sagis@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255253-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,mail.gmail.com:mid,netronome.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAEC2BE96C
X-Rspamd-Action: no action

On Thu, Jan 8, 2026 at 9:53=E2=80=AFPM Ankit Garg <nktgrg@google.com> wrote=
:
>
> On Thu, Jan 8, 2026 at 8:37=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Jan 8, 2026 at 4:36=E2=80=AFPM Ankit Garg <nktgrg@google.com> w=
rote:
> > >
> > > On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > >
> > > > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > > > > This series fixes a kernel panic in the GVE driver caused by
> > > > > out-of-bounds array access when the network stack provides an inv=
alid
> > > > > TX queue index.
> > > >
> > > > Do you know how? I seem to recall we had such issues due to bugs
> > > > in the qdisc layer, most of which were fixed.
> > > >
> > > > Fixing this at the source, if possible, would be far preferable
> > > > to sprinkling this condition to all the drivers.
> > > That matches our observation=E2=80=94we have encountered this panic o=
n older
> > > kernels (specifically Rocky Linux 8) but have not been able to
> > > reproduce it on recent upstream kernels.
> >
> > What is the kernel version used in Rocky Linux 8 ?
> >
> The kernel version where we observed this is 4.18.0 (full version
> 4.18.0-553.81.1+2.1.el8_10_ciq)
>
> > Note that the test against real_num_tx_queues is done before reaching
> > the Qdisc layer.
> >
> > It might help to give a stack trace of a panic.
> >
> Crash happens in the sch_direct_xmit path per the trace.
>
> I wonder if sch_direct_xmit is acting as an optimization to bypass the
> queueing layer, and if that is somehow bypassing the queue index
> checks you mentioned?
>
> I'll try to dig a bit deeper into that specific flow, but here is the
> trace in the meantime:

Jakub, the issue is that before 4.20, calling synchronize_rcu()
instead of synchronize_rcu_bh()
was probably a bug. I suspect we had more issues like that.

 __dev_queue_xmit takes a rcu_read_lock_bh(), while the code (that you
added in 2018 [1])
to update the queue netif_set_real_num_tx_queues does synchronize_net()
(aka synchronize_rcu()) and in earlier times, it would mean that this
would maybe return too soon (say on preemptible kernels)

[1] commit ac5b70198adc25c73fba28de4f78adcee8f6be0b
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Mon Feb 12 21:35:31 2018 -0800

    net: fix race on decreasing number of TX queues

    netif_set_real_num_tx_queues() can be called when netdev is up.
    That usually happens when user requests change of number of
    channels/rings with ethtool -L.  The procedure for changing
    the number of queues involves resetting the qdiscs and setting
    dev->num_tx_queues to the new value.  When the new value is
    lower than the old one, extra care has to be taken to ensure
    ordering of accesses to the number of queues vs qdisc reset.

    Currently the queues are reset before new dev->num_tx_queues
    is assigned, leaving a window of time where packets can be
    enqueued onto the queues going down, leading to a likely
    crash in the drivers, since most drivers don't check if TX
    skbs are assigned to an active queue.

    Fixes: e6484930d7c7 ("net: allocate tx queues in register_netdevice")
    Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

So perhaps a fix for pre 4.20 kernel would be: (I kept the
synchronize_net() to be really cautious and because I really do not
want to test)

diff --git a/net/core/dev.c b/net/core/dev.c
index 93243479085fb1d61031ed2136f5aee22d8f313d..4dd1db70561d35fe2097afc8676=
4dd82bfd0bf27
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2636,6 +2636,7 @@ int netif_set_real_num_tx_queues(struct
net_device *dev, unsigned int txq)

                if (disabling) {
                        synchronize_net();
+                       synchronize_rcu_bh();
                        qdisc_reset_all_tx_gt(dev, txq);
 #ifdef CONFIG_XPS
                        netif_reset_xps_queues_gt(dev, txq);

