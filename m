Return-Path: <netdev+bounces-251736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC+oCBpCcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:03:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C089550345
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0940D56565B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18BF342519;
	Wed, 21 Jan 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3uFsn+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ACA320A06
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964628; cv=pass; b=nXbifLBwgHq4FgdnfkYk8c1nW/IWRAvj3Y5/IEkOWf7RCLymQ7SqZo5r+/6XmIl0UYWfyeXgNCJSiKi5/+rcr+ADXqCioAqnHeK6i5Tf4cZNKZg6R52mve0cmNtIGcB2GxVxOaEectXwKFS0MfQ9DV5cMyxQaDYX9SxdAIF+b2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964628; c=relaxed/simple;
	bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vre155OOBYRrfHP/6lKy4bTT3xWWbGK8MkcGmwzWx2zqpQ1aFuIsR1mYKFzuiPXZHLNImxuaAJwk+3CtCBNxaiUd+eEjZYVfnV06guAoOK/kTkE2fIgURBtAzQ77sUyStgeif3X2nrlf6quIOmILuqX5AHnMuWmgpZwBH6RoQx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3uFsn+4; arc=pass smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6467ac59e16so4406486d50.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:03:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768964626; cv=none;
        d=google.com; s=arc-20240605;
        b=R01SRdksEzWg+pNCvQ139JnR1QKLMqSs5kVKtdMuLcc20eDD7qB4Zx1pRqh1WuywBW
         Awh7SpMnH3txKAUUiLL4sVVi0dPIKfcvBYqU1PrY5n8ayiCgFlKpn5BjTycrr0e8/EHP
         OBx4IALkP1XbIAoFUzIb5c0ocifY5frK8RuNIOVRkfzF4rjYLljFHKK7JjcHyhj/G7iZ
         oHqdrRc6O77ZsDPPgRkZ+nrGr8BNmq0sJuTMtWg+3BKkiXphXqs0YE1CDfa7N3nykS4C
         ofrzAnEeDS3NMyM3jMlEOYxIGMZcU5NxUfmW/Fjr/gSX8bdcuChdARxNlivJDARDtSSW
         mLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        fh=xGh+NxvU+wbTjm/KPze8WApbpjDz7aDglny6OqOCmas=;
        b=QDbpcqgJ1cGvghRXBZf6B02MYul4PCpNDwOMbAkVch3QA0CMZlG3Jmk6evExaUvBKW
         LR6uIvfBhoWp9qvmgPpjJv2Gi6YaP7YAf1L2lLmlbmhdchBK/hBn0YbwdgjOFaxRH3nh
         5a6inV6/jUj1uVoXbwyKGDpR7P9HsIsTPrkXWsR7+bcFPaIo/mCAas1/YIXWVRhJS1sn
         IldwoGbmipeXbTAFCro81qcfBuO4cdUiOE0nZQOUD0Ssm62K8ug0/uz+KgjJAHr1KNO5
         d4wUJpTgr3Db5JGK16au/inmjyd7aPhUj2xS04JHeYS+4ruRgoCcfcQJ2CTFr2P45cOU
         7ntA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768964626; x=1769569426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        b=S3uFsn+4iiJtlZMTj0nqj7q2bUCWgn44WpoatXBW/YfIrFqx5iH3fe1och8lual+Mc
         zrh8+n0CA1OAdJDRvharnVyClDeyUsx2SeWLrUfKx4iFkPL8yd2a++4ccwVd+VpcFVcU
         Z18G7AwtOne5MoGi58yVuYwajfyPhZYrtPmplbwCtnnnkBA1nrdr5lZsvxLZL5mzRywa
         bK5CkzhdOabK8dBpbO3rz1aWdGWugZg5sAY3+J8mvKi712jNhKFoa2ZL31bmV9PMi0Xi
         HD8hmslQX1A7kjUF7DIMODZOOe57gGFR9IsGmjtJzQj1zkewTL26X57COREoKlUktJq9
         U51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768964626; x=1769569426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        b=pmpYIkrN6cMF1M8kgqV7XzEyR9w9nsnE3HIjQrSYNvKy6EfU3TFcaev6tOQO9dV7OQ
         l34qs6n8qLctwxhtxozgk5lZLG7ecA7D+Xbn6V9lbnyv2QsG+IIkbixmt6akWijR+r1r
         5XAiTawewjJbwHyUHhkjXKfV7ilUy58htoSRtuquvlwDYh4QjvsmKwuP221Mrlw+zu/8
         ixV9MR8jUBkE5dYzQYF22EPw7OZ/rFZSmCAlQmCIEun6XZZBZqm6PObq8LajfOQk0OkP
         t20UW4axY61Eyh6RKml0EqBMqtkx4YJRyMV9DZ17Z3X6yUo3E5sJ4GwfBWHaT1eSsQdw
         8BXw==
