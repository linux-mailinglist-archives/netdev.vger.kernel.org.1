Return-Path: <netdev+bounces-291976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIXZMXgsFmqdigcAu9opvQ
	(envelope-from <netdev+bounces-291976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0265DD8B6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEC8B301154B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BC73CF952;
	Tue, 26 May 2026 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd/kG/Ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9833C5856
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838060; cv=pass; b=QOgld8+PK0FM3Pz/1Zr2swuOzIgNI8DDfusOOFnXH4XNQEYHbkVv4ojxBWd1pH4/2eZHDtJi9iXFhAd6QjHWmqNlP1tAumuAb5Z6pcttjA5fV+08GXV3yDFZEEKetljDuFnHFoxgURFmM+StHzQ16qS+5cUK8xGg/QVPMNaBilc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838060; c=relaxed/simple;
	bh=bwnH+qqXBGDNH1pSWPHYbKfMg7zHv6kdJ60OymekNZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lW9JcSjtQFi2KQgeqwH6e1jroWIGtMkHeIwDV3aIFz1BxLYpPw6PqXqB18c0KvRGYolwVSFf75ufOp+N9UlFQp2rQANTF5Jg/BA//ZlbwmbCy3obZ4PKAIWA6U6ov0ZOjqXF4Tkwlcfd7PgBk7Getlj4IaCM5q9Rx/PqdAlFWlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd/kG/Ul; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso9024359e87.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779838057; cv=none;
        d=google.com; s=arc-20240605;
        b=bcFuh06b/FBIPr9Z+FlaCOvtvlTtgRbtjU8yMyZd6IorFk6BSvn3VkbJZ6T/YkKLcy
         dJYSAKym45i2RDeq9d69uoQp4KNZh99dIAShPcQYgzP7xfmHaqbbVM8TtvqxKxKuyal+
         1EA4eIEX4rLMRAwQWgJTqMFLraDdPTA5cQlTyGWE6QBCCY9wGFahqq4EHRvFTWpYjJ0a
         GgBcp3vgc8lbW8bJEt4FcsYbpAwr7YqPrGLCJmP3ZSPYTMNSZn12WCe0nN7nLQmGCdwo
         NZNJurYwwaFpqK4sgLJ9Q8dQYx93DYkGgpiwhUSGdKJ7JW0/O9vTSF09x6Ycaz2KPeZm
         kIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        fh=4utlQKp9LMHHgcddQo9amSqmiaxwJIXaYCH2iXW+X8c=;
        b=Jdcm0BISh01ssvp6Kd90mZ36uyQdTYWcfF/4a+a/i+k0TXTcZcOcR0wsQ1yUVbT4ZW
         FkG38kaM0I6yChZZcK+nr7AkuFhUlFBKAIqcaG3h+1QTOQsAoevH7ZxVrjDPZERG8DJj
         bIuCU0WbAqZmPlyAHGnfmsbLRm6t1O0xClCbTe6Px+t65Z4q6GJp9I2pZRlAB4zVur/X
         KVOvMLgSpxdq274yh5V/QWeyWvaG8VKwARqXKQu2gCw2b1MfZme9w7l0JLiFR81pspqL
         30Q+rTvi1JdE4/D3YKcGgBZTBmGOEpAGFy+5I6iw6Q0D1zChj3ICXTDhV7H4phWqPGur
         zjWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779838057; x=1780442857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        b=Vd/kG/UldV/BhQ4b693e9yQzMsEFsREfig7YKZdNZX5NlxhcbTNvvBiG3GvOH0QbJx
         /gQTNr/p3q3pMlprwEkaNM1mUxUsF2TdiDkNDNUWxX9tnhgArpyht5F0klzhn163qJ3Q
         MfHj4JZjZCB2NnFtH0AQ6+cjswnyFZfn25AilIdxqgDL5iuI16G2lMQ4T385djX15Vr7
         9XW75s5bzUF4NFdfnQ5XQH23+1QcwuQBTNyAXfcum4TvDGT/t/lbkKnVSDqHrNgOTQsk
         /NWzlXfwdV5MZKDqP60nfTlJxALLsEu8jLZsJB/6z0HrD+0wQpGUBmjrlzFfugH31wKE
         qH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779838057; x=1780442857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7VvVVF9TQ2M3AhNyLDn1boVhFbmnNPIqQWMPVPpz0o=;
        b=SU4iNyQyMTCtTYaO0g7rj68OE7QEwIOSNgDA7UkUR5ROV09WZw8Q87dejJLhSxroHx
         wn9kmPAmnhqlr42f0/DExk9T26hy3/4YjoaPewrD2blq+eqwh9qriM+JIvkQEbYMQKzE
         n4VivW2NlRpVofCHHDMVjgWLVraz+N24DExc29lL0TyOL2/r4FjM+B9rYBMYtuJpIBUL
         lrZ+DFzG3OS28KZFfEtACXL3WycM3j8cvwNIzhTEbli+gAMzFf7AWQxuksIqAUdWpSGm
         OKiGt4yIt6lXHM5oRq2D0ZKPSe4Hpbg5p9hwPImzU6jSux81Iw8NxHsZVMYcCKjfLRxO
         Te2A==
X-Forwarded-Encrypted: i=1; AFNElJ8eFvlfXp8kI4FQzep9EfSWw3oRoLlM13oqfG6sqSQP88+p0q6fE+24B8DxGnn/JyLITNXElsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErfjieMXyLbOnWB+OU4XaodMKXh1Yrgwa7v2pj2UZ1cUwfeqF
	tSCZTJ4yjqq3MLacwjDMtU1qaBQOMnY5h9wb8pGCvz9QzB1CQgSMIrBIPUdKYYE0gSor9bwgtwZ
	XfLoui4RWDGgp+CnzTOFcnj19sRv/b9E=
X-Gm-Gg: Acq92OFatLIsxqO+X8batVx6UnRCWP+EaAJ0JQyHcXjptFro999A6er9BQW/LNcTAzT
	5UMI1morjLc0ji6jbtWYS6hK6drYBJzOlimC1IN7EiK+mcoTK7PFJyD8hGqOOcmgF/ofDO9hoyh
	8mt1mSZseQ6G00keR7StzE5yI0H0ghVKz2o3tXxJq6dWpWFqhkh3HR1zvYYbnutApGjLKDkU5xW
	rcOiWvryePAiAsIvef5AvZP41TqqSisFeNJAj5S1cRplughPlA1b1HtEbm8230Sd6/5lKTNCeax
	hlNeQHjIoIO4J9lalzc5ysHO52wUmgCuBLlp308=
X-Received: by 2002:a05:6512:3d24:b0:5a8:9b19:8ff8 with SMTP id
 2adb3069b0e04-5aa323cbbcamr6743621e87.32.1779838056809; Tue, 26 May 2026
 16:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer> <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer> <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
 <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
 <ahChjcRmM+wEx2uq@boxer> <CAL+tcoBud6+nZ=Zeq-Ja+nnOcfwt71Z_QBofOS3qyrNt3Tkkvw@mail.gmail.com>
 <ahX3zCRWTD2v7kwn@boxer>
In-Reply-To: <ahX3zCRWTD2v7kwn@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 27 May 2026 07:26:58 +0800
X-Gm-Features: AVHnY4Ki4miX94TDW1Znm1UKdhBucSygFFqlEh1pGvikZPAPr6IU5qCaAcKosK8
Message-ID: <CAL+tcoBC8CUzu9S8UDN7tW3H6L9F3TMzt_pF=-dXTJ6_Mz2F4w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291976-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC0265DD8B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 3:43=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, May 23, 2026 at 07:49:00AM +0800, Jason Xing wrote:
> > On Sat, May 23, 2026 at 2:34=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Fri, May 22, 2026 at 09:48:39PM +0800, Jason Xing wrote:
> > > > On Fri, May 22, 2026 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2026 at 10:24=E2=80=AFPM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > > > > > On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > > > > > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowsk=
i
> > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wr=
ote:
> > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > >
> > > > > > > > > > > The series is the product of previous review from sas=
hiko[1].
> > > > > > > > > > >
> > > > > > > > > > > 1) META
> > > > > > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > > > > > >
> > > > > > > > > > > 2) PUBLISH of CQ
> > > > > > > > > > > patch 2: make sure xsk_addr->addrs[] can be published=
 to cq when
