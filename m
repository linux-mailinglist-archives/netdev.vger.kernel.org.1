Return-Path: <netdev+bounces-296815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiUpA6tjJ2rjvgIAu9opvQ
	(envelope-from <netdev+bounces-296815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2765B6FA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qta9XaNG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296815-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 660173010ABC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3162701B6;
	Tue,  9 Jun 2026 00:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C219E992
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:51:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966303; cv=pass; b=CdDku39SdO9G/QDtplJ9P2kadu78hYIgsq0M+TG77ppIlsvrI3ZyJR5+8cjWhud+TuYzQqebUEGSBFdfppsL9L0aXEoGU5dPD8siXWOU0FiCUxqRPYO+KvA/HAAdKSBalxVMd+ECjr4QlgBV1+kcrjTlrH+C4fUva9s2vW+KWtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966303; c=relaxed/simple;
	bh=pNBw/JYbTFeIQ68pEgi8F27k8tdkx6lYUXeNH3D0A6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqzBBywp+/OHopaXYigBZZ4bJ63RNmm4aR7ebiaVT9bHxTbZoo6cIqPQ0Tka3deAF+8D89/3RwhIND64b0G8trQUt0vxSLVqnMCEy8wqgZD+v0sN9BoTLXQ3Wtd16REHCQ7FHTy7o0GzMWhfCc3417C3BXfVL19MEOp0zz/fW5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qta9XaNG; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51790c0a692so49877631cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780966300; cv=none;
        d=google.com; s=arc-20240605;
        b=NTrCVFIAsjzpbC80qPyQetvyT3IaljUp73M+6S3YnHK251USTq5lKqUKnnIVliOCaN
         TGvwQ0kA2Kt1nD58lULN6msbAZG1j7yi/ZebXWXVHMqYfMDgeLUKF4JuLesqT/Ttd6Ty
         4rPyLmNgw1oWZib1kQGebiMmSau3/WTlTSMV/Gv78tN0IEjIzid02VLocztqq1bbDv3k
         43+wb9E+NMST72HrpEZNsW7tO0TnW/4/k+n+4MbBqBYOUsu8NXqvpNL+J7m1y+jjp3qO
         i3NLlSXnv8s2UZ52bmTUU6BTO8DyX5Ghu2T3+4igFLzG2arZHjOcBkh5XTvBUtr6ZFOj
         v8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0i39kCTiGN9EkAR5Nng+uGPJ/RstgOMRbdGBeGs+zWI=;
        fh=wzChm+h1ID8FvMZbCp628zgY7LvsVwrSyPUagCWFrtk=;
        b=Dj+owC0VH1yI5As88xyM3rLGhFAqfeJGY+m97DX2qLlsv2gvVR/2Qc86LTLjZEhSkl
         OKwlOSAjCSwIuJgH2XwzNvXJC4rhct9TBYwUNOZMZJm4CQGZ6Jn74wQLyyyswTCKFMQX
         ll1yE9vWFTg8wMRhftQHSsGUTqTBfD2K5X5w58kk2ec7tUs/gxywU1KIIXCGImWDAFaH
         lrovLgbUxpOgYnHcC0tO6Lvo7fnID2Gdnop3+b2G3XaiF66ZaVsgQkKnWorS0dF9CMoD
         mrOBeVFRIYbox5mkj3mqWZ5dmhqnD09P+ddQ8FGautJasF7ZXXKtT97QnpychiBwU70q
         GnpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966300; x=1781571100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i39kCTiGN9EkAR5Nng+uGPJ/RstgOMRbdGBeGs+zWI=;
        b=qta9XaNGRwOZ+oOlvs/lmqqm76HFZWMfXEPsJdOmqnkl6RUZuZdJhb3y5i5/YxnTVQ
         7JjJne8UcEtmB3hj68TzYEXoUcuRfYhbQmcDtIQ5KymKIH3rc7RfgS32jVbUsxaif4U+
         PgLWs1BV/nblskBOni0doO1uWBnJGdHIX9JFjXu1adGEi0esaouzZSqHjAVdZTxHuT9r
         ykMXvL/RH7mlmtJVZ3jFBfZsvmsptYVuOlDLUIQ0nx8fjRWqrTysCk9jkSVcKdIKrbtV
         /7zxjo/8SoVXqi1fXOMTkmbwUaisqNW7NxJsUML6f7hviSQYC0e0XJW43qSnqgrh+s/7
         yxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966300; x=1781571100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0i39kCTiGN9EkAR5Nng+uGPJ/RstgOMRbdGBeGs+zWI=;
        b=cvgP/4dVngx7TFFxWH4IhpZfB0EK7Orha+134m2wKjnsdeTzHgY7yJspXfKJQ8J0IN
         iX1fepma255MEdmfsRh4BBKBqdZqjr4c9/aY4KIrnXx9Ez9wywxERRByXuwoHJfRvQ8Y
         mtL+O+TkYKmmSwwbUEPUuUMzoCAtE5dEU+P2KEXCVCn+TqRK5MTu0IK9imzWXVUYI179
         OBERNZ73TpBcQGvLfa3yrdaWDKQUNV8mlReBHSfZtU2kyZTFtOHTgPY7RV3BKsR4UEZZ
         cHetmUKts79YFWs9aLboMNzgW179lJ+4sWH9JoHbF9lAS04ZFDHZzNtZdeJQ3x/uLMBm
         Ur/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+XLQAVCwpM7mc/YjHo8LyBDsrGpPNSaBTKlx48MkQreA7vglEydZ94iaNxxCIRr/X+63+7h08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL5PYpB7dt/qpf8Q/7PJWb+hi2XIH7EhXQyQM8mZWU2Jir8NN
	uBhj9GvcVfeHysuXK5WzZWnSGuCFZBiGzCa8RFDWuifFgPJe/bOjvkasaUl0Qau3D4eSj+KcGIC
	p3iFka7Dybc+w4tm7kIlq3kMgYyC13t/RoixCB4Jj
X-Gm-Gg: Acq92OHM2tOBWVK7LUXYOVF9nF6bkAC/TToms2r071QsELmMAxZdrRJpLRLJBo3SOW/
	IdfwrDJvZVIT3wvPhgbM9wGP9h2CX83GpHLGvO14XpXpfngT2SjW3+sduCiVIlej+VESgDSz9/E
	zEy0Tl8nfzLLs1XTRdZ4sxzCNhrBn7QVYAFL89AmE9N+U/VBBHlzhUx03hmxqDzKqdhhoKJU9iS
	1sZFa88FrxIKXytg3KfecBjlQan13W6ozmdGApCW8RBHM+0vpFx+cz1n0IZmL8Ubhlgf0cPMvHQ
	nTtF5hiC8xWk9ZAWD2a5zHypcPulESScr1sP5NUqn/NzFS4bkREjnToLIOC6jMATWsyL35n3w87
	Wu5/nWwW71gpCbPwH278EKmfo6RmN
X-Received: by 2002:ac8:5c83:0:b0:517:812c:ae3a with SMTP id
 d75a77b69052e-51795b83c41mr239451681cf.51.1780966299327; Mon, 08 Jun 2026
 17:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003907.1238501.72ef81046550.fq-internal-plimit-bypass@trailofbits.com>
In-Reply-To: <20260609003907.1238501.72ef81046550.fq-internal-plimit-bypass@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 17:51:27 -0700
X-Gm-Features: AVVi8CetTw7-V8-99MYpu-hZRkDjuE4D8TbWMU8Acj7zEPy-hltQMBcEnRlTNt0
Message-ID: <CANn89iJHn_-Vv70jpW9QpkYYjRCD5fd1=U_MvTJW+sXwz+Et5w@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fq: account internal fast-path enqueues
 against plimit
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296815-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,trailofbits.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13E2765B6FA

On Mon, Jun 8, 2026 at 5:39=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> sch_fq has an internal fast path that can enqueue packets without
> applying the same packet-limit accounting as the normal path. The queue
> can grow past the configured plimit through that bypass.
>
> The packet limit must apply to all enqueue paths.
>
> Charge internal fast-path enqueues to the same plimit checks as ordinary
> enqueues.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  net/sched/sch_fq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index f2edcf872981..608ff3ecfb16 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -548,7 +548,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdi=
sc *sch,
>         u8 band;
>
>         band =3D fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
> -       if (unlikely(q->band_pkt_count[band] >=3D sch->limit)) {
> +       if (unlikely(sch->q.qlen >=3D sch->limit)) {
>                 q->stat_band_drops[band]++;
>                 return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_BA=
ND_LIMIT);
>         }
> --
> 2.43.0
>

No, this is very much intentional, please look at commit
29f834aa326e659ed354c406056e94ea3d29706a
("net_sched: sch_fq: add 3 bands and WRR scheduling") changelog.

Your patch would totally break FQ band isolation.

Your patches are lacking to describe their targets (net or net-next).
I see no Fixes tag.

Please take a look at Documentation/process/maintainer-netdev.rst

