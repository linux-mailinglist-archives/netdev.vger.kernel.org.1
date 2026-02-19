Return-Path: <netdev+bounces-259398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDxXIHiAlmnFgQIAu9opvQ
	(envelope-from <netdev+bounces-259398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 04:16:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D502115BD90
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 04:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF2330293E8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 03:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73D2765E2;
	Thu, 19 Feb 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb/rtfZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0E70830
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771470962; cv=pass; b=CeUcgz/xGLAC+zyaSvzg651DDpNCdN8u9DRwFMlCJGKwcKiknf7uRKJhgj/RFBtw9sMlXd6g48OPHvf+sCHWUeBXzZ1cMV3X4/o0RTmrLzxRFuAjZFGJsn4q8CTlt+RnDZQyZ0aLGdWvd90ivT3rKzrtUcz5GzawBBXCcNJ7dkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771470962; c=relaxed/simple;
	bh=jlCbJqBO571MidmO2wSH6N7GAv5ijJbh91S/So6TFw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo3DBTiytQnNDVnjzi4nQb7oQX0HN6ALq9zxW8defk89fzPdCA747h8KwBMTsRMtq9OPKQkNy0Sl88qMvikyau0+Q4HrDRpL00nmEYI5PnPwePwhql47hzOSJpkfGXAPHsJKwO820Iq6Fk2h1huhHgiG7kUrrOJt8/3TzPuWmMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb/rtfZC; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso5294985e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 19:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771470959; cv=none;
        d=google.com; s=arc-20240605;
        b=hOADvcQ71U0rwsfE3kOgweWld3+X9FWI4GAJr1zHLYqZ5rYL28e3ZLPFvUQnDYRkjK
         S35h7jAR4dulJgJZG8DXmPI3w0i9iMB15rdEJ7Z1yhdCJzJN7UXWDrChK2ZB3KK0pnhm
         u4Q9pqR8hg6L8F0nNlqw/b5ELR9WginY2q/PRWIMbFHvLDReB6PHOvNZY34if5rWTm13
         Pce+ZjHcqMin2HVGdYphff5mBusHgnPr8jfFHVWTmcdI6RtInexWOMKg56tnZG62xHU8
         ZhMiUXM8QBCdn634FDr0wS2/8c4a1V9osjWjqNdxiA7P5bAaLOr4YWFgKzgZdavFnPsI
         wU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        fh=2Rk4KZspciq4mcjUQpF9J/yR+Yvq8gru7HhWY54Y+XA=;
        b=GsxnJdR9zlnOHtMB7KeZsSqVj8Woa76/cd8jobyoG6qfU0c1fDxLaSZTY+HcO6ZLOV
         rTjdKommcS7eKkUVIpM1JP3KxoKU2FXa92h5+OdS/1Tl81x3IGaiM1BxgHhex9Ep3uc8
         BXIZavAqfyOXXCRomx7CgW4mmwAqBjA07jw1nThZRujNUFHPSUMmv78zOSURmaYqtcC+
         CV34ju1GLJIP3DsKT43D8cV/PK133u+U2W+DYppoHRQvPwWIx9TRPOXYCjHMgFx3LQCd
         qd8XX7XrHhAViF7if/oIWokiN0LURtf4Csf0MarcQfSnVcUP2R7f86PaH1cabpLQ0OJ1
         pR2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771470959; x=1772075759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        b=Bb/rtfZCvz/6suRKPp+0hjs+hwtLbbE/o1EpgtBudtTz6GCGGi16OgBvWS6KkATYrV
         MkZO1djTqEXV5d7Yo6vQ0eiq3scuU9Lrec8S2zVR2HCa1oOYgRkrPgGn4KF2hqt6MGxd
         sabOxazVj77+QbD9rfvbdvqJAGrSmPd7jelPRxDV+UhXg3sK9CBOBUGwJ+I5Zwb4JEI4
         qzk6xdGHKZe6CHy6gsaGvAImPJRpwLlGKpluB2NAk/KedajfKW8wrZumzRZS4lb7quKx
         lZX94Gkmuds28U4ejBkRWP2PnxMiyqyEZF+lwOI6neiFY30DJGz46F3PnJG5p1uzVTjX
         3UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771470959; x=1772075759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UntGXKcFzGwNAgtGSqTbh0eSHenwKqwxhDYlBtgE9dA=;
        b=TYfEv5LQlRLNMuGtjkvNyGWE2u3Nvtoifn9Dm+Ze2giXOu5GVXti5ss99rVgFZvFxK
         NSq4ekAurLEm4GxOS4ut95CULOkTuM6UywpagG1JhB9QVipQ9YQ/7SVK0Kwm2+bYxrXz
         P7a1WErYz2j7HB5uCEmorE37GJIaTf2pU1DdwsXcftgmgk/dDVeGkLLdGFYuexhzQwtf
         B16p46QARDmUWu8FvxK9rFNje7UdSRy/DWtqHMSmcOYPJ2/gkOg0twgD+0Muv7ucC8G/
         uKfYqxcEDem4eo8AEr4vQR8u/kFQEQVKFZbSNviRQCaKxi34HwXVnaE0o9Dvpkv9nGuh
         owkA==
X-Forwarded-Encrypted: i=1; AJvYcCW67c8lJqj8aNHQN+JYRcX4aDGZAUFcFGkKzpNIQv1QaE7yd5aBbt7GS0CNYI0sIGzUIY60Dnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+wWdhp96boAd8bWOvSfHVMV9l+smZOevhleKVh+INM0UfQh2
	PbAZLNMjDUsj3QNnHudbfPYMRH1ryvuKd2LvPohjGbjEp1bNN5Et2tUzAEnNGBzPUqkH/JPk0No
	FlLoZUoU+4SiUjZgXrpDqDCvb44U0fuk=
X-Gm-Gg: AZuq6aKofdGr9gZwQ/XuwJMEbB6ReaiVHJNLJ7LuhXwQKIQty0zNYqvXlQPXWoCMP48
	nEpT9dgIWtwaQIVH676hN2bc1vPnn8uNT57pkOomC7LyLNUM8kDpBPBJpUI40MRedbqVPrgGmmz
	6Xt9Lprvnw4fShNLYDNFB7+xXSL9z8bnzfHe0yCgdv+GeOehSXj5gU1o+KDu3zjBFagGnbSAxZ8
	2aUjtRM0Vu5IUcu7m1OIZM7LAAhGg5qrDK9oW5G4PWokPXZe8vwmqFyAn2BsVToDAW4OYBxrsw5
	x69jFEt7Cf3Xh7yEU8ySR+M06/gqHcpM2oTHs85VfogeUnuszeT7N9YVDEG1XtHtp2Z+w3sta7D
	tYYnHqXOeX5nAXtlEuche+/HWlA==
X-Received: by 2002:a5d:5d85:0:b0:430:ff0c:35f9 with SMTP id
 ffacd0b85a97d-4379dba3125mr31163255f8f.48.1771470958805; Wed, 18 Feb 2026
 19:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com> <20260218104328.14341-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260218104328.14341-1-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Feb 2026 19:15:47 -0800
X-Gm-Features: AaiRm53gWOBDMduyfV7JO2kUd65n6UPNFg_pAv-3-BgblkJrkKoD_kavOi4g3jk
Message-ID: <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-259398-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: D502115BD90
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 2:44=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
>
> - This programs cannot be compiled as bpf_core_cast cannot cast to a
> multi-level pointer:
>
> SEC("lsm/sb_eat_lsm_opts")
> int BPF_PROG(sb_eat_lsm_opts_1,char *options, void **mnt_opts)
> {
>     void** ppt =3D bpf_core_cast(mnt_opts, void*);
>     bpf_printk("%p\t", *ppt);
>     return 0;
> }

Looks like there is a bug in llvm, since it crashes on the above.
But the following works:

void** ppt =3D bpf_rdonly_cast(mnt_opts, 0);
bpf_printk("%lx\t", *ppt);

Plus Eduard's diff:
-       if (is_void_or_int_ptr(btf, t))
+       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))


