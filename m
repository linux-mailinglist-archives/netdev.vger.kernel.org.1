Return-Path: <netdev+bounces-263499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCwCKL1+p2kjiAAAu9opvQ
	(envelope-from <netdev+bounces-263499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:37:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4071F8EEA
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 760133055E6A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783AD2F5A12;
	Wed,  4 Mar 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h47OWWuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C6257827
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772584633; cv=pass; b=hu0GcT8gnnyLdzl873dcbdYDx8IYpLUqlOb+QNgnZevxK13rJUqeXs8uFQ5Z5K7UQxPqNtPCptPwO0REgX1sB0LPtdeIMptLr5Dhy6hn5PEPPdZXgMpF5r0o86RVT7KfpgL2GMP0SeEbmFw29AvH/v/e3Vj9odyH2VI819lPoyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772584633; c=relaxed/simple;
	bh=M6yXY28eT/NPSOXtoeWobinqZuHIfZPk3axLOzNW8iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpBHsc+h5sUVePCTrOY283OpiSe3cf4BJuvL3zmg3TMoxYbR0YIKDrl+Z8yWQ/sE6YNEiKe4JrCzeLh3r5z91xW2EujrJ0o/gp/FNE8VXxgnieKb4142hUTd5JKv7b9IsbIQ4br4NBeoABEbtK7O20OMQI7oiA6PyWz7GZ6eAvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h47OWWuv; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so1692921f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:37:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772584630; cv=none;
        d=google.com; s=arc-20240605;
        b=kZPyK/0z0GIJru/+Ap7NjCnnzraJ++1/SENSTw57FlFPbxuO+y93Zdf/O1xnot9Gd/
         91KaRZ7iZ57vklxF9PhBal95OE5M5ZR+M0564bmwnwEJuL1Yi06rKr2Vf+SjYXNaENUm
         /+2kpP9VVlsm0NNK/A9p7fREOM1xU+86iBSSF7DhbRsLgbB5GVaiPoS50i62iOK7jdIM
         BjPiwfkrD1pCCIhTprB+iPLUmSPNrsUYVlrrJcS6Yb6rrBxP2ICKyEwKQ3Cmswcd3y2f
         sFv4cvrMP+mdWVb2hhC+hC8k6EuSA/+NjviAXrkanB0ifesLMUWUmBKKixaVweaH6L/Q
         y7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HjSTBkZmlHgWHXmWcu1dYSmftEDtdRC7tlAMRxF3WPs=;
        fh=ALqF671JzczYQgIPYzUHw7588MdsXRtj0QAE9f4ZwRA=;
        b=iK3g1QJnummQj9sELHcTbD3iDUlvs0FCzReh1NrGGK+gl/e9QDntmbp5Oai6wEZFAu
         kB9dv6xz1NNMUYTOlka5/69lCHwGG+Ml6XdqQDWkswz8McwuSn1ro1tMWIjcPV7755mN
         7djy85k5iyAwVr0cW84bMuAn2NeInYMQlHgpuHfC3FVv/WTlAXUPwlSfq5g3Mqkw+J36
         S94PVC4bYvfhHeLCICxZoGbBMsrl8M9vaohGQ8IZ1bG8ebeCU4R2diZMBMTcxF33zUuq
         RMrYAHz1O/oboPcFdXMyF57uhUOel4jSjFKxVLwtCAAtUkX0sZ9tYb8qgoIuKxHvCCI6
         6yRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772584630; x=1773189430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjSTBkZmlHgWHXmWcu1dYSmftEDtdRC7tlAMRxF3WPs=;
        b=h47OWWuvdvoackdwkbcSkHOrVKu0cSBfmZYwiiTMkYVDFC6IRofVTuru+c4EOjkgqv
         +mPCtb0aW++G8nC2hW+oJozU8SBEL39x7FaIa0MyFy3NLieX+nwbmq+UEk29a1K1Ao1s
         dTfteZoQltgpx+H4nWdUvaq22ijuHrwf+N+icOMKwSG2xgvJwcfA73sB8pOdAkBiWpPY
         o97S01z5dYX7u0qTJcsRymxhkwtYddEhtYEqIuHxAOJ+3hfBY3JbaSeR6T/81s760HEH
         oyuBjfVO3nQX92G8QdJzDlB5NV/r9UrbuQZ+q0BC/YyPHzw4XO6SeMXWa/+dy4wjAjzc
         I5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772584630; x=1773189430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjSTBkZmlHgWHXmWcu1dYSmftEDtdRC7tlAMRxF3WPs=;
        b=aNeC4yn9Zricsw6SKX43Ug+w3SE5t2md/nPJDKKWFs8XsdjG6Sq/YcORSZHhLA/Orh
         LDDC1V+day3U21kfVEFkAyNnTWLAsn0wGUegqQD6XFSRUB335MzBSE5PfaeqbbxT/GVj
         /HSEJ6QGKMami6XokVA0NsRglPr3foaMwSvtbOuy+vJxUvNLSAf0cuWy6TYj92OqV/Po
         9zmrbRp8yycPOjDPvIKpVitIuP305FnFTTRtd+4zRvh/MKz94UJov6f1mSnchE2gYypi
         remInwXuwOfjaQbfWLztaZK0HBjX3djba1WvyB9seHhriNd6hDqBGD6Sx1iJtXgG2dJB
         gmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi9eWx0S+CIaHeH+icf1S5ZvQN+rUm07z5QWOgYFO0bekcbJY+n+dwNV4eIXVFY3pQnQDpGRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4w3YqsEvgTswdWloJJk5UkeBJ7t+4+tnyvSKzlduk04U0kJ4X
	pORzVOox2pE0fj2iJzQrMX8oJ53mVTPJOXYhFwooVTh0gaaXN63rtRkz2vr7aRK4l/0dT+TcH/e
	vgRjpPjrydzyZnFOABkpZxMbb4ObBZVA=
X-Gm-Gg: ATEYQzyQfKCmSJExeiIArc4ZNxpK9JcnMCr9sUTruPkC0VAtPOCj3ihoPl33x5jUJEf
	im3DE9+As4Ic3Cg+nGUQs9oSK8VdievzklWyooeQk1AesjzXX5E4IWnXvZ1x4pqvSYzAVmUBZAi
	KDqncBaprPm1O5twTf3j38oTdghFnltIU+QfySh2DbJK05y8GoIkbmeI2494PUxPFPEGUmk8jlb
	3R/GrvIvTjayKd7Lpk15pNjPmjTHMVQpi0ZsVvdCLglGSE46DNqsMmVsvzLb343zNilGl6L9e8Q
	5qgn6LAhROrsxqi+pUuJNah/AwG/xCnpqC9hIQxqk8NxxZVasC9lg76hxC7SCfA2qKeKX6cBsn0
	RY1ofc4F4cFcVPmspDpucqKWIhxg4VOTPaHEL
X-Received: by 2002:a05:6000:26c5:b0:439:ba75:7db0 with SMTP id
 ffacd0b85a97d-439c7f650famr651838f8f.1.1772584630044; Tue, 03 Mar 2026
 16:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com> <20260304002205.15728-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260304002205.15728-1-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 16:36:59 -0800
X-Gm-Features: AaiRm53fsqHcb7hskQftzErG4rG0bRpNrutpMN_cIrd9jgoITk4du18ug015Amc
Message-ID: <CAADnVQL9baabzG=Efv-PAdFbhdaoj8qSwHT_AxHODPW678Cq+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types via
 SCALAR_VALUE for trampolines
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
X-Rspamd-Queue-Id: 1A4071F8EEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-263499-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:22=E2=80=AFPM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> On Tue, 03 Mar 2026 14:43:01, Eduard Zingerman wrote:
> > On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> > > On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
> > >
> > > > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enu=
m bpf_access_type type,
> > > > >               }
> > > > >       }
> > > > >
> > > > > -     /*
> > > > > -      * If it's a pointer to void, it's the same as scalar from =
the verifier
> > > > > -      * safety POV. Either way, no futher pointer walking is all=
owed.
> > > > > -      */
> > > > > -     if (is_void_or_int_ptr(btf, t))
> > > > > +     if (is_ptr_treated_as_scalar(btf, t))
> > > > >               return true;
> > > >
> > > > I'm probably missing a point here, but what's wrong with Alexei's
> > > > suggestion to do this instead:
> > > >
> > > >         if (is_ptr_treated_as_scalar(btf, t))
> > > >                  return true;
> > > > ?
> >
> > Uh-oh, I copy-pasted the wrong snippet, sorry.
> > The correct snippet is:
> >
> >          if (btf_type_is_struct_ptr(btf, t))
> >                   return true;
> >
> > With it the selftests pass (except for `float` tests noted earlier).
> > And regardless of selftests, the code below this point will
> > error out if `t` is not a pointer to struct.
>
> I think you tested with
>
>         if (!btf_type_is_struct_ptr(btf, t))
>                 return true;
>
> I decided on a narrower condition, as
>
> - if (!btf_type_is_struct_ptr(btf, t)) -
>
> changes the existing selection condition from "treat only these types
> as scalar" to "treat as scalar any type that is not a pointer to
> structure". Technically both approaches cover the problem I'm trying
> to solve - multilevel pointer support for structures, but the latter is
> open-ended and changes the current approach, which checks for pointers
> to int and void. So I'm extending this to int, void, enum 32/64,
> function, and corresponding multilevel pointers to these types and
> multilevel pointers to structures.
>
> It seems - if (!btf_type_is_struct_ptr(btf, t)) - works, but it's
> challenging to strictly prove it's sufficiently future-proof.
>
> > > This reflects my belief in a cautious approach: adding support
> > > only for selected types with tests added for each new type. That said=
,
> > > I can add the suggested broader condition and make it pass the tests,
> > but I cannot be sure it will be future-proof against conflicts.
> > >
> > > I think the broader check like
> > >
> > >       /* skip modifiers */
> > >       tt =3D t;
> > >       while (btf_type_is_modifier(tt))
> > >               tt =3D btf_type_by_id(btf, tt->type);
> > >       if (!btf_type_is_struct(tt))
> > >               return true;
> >
> > btf_type_is_struct_ptr() is almost identical to the snippet above.
> >
> > > might have some incompatibility with future changes, compared to
> > > explicit type checks for selected types. This condition is
> > > open-ended, including anything instead of selecting specific types.
> >
> > What potential incompatibility do you expect?
> > Two things change:
> > - types other then `struct foo *` or `int` can be read:
> >   - do you expect we would want to deny reading some ctx
> >     fields in the future?
> > - the value read is marked as scalar:
> >   - not much can be done with a scalar, except for leaking it to
> >     e.g. some map or ring buffer. Do you expect this to problematic?
> >
> > Note that the above are selected based on type, not on the
> > function/parameter combination, which is already not a very effective
> > filter if some parameters need to be hidden.
>
> I do not think any of these represent a real problem. As I said,
> my approach is based mostly on narrowing the supported types to
> reduce potential conflicts.
>
> I do not have a good example of such conflicts.
> The added tests for pointer to float, which failed with -
> if (!btf_type_is_struct_ptr(btf, t)) - might be an example when adding
> a new type might silently pass this check because of missing tests.
>
> I  was not able to convince myself a conflict will not  happen.
>
> That said, changing
>
>         if (is_ptr_treated_as_scalar(btf, t))
>                 return true;
>
>         to
>
>         if (!btf_type_is_struct_ptr(btf, t))
>                 return true;
>
> just makes the scope of these changes wider. This was
> my initial approach to this problem, but I was worried
> by its wide scope.

You contradict yourself. If returning scalar today for pointer-to-pointer
is backward compatible in case we want to make it smarter,
then returning scalar for all is backward compat as well.
So no reason to introduce is_ptr_treated_as_scalar().

Also simplify tests as Eduard suggested.

pw-bot: cr

