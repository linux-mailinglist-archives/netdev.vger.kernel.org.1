Return-Path: <netdev+bounces-261014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAI1EvwVn2nWYwQAu9opvQ
	(envelope-from <netdev+bounces-261014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:32:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0471199A2B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 912A93026A8C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0523D6664;
	Wed, 25 Feb 2026 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyGSCSO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A43D5254
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033525; cv=pass; b=QVdNf4DI300yeAqPUWXkGaKI4qS2FOXUiSNCNXXM5aTWCz24p2WepyooWHWAaSk86uI4arU1WQSTi+b1sDXOLMzzFfBmQ9egSqGwXnb8EDUwK+nfCsMGg6M9WEzDHEH/uCIrFj5notEaoC/EG1hHkhCR0oQFOclXKVrGUmPhyUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033525; c=relaxed/simple;
	bh=bjupSToOrAI0DDwjT7STEKsEGqrDSWoZgas6vdq8Ts4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV24WDTquB6TN8OZShCv2fDJ0wsXM8OMlaLEkEcGRuPkYKfep29d2KRuDD5U5jLALp4QW9cwFNqXV34ozwvvgTZP07o4Z2rUV6XL8bnJ45W3oeXlduHF2BYFBBU7jDCHnCaaSUBjF0Nc9SicFjy6GEDBj3FvRlWBAYWVuXXGRkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyGSCSO2; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so42359345e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772033521; cv=none;
        d=google.com; s=arc-20240605;
        b=Wthh3gB8UpY0zPpD94wgdWiLJosd3STPKbv7hlIqHHAYi6AbAiyvnQG62ZRvOBZTgY
         2MAoKzsdRenRI+eDTsrhp17vfLHpj9JwrsPYM4T/G8PIVc5/1e6sUI52Gjb9adnTYiH9
         h+m+3GzVkcSXPF8XHS9SAfHYk+SCIg8V6lFKYRGQeAVCT1wwjs0n5gaRzTQ0RWFFRKLU
         E6oDo++TjJh2AVWo1lm/xZcnzjoj6wrIj6otmjckwzaxd05tHqDAAvN1YmkYe18up/ag
         AIyFOTYqh0fQQD4voMJNqLuvZXnfMCOqb3osOcVkh+XJcMe26DTuSY6xFChY5YzcAUai
         pR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        fh=BhpOH9dXY5Y2uAff8YnQHXdlpeb3CSaBOA+ReO/fNJ8=;
        b=igHTrHzEANteKn2Ezy+NmxsuVbRaAh4OY64N/eFahXKxnmSbqL9/IGRoEr6ko+VrH5
         AJTdMXFxze1T3PZh/gNtEbe4+Uhf+C4bL73hhz7sYYfSUJy6uJdIBRo33v2WFZFUQ8z8
         r7mDyKkZUeaHR1YulBZiTtjgv67uh0peBQB+PBfkscKf42qc/K9xKT2yaDTRT2lQ+s+1
         zdElZd+oW1YLX1I61lXHUbTsFbguA9F9OADCEaloUAVYqUgQVQWr5Te0jHAYEKSeKC55
         Jni/P+PhYbaeDiLSyL9cXJc/1MaZYbHkBqcBuqRSNfZGsvpl2xmuqK3ljnG2A7gTMGuE
         VHfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772033521; x=1772638321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        b=dyGSCSO2uFZ3XjRKUlBYi5DA0DRMbuNpVnPifvFYenMG1nCBJSQvtRc1VrI2lESDXF
         Wn2psPpywm2DFoyL5YBQ1K3uHK6wmbeGKGaP9v+QZGNuYzFS3zgKTBI2hKC4xi2SvdMP
         oDeOeMDUsx/wI4kb08ywtvxYg8k1Al/Pf9RQlGyWGTHxohqEjPpmZwxXa3c63r5oGENx
         fjudeYM8I7rUeaVnLD+eH+6+2W3sWwjB9PZoYe/5sy8b3JclO6RiI8s7PuXXvIJHCNej
         RYMxXDQjkcCVRkZXDtlZmCymVXXInvZ8zdAXnn1PXLNjPGhc4sItegHKMEwIRQQtU0o8
         xGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033521; x=1772638321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        b=SVJMDQtwUbp4l7j3/6UTVonBizG1YHvGKDQ4jQiJpeyk9YZnxduE0hRak9vWBuSpiu
         7ljRtJB2hH9rNhnt/yglK3rbyJpVuH7ORIpQFihuhg1Q3hIw3hwYcmmBrzoTE+bcBane
         XFzdcbeadCnfIU0gwX0XKQh8u+69KFALjKcBhfSG3/AEYiTUAJyTJft/n2hYyoHFDOn1
         MwcB+VvsLLtX9sDWN6n2tfHnCwDusKd5gpZxxqEOb2NExNEDM83DpLRSY8rRqtfXB8lc
         uk7XGV0CrI9KmX62TdNqUaEE2llf6yJ6NgmhJEnqyP9TCb0Ahqz3csakRwdydkmJPkRs
         osmg==
X-Forwarded-Encrypted: i=1; AJvYcCUPsd1+j/lV0DHSeytDuprAR9sdWeZNbmAM+K5sRCF8s6GHcRrZL01pCH8wYCpI0xlUdzTMkRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4SrtojtwdSZat6L8H+bRhog7C4Yg23K1Edlk3mbbjrY08Css
	0yE+e4/jVWOaxb1qgvESyFTHEd+7aDYE0g0d4pPJZ0dZbMQDFAMdCUPZzT4URlJQUuW3NZHE8ld
	Vc8NnBbT1POPVHHWkh+/rB1pwzDcawy0=
X-Gm-Gg: ATEYQzzKto2qJ/ZtaFe+SNfuSNkNKMZ1cfglv3Fee6BHBAXfL904z2Nx13IMQ4BchII
	hY4S9VKX6opS2bZSzwcHXyVylSBqOnmZr42N01vgyhoGStUZAFSl0zRIL4QMuGunboJeDp3S+8M
	vN8EvHvOyXfndma5lJVAAPuIcYANaCqbkDaAevRl1GiVliF59V02fWyrLpOjTppw/Ndm/jCrTtt
	QsoasPAIUWpXxtuGZdFyzGS9T310jrxkqVLoyUDqkPQwEgaLu54D/Rs3u7Pux6QWES/DVJJi2rV
	+SMOcnpi6Z07jba+wAUYBov68Xl0swQTrlE7KSWfRvtADlZBf197+fiyykvLSz0MuWOb/1nAo9K
	A3jVNhh6ksmXW7hV9EkDR7sdbYxuZRLrudykG
X-Received: by 2002:a05:600c:5253:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-483c21691e0mr12465775e9.6.1772033520933; Wed, 25 Feb 2026
 07:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com> <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
 <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
In-Reply-To: <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Feb 2026 07:31:49 -0800
X-Gm-Features: AaiRm50uUxf6w6Nm2mJwbIUWIWYnVWO71EBV1G4XR43xAenu_Z1PpkZg1sv6ayE
Message-ID: <CAADnVQKE-ULKsArGdHs=_xakhMJ7-hiYrQ1X2eLpXFyJyY_ORA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261014-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[man7.org:url,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0471199A2B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 9:59=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> On Wed, Feb 25, 2026 at 7:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@g=
mail.com> wrote:
> > >
> > > From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > >
> > > This commit fixes the integer parsing of -t option. The cli parser
> > > only relies on errno to detect parsing errors. The manpage for
> > > strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> > > states that the said function "MAY" set errno to EINVAL in case the
> > > conversion fails. Currently on some systems, this leads to a silent
> > > failure with return value not being exactly documented in the
> > > manpages (probably zero). The reliable way to validate the input is
> > > to check whether the endptr has been bumped all the way to the end
> > > of the string or not.
> > >
> > > Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > ---
> > > v2:
> > >   - fix style issues
> > > v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmai=
l.com/
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing=
/selftests/bpf/xskxceiver.c
> > > index 05b3cebc5..5e4095fd1 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *i=
fobj_tx, struct ifobject *ifobj
> > >         struct ifobject *ifobj;
> > >         u32 interface_nb =3D 0;
> > >         int option_index, c;
> > > +       char *eptr;
> > >
> > >         opterr =3D 0;
> > >
> > > @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *i=
fobj_tx, struct ifobject *ifobj
> > >                         break;
> > >                 case 't':
> > >                         errno =3D 0;
> > > -                       opt_run_test =3D strtol(optarg, NULL, 0);
> > > -                       if (errno)
> > > +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> > > +                       if (errno || *eptr)
> >
> > This is unnecessary. It was required we would have hit segfaults by now=
.
> This patch does not prevent segfaults; it prevents silent misparsing.
> On systems where strtol() does not set
> errno for non-numeric input, passing -t abc results in opt_run_test
> being 0 without triggering usage().
> Checking endptr is the documented way to validate full-string conversion.

Prove me wrong with a selftest.