> - There is a workaround, which requires introducing a wrapper for
> a pointer or typedef:
>
> struct pvoid {
>     void* v;
> };

llvm should have handled it without the workaround. It's a bug
that should be fixed.

> I think there are no technical restrictions for treating single
> level pointers as PTR_TO_MEM.

I think it will be a missed opportunity and a potential foot gun.

We didn't support access to 'char *' initially.
Later relaxed it to mean that it's a valid pointer to a single byte,
but since the code is generic it also became the case
that 'char *' is allowed in kfunc and the verifier checks
that one valid byte is there.
That was a bad footgun, since we saw several cases of broken
kfunc implementations that assume that 'char *' means a string.

There are only two lsm hooks that pass 'struct foo **'.
If we make it ptr_to_mem of 8 bytes we lose the ability to do
something smarter in the future.
I think we better add support to annotate such '**' as an actual
array with given size and track types completely, so
'struct foo * var[N]' will become array_to_ptr_to_btf_id.
That's probably more work that you signed up to do,
so I suggest treating 'void **' as a scalar as Eduard suggested.
This particular sb_eat_lsm_opts() hook
doesn't have a useful type behind it anyway.
I'm less certain about 'char **'. If we make it scalar too
it will be harder to make it a pointer to nul terminated string later.

So I would do 'void **' -> scalar for now only.

