Return-Path: <netdev+bounces-274721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO+SFZ7vzmktsAYAu9opvQ
	(envelope-from <netdev+bounces-274721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:37:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625838ED5B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45A2E301FB53
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57D3B38A0;
	Thu,  2 Apr 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLWB8JIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D9361DD5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169432; cv=pass; b=VLw3/FV998qOdpeTwlp7xccTXFaFs/lM2vLa24WzLvU+E+sKlbvAUQ+3Tve0VKkfZya67vwIoHm9oEPNcqaYa7otS4pSXBpCPnpv2FiN/zGOoFEfnn6FytNdPUFsKBY15QpiX7v53MdE302UeNfPoG/jC/dqDWnPMjjpEh+5x8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169432; c=relaxed/simple;
	bh=1Jh0vxXr4ZFHOzGbkLJdU9z7cLnd46O/8Fi79peIc8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5TiRws1OoZHFQVQdx3IaPskRGdK5fFjhUgJmyVVzYgwoBAPbqZabZyQ1PvG97cAkjpOeff+w6OUHkqEjORkRO8R84rxGRSiErJ99rk6cyMStuaWgpnaMOBttEN8YnnmufSPazlxpATId0X6LxwgX5B7ZHCwZN7xqynnuIr9Pmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLWB8JIF; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so2012a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775169429; cv=none;
        d=google.com; s=arc-20240605;
        b=gPCWOUAgLYFs7NCZfxOGpZQlCwGaGpskagNypckDrkKVecgZuOlFjU1abPTTrlfSYu
         WPIxMVVzh7/g2aS196pV82NpsltksKpB4tLLTQT51S8G6WP2q2rnCJ0GnopR8ZLmTXjM
         wMVa7WRjFAgl69JaRpcJ9Qj6cgDufTxHS3qnkofkiPjlAcV8zlPcg2dbFZTY/Uad3kq3
         /mKYgRkKHShwROANBcfp6hPPUxeZ8+4v0ud7BsrbBu152Ylq9/Ko65tO5C2Lv31tzID1
         erlCd7dBU6w9uKGQ8txH48vBV/NUmRO9FIIJyBWXU83g7cWK3d2A5xoETjw6YmoBaLrA
         DP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQbXMp17s0qmSHCOH/pf215QEhTjMWbLAgi5xYalmoI=;
        fh=W2RhlZbcaHYT+kK1vP1fQcMOjx5qy+rpVWUUJqGwVA0=;
        b=V9wKpEgq5FAx9I1+dloUdGTD0Un1ymd8jP+DTEKzv7ppmxDuyW6LO+d2H5oAWZIwI7
         bqDUkqTjHhIK3txspx6A5ETueQZ3hczKmXILh1/04l3/LP43bh4K9KNfJJ8O3iyPFLaB
         /IVy+0pnkb39CBwS0ip3CiDrUhbr9MYhqqCeTKvkVfshaBZom+/ZMEfADc8QIOr1lkVJ
         u62D2tVzc6tDcXvvmd9W5zIbdS4XtdIwvPw7kUwYqmDeIMDzvP5aBTToLMlvwR6wCFmH
         qwh6+onMgoDn9SQjwYZiqmYhlebB9ZeZLL9XRGhquMC2oolF0yW8XPZsu82jaXAhY84c
         3FKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775169429; x=1775774229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQbXMp17s0qmSHCOH/pf215QEhTjMWbLAgi5xYalmoI=;
        b=qLWB8JIFBav8QMIDxNItptqxbN6eah53qQCReXH8S2ZaYEU+L59a9rf05Gf+3Xo/ns
         tpslPk6OOnrMXq3d5plyPYQQLTRBP/0XKS3rAf+hIOpmeU0XT9g51Yv15+2iOEdi4viy
         okIPPglHu/8LP5Eg17+i7n8thl4BER/GeakS637/x34TkbVMbkmWj9DXMziNmrBZjr2Z
         0B5xLcRXd8zzx1q0keAu/JB3kR8pQkX7AVMyWPHz0OVv9iWsApCednsky1HbNeJplF3N
         UKJMEShdTf2zZsWNax/k9WlrwaN6GIzEITaAhPPZiEkvoNt5+phrRGj/Ow6nn7VI/8RQ
         XR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169429; x=1775774229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQbXMp17s0qmSHCOH/pf215QEhTjMWbLAgi5xYalmoI=;
        b=PpPZq8RaNlp65s9fqXJy2tw65HWANQMqO9TmtI9O3KbL2mqfJ8MTD5M7ReDUBv/v1a
         rdEda9pR+IsxCb2KhOLSYvssS+jQrcq59o7vSMzRVspU9+ANtMAZmfbORr6r3uHUsv9y
         sIQonETVpm4t4TZlNuSMzrwfTe7sNLuctAoQ+qalTcHBzsxqTmYlu3ZM5TSl7qQysfhj
         V+1i8mf90FP+tQql0obYGfi+PAMGCcSnguHJOMjRinjn6rNXzsOkfmgff796o8SjhX90
         wPIEvTvMYYVDJ/R1hk3gBGbol50AIzMq/YHnVuwCFom0uzbfPLIxz+32sOkTc5JxOC9q
         exdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQtUfYeC5uBMloD+bQTX7Fax7bCzlfuJS6SOy3zYjMizDnmE3+6ygNta5ekwkPD6aVXSy6dgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mNgIc02ayj92yOG6er5G354qo1Kk0cXpnkZ3KnGrUAP4Z+Bn
	9KwZXsNejwo6HE/sXEuttSBOEK5KMQTeDv4sB7eOSzYcmcMr6TzZ1mSr4XygjeETt0AbDhHW0BS
	l/dTquMR9CeRnzSc1h33Sr4J2XrZ9Mxa8vKhbwlCD
X-Gm-Gg: AeBDievt+d5L5X+1mO9NqBF7uMAsCFmiBKItBZcghRMxgB1DCMGM+C4EWaAL5+HMt/f
	lzdnjsHDsxslgx3bN3X2tIBZPwyRH9hsy/Mg+dNaXg3LcwmApjYlHDLHv5LqpZPG/H8PPnrwVgC
	ioikMh8xv22uYd/pMy5J6JwbYTSY7vDvaJzQaNVRJ8mq4L6j/oawSgUUqCEgKsoNMD/Trn+PkLg
	TaEQf1fT1mptJzpsGXr59/iFCKIkS0+PJdWEpY29WVhmfCbnWFimk4qS+vLBsCxorWebjkgpoNj
	C0Ms18y6JyANSiUCYfNgFa8FGA4O2PGyDl1J37bi7Rx6qzyI
X-Received: by 2002:aa7:c457:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-66e43f2e6ccmr1735a12.7.1775169428404; Thu, 02 Apr 2026 15:37:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-4-hramamurthy@google.com>
 <20260329212002.2875815-1-kuba@kernel.org> <CA+mzVtuK6NSrnZdcwyToTseFqBU86jRn9nbdeLGFjhjeok=q2g@mail.gmail.com>
 <CAMP57yWZkgU989sN38ycxiR1p5w48mssAwycZY4BZS28nDObRw@mail.gmail.com>
 <CA+mzVtv-91ru7v6GxOS80xihE4ZbwGqdyQdKPTHv+woKaeOhuQ@mail.gmail.com>
 <CAMP57yVS3OiFX+Qjcr9djO46OLZ=KuW2awD-7fCPZ=k2SdHNnw@mail.gmail.com> <CA+mzVtuL9iZ71VkMhb8vhs8idqOfJ=heWwgMLkYUjv6F0L91kQ@mail.gmail.com>
In-Reply-To: <CA+mzVtuL9iZ71VkMhb8vhs8idqOfJ=heWwgMLkYUjv6F0L91kQ@mail.gmail.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Thu, 2 Apr 2026 15:36:56 -0700
X-Gm-Features: AQROBzB1fuleJobk1NTpIdxLyekNycrNmrboJoEL591WfodxL-pnKMwjR_2oxGk
Message-ID: <CA+mzVtst5BJt1rU_MP11wqU8T_89gRfqLr-mA6wdiffFyh=K8w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
To: Naman Gulati <namangulati@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, hramamurthy@google.com, netdev@vger.kernel.org, 
	joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274721-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5625838ED5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 9:15=E2=80=AFAM Jordan Rhee <jordanrhee@google.com> =
wrote:
>
> The iowrite32be() inside gve_adminq_report_nic_ts() will prevent
> reordering by the compiler because it uses volatile, and the VM exit
> will prevent speculative execution by the CPU.

After some offline discussion with Naman we agree it's functionally
correct without
a barrier. However, since it's not explicitly part of the contract of
gve_adminq_issue_cmd() that
it causes a VM exit, it would be best to use an rmb() to prevent the
2nd get_cycles()
from being speculatively executed before gve_adminq_issue_cmd(). This would
prevent a subtle bug if gve_adminq_issue_cmd() were to change, and the
performance hit of the barrier is negligible compared to the VM exit.

>
> On Thu, Apr 2, 2026 at 8:53=E2=80=AFAM Naman Gulati <namangulati@google.c=
om> wrote:
> >
> > On Thu, Apr 2, 2026 at 8:38=E2=80=AFAM Jordan Rhee <jordanrhee@google.c=
om> wrote:
> > >
> > > We know that gve_adminq_report_nic_ts() will cause a VM exit, which
> > > will act as a full barrier. Additional barriers are not strictly
> > > necessary from a functional perspective. Can we rely on this fact or
> > > do we need explicit barriers?
> >
> > I don't think that's enough. Without a barrier get_cycles can be
> > speculatively executed before gve_adminq_report_nic_ts.
> >
> > >
> > >
> > > On Tue, Mar 31, 2026 at 11:05=E2=80=AFAM Naman Gulati <namangulati@go=
ogle.com> wrote:
> > > >
> > > > On Sun, Mar 29, 2026 at 9:31=E2=80=AFPM Jordan Rhee <jordanrhee@goo=
gle.com> wrote:
> > > > >
> > > > > On Sun, Mar 29, 2026 at 2:20=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > > > >
> > > > > > This is an AI-generated review of your patch. The human sending=
 this
> > > > > > email has considered the AI review valid, or at least plausible=
.
> > > > > > ---
> > > > > > Subject: gve: implement PTP gettimex64
> > > > > >
> > > > > > This commit implements the PTP gettimex64 function to enable ch=
rony and
> > > > > > phc2sys to synchronize the system clock to the NIC clock. It re=
ads the
> > > > > > NIC timestamp along with pre and post system cycle counters to =
minimize
> > > > > > the uncertainty window.
> > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/driv=
ers/net/ethernet/google/gve/gve_ptp.c
> > > > > > > index 140b8fbce4f4..bea794541f30 100644
> > > > > > > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > > > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > > > > > > @@ -10,28 +10,203 @@
> > > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > > +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> > > > > > > +                                  cycles_t *pre_cycles,
> > > > > > > +                                  cycles_t *post_cycles)
> > > > > > > +{
> > > > > > > +     unsigned long delay_us =3D 1000;
> > > > > > > +     int retry_count =3D 0;
> > > > > > > +     int err;
> > > > > > > +
> > > > > > > +     lockdep_assert_held(&priv->nic_ts_read_lock);
> > > > > > > +
> > > > > > > +     do {
> > > > > > > +             *pre_cycles =3D get_cycles();
> > > > > > > +             err =3D gve_adminq_report_nic_ts(priv, priv->ni=
c_ts_report_bus);
> > > > > > > +
> > > > > > > +             /* Ensure cycle counter is sampled after AdminQ=
 cmd returns */
> > > > > > > +             rmb();
> > > > > > > +             *post_cycles =3D get_cycles();
> > > > > >
> > > > > > Are execution barriers needed around get_cycles() here? rmb() o=
rders
> > > > > > memory accesses, but the CPU might still speculatively execute =
the cycle
> > > > > > counter reads out of order with respect to the AdminQ commands.
> > > > > >
> > > > > > Could this speculative reordering cause the strict bounds valid=
ation in
> > > > > > gve_ptp_gettimex64() to fail spuriously?
> > > > >
> > > > > I will add mb() barriers to be totally safe.
> > > >
> > > > I'm not so sure that rmb() is insufficient here. In x86_64 rmb() is=
 an
> > > > lfence. lfence is used to prevent speculative execution (per the x8=
6
> > > > barrier_nospec implementation) and rdtsc_ordered, which is called b=
y
> > > > the ktime* helpers, also prefaces rdtsc with an lfence. On ARM the
> > > > get_cycles implementation adds an isb instruction before reading
> > > > cntvct_el0.
> > > >
> > > >
> > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > >  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> > > > > > >                             struct timespec64 *ts,
> > > > > > >                             struct ptp_system_timestamp *sts)
> > > > > > >  {
> > > > > > > -     return -EOPNOTSUPP;
> > > > > > > +     struct gve_ptp *ptp =3D container_of(info, struct gve_p=
tp, info);
> > > > > > > +     struct gve_sysclock_sample sysclock =3D {0};
> > > > > > > +     struct gve_priv *priv =3D ptp->priv;
> > > > > > > +     struct system_time_snapshot snap;
> > > > > > > +     u64 nic_ts;
> > > > > > > +     int err;
> > > > > > > +
> > > > > > > +     /* Take system clock snapshot before sampling cycle cou=
nters */
> > > > > > > +     if (sts)
> > > > > > > +             ktime_get_snapshot(&snap);
> > > > > > > +
> > > > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_ts, &sysclock)=
;
> > > > > >
> > > > > > Could the system time snapshot become stale here?
> > > > > >
> > > > > > If priv->nic_ts_read_lock is contended, or if gve_adminq_read_t=
imestamp()
> > > > > > retries and sleeps, the snapshot might be taken significantly b=
efore the
> > > > > > actual hardware read.
> > > > > >
> > > > > > Would it be more accurate to take the snapshot immediately befo=
re reading the
> > > > > > hardware, inside the mutex?
> > > > >
> > > > > Ack, will fix.
> > > > >
> > > > > >
> > > > > > > +     if (err)
> > > > > > > +             return err;
> > > > > > > +
> > > > > > > +     if (sts) {
> > > > > > > +             /* Reject samples with out of order system cloc=
k values */
> > > > > > > +             if (!(sysclock.host_pre_cycles <=3D sysclock.ni=
c_pre_cycles &&
> > > > > > > +                   sysclock.nic_pre_cycles  <=3D sysclock.ni=
c_post_cycles &&
> > > > > > > +                   sysclock.nic_post_cycles <=3D sysclock.ho=
st_post_cycles)) {
> > > > > > > +                     dev_err_ratelimited(&priv->pdev->dev,
> > > > > > > +                                         "AdminQ system cloc=
k cycle counts out of order. Expecting %llu <=3D %llu <=3D %llu <=3D %llu\n=
",
> > > > > > > +                                         (u64)sysclock.host_=
pre_cycles,
> > > > > > > +                                         sysclock.nic_pre_cy=
cles,
> > > > > > > +                                         sysclock.nic_post_c=
ycles,
> > > > > > > +                                         (u64)sysclock.host_=
post_cycles);
> > > > > > > +                     return -EBADMSG;
> > > > > >
> > > > > > How does this behave on architectures where get_cycles() is not=
 implemented
> > > > > > and returns 0, or with older firmware that leaves nic_pre_cycle=
s and
> > > > > > nic_post_cycles as 0?
> > > > >
> > > > > Firmware is not allowed to return 0. 0 should trigger the check.
> > > > >
> > > > > > It looks like the bounds check would unconditionally fail and r=
eturn -EBADMSG.
> > > > > > Since userspace tools like chrony usually expect -EOPNOTSUPP fo=
r unsupported
> > > > > > extended ioctls to fall back to basic PTP ioctls, will returnin=
g -EBADMSG
> > > > > > cause a hard failure for clock synchronization?
> > > > >
> > > > > Will fix. GVE is only supported on x86_64 and arm64, and will fai=
l on
> > > > > other architectures with -EOPNOTSUPP due to the check in
> > > > > gve_cycles_to_clock_fn(). However, if an architecture returns
> > > > > get_cycles() as 0, it will fail here first with -EBADMSG. I will =
add
> > > > > an explicit check for x86 || arm64 earlier in this function.
> > > > >
> > > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > > @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
> > > > > > >               goto release_ptp;
> > > > > > >       }
> > > > > > >       mutex_init(&priv->nic_ts_read_lock);
> > > > > > > -     err =3D gve_clock_nic_ts_read(priv, &nic_raw);
> > > > > > > +     err =3D gve_clock_nic_ts_read(priv, &nic_raw, NULL);
> > > > > > >       if (err) {
> > > > > > >               dev_err(&priv->pdev->dev, "failed to read NIC c=
lock %d\n", err);
> > > > > > >               goto release_nic_ts_report;
> > > > > >
> > > > > > Is there a race condition exposing the PTP device to userspace =
before its
> > > > > > resources are fully initialized?
> > > > > >
> > > > > > Looking at gve_init_clock(), gve_ptp_init() is called before al=
locating
> > > > > > nic_ts_report and initializing nic_ts_read_lock:
> > > > > >
> > > > > >     err =3D gve_ptp_init(priv);
> > > > > >     if (err)
> > > > > >         return err;
> > > > > >
> > > > > >     priv->nic_ts_report =3D dma_alloc_coherent(...);
> > > > > >     ...
> > > > > >     mutex_init(&priv->nic_ts_read_lock);
> > > > > >
> > > > > > If a concurrent userspace process immediately invokes the
> > > > > > PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers th=
e /dev/ptpX
> > > > > > device, could it call gve_ptp_gettimex64() and attempt to lock =
the
> > > > > > uninitialized mutex or dereference the NULL nic_ts_report point=
er?
> > > > > >
> > > > > > Additionally, in the error path for gve_init_clock():
> > > > > >
> > > > > >     release_nic_ts_report:
> > > > > >         mutex_destroy(&priv->nic_ts_read_lock);
> > > > > >         dma_free_coherent(...);
> > > > > >         priv->nic_ts_report =3D NULL;
> > > > > >     release_ptp:
> > > > > >         gve_ptp_release(priv);
> > > > > >
> > > > > > Could destroying the mutex and freeing the memory before gve_pt=
p_release()
> > > > > > create a use-after-free window if an ioctl is currently running=
?
> > > > >
> > > > > Will be fixed in the previous patch in the series.