> > > > > > > > > > >          overflow occurs.
> > > > > > > > > > > patch 3: keep cleaning up the continuation descs (mor=
e than 17) and
> > > > > > > > > > >          publish its address when overflow occurs.
> > > > > > > > > > > patch 4: like patch 3, but only handles the invalid d=
escs cases.
> > > > > > > > > > >
> > > > > > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960=
-1-kerneljasonxing@gmail.com/
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > V4
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260517063311.2892=
1-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. correct the description of xmit path in patch 3 (s=
ashiko)
> > > > > > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > > > > > >
> > > > > > > > > > > V3
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260515123018.8014=
7-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. avoid breaking previous usage of sendto, and silie=
ntly handle
> > > > > > > > > > > overflow case (Stan, sashiko)
> > > > > > > > > > > 2. add one particular exception process in patch 4 (s=
ashiko)
> > > > > > > > > > > 3. adjust the selftest to make sure it passes in eith=
er virutal or
> > > > > > > > > > > physical machines, which includes add usleep to suppo=
rt physical machine.
> > > > > > > > > > >
> > > > > > > > > > > V2
> > > > > > > > > > > Link: https://lore.kernel.org/all/20260510012310.8857=
0-1-kerneljasonxing@gmail.com/
> > > > > > > > > > > 1. adjust selftests (Jakub)
> > > > > > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > > > > > >
> > > > > > > > > > FWIW I still get test failures (yes with patch 5 applie=
d). PTAL.
> > > > > > > > >
> > > > > > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > > > > > >
> > > > > > > > > I noticed there are some flaky tests which have nothing t=
o do with the
> > > > > > > > > series. Can you confirm that it's not caused because of t=
he series?
> > > > > > > >
> > > > > > > > That explains the different results as i am using i40e/ice =
which have
> > > > > > > > multi-buffer support whereas ixgbe does not even support mb=
uf at XDP.
> > > > > > > > Broken tests are from mbuf cases.
> > > > > > >
> > > > > > > That's weird. I never expected the failed tests to be about m=
ulti-buffer.
> > > > > > >
> > > > > > > Are they the same as the output you attached last time? Or so=
mething
> > > > > > > new? Could you please share it so that I can investigate the =
root
> > > > > > > cause?
>
> [...]
>
> > > > >
> > > > > Sorry, Maciej. I managed to get one server with i40e nic but stil=
l
> > > > > couldn't reproduce it. Can you try the attachment (that is the
> > > > > replacement for v4-0005) instead? I removed those nasty CONT test
> > > > > cases...
> > > >
> > > > Ah, I think I eventually figured out a solution. Maciej, could you
> > > > please test the 2nd patch instead?
> > > >
> > > > This patch reworks the CONTD test cases. Cross finger.
> > >
> > > Please don't rush things here, I believe we need to think a bit more =
here.
> > > I have second thoughts about overall approach.
> > >
> > > My understanding wrt CQ was that it is a container that holds descrip=
tors
> > > which have been successfully transmitted. Now we want to add also lef=
tover
> > > descriptors from broken packets, which might confuse user space sides=
 in
