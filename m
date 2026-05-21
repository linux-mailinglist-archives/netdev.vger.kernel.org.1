Return-Path: <netdev+bounces-290237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HmYIo6LDmrG/QUAu9opvQ
	(envelope-from <netdev+bounces-290237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E459ED4E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED0543004CAD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14768363C6B;
	Thu, 21 May 2026 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgm0NQml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BC27FB2A
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338120; cv=pass; b=kLDSC78plhF3Fm008RJR4yaPklb1wfxvsFokdllifw2801JeH7TQ46vcPJy/kD1FZHLwan2e2VimH2tE/4e9idtlmz+JXJmv50fiZd+9Smvkc5MPMFK9HOIyvXBRDCcymu9JytCmYXA+elGCFB7HBVnK1jXk6YvWgOterS4SK08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338120; c=relaxed/simple;
	bh=rrWiu7XziLiS0ZtP+clkxl5v/1P1VUsr1mVLl0/au8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq5mBSvQe7T+9OebCcX1nhD9AOytq3qmOIu0VgCzlgPFM+7DjV5veHGIW2pwXbP03F8LYpwSDo2j1MHcGWSRoqBCMRtMrsieZqyLAiImOSlWIPqbhaBkWxgf1r+CHbsuhjkF6J/9GWg1QuKBgGaM3Iy3Y+s0Jmq8diI/bxwD+mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgm0NQml; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso38a12.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779338116; cv=none;
        d=google.com; s=arc-20240605;
        b=bA7hEUsw5R5OhHRhmkSAlwToJQeUWoazK/WeayptF1d7vlo76VLXVF2oifTpqckpdT
         tR83f0mf+jg0Vk+vFXWCH1cwjLCuFr2FjdSSN1cAUPcBbBM8E9KCAzkrY00hmfzUQIFP
         Lr8Rswg1cxvvq63FgzSW9bM1Q9f37+WV9kNAKkPEqK0zn9lFUOhQWwUaxDtrHckrHUSt
         24NQWGN7pfOgmdHGlUBuX1+htF+LmqQpeHx5DzPrsUedXXo6/Njsxp3RHpVClcgyU3x/
         l5lwlTf7aWJPKMwsfwQMArMbxCxvKXkpDHUiX0EHKrHKd45C/u2cVGAbGVUfLGNeXihD
         rUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wu87ltrY7KKbUf55cQPmsDg3ylXgD7KczleLgozBFxw=;
        fh=Y03eOENTDnr7Rm70phi/06rHchopo+RSaADlsMrkZvs=;
        b=M4dbUGnVMlf2Tw8ouznvk9XoMkBUCX2eKnZ5OF2sdZZDNwcBKtXgPLWiJRqNRz0o1/
         GjyMbAy1vxyp9Bw1gkrKj1nRAnf2O6lTkfMGFIr7K4+LYfhUstUZDghAUZspHTELn8xd
         KKJSNCEYT1uAAH8QRKl7pd2jQZYYO8PeigtGc2tDm9NyS/YeoYGik330paOsXFQXT5aj
         cACsIbtXSJDkxs7JJ37abHEAEL0N+lFbQTM2m77d+Sa7d2o8b5IMQ3O7t1NQwAYAWnj8
         0m74jCNg/TulilbsFhtGqqdRi6mfw5QYzKbTc8r50gspdgFK0nc+YO+prw1IB5KwTtB5
         5IaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779338116; x=1779942916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu87ltrY7KKbUf55cQPmsDg3ylXgD7KczleLgozBFxw=;
        b=mgm0NQmlDKeOR5CeajQ55sAFv/GI2uwfKUcV1h1I1kyD56mm/TNernFSy4Ma8pSy/j
         TlMJGMh+WmlNFChjtUAhdGsgbrt7bylGwbjF0jGRJWUpGwHc/TmWgLm1037leA/nPPl6
         CgO/T/s1PGIqO/b8sZwn+ylhDlRWswGSnXnjftjZmBWMdRMmQLJ+VC3Xy5pWqij6+PvO
         lII8BbkFXwVwjTEo/1UQ0dYFKin9tWzj2K2Ije2nnOzcZpIsCg331fol+hSK5rBEXg+P
         6SMrkzn5FgOgEbfCeoT7AU0hzVY6zFPRfxo+6r8eDK9kHJWFk0O/bivqDzMuXN4/ic1S
         owKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779338116; x=1779942916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wu87ltrY7KKbUf55cQPmsDg3ylXgD7KczleLgozBFxw=;
        b=pHl+JRv455ST3DmmqQxtYHhEkVtNydbXROzRoGCEt0q7LfdTcQciv6QZs0pBItAKj/
         5x23Hol4Ruo+1C8jwaXc9ieqZAukkuSuiyyKnwVMGt2wRW2qBvpMsescn96TPfIpYLTj
         +Q2JbkwPtt2lMa5ZM2LFywNiUSySptVzXjR4B7KguATowSnmwAkWWNa1dGCvgZ/kNWTa
         vOt4XgFVjETx4GljlF9cxApOgg/4G/GRTinMWUrg9jtBNzeg+slSmrqNkrWXfmHvpz/g
         Az01mnqxB/IToyvutqoFh/FZiD/7ZUevVvWCeSZghbPQXWjvDFjDBwyGPbMXFlZrCKuL
         CnkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+85ovv6x8MXdwkuJnogbFFLgHhXyzaMVHZbPzwj7NcqRTbt0cnDRGaUMFSnexReDBy4Cd0aH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhG88M4oWBVVo4NgyOVBZMIav/ESMHgextiPpw/QfwYQ/5RtF
	C/ysnGi5S1olm/8Tsw3yY20evh5rngy+Ck5xRGV4mXGkEE0B93rHOU7fYkyPd1K4cBKPuN8WXyB
	CAard85yzQex/DqiZYvoBOECKEG7JDf47FDsklqQ5
X-Gm-Gg: Acq92OEZPy5ceh34G3vFzKxckL7+pq6CJ5R5ndxiUaHgxoJ5g+aOyMWqNd9rQdhYvG5
	ut9Xx/9pWPgpl0PbWB4UmtWT2wyKKTUqXVcd65iUbqEnsSZCppJMQMFLNyRnqU2oNUKPA5keK8E
	IVoLikL461vfoYjLeW5Bu24tslVdJy/h8a75WcBX3iSZm6au8nxDjkkNZbltOZADfo+7nBzxek/
	8LomJ2T/jw0c16RV+8mI5tpub8KOePwHx4rJrRbcSxaAcQL6Y8MeSExh+RUS44qId41pW3D0ehL
	AqTj1/S0WDYwcxMqd5E=
X-Received: by 2002:aa7:c9d6:0:b0:678:93b4:1fd3 with SMTP id
 4fb4d7f45d1cf-6882e9c639dmr35674a12.6.1779338115988; Wed, 20 May 2026
 21:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com> <87mrxtwzz9.ffs@tglx>
In-Reply-To: <87mrxtwzz9.ffs@tglx>
From: Jordan Rhee <jordanrhee@google.com>
Date: Wed, 20 May 2026 21:35:03 -0700
X-Gm-Features: AVHnY4Js0Zc41PyCS3uqOaQn4dVho9Nr4F-7VQhJ5lGVJaJrdP_-a2gxX2OcPFU
Message-ID: <CA+mzVtuhB9J9MDHSUfmBeV8hdtprGBsBZWrxLRtvdZY_V_NhNA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
To: Thomas Gleixner <tglx@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	jstultz@google.com, sboyd@kernel.org, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com, 
	horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 917E459ED4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thomas,
Thank you for the review. We plan to rework this to use
https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/,
which will let us use the midpoint of pre and post while still
propagating the uncertainty window up the stack. I am going to address
some of the concerns you raised simply for the record, not because I
am trying to convince you one way or another. I do not expect a
response. Thank you,
Jordan

On Wed, May 20, 2026 at 2:08=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> On Thu, May 14 2026 at 22:58, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Enable chrony and phc2sys to synchronize system clock to NIC clock.
> >
> > Two paths are implemented: a precise path using system counter values
> > sampled by the device, and a fallback path using system counter values
> > sampled in the driver using ptp_read_system_prets()/postts().
> >
> > To use the precise path, the current system clocksource must match the
> > units returned by the device, which on x86 is X86_TSC and on ARM64 is
> > ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> > be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
> > by default on GCP VMs using Chrony, so we expect the precise path to be
> > used the vast majority of the time. If the system clocksource is change=
d
> > to kvm-clock, it activates the fallback path. Ethtool counters have bee=
n
> > added to count how many times each path is used.
> >
> > The uncertainty window in the precise path is typically around 1-2us,
> > while in the fallback path is around 60-80us.
> >
> > Stub implementions of adjfine and adjtime are added to avoid NULL
> > dereference when phc2sys tries to adjust the clock.
>
> Sorry that I did not react to this earlier, but I was burried in
> regressions and allowed myself to take a few days off.
>
> > +/*
> > + * Read NIC clock by issuing the AQ command. The command is subject to
> > + * rate limiting and may need to be retried. Requires nic_ts_read_lock
> > + * to be held.
> > + */
> > +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_c=
ycles,
> > +                               cycles_t *post_cycles)
> > +{
> > +     unsigned long deadline =3D jiffies + msecs_to_jiffies(100);
> > +     unsigned long delay_us =3D 1000;
> > +     int err;
> > +
> > +     lockdep_assert_held(&ptp->nic_ts_read_lock);
> > +
> > +     do {
> > +             *pre_cycles =3D get_cycles();
>
> This is a completely non-sensical hack. Why do you need get_cycles()
> here, which is a horrible and ill-defined interface that others are
> trying to get rid of?

We use get_cycles() purely as a sanity check against the TSC values
returned by firmware. We do not use them in the time conversion.
This check found a serious correctness bug in the firmware.

>
> Just because it's still there is not a good answer and it's actually not
> required at all. See below.
>
> > +             err =3D gve_adminq_report_nic_ts(ptp->priv,
> > +                                            ptp->nic_ts_report_bus);
> > +
> > +             /* Prevent get_cycles() from being speculatively executed
> > +              * before the AdminQ command
> > +              */
> > +             rmb();
> > +             *post_cycles =3D get_cycles();
> > +             if (likely(err !=3D -EAGAIN))
> > +                     return err;
> > +
> > +             fsleep(delay_us);
> > +
> > +             /* Exponential backoff */
> > +             delay_us *=3D 2;
> > +     } while (time_before(jiffies, deadline));
> > +
> > +     return -ETIMEDOUT;
> > +}
> > +
> >  /* Read the nic timestamp from hardware via the admin queue. */
> > -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> > +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> > +                              struct gve_sysclock_sample *sysclock)
> >  {
> > +     cycles_t host_pre_cycles, host_post_cycles;
> > +     struct gve_nic_ts_report *ts_report;
> >       int err;
> >
> >       mutex_lock(&ptp->nic_ts_read_lock);
>
> Why is this lock taken _after_ the regular (fallback) pre/post
> timestamps are aquired?
>
> What's wrong with doing:
>
>        do {
>                 guard(mutex)(&ptp->nic_ts_read_lock);
>
>                 ptp_read_system_prets(sts);
>                 err =3D read_nic_timestamp(...);
>                 ptp_read_system_postts(sts);
>        } while (err && !timeout(...));
>
>        return err;
>
> which moves the "fallback" timestamp right next to the actual hardware
> readout?

The lock is taken at the smallest scope possible, which does not
include the pre/post TS reading. This routine is called by multiple
callers, not all of which need the pre/post timestamp. Options are to:
 - move the pre/post TS reading here and add branches to conditionally
sample them only when needed
 - always capture the pre/post TS readings and discard them when not needed
 - duplicate the locking logic, once for path that needs pre/post TS,
once for path that doesn't need pre/post TS

Since the fallback path is expected to be rarely used, lock contention
and retries are expected to be extremely rare, and chrony is resilient
to samples with high uncertainty window, I chose to prioritize
cleanliness of the code and keep the pre/post TS reading in the caller
where it is actually needed. That said, I do not feel strongly about this
and would be open to moving pre/post inside the mutex if I were sending
another revision.

>
> That would make the "fallback" case too precise, right?

Moving pre/post inside the mutex makes no measurable difference
because the lock is rarely contended. There is 4 orders of
magnitude difference in RMS offset between precise and fallback paths.

>
> After noticing the obvious, I just checked what our new AI review
> overlord "sashiko" has to say about this:
>
>      "Does wrapping the timestamp read outside the locks and retry loops =
skew the
>       measurements?
>
>       In the fallback path, ptp_read_system_prets() is captured before ca=
lling
>       gve_clock_nic_ts_read(), and postts() is captured after it returns.=
 However,
>       gve_clock_nic_ts_read() acquires ptp->nic_ts_read_lock and calls
>       gve_ptp_read_timestamp(), which can sleep using fsleep() during ret=
ries. This
>       means the prets/postts window could include mutex wait times and sl=
eep
>       durations."
>
> It _IS_ actually on spot. So why the heck did this garbage get merged
> without addressing this obvious fail?

- The fallback path is expected to be rarely used since it requires
changing the default configuration
-  The lock is rarely contended as there are only 2 callers, one of
which only executes once every 250ms,
  and retries would only occur if a VM exceeded their rate limits
which have been tuned not to occur
  under normal chrony calling patterns.

>
> What "sashiko" actually saw aside of that, which I didn't see myself when
> looking at this, is:
>
>    "Similarly, in gve_ptp_read_timestamp(), the get_cycles() bounds are t=
aken
>     outside the gve_adminq_report_nic_ts() call, which acquires the share=
d
>     priv->adminq_lock. If there is lock contention, the cycle bounds coul=
d become
>     extremely wide."
>
> Oh well.

get_cycles() is only used for sanity checking the values from
firmware, not in any time conversion.

>
> So what you really want is:
>
>        do {
>                 guard(mutex)(&ptp->nic_ts_read_lock);
>                 guard(mutex)(&gpe_priv->adminq_lock);
>
>                 ptp_read_system_prets(sts);
>                 err =3D read_nic_timestamp(...) {
>                         ...
>                         return gve_adminq_execute_cmd_locked(....);
>                       }
>                 ptp_read_system_postts(sts);
>        } while (err && !timeout(...));
>
>        return err;
>
> Or just rely on gpe_priv->adminq_lock in the first place. No?

adminq_lock is private to the adminq layer and protects adminq shared data
structures. nic_ts_read_lock protects the global DMA buffer that receives
the timestamps. Since retries are a response to rate limiting, we must wait
between retries, so we do not want to hold the adminq lock across
these retries as it would block other non rate-limited commands.

>
> But what's worse and escaped the AI scrutiny is:
>
>   Your attempt to convert these 'get_cycles()' time stamps after the
>   fact and outside of the timekeeping core protection is fundamentally
>   wrong.
>
> get_device_system_crosststamp() does
>
>       do {
>                 seq =3D read_seqcount_begin(&tk_core.seq);
>                 take_timestamps(...);
>                 convert_timestamps(...)
>       } while (read_seqcount_retry(&tk_core.seq, seq));
>
> which covers the whole sequence of taking the snapshots from the
> hardware and the conversion.
>
> Your abuse of this is completely out of spec. Just because it did not
> blow up in your face yet does not make it in any way correct. You do not
> even get bonus points for creative abuse.

We use ktime_get_snapshot() to capture a historical snapshot before samplin=
g
the TSC, and we pass it to get_device_system_crosststamp() which
uses the snapshot to interpolate the sample if it occurs before the current
timekeeping interval. Perfectly within spec.

>
>
> Now let me look at the "firmware" provided timestamps.
>
> That's the poor mans emulation of actual hardware timestamps aka PTM.
>
> Why do you need all this pre_nic/post_nic muck there? Fix your firmware
> to actually honor PTM and not provide some made up version of it.

This has to run on platforms that don't support PTM.

>
> Also the whole debug mechanism of comparing the time stamps of
> get_cycles() with the timestamps provided by firmware tells me that your
> firmware is a hacked together piece of garbage.
>
> If you want to use "hardware" timestamps then populate the
> ptp.info.getcrosststamp() callback.
>
> If your firmware really can't do PTM and only provides pre and post
> values, then you simply can take the midpoint in your getcrosststamp()
> callback:
>
>       do {
>                 guard(mutex)(&ptp->nic_ts_read_lock);
>                 err =3D read_nic_timestamp(...);
>                 system_counterval->cycles =3D (nic_pre + nic_post) / 2;
>       } while (err && !timeout(...));

We considered returning the midpoint of pre/post up through
getcrosststamp(), but there was
no way to communicate the uncertainty interval which is important
for some of our use cases.
https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/
fixes that issue, so we can use that when it lands.

>
> If you do not even trust your firmware then you still can validate it
> easily without creating horrible hacks:
>
>       do {
>                 guard(mutex)(...);
>
>                 ptp_read_system_prets(&ctx->sts);
>                 err =3D read_nic_timestamp(...);
>                 system_counterval->cycles =3D (nic_pre + nic_post) / 2;
>                 ptp_read_system_postts(&ctx->sts);
>       } while (err && !timeout(...));
>
> and then check the ctx->sts timestamps against the results provided by
> get_device_system_crosststamp() after conversion in your
> ptp.info.getcrosststamp() callback:
>
>         err =3D get_device_system_crosststamp(..., &ctx);
>         if (err)
>            return err;
>         if (ctx.sts.pre_ts > xtstamp.sys... || ctx.sts.post_ts < xtstamp.=
sys...)
>            return -EBROKENFIRMWARE;
>
> no?

get_device_system_crosststamp() has nontrivial logic that operates on the s=
ystem
timestamps, so I am not confident that a bad TSC value would be detected
if we ran it through get_device_system_crosststamp() first. The check
is simplest
and strongest when performed against the raw TSC values received from the
device, before passing them to any kernel API. But I hear your point
about mistrusting
the firmware enough to need this check.

>
> Jakub, please back out this hackery before it makes a precedence for othe=
rs
> to copy from.
>
> Thanks,
>
>         tglx

