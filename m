Return-Path: <netdev+bounces-297749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IU1aKbqLKWqaZAMAu9opvQ
	(envelope-from <netdev+bounces-297749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 038DE66B2C7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UIrA328K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297749-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297749-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C937317416C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DD48123A;
	Wed, 10 Jun 2026 15:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A3481660
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:46:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106396; cv=pass; b=oP6svgVEZBCeUNdNFMrU6qgLHopA5idKppJZvMyr/8XAhcf5jFfVJqi2+8QH0/6B97U8Ca/BdhGxO2L/EytLM95uNU+jbUNP8qs/0GEK2LPaIKWWKcymHImn8NVfyHWek5hz56IGQOa85LGyhHSjUsGXBjVaNkD6XCX/ZfYEFkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106396; c=relaxed/simple;
	bh=LlejGVeNf9MQGP7Vy3nqTh4i/eTPk2UsDb5dGTTrY+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKLe6DXsR/yx+MscndPW9x9hk1TylrHxD5v2FcXQqvHDnxXZIA9r4cic2NbW85KfZu44WFeg8By/sPE/RHjCQZZM5efuS1tB8+ExsRwLwO1Cm4cR+PP5dq/e0tr9p9oqc1oBIzIBHCLC1/WCwI3A55+k2PORUvoU6XPw8kqqXbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIrA328K; arc=pass smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a76757e5so46184355e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106390; cv=none;
        d=google.com; s=arc-20240605;
        b=B3+7FgH6Ab785n1EA+uId45xLIlemSFGRudEbOpLtbTlS0mN9x7uv35XR448L1imMm
         tz+V39WC18gS3jYAfu2pHgPsWo+ZJNt5tmXgsHrLU9jPp1ex/9rR1+ZMPwB9z0aLdKqp
         Mt9VGy4M1iJASk6rsTuhMaDAseATWeQdl1ozYvsKo2Dd0OIofo1QngnYE+a3aLSvsgUN
         S4yMvydMmLmKKNreLItpND3I5e+OIeMxbYdQGJolYZz5ZL4kv4+E3SQTCZfz0sgRcDCp
         atuadeGZVCvybkbeDSn8TS9EEoVb3kBLOhfI3XIJtR+f5DoYQtzLiwzJ506kdE33jvpT
         xGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        fh=nAVu9odcJx3YHCjbEMkhlp6TH92j0NXGuVx6Greu6VM=;
        b=hffaN7xNwQEG1i1xHKg2p8sMmVts2tyoIMnsUt1vrv0sk0rFlDx1HhJKLxvSxOL92q
         ZZrX2jStcroSNY2MNNSFh/lea5Um6YB0z7PIFAOzBLLnqR0a6qn5oGd6RP7a63KxCxi2
         2edb3CStV56ohWaJ7u3YuOmDVvbUwiRjTSfVyNVUP86xtABF2QQF7iRMcWLhzPxSAN3/
         4oV8AaK6ykrPsOliP0T+2iCsFBnPKfqCCvlSSP+tqQHC8as7Y2Nch2k6jrpOJgwy2kUc
         OYfJdL+teickgXwUZ+risFZDOuxol1cPmgQqWU/r9wjPWf/eePPrInQyaOvdjDLcRnyx
         L9hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106390; x=1781711190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        b=UIrA328KJJ5thGMbSB/tZ7y88EyGTbWj3TSMy6ls04PM0wNq0ptS3G6B1DZcWWY64D
         GHK/49b+J0Ops8ny99z1EAd4LUIuUkWly2c1lXXWjhzjoyO+KWrukoUP5bQasU4gZyAQ
         SBPHK3gJc1N3ASRZxkS4L8ly3nPivAaW+JL10HoFti84aBYDHQ6h0EbvE0snbrz7rm6m
         vIxPtlVa7dD9qi63IRH5XELJPlZyzws9OYMgd2Y1hkvjeV6TELD0bh5v/Hb9yngJe22u
         kxx2KQokrpZ/yeNuZGiwI7ZAC4I4ZKfbPZivUm+GtVVi6uDbOTVAgeF4XMzZT4mpyV21
         /+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106390; x=1781711190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        b=A8o43nHeOdUJuuP+n3OOFUeg/HWy0x/JfP8Z+tyMf3bQXd2MfM/OqJxHkizF8gdncD
         RxwtZLT9otlVNYBm3m0Qx1KFFUGqTJvYj85Kcbq9GRveM7zg0MNtHiq1QChJXpUMqeUJ
         pS9bdqKuJL/nIw6cnTt+jY63TYadHrv3VnDMU/AtZfpHE37MIXHWqmp8YM+wbsETgi5S
         Gdi1f/MeNdIYNdkTdPknKhM/ssik7CtkueOyGQXfZRVsTYoyxkmZkfVzN5oKtSY0h0nV
         zS2iyVv5u7C19dKev1dmA56dzJDAtIJT2rONug/qIo00TajHcTW34Y7+atvX9WiC5Gyr
         MsPA==
X-Forwarded-Encrypted: i=1; AFNElJ+2IobLurjXtH9GLIe3BcfjFL7HG1rjDFtvINoqC82s238jtfR+k96y3YRI1HVSxDSJZ+Gs4/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXR1+mbls4k+n1KRjq+C6/a6xMH++WzwyOErqLaE7D8pNg/4b
	FHGPTdA9JPhAmiaCyBs0juKhCNos8GsnVmJ5f1nhyZImfgyOmXlazqkJVD0HUxqbl+NTXntu+GJ
	t5FziqwKRspm57AyCb2ESfrp/edWwDW0=
X-Gm-Gg: Acq92OHYgGiIuKDDkhm6jTJgx2pOue2yEiVdOtdvQkw98cFhuC8xXDDYiL8y9rOjXnk
	KZsT+wS6o2deNl14v8yoI6RIm8HNPCLhn4XSyc9XPHelguglkBBr+zdfHNyWz7GWZhqS8imEwUH
	jRsVd+WAfZKzHIqDGhZg1ti15NcK4H5Xzk+8mwWc4SMMQVObKPYG5XkU6vSmC6/MwBAh06CWTXM
	WMQeYW6WkE9jYqfLcMkcbCTlQeDtYx6rwHqfzNQOQMeRTv7xPlLCdU2kHC3E1VW113izI3oeg0D
	YuUwAw8BJZNCLsEmD/Sx6XxOUGu2Pec=
X-Received: by 2002:a05:600c:8b0d:b0:490:b9ce:a73c with SMTP id
 5b1f17b1804b1-490c55662b1mr421764765e9.31.1781106390156; Wed, 10 Jun 2026
 08:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607170959.823755-1-jt26wzz@gmail.com> <aiaTZCQLWy-96M9O@u94a>
In-Reply-To: <aiaTZCQLWy-96M9O@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 10 Jun 2026 23:46:18 +0800
X-Gm-Features: AVVi8CcoLtFn4ZVY2bNQmeRdbugLd8hTbDX-gKZVn4sspRD8xZt4FZSBjUYoMz0
Message-ID: <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shung-hsi.yu@suse.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:sdf@google.com,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,fb.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 038DE66B2C7

Hi Shung-Hsi,

> More importantly, 'bpf: make the verifier tracks the "not equal" for
> regs' does not address root cause of the issue, it merely mask the issue
> by making the two states different enough that the two is no longer
> equal, which works for the Rust specific case you have, but won't work
> if the value was slightly different (e.g. "r0 =3D=3D 1" followed by "r0 !=
=3D
> 1").

Thanks for spelling this out. I now see that I did not fully
understand the point behind your suggested bpf-next-with-d028-reverted
check.

I was treating the not-equal refinement and the linked-scalar precision
issue as two ways to break the same failure chain, and chose the
d028-based path because it was smaller and easier for me to reason
about. With the `r0 =3D=3D 1` variant, it became clear to me that this only
fixes the zero-valued branch shape from my original reproducer, while
the underlying linked-scalar pruning issue remains.

> Could you give backporting the full "bpf: track find_equal_scalars histor=
y on
> per-instruction level" series[3] a try? For 6.6 it should be doable, and
> hopefully for 6.1, too, but not too sure about earlier ones. If you prefe=
r I
> work on it I can also give it a try later this week.

Sure, I will prepare v3 based on that series for 6.6.y, and then work
on the 6.1.y adaptation separately.

I tried applying the series starting from 6.1.y and still hit some
issues that need adaptation. 5.15.y and 5.10.y appear to need more
surrounding verifier changes, so they may be harder, but I will still
try to work through them. If I run into anything I am unsure about, I
will raise it earlier.

> As for the selftest, it would need to be send separately and by itself
> to bpf-next, and picked up there, before it can be backported to stable.
> I suggest you look at [4] and have your test placed similarly, and
> mention that your test specifically test a Rust/Aya pattern.

Thanks, I will send the selftest to bpf-next separately. I will also
change the test to use the `r0 =3D=3D 1` / `r0 !=3D 1` shape, so it covers
the broader linked-scalar pruning issue instead of only the original
zero-valued case.

Thanks again for the detailed explanation. I have only recently started
digging into the verifier implementation details, so this was very helpful!

BR,
Zhenzhong

On Mon, Jun 8, 2026 at 6:11=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> Hi Zhenzhong,
>
> On Mon, Jun 08, 2026 at 01:09:55AM +0800, Zhenzhong Wu wrote:
> > Hi,
> >
> > This series backports two BPF verifier scalar range-tracking fixes to
> > 6.6.y and adds a selftest. It fixes a verifier state-pruning issue wher=
e
> > an impossible linked-scalar path can be kept while the real success pat=
h is
> > pruned.
> ...
> >   15: (85) call bpf_get_func_ret#184    ; R0_w=3Dscalar() fp-8_w=3Dmmmm=
mmmm
> >   16: (79) r7 =3D *(u64 *)(r10 -8)        ; R7_w=3Dscalar() R10=3Dfp0
> >   17: (15) if r0 =3D=3D 0x0 goto pc+1       ; R0_w=3Dscalar()
> >   18: (bf) r7 =3D r0                      ; R0=3Dscalar(id=3D1) R7=3Dsc=
alar(id=3D1)
> >   19: (55) if r0 !=3D 0x0 goto pc+6       ; R0=3D0
> >   20: (67) r7 <<=3D 32                    ; R7_w=3D0
> >   21: (77) r7 >>=3D 32                    ; R7_w=3D0
> >   22: (b7) r1 =3D 1                       ; R1_w=3D1
> >   23: (55) if r7 !=3D 0xf goto pc+1
> ...
> > I also checked bpf-next: bpf-next passes even when the d028f87517d6 JNE
> > refinement is reverted, because newer kernels also have the later
> > 4bf79f9be434e ("bpf: Track equal scalars history on per-instruction lev=
el")
> > precision-tracking change. I did not use 4bf79f9be434e as the stable
> > backport base because it is a broader jmp_history/precision-tracking ch=
ange
> > for linked scalars. For 6.6.y this series keeps the smaller stable back=
port
> > path that directly follows the bisected fix: preserve scalar bounds aft=
er
> > conditional refinement, then add the not-equal range refinement in the =
older
> > reg_set_min_max() layout.
> ...
>
> To be honest I have not figure everything out yet, but I really much
> prefer we backport commit 4bf79f9be434e ("bpf: Track equal scalars
> history on per-instruction level") to address the issue instead. While
> 'bpf: make the verifier tracks the "not equal" for regs' itself is
> self-contained and reasonable, "bpf: drop knowledge-losing
> __reg_combine_{32,64}_into_{64,32} logic" comes from a much larger
> series[1], and taking that out of context seems rather risky[2].
>
> More importantly, 'bpf: make the verifier tracks the "not equal" for
> regs' does not address root cause of the issue, it merely mask the issue
> by making the two states different enough that the two is no longer
> equal, which works for the Rust specific case you have, but won't work
> if the value was slightly different (e.g. "r0 =3D=3D 1" followed by "r0 !=
=3D
> 1").
>
> The root cause to the problem have been stated by you already, it is:
>
> > The relevant pruning point is that regsafe()/states_equal() accepted th=
e
> > real success-path state against an earlier cached state where r0 was an
> > imprecise scalar and r7 constraints were loose enough to cover the curr=
ent
> > r7.
>
> Looking at the verifier log you have, in the impossible path we have
> r0.id =3D=3D r7.id from instruction 18, where as the real success path (t=
hat
> skips instruction 18) does not have that relationship, thus the two
> should be considered different, and that seems just what "bpf: track
> find_equal_scalars history on per-instruction level" solves by having
> the correct precise mark.
>
> Could you give backporting the full "bpf: track find_equal_scalars histor=
y on
> per-instruction level" series[3] a try? For 6.6 it should be doable, and
> hopefully for 6.1, too, but not too sure about earlier ones. If you prefe=
r I
> work on it I can also give it a try later this week.
>
> As for the selftest, it would need to be send separately and by itself
> to bpf-next, and picked up there, before it can be backported to stable.
> I suggest you look at [4] and have your test placed similarly, and
> mention that your test specifically test a Rust/Aya pattern.
>
>
> Thanks,
> Shung-Hsi
>
> 1: https://lore.kernel.org/r/20231102033759.2541186-1-andrii@kernel.org
> 2: https://lore.kernel.org/bpf/20260601182508.29C811F00893@smtp.kernel.or=
g/
> 3: https://lore.kernel.org/bpf/20240718202357.1746514-1-eddyz87@gmail.com=
/
> 4: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com=
/
>
> [...]