> > > case they were relying on behavior described above.
> > >
> > > The intent is right of course as we don't want to lose UMEM descs, bu=
t I
> > > feel like we need a separate mechanism for that rather than putting
> > > invalid descs to CQ.
> >
> > I don't sense anything strange here if we stick to put those
> > invalid/overflowed descriptors into cq. AF_XDP is only a tunnel that
> > transfers the data. That's it. A bit like how the physical link works,
> > which means it possibly drops data because of congestion.
> >
> > Upper protocol is used to guarantee when to (re)transmit a packet -
> > the mechanism is the ACK driven in terms of TCP. TCP is absolutely
> > capable of finding such an abnormal thing happening by checking the
> > seq of incoming ack. My takeaway from this is we don't need to
> > deliberately design new stuff to fulfill direct and immediate
> > communication.
>
> AF_XDP is often used for L2/L3 forwarding, UDP, custom transports, so I
> was afraid some existing solutions might be relying on CQ entries implyin=
g
> successful Tx.
>
> Generally this issue is highly unlikely yet a thing we need to address so
> let's follow your approach, but for that we need to update documentation
> and align ZC side so that we would not have to deviate test cases.

Sorry, I don't see the point why we need to align the ZC side rather
than skipping them in ZC mode simply?

>
> >
> > CQ works somehow as a notification that tells user space whether the
> > kernel receives the data from the app and handles them. Without
> > putting them in the CQ, the only thing for userspace to do is simply
> > wait.
>
> I don't follow the last part of the sentence but let's disregard it.
> Userspace gets errno/retcode in generic xmit so it is aware of underlying
> issues and then it's app job to act upon it.

