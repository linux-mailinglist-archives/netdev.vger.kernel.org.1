Return-Path: <netdev+bounces-289050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FjgCjkIC2r4/QQAu9opvQ
	(envelope-from <netdev+bounces-289050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0EC56CD22
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1FB6301E211
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59175410D3A;
	Mon, 18 May 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+U3xSLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE8410D17
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107801; cv=pass; b=XuvAbfMSw5YiYAwyHW+RCH7jjNe523yAGp7MJg/cCp1J4LQrjrfG/RvOs+ZArX3c7tsG/6lZX/0M9FXlLLhZSyClwBK6HE42mrMiXhhRSfHuleA6cms8XPbX1rHyDJcV5854sNo+Mc3XD0/9SqWKukkOTV7ebuk0ZGQRmtFQ/eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107801; c=relaxed/simple;
	bh=UxFHQ8myRrvcKnyp2w/HbJak2/jS/38obKXyH8OshAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIaruLHQeEauDe9aBSskK2bLoNpzBVE4TlilaH52/jLUCFx3bQjONl4tbwkF57VEJARH/LDoWyV+oLzeLsEUX/n0/qNYL9243aouN+2W1hSqtcNzo7dbCJBvkgD8cnPBqUgjvtXUfmF4lTvFijUY740iN86atsS8hKdaxY9Jmrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+U3xSLK; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2878235e87.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107798; cv=none;
        d=google.com; s=arc-20240605;
        b=GUNOhOO79YQ8/V4W1xsFwtDwu3GlfjF20UKDxuWGpKHAne2C1o7/Nhp+D9post7zSx
         bpTmAazK4tlgj+6HFiGGtjrKStMyzI0UUVWj4t4bq0S6rJKgl2G1LkgDkduXnmMU1lO3
         nvfZMa9PpTAxKp3Fbwg8VSPKooo1n0WVmcdA94+6n5DIaIeTFYGoE+TnIWl2zgq1TIoU
         fVdGnIL3h7xn0AnzgCoXHDlEZUc883OxbmN59A0X8qRYwEqfK/2AA/OkiVtB+b+J2v5c
         TRddCRV8sl40UXjnX5+r5+Ez17SqIk12ACSRi7WK/4ILDs4nU1A7tELWOLvHKvEVTwM1
         VJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        fh=tLTa0Y0TILfuBm4End/FotmAo9zCvf5cIpqb2+KUits=;
        b=JnQWh05RsDx9JExtqYgMA0QycZakdqsnJ2+Oargj0X7ugccF20SbPo9oAklMwcI+78
         WucKyNAPQQKGyuNhL4oH8sWQ/D64IJBwhIaxa3lyd4Y2Msm2rSHwvQHzsHQCbz7C51kD
         MgHcOw87NDDlN2ulJ81wTrplCT9UJ0wVIp3XvO+00JZYtj6HHe+nvcCvsSU86qpHXXIb
         hDcK34N9KQ4HdioCBYUm4ZpXwaWP6mKrRog4IbsZVRnZR6IgKOXelY0+aCNp0jdHp550
         2ictO/QqLg4b1yRUF64k1yUF+ewwoyHdQ1WfxnvScDGY6hQuUnjM9Vx0Ct3w7sBXIAsN
         JfIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107798; x=1779712598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        b=D+U3xSLKudhqxPnVvVdDuYrJSiOy1pbQoULBThY5Y9ZcyGjINGdi6w+9J61pKjyUoW
         i8amaWF7yS7vAJ7mi88CDKyMqFofr2MwiBYBzWIXe8x3EIlpngj2Ld3M8e8/8ZKQX5v1
         A04c3MQIEnK8Qp3OWt4tRpP4xkrMqIyY3n8uQHX70+11NxKFFjXea3rYddzMPrrM71jE
         yaH8yMEogH3/Stsv1isyZb8tYbu49YpwIv0ZxRL+6ICsMNGMX8lPhyawnyVgYRYDfNkn
         Kjdu6TLbogTiaCnEUg73OSpmgyATvkXYaQHwNT/xv321DeVgpxsv3n/1gmrOQGI5I7fI
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107798; x=1779712598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQLPiuOk6sV8kiLBT0hZDm0NkG6cxPfbECWJSraE7Lo=;
        b=O2yreljlvwI0wRyJpnLvsqcWFVQEv1bcHrnq4K/82IPk8HyjwLzh+w88f/ea7XC6QM
         s06W5G7opJTzeed6RxUey5abQYmluRSxBGQ348e5gl3NY0xV6WWt7ygr6pWu/BbKBOpv
         rrgavGG63y9OBUTrjE0nN59y0b1oHqlqF7OnJdzb/N8qVCPLqY/oD570XmEdeV9EJucO
         DHFWA5dyb9/YJ0aCSoch5jxNOhkbgG6IkiuDuKyToZF/WODltuoEeFEVD+VF/KUKv8IP
         eII5qlVJ9i14U93Z83RR0jZsAiC0J8YuX6eorQuGkqrkPLHQTII9sJ1L7pGpZNUVSJYA
         lYDA==
X-Forwarded-Encrypted: i=1; AFNElJ9imNewkhLjbKniXyUQoOehjpsLEREfQqE6zERhUbQx4Mw742CwmYKUfU/cgPXNPrbUHVBF+n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUB+G33RVPDyY5d+w9U5a4Xj5OTOHlx8LVJGiBEFI9BEAOc1Ni
	ZN324jc7zvtWHx6XkVTLeKX5CCJApA4E70MUD+uDfkfopST/r0E03u3G000NqU/uWhKDmuFY/ad
	GInzaGGp0nAtwkiQ0S5xeeOgP7uGYD3g=
X-Gm-Gg: Acq92OGWtpZJ1egs0Lvsnv1nE8EQGv8cWLrayXsq28iUXv3hy/hsv6hqw3LX0cLipIF
	Ekiq73SMP6w5f8Ku7VmOgVNrprVdpQCdssAR3VraXcEyl2FO9XE16KpuzeLMytp484jan+yv4FR
	taD4+7JxMFGDnSfR122YMNBpU/TiqbfXIqURA5N5V+wPUqloPmfZJJVI51Id6c83uE9gC6mBLJU
	8OlpkKm0pG/jtx06hruumW9tDj+fQSqRg5dUVzNUJRxlneu+MFyxhiJDqvYozPKjeZf4XXsYWjr
	o6w4BHlw3c9D16+ViN638nHJsVH2UtSkv3wWs+7T4Iqc2VYHq5I=
X-Received: by 2002:a05:6512:3b8a:b0:5a8:5187:2e78 with SMTP id
 2adb3069b0e04-5aa0e60ce1fmr4598222e87.13.1779107797593; Mon, 18 May 2026
 05:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-2-kerneljasonxing@gmail.com> <850e3709-2cb1-4a26-8546-745401423696@kernel.org>
In-Reply-To: <850e3709-2cb1-4a26-8546-745401423696@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 20:35:59 +0800
X-Gm-Features: AVHnY4KuhWWWfQKXUCIMgTLWad_PQHq31BMxVWNlZDH5P1tGxWBXQynOnQmIOqM
Message-ID: <CAL+tcoBA0+Vspq37FtEURgM9A+Fk5MOPkhPvaq7OwP6SSpXfxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, john.fastabend@gmail.com, 
	Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CB0EC56CD22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289050-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com,kau.se,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 7:57=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
> > which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
> > populated by the network stack uses ktime_get_real() which is in the
> > CLOCK_REALTIME domain.
> >
> > In the series, kernel reports the software/hardware timestamps through
> > sockopt and then userspace bpf application gets them and calculate the
> > delta only through an unified time unit.
> >
> > However, prior to this, when a BPF program tries to measure RX packet
> > delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
> > is incorrect because the two clocks have different epochs.
> >
> > Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
> > current CLOCK_REALTIME time. This allows BPF programs to perform
> > accurate delay calculations without clock domain mismatch issue.
> >
>
> I support adding this helper, because have also hit this issue[1].
> Our ugly workaround is to use the TAI clock and adjust for the current
> TAI offset.

Right. Thanks :)

>
> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat

The tool is useful as long as we enable net_enable_timetamp(). Yes,
bpf/so timestamping is one of methods to do so.

Thanks,
Jason

>
> Cc Simon Sundberg <Simon.Sundberg@kau.se>
>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   kernel/bpf/helpers.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2bb60200c266..863645d096ef 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *fi=
eld, void *rb_root,
> >
> >   __bpf_kfunc_start_defs();
> >
> > +__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
> > +{
> > +     return ktime_get_real_fast_ns();
> > +}
> > +
> >   /**
> >    * bpf_obj_new() - allocate an object described by program BTF
> >    * @local_type_id__k: type ID in program BTF
> > @@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume,=
 KF_IMPLICIT_ARGS)
> >   BTF_ID_FLAGS(func, bpf_dynptr_from_file)
> >   BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
> >   BTF_ID_FLAGS(func, bpf_timer_cancel_async)
> > +BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
> >   BTF_KFUNCS_END(common_btf_ids)
> >
> >   static const struct btf_kfunc_id_set common_kfunc_set =3D {
>

