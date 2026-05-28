Return-Path: <netdev+bounces-292764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFvxC3d1GGo8kQgAu9opvQ
	(envelope-from <netdev+bounces-292764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:03:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A14EE5F55D6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C557D314B99C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1D316199;
	Thu, 28 May 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CL/hZuSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D0346E44
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985346; cv=pass; b=D7GC9lHEoOqJL+jZ+7pJF7x/FhdMyqRHPu7+CYqtikrLFbvW+malcqWLOu/O9ChMSycYF6DUfN+g2vI8Gtrem0lPviov0UX8syEgT9WD59iumxzRhf+GnSl56K7pDxzP4baYF+k1kfAWIrHZm47COc0K0pQ/f5w9soREfRhMEsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985346; c=relaxed/simple;
	bh=au04pUeIILFt07hDqornbcSFtAuJxWBhw2TFUAMrAfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu3CPbZLs6kOv+EIDNmiRonyMnK81ois/49WXQV64VyKlEd9QhVlv1/mg8PuvTC/q5hWrlQFUq6T0DglIWZFVjjM0g0oA6vslI+nBIMTD77PtyEM6R265DClXJZj61j8zbtbCaRvOH3h2uWvR7uEs7cs1ywDV1DSywl5XpPGj5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CL/hZuSH; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so197a12.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779985343; cv=none;
        d=google.com; s=arc-20240605;
        b=LD4O5Me1++rOZ7B7mXDuMvWTG1A1QO5HOJkNEQ/dlDEDv4AAyoHzFVvffE5xWTu2tG
         DTLVXLtCQaU9dje5FJ1BOSx86A+ggNtgPe617jln/IMSu8ZSfNt2ahsnJ0isOoLZs+N5
         1kR29HGvgaACXt9Bs5KBAK+IeqBKtAR8J9NWJH7FbksOAq6HkWxACS+qul3lwmTfrLjY
         05CgWo2JaoNhHhIq2C3CgPFLknigXyNjglCb3+u+2zM7lWlnpUrQlWVta/m1mUnTcRj1
         plzZ6ZVqnllV4+IYibLf3ojAhQKqENKNsxlzVEhnGnTSuitmG9GYG4JtedvV2DUZ0kfn
         qGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=in32rJ9n5b3pvsDoFcfp5uqMlAZkT9xBdnIgxvH4pBQ=;
        fh=k8x0jlWZUpXJdqxIrsu8Z+NsVfd2n0lfDX62rNEyCPA=;
        b=HourUUKn79uELqIINcHIO4u6gFMfeBXcmPUql2GnpuNg2Kfeh85JyWW7xCGA+oM/Jk
         x6QmWMkIu18nbPLvgbI82/GSNEXlxw+V44y048kLFbZT8L7SmgZVqM0wRcxJvs567cDS
         vYY/fjFx1Y3bR1YW1qpv+7SyjlH4LoL5TFaplXH3fDKJDJrV4q4z6GGhLsCVaQC2pXzO
         1qiw3SjcypIrVUD/iFvSDilTzJFKYQTxIW8luqX+PUC/FDEgauGpypI4rJYy3YYZpoaJ
         Q83+a2rsNRPFKC93sMx7JTqGFybV6BLqWs/nZLCrluu8gpHgSdOLNn5m0JTUkFnnC/9O
         xm2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985343; x=1780590143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in32rJ9n5b3pvsDoFcfp5uqMlAZkT9xBdnIgxvH4pBQ=;
        b=CL/hZuSHl0+kmvG1jZvc+BBQAiaaybpJi65uyiXXgNVynIeqNTptVYuN43MD9CxsPP
         qGfjqFg6mzd/QrYRe1UFwiwvVb4RsJx0QaMKAJY62WVw/BDJusRmOUQq9s0FSqeFTPaE
         lfcrjtdGANvOjxMLc+crQZHiU9nsv6VG1lqd+RQB2NoryB4X3mBexvjJu9AvzJMA2cN0
         byufBIaG1H71MhaUA0DlofJ/vm5oB/mFVp8b/tgIiswEuG5ClzAgDWLkjtNabcmFZvNH
         CY79LUUoOkkqD5iev1e8xFTmQRhEdaoiqdDe/fzfCaP5p4qjci7j/ZqIY6+mIB9v3IoB
         2gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985343; x=1780590143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=in32rJ9n5b3pvsDoFcfp5uqMlAZkT9xBdnIgxvH4pBQ=;
        b=rsbafbpO3GWjJ1OqGLm4IxGbZJcTlgc1btM4UFchWSrTechx3b4TMPIbsomZczVxxh
         hhlZyaaOmNVxZLTaHNF8AL/NrzuAEZjRQ+zDD58gxAG7F7EDBKfsFTs/qkxJ4PdyjdMA
         dY7zzmfYJI1yUwIjygzRbdWxIXCwDyGRvQIYsFbEDp4NSfNsjCf98GBs7BmLllDo2ccw
         3mrrJWoNdNL2TMAvtQ9+O0QN2g1Ylz1DWfd8KUktD/eDKou6vBpyV0DapmXQFqZheIhE
         2+XgYLTvSHyUcjgysDH4SEzMFNtQjm+J1KDb2Ma5gvimhgkTamukg0uRkGNGK7Jwg/9i
         ls/g==
X-Forwarded-Encrypted: i=1; AFNElJ/PM6Nd1YhjiSeJuIz0/nNudvXyRxxOc6m/FUEa5tHsjjBSB0+qEQzreO44/DiYhyLz/nY8lVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cKADUPOBtYo9ZItMzxFkHOwKQU8AtDnuSdO6aKLrBL5ncwfo
	8pLJiIwt58NURf4p4f/+4tOW9BjXeA9nOisaV6NUcfC3xIeh35CEk8HZCTjoaHhmzJLMNv9QAaB
	yzf5HIIODrLPeGQHJHNsOjJ+cXRfhAoTr/ydJZ5mN
X-Gm-Gg: Acq92OEasdVSDG26qlx4uR/62aY9KdmSZXPx47YZKeLOcYDCKgAR7AdDj9mStx07cgX
	Ce23A4VImK5wbR1ECxaFWCVz9CIiRxODrwiAdWHphnzmSCvrVfyuwZlwce3BO+4zsdHGX1t054N
	EigNz9CRWWbUJhgU9QIXHAuHBqH+/IYu7JnO6awqfTHfm0vQLvUkIi2miUbjqZNPSMuoGz37KbG
	tIeVxNEaBdse+IV3AILdoduvOQAwpk3mGysh240XPnbJNftjxg3HSjBaEGv2ByI/TDWPlQVwnYt
	y/iojZcSI3T1HxA44EA=
X-Received: by 2002:a05:6402:3129:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68b433fcfe8mr35626a12.10.1779985342889; Thu, 28 May 2026
 09:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514225842.110706-1-hramamurthy@google.com>
 <20260514225842.110706-4-hramamurthy@google.com> <87mrxtwzz9.ffs@tglx>
 <CA+mzVtuhB9J9MDHSUfmBeV8hdtprGBsBZWrxLRtvdZY_V_NhNA@mail.gmail.com>
 <CA+mzVtt==6x0-BK7_5OupH+a=dwNrMY0YT4fGjHH2OM48MgLkA@mail.gmail.com> <4322b8df98c08e238d4161bfacd46080c54f2c40.camel@infradead.org>
In-Reply-To: <4322b8df98c08e238d4161bfacd46080c54f2c40.camel@infradead.org>
From: Jordan Rhee <jordanrhee@google.com>
Date: Thu, 28 May 2026 09:22:10 -0700
X-Gm-Features: AVHnY4Imj7RMfC2Oc1KhvxSYFZ3phXyYRMGEHYOV6neadigCzOoeiBsPVGoADxo
Message-ID: <CA+mzVts6A=VQ+5AakYTtHxWndQoVcNOFW9bbH+XPPJUeWpUSWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, jstultz@google.com, sboyd@kernel.org, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org, 
	jacob.e.keller@intel.com, yyd@google.com, jefrogers@google.com, 
	linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,lunn.ch,davemloft.net,redhat.com,gmail.com,oracle.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A14EE5F55D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:03=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Wed, 2026-05-27 at 11:46 -0700, Jordan Rhee wrote:
> > Hello,
> >
> > We would like to request the community's guidance on how to proceed
> > with adding
> > cross-timestamp functionality to GVE. The key challenge is that the
> > NIC clock can only be sampled in the hypervisor because the NIC time
> > registers are only present on the PF, and a hypercall takes 60-80us.
> > To minimize the uncertainty window, the hypervisor takes a TSC
> > sandwich around the reading with an uncertainty window of ~1.2us,
> > converts it to guest TSC, and returns it to the guest.
> >
> > The goals which led to this implementation were to minimize the
> > uncertainty window and communicate the uncertainty window up the
> > stack. I've reviewed
> > https://lore.kernel.org/netdev/20260526165826.392227559@kernel.org/
> > but I'm not sure how we would use it, so if it is intended to support
> > our use case I would appreciate if someone could explain how we
> > should use it.
> >
> > Here are some options on how to proceed, but other ideas are welcome.
>
> So, your hypercall gives you the ABA timestamps of
> PTP_SYS_OFFSET_EXTENDED where the 'A' timestamps are in the form of
> guest TSC readings? It does not give you *simultaneous* capture and
> thus you can not, and should attempt to, implement
> PTP_SYS_OFFSET_PRECISE? Don't even think about that "midpoint" crap?
>
> And your driver brackets the hypercalls with *actual* guest TSC reads,
> to keep the hypervisor honest?
>
> Based on Thomas's branch, I'd probably do something like:
>
>  =E2=80=A2 ptp_read_system_prets()
>  =E2=80=A2 Make the hypercall
>  =E2=80=A2 ptp_read_system_postts()
>
> Then do your sanity check that the guest TSC values provided by the
> hypervisor are reasonable (inside the raw_cycles=C2=B9 values in the gues=
t
> pre/post snapshots). If not, return immediately using the wider
> uncertainty window.
>
> If you *do* believe the hypervisor-provided TSC readings, can't you
> convert *each* of them to the system clock using
> get_device_system_crosststamp(), a history from your captured prets,
> and a get_time_fn callback that just creates xtstamp->sys_counter from
> the hypervisor-provided TSC value for pre/post respectively, each time
> you call it?

Thank you David, that's a great idea. We will respin with this
approach after https://lore.kernel.org/netdev/20260526165826.392227559@kern=
el.org/
lands. In the meantime, we have some other GVE patches that we need to
send up.

>
> Take the code sample below with a *massive* pinch of salt; I only
> shouted at the AI a few times when asking it to translate the
> suggestion above into sample code, and I haven't gone over it with a
> fine-tooth comb. But hopefully it helps enlighten what I'm
> suggesting...
>
> /*
>  * Suggested approach for GVE PTP gettimex64 with hypervisor-provided
>  * TSC values converted via get_device_system_crosststamp().
>  *
>  * This gives PTP_SYS_OFFSET_EXTENDED with ~1.2=C2=B5s uncertainty
>  * (from the hypervisor's TSC sandwich) rather than ~60-80=C2=B5s
>  * (from the guest-side hypercall latency).
>  */
>
> struct gve_xtstamp_ctx {
>         u64 cycles;
> };
>
> static int gve_get_time_fn(ktime_t *device_time,
>                            struct system_counterval_t *sys_counter,
>                            void *_ctx)
> {
>         struct gve_xtstamp_ctx *ctx =3D _ctx;
>
>         *device_time =3D 0;
>         sys_counter->cycles =3D ctx->cycles;
>         sys_counter->cs_id =3D CSID_X86_TSC;
>         return 0;
> }
>
> static int gve_ptp_gettimex64(struct ptp_clock_info *info,
>                               struct timespec64 *ts,
>                               struct ptp_system_timestamp *sts)
> {
>         struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
>         struct gve_sysclock_sample sysclock;
>         u64 nic_ts;
>         int err;
>
>         mutex_lock(&ptp->nic_ts_read_lock);
>         ptp_read_system_prets(sts);
>         err =3D gve_ptp_read_timestamp(ptp, &sysclock);
>         ptp_read_system_postts(sts);
>         mutex_unlock(&ptp->nic_ts_read_lock);
>         if (err)
>                 return err;
>
>         nic_ts =3D sysclock.nic_timestamp;
>         *ts =3D ns_to_timespec64(nic_ts);
>
>         if (!sts)
>                 return 0;
>
>         /*
>          * Sanity check: hypervisor-provided TSC values must fall
>          * within our guest-side bracket (using raw_cycles from the
>          * snapshots taken by ptp_read_system_prets/postts).
>          */
>         if (sysclock.nic_pre_cycles >=3D sts->pre_sts.raw_cycles &&
>             sysclock.nic_post_cycles <=3D sts->post_sts.raw_cycles) {
>                 struct system_device_crosststamp xtstamp;
>                 struct gve_xtstamp_ctx ctx;
>
>                 /*
>                  * Hypervisor values are trustworthy. Convert each TSC
>                  * value to system time, narrowing the pre/post window
>                  * from ~60-80=C2=B5s to ~1.2=C2=B5s.
>                  */
>                 ctx.cycles =3D sysclock.nic_pre_cycles;
>                 err =3D get_device_system_crosststamp(gve_get_time_fn, &c=
tx,
>                                                     &sts->pre_sts, &xtsta=
mp);
>                 if (!err) {
>                         sts->pre_sts.sys =3D xtstamp.sys_realtime;
>                         sts->pre_sts.raw =3D xtstamp.sys_monoraw;
>                         sts->pre_sts.cycles =3D sysclock.nic_pre_cycles;
>                         sts->pre_sts.cs_id =3D CSID_X86_TSC;
>                 }
>
>                 ctx.cycles =3D sysclock.nic_post_cycles;
>                 err =3D get_device_system_crosststamp(gve_get_time_fn, &c=
tx,
>                                                     &sts->pre_sts, &xtsta=
mp);
>                 if (!err) {
>                         sts->post_sts.sys =3D xtstamp.sys_realtime;
>                         sts->post_sts.raw =3D xtstamp.sys_monoraw;
>                         sts->post_sts.cycles =3D sysclock.nic_post_cycles=
;
>                         sts->post_sts.cs_id =3D CSID_X86_TSC;
>                 }
>         }
>         /* else: keep the wider pre/post from ptp_read_system_prets/postt=
s */
>
>         return 0;
> }
>
> =C2=B9 https://lore.kernel.org/all/20260526230635.136914-1-dwmw2@infradea=
d.org/