Right.

>
> >
> > With that said, IMHO, I cannot figure out why we need a separate queue
> > or something like that. Of course, a new notification that handles all
> > the possible/potential exceptions and contributes to the performance
> > of the upper layer is worth a try :) The latter is crucial.
>
> We discussed with Magnus it would be good to have a dedicated xsk_queue
> stat for that case, such as 'oversized_descs' which would be bumped by th=
e
> amount of descs produced to CQ.

That is surely necessary, which was actually put into my todo list as
well as skb drop reason in the xmit path. But it's a net-next/bpf-next
material.

>
> >
> > >
> > > Does it make sense?
> > >
> > > Besides, even though we would stay with proposed changes, behavior be=
tween
> > > modes should be aligned. Right now ZC seems to be broken in touched
> > > regions here - when we hit the limit of frags via pool->xdp_zc_max_se=
gs,
> > > we break the loop and discard the packet, never post it to CQ and the=
se
> > > descs are lost from user space POV. Then we would continue on next ca=
ll
> > > and interpret the rest of too big packet as a separate one (clamped) =
and
> > > therefore submit corrupted packet to HW.
> >
> > Right, this is how the previous selftests changes pollute the
> > subsequent tests after that. I think the new version of the attachment
> > should pass all the tests since I put all the CONTD tests separately
> > into another two functions? It's pointless to test those in the zc
> > mode.
>
> We need analogous fix on ZC, then no such quirks in tests should exist.

I don't regard it as a quirk honestly. I'm curious what is the
advantage of unifying it just for this case? ZC mode doesn't need to
test the overflowed skb that appears in the __xsk_generic_xmit path,
right?

> Test is doing the same thing regardless of underlying mode. Only the rang=
e
> differ (MAX_SKB_FRAGS vs pool->xdp_zc_max_segs).
>
> To wrap up, I see it like this, moving forward:
> 1. fix docs
> 2. add ss stat
> 3. wait for me with ZC fixes (I'm slow!)
> 4. inspect if tests will fly
>
> Let me know your thoughts! Maybe Stan wants to chime in?

Roughly I agree with the points if you insist on working on ZC fixes.
I can wait for you :)

My plan is as follows:
1. only submit the 0001 patch only in v5
2. wait for your selftests fixes and then submit that series
3. move on with batch xmit since I don't expect this series to be a
blocking point

Thanks,
Jason

> Maciej
>
> >
> > As to the series, if no objections or any suggestions jump into the
> > thread, I'll post the series within a week.
> >
> > Thanks,
> > Jason
> >
> > >
> > > I'll be looking at ZC API but i do think we need a common approach,
> > > mode-agnostic.
> > >
> > > Thanks,
> > > Maciej
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > Really I don't think I have much time to spend on these tests whi=
ch
> > > > > makes me feel extremely annoyed... It's not easy to analyze the c=
ode
> > > > > without a reproducer. The good news is that now I highly suspect =
that
> > > > > this kind of CONT test cases pollute the whole cq which affects o=
ther
> > > > > tests. Before I give up on the 0003/0004 patches, I'd like to hea=
r
> > > > > some advice from you. Thank you.
> > > > >
> > > > > My original intention was to push batch xmit forward but at that =
time
> > > > > sashiko pointed out some unrelated bugs accidentally.
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Jason
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Jason
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Jason Xing (5):
> > > > > > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in =
xsk_skb_metadata()
> > > > > > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP m=
ulti-buffer Tx
> > > > > > > > > > >   xsk: drain continuation descs after overflow in xsk=
_build_skb()
> > > > > > > > > > >   xsk: drain continuation descs on invalid descriptor=
 in
> > > > > > > > > > >     __xsk_generic_xmit()
> > > > > > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > > > > > >
> > > > > > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > > > > > >  net/xdp/xsk.c                                 | 44 +=
++++++++++++----
> > > > > > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +=
++++++++++--------
> > > > > > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > 2.43.7
> > > > > > > > > > >
> > >
> > >

