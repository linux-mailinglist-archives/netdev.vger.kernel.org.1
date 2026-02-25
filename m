Return-Path: <netdev+bounces-260771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D6fNtqPnmnTWAQAu9opvQ
	(envelope-from <netdev+bounces-260771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 06:59:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9EF192356
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5310F3027DA1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B162E8897;
	Wed, 25 Feb 2026 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmd8nkhY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3E2EB84E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999192; cv=pass; b=bQVLba9+RqsrqaHk4rlKt2+lqiLFvIVF6znWBUSBKHfxvuQXSgWSP+I8XLuZIajN9UeFDecUgfRojvrfUQZo3r2m+1ki5HZ8DnXwfxoMEo86ypS8W+vQfx5VUDM+qxjCofSX515HirRFlh+AJcgmENgnHe4mZg6BTF6BfzQuyp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999192; c=relaxed/simple;
	bh=0187+HJXbxbDqoLndFtsYeQmB5bITMCie3MJcozAX/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMUFDhwr8VUV/De/q/w4mjdATsrrHJMy2O5/VsfW9AaK2pV+jaC2pF0wnxPD5RStFzXXbe4uKJ5mtvMak7f0jneGqLn4Elq9cxWV7Evvv34lwsR6nG4AqP/4Vdb9KQbgPPpCXJcKLInGq8f5neVQvlTOBl6hz7pmgwKB6Kr/lzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmd8nkhY; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79827d28fc4so37507147b3.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 21:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771999190; cv=none;
        d=google.com; s=arc-20240605;
        b=aBd4KvU/ScgMDi1P/E7jfC5jQZGmmnhOBYqAxgZ8ZpUJXAMtSIfWEr8N/UGdTvH8OG
         c398gTKbyl64fRtheRcAzYq3EgITCy54kwKgu5EJ6Yby8UvXWxhqYA2oMzvZUQZVUGhF
         wV+hWBL7A16Hcn9XqUWnODKvHf6pk1sIbFxnYK6MQ0GOr3CSlnFzlWgEFVxVct2G4zxX
         1RW0PbBhmdYswzKY1E4xVd5BbbstF1/Hal8lwgQ9srNiulV/ruRKjUy2wFTLqNlD9coi
         +zLxa/+/NUhyC/lOMBGmoXQBMOL8S02TZj89SWJnIl0kXovur7HiljDJVF8pKQptwabd
         v8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        fh=Dh+hlXRp4DJrULgkI2BJX9zueGpSGn5myjigluBeskk=;
        b=k/9ahRkxmo/aoHGPg8DEBUxEyPAJtZ9dZsre+8rbGPw1WW24EfRHvaADvZ1zVOa6Fx
         D5P/hU6emhMhNYHQeveHB7zGbOvy59zK7cLT5YvjPHggU/QjSQn0bNta2GJGd3u4zwkE
         6BUtVNwOZUdYjelYNW1SKWkQojqz12kZFOUW51jbTy4FE4tmBpIODaTRTlrYUZWH/HqR
         m4B7WRwqlqqXku3lWo7+a0wW4Z3PC+49s5d7TJZZ5C2XV0Ku5KW9ZYIF7dbKrXy+Mzsy
         IbLUGF+De9+2C8elZDqFaXhSDulWHdUXfle16E0LG1DEvW2mM+LD/wwTxpQRnPCGSgne
         XerA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771999190; x=1772603990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        b=Zmd8nkhYOuPr3EEgo+NbAUzEvq8xZ/n0WVOYGtx+/65YvvUo6ke+vTHOc6C7rW0ldm
         2+n+AcVW2aZZMQdKNq+XIwzs3d6ktE6AQoxSPJbAGqZ2IThAm05ysU63tUo8sXyyyL7l
         fBXg4E0joW83zQDcvEB5+806ohIYajT0mOwngX3E7TN+u+yEEVmLswvSPyUXjFkuuIOi
         fbE90U9NfE/+VbV1xCWPP7fjD8sWkM3qpUkYgA7HaRy+KWTcvl+mxSBpPWItxfzYms4n
         sDnPFOH02NCImS3oDq9WKePZ7OSKMkQLJ8MZ9EJ0dRFpBus21J3eHxdwoTOV+f7jZoZ4
         QnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999190; x=1772603990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        b=l8pDlOAwS1XJL8e2x/U/caUsk70xh58RTCq1rGGqbRSbN4KU4fCvu9CpwsvV+3lZ6v
         xM1/H6v7LmLdZnvXACwojF914ufKiSqZ9doJz8RjfeaZw1wiFhnJM1bunxYrjGz3HoEc
         0176PuKMQa6prhVtT09Qr2Dr2KOVxD9ShbMux83j3O3AoeiCxo8HoyCEdrtueaPgqvSD
         D71koO4+seEGhyeDgoX02KWE+9UiYQ6wC5HPvATk/HiPP2UvjyGBUrU5eogY+cmxNHAs
         bJGSkQRxf/xw2sz2g3rHsspYr21hsu9kX7mNaejulWPHTtjzA4FV90iiRAez8vpadOr6
         uppw==
X-Forwarded-Encrypted: i=1; AJvYcCUz0haITZuc0eVUzof6T+joT0fIp5Q8QJU/n23livfDlZEfs9/4X5Sw10KN/xad8tKBuUqwpL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Gt/ItBG1PZheD93dqeDaTUBBFx84xP00L5Gj3UCKYFYzsd1U
	8VwMCIpxXCcx6vRc/o2HodsJgIrzJxo6jYdl5TWWIR2DigCQYEQmNjgpw0fVq1JIzH8MzGZOUDa
	J7h2f76j/S3bQ98hQ+u5v8Z2SuXX4H1g=
X-Gm-Gg: ATEYQzwEhZTXRuLZhPbcKYb4eW1nBGSHwp+O9JxZU89/YxW+S4Jj54ogAeqajMOBKO/
	8H3o+K6uCnjfADmfYrdntp3SaRIcaFQfkXF7UVHeRCoOSaZZSjG/kVy0abhrv8a/A4JLboPo4He
	W5dKzgpQHha4dk3JSql4IDxhofN/yS4KjtM+oxs7BUm2UtsY4lF/0p9hLwXmauHtxRz5jeHT6sr
	n3UpXorSh64HIIJcgCoewrv5Xbb+zOhYlfOmpDZvHnJxVDsuuphlfTkGUmnPtUhLuEh/IiMa0CQ
	9dgZclIq
X-Received: by 2002:a05:690c:9d:b0:798:25d:9b1 with SMTP id
 00721157ae682-79828cd049emr129572897b3.12.1771999189729; Tue, 24 Feb 2026
 21:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com> <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
In-Reply-To: <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Wed, 25 Feb 2026 09:29:40 +0330
X-Gm-Features: AaiRm50Jnc1hdfMZrcEoHjnxIA7SWXi5yLlX7fypqKNkoMiU9nlIjTPDz2hqS3I
Message-ID: <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260771-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,man7.org:url]
X-Rspamd-Queue-Id: 5E9EF192356
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 7:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gma=
il.com> wrote:
> >
> > From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> >
> > This commit fixes the integer parsing of -t option. The cli parser
> > only relies on errno to detect parsing errors. The manpage for
> > strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> > states that the said function "MAY" set errno to EINVAL in case the
> > conversion fails. Currently on some systems, this leads to a silent
> > failure with return value not being exactly documented in the
> > manpages (probably zero). The reliable way to validate the input is
> > to check whether the endptr has been bumped all the way to the end
> > of the string or not.
> >
> > Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > ---
> > v2:
> >   - fix style issues
> > v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.=
com/
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 05b3cebc5..5e4095fd1 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifo=
bj_tx, struct ifobject *ifobj
> >         struct ifobject *ifobj;
> >         u32 interface_nb =3D 0;
> >         int option_index, c;
> > +       char *eptr;
> >
> >         opterr =3D 0;
> >
> > @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifo=
bj_tx, struct ifobject *ifobj
> >                         break;
> >                 case 't':
> >                         errno =3D 0;
> > -                       opt_run_test =3D strtol(optarg, NULL, 0);
> > -                       if (errno)
> > +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> > +                       if (errno || *eptr)
>
> This is unnecessary. It was required we would have hit segfaults by now.
This patch does not prevent segfaults; it prevents silent misparsing.
On systems where strtol() does not set
errno for non-numeric input, passing -t abc results in opt_run_test
being 0 without triggering usage().
Checking endptr is the documented way to validate full-string conversion.
>
> pw-bot: cr

