Return-Path: <netdev+bounces-298451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5yOODSIK2qv/AMAu9opvQ
	(envelope-from <netdev+bounces-298451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:16:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A4676926
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:16:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mPjr1kZT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298451-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32A130AC6AE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF726CE2D;
	Fri, 12 Jun 2026 04:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01252874E3
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:16:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237809; cv=pass; b=it8A6qGtF6m4VNxRo1G1Vvjx2aPw86F70SaW1OIJEOhwWtepYXWUZGBCh6OC/ftdy9I8i65dkBg8FPb+ipQW6TmT3OaDhSF/z2RWSe1sEzZ4wRLlWpJ8X5pbWp27GPC/jz0nAvHABLg+lW5Yc50/qCJlGkmvawITFZwqpbrAsfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237809; c=relaxed/simple;
	bh=aByKdEYmDrdAXoT4Aad2acQd+T7frYW7KWYyXTDQum8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjIBYipTGIXjDN1eqGf6XZ0pLcY7I99somtKRVZygTSKgqT4pWYwzFZb+NZ0OjkODtLmLEOpwbhsCbS+ugpcYR+ximRBOMX8OIQL/z4KAN5UaUsTVr82LLPPTEDae/Ovn/RnTU7gUOUCtLpCi7cR+FK36X8Wbmn5EwR5XGvNLRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPjr1kZT; arc=pass smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1383e116edfso454783c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781237807; cv=none;
        d=google.com; s=arc-20240605;
        b=JzXjhBlzZp2nUJbJUUVIx/ZRdChdwJHsO1DBg0HWXwQ051NmH26WEeAGB5tnhCAOlv
         Hb29CRPqlSAhxhxLh6oosdvDtdKuzAXzUzDnThH0Zsm5HGXQMsio7qSfbPGKpFko062O
         NNW7RLtUjbX01APE9MFigsCpTRx/ucVUSX0C4zVEtU3HGzhBxdCJP3sat1nKFTuUP4FY
         NtPKayUv+bac1v44hlaaBPbwkpeQoNBMc/4T0q3lFXq4KApXbFK8Ffl3MpjCvXlxp66e
         xtx9/CQY5EgmHLdMivMwmeKFwlzBblx0HlSG4BmnNf6HGbXnglxzpi08h/XC8t+s/01Z
         bOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        fh=90LBsriFIXYnVODSEGbSjvjs+td5XkAtdz5VbwxFx6o=;
        b=VC9um/TLMUjXpKA248mbXknoR7FNiadm27010OHZoIUOE/2LDsmt31teDHo7j7lcKP
         5uOYoWQh6ypNPYfQVoTc0goMbueijV3pTMGmthnykwrE7aPabd3LA+ZCN40BYA6cab90
         eUKJXZVICNZPw0KCCCvM6s63d+WaGxfu59kAQwgz1Lf93MEn9APk/04NUUA0GtUPlMER
         mPJYKGLFfP3Bps6thj0Fq9Dsr9DF2rkH+874OEyaW0xM3t+sKCp9idJzDQIyzNUlcAyS
         jWQ4eiPfOEBWy/i7ZeKbsHTDeucS8AfTSnVv1Bb7JohvqSyH5/peGeQzTk0yhzubcA4+
         DMXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781237807; x=1781842607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        b=mPjr1kZTTPI8PiFiAuG6eP7z/vf7YA3yoZ+qwGhSm+8B/yG6YBf4VHVsHF7YRjcVMA
         lcp8IkZ/bwL7k+1Hh9wHVyQEYV7MrCvLcWTbRp5jgeqcDoAczDz7GKyVk++4AfjXWVx3
         jcVtmC1p3kMj4aA4Lp+yhNk7tdKrsHVrABQ/Q+KAAfIHkTfsN+sbZlTJglKXLnTOB8XW
         04NC7m7mQr/B7gk/CYaE5mCZbJwMM07GRjIyeJSSmZPz9Ws5qwDYNWc6SALtwPOnubBq
         EbtPjopqh+nIv5noidtADKX9lg+NZ/q+oGScu1cqIdP20XGb3OIpJDkdh273IDIyWJJM
         VPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781237807; x=1781842607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/9qixpLC6/JP2Ij5RyIicR2pVsaWdLKqWMkigjsGTs=;
        b=IZzpUUYcm0ju5uZvWTbvs98Jmthf9aUDuInauMSTr1xJN6Mm8n02f8wm3zz0z1m3NV
         koijUaKLiCDKWpETnsmj++CH67alEpBcGobMaSv7uBMSKha6pF5AtJYnI/yN9ENtuAhq
         Rw+W+VaOOdnnmtl7uRUFx0GgPHQIvVd2fUEMAx9qwcgazLGztAb1GJnR67za7xmLJYx6
         aOZtl41JajqmFMY8NTf534BIEczF1vbzvfPu3qNJbZBKuihzTZvRoLSAPTcR3MMihHI2
         4zjgwPa4La2ltXACUogMAWXqKlYerr73zDBwd+fOpeQ4smWIJBrwEKbKCPfs2ccTucV9
         yw8w==
X-Forwarded-Encrypted: i=1; AFNElJ9WL9HIKTidpkstZOAKPtdNvJZCisT9oOPQZK3arX7Zxz+QqHcN6Wespc2LyS5Dnf7/AuIY3kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJwbWNshuHt3jH00C2pgyF2kXPH0gb8jIx2ltoLWZ9mBk1M6g
	98gBlVF4d+WeAgmwA8QzdhDcj8Ciq5hzMfQA7T4OUX6o57cmhXXTpqaTjzlqDaL/PWbguDD5qP9
	heRttsjjrnfNeNhPbBXnOKppi9RZQYUe0HPJ1vKoI
X-Gm-Gg: Acq92OEHNsKGsqcyRWA+IeEXBEb+ZFG0NZGiSNe5TA2UaeNBm6/L+IycXv6c8Exz65h
	Cg/R1sbYwIzcW9qMN+wqSLZ/8BFCWYXP5ySnW47Uqh90wiep2j9Zzt1IBdpJJFJI2h9UBNIvl4I
	bAyXdv6NC8NDm8YE/RvLHQH3cyCtE/OZ4ukDhy9LWaHNLv6xQNYgrY8j8W7eqEat2t/yIfQVY4V
	7BT6DZH5YrFWiS/MoSMgdMRBr7Obbj58Ezqwbgzfkot1ftIRn753JavQYVUi5E47gg2jqdUTBia
	56zIYmq33YzwUbiOQCy9RnCqqUoTafgZigaruSUPw2fLx69YGS1OXlS8wAtr+MpwrgEHPvNdwRg
	ZWQGVCl7aJosFEcyE6cqYY6QVvEFPJwrlRldCfMVn3jlPvLPuvIH7
X-Received: by 2002:a05:7022:5f13:b0:12d:cbce:5fb7 with SMTP id
 a92af1059eb24-1384baee489mr399369c88.6.1781237805827; Thu, 11 Jun 2026
 21:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com> <20260612001803.23341-5-kuniyu@google.com>
 <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
In-Reply-To: <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 21:16:34 -0700
X-Gm-Features: AVVi8Cf5RgJoicxZH2wP_fvnr9jS4dqjKjYyC21aEmx38pVrIOokFw2JIrbISWU
Message-ID: <CAAVpQUCUCETHTWR=_7E3eP8L-00NeJU1=b1pYJ8mjXcV6KbRhg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298451-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A0A4676926

On Thu, Jun 11, 2026 at 8:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 11, 2026 at 5:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index b4ac1180f5a8..bd9343288928 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4706,6 +4706,14 @@ struct bpf_hwtstamp {
> >         u64 reserved;
> >  } __packed;
> >
> > +struct bpf_tx_tstamp_cmpl {
> > +       u32 tskey;
> > +       __be16 protocol;
> > +       u16 network_offset;
> > +       u16 payload_offset;
> > +       u16 reserved;
> > +} __packed;
>
> Here and in the prior patch..
> let's not penalize modern architectures like x86 and arm64
> just because somebody has sparc on the shelf that collects dust.

Oh, I didn't know __packed has such a side effect even
with 4/8 byte-aligned struct.  Will remove __packed.


>
> Also don't use 'u16 reserved'. 'u16 :16' is better from backward compat p=
ov.

Will use it and ensure 0-padding with memchr_inv().


>
> And consider addressing sashiko findings.
> Everything with [high] or [critical] most likely needs to be fixed.
> [medium] and below is a grey zone.

Sure, I'll reply to them.

Thanks !