X-Forwarded-Encrypted: i=1; AJvYcCWnVZ+Ht3hwUdan81Y03V7Tre2hvdjdrjCEtICdmMwAX4d6BD8IbIlfhfYcTjCDgi4mFZudgzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMhakIej+GJ/M/iSoS2Jj2UrztKB7j5QS4ktetOu6BoC16Hyu
	lGJprCwlPmhayiKEpZe/QzKlOLMbLOU8cMX/MpVadKnTJFjYM98OeJJmwldTFgKqUX9oaf8SFub
	Dk64J4rECo7ovcG9JGPxhE8cbluP1NmY=
X-Gm-Gg: AZuq6aKzFMd0bdRatI/cFy6u5c3c7ubNnSw2TwCvHWpUsuhMbN2GRBxkkqq+IfnaDSe
	8tvSlwGS1k1c2ODCKwYCkrt6g3aPAVUHSjBkg0K/s0dd4iYX2khxobDBefUojpHrhn7w7z8D4R+
	NRLeHRzJYnY2PaByoIH2dDmDH/hs00pbG6OpShuHdpoIE7AZFExWfPBlaVuciSIRex+UrCaSVPr
	imgtsveXPgEQUWyRGsHeKuUWuyfSCPBHCvXWAR9NFAwR2kd33mFTPl+eTYSrLptZN3MlLOnhvXo
	ZNgUHZ7Z
X-Received: by 2002:a05:690e:d8d:b0:644:6c79:62d7 with SMTP id
 956f58d0204a3-64917713222mr12432211d50.63.1768964626122; Tue, 20 Jan 2026
 19:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-3-dongml2@chinatelecom.cn> <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
 <5071056.31r3eYUQgx@7940hx> <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
In-Reply-To: <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Jan 2026 11:03:35 +0800
X-Gm-Features: AZwV_Qit2NKtH8jlbRBC4sp2eYwMKaaQ-6NnZxqEn4yUhXLl6r2aTmYTf8D2EII
Message-ID: <CADxym3bDOcwi9Qgaibu8TeER8ORtvX0-6ernqfLBTvd1Bo+5xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,davemloft.net,iogearbox.net,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C089550345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 9:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-01-21 at 09:28 +0800, Menglong Dong wrote:
>
> [...]
>
> > Do you mean that the CI of arm64 doesn't use LLVM for the selftests?
> > I noted that. I found that there are other similar "__jited" testings f=
or
> > arm64, is there anything we can do?
> >
> > PS: I tested the arm64 locally, and it works fine.
> >
> > >
> > > So we should do something about silently skipped tests at least...
> >
> > Like a warning?
>
> Yes, probably llvm-devel or libs dependency is missing,
> hence jit related selftests are skipped. Same thing for x86.
> Discussed with Andrii making llvm an opt-out dependency:
> fail selftests compilation if libraries are not found and SKIP_LLVM is no=
t set.

Sounds nice. People may not be aware of the LLVM dependence
sometimes.

So is there anything I can do in this series?

Thanks!
Menglong Dong

> We plan to address CI config issue tomorrow.
>
> [...]

