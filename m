Return-Path: <netdev+bounces-258821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2bHtJUJtkmmstwEAu9opvQ
	(envelope-from <netdev+bounces-258821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:05:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D461408AC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F9BB3005A86
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52A27A91D;
	Mon, 16 Feb 2026 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJaES4Yt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B251D5CFB
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203902; cv=pass; b=KMUunVL+NQmkQNZ3AE2a2KbIOeSEQd53JKE/nlm9D1q1ly0K+SBr9zuGcl4N9BR2lm+trHskrGh07asOZXvu2NI1HWNU2qJv4ylggIaajq4GYRdW1mUpgGWA8dwkS3si8lojuNyh18k3l6FLlKCq0ghodMeaW8an5eAv8Q7BepI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203902; c=relaxed/simple;
	bh=nJojw4RAHs7l7r+Fo9vlFDzzUIL3e/8udM1ParGdhXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHrEZ4/LKGghJdF3X21kNUHYf93+ukZU6+Sf7hUhi+edE8VvSz1y+eIIy1hoE+QpAW3zUOmx+SUskGB7AcZbtHbX7oJwg4swSQfiVXMriM8cbg67s9k6YthH/jjCaZXkLQ+7GYauq4ojFt44vcrcMiv45dbscFL2HmZr1nUJOAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJaES4Yt; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-127380532eeso7105337c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 17:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203899; cv=none;
        d=google.com; s=arc-20240605;
        b=J9bekrUMNMWkv2vWENlE4tVLh6MlH6Goc20KlncwbsL6FF17uo+A33/zN09GU2DqO3
         GrY3Y7IlROQDCGva1Z7Ykl3pK06g+9rnSgjrhorBBU6h7G4KwCUAe11x3il3b+sk1eny
         N1nR12njHFQJSGMrjqGUFGZju4/sISSgSIEG+vqwYgZKoC9bzBEnVnSRyTHmed4NC0cQ
         UmfxPQDjtEPE6CP3fD8i/KGU7/Quqp6SK2fi+TX5ka+pDS2ej+72shJqO+8IaPIOcQP+
         u9/eRkZTRFgbwYsam6kkKDTTqhG3bJeb2GHcGfJIW50+6zFni9cATe+IIaK2uua1Wbcb
         EzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        fh=qNZLijMNiS9tSpkdgZRQniZWTBa0oy8vyAfkAkLz98I=;
        b=V4pQneP/Lo9QDSJHeNUTKrVCbCBFh4p9o5QJPhyqgKB4vU6OuCSIHPfKHSXeUUwIfp
         y0WAlTy6CSl7kWqK7aHEiXLV/m2lRIUuOMpBcE00cSuLcfdUBRP3GkRQAwpBcHhFgoW5
         oyJ95iSzA7a28R3BLUGRf8QET5uSvF6mqQOyhbpkNnWPc2XzrVdP1g48L6Rbqd4js26I
         rYxW9VIONj17ow0qF/4D7nyMj3g9v2WG3PLiQeRlJza4z8BEWeS9ghG19yHNcvg1YvzQ
         daXf5zHDjL7l1B4F6dx+zaKVk0D6W0TCCFAAbuhsCsmjN+FKPXko0Ovm1JOxYyH1CFaS
         i8Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203899; x=1771808699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        b=JJaES4YtDOZUn9pliNOH+c7IU6HtB/2Xbr3cmnMCk2YEZ+VX9MtM8orr3u6ewUFx4s
         skmtPs8kKtyyE9/u/KyxIiH8FVUs/1zkOTAxJkDiwp8q1fsM604ej7Ou8fUWm53QqcfA
         nlGvFaN0joxJWckEWIEECAP4YpWYeA+S36t1alllHxlRf3c1h59hXEyJibbmuJFZdGoF
         5HknOlvyrBNHUmtvKYMUPNG80UpsuSoSYJ9fKo1q9NJYprsBMFac5s2+hTZRYr1vTi0N
         wGt6OZFwqvHxq9sBFI+cOXfOqx0LKtA5ot2Q6ZmCEkh+bBIWsVlD9B4+iGCrUDuHv9X9
         EHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203899; x=1771808699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRaH9CdLgfVLiyWm5pAQ4rgMWaoX/ETj8CsxQm45qgw=;
        b=kSg+pJ7OmTSGIGGF7/guaZyuWX8utpr+aDKPBjYnsNHG+VUO2+C8+lZR3COOg5tG0d
         ZA+Q5ySgenyX5uwRQBh59iyoToP1VP0ldCbOy0DCuiTJ8UQJQK99vleSeikD9+/SvuKM
         Ui5g/z2Nhwo7hX6nI/2p1ScRwqW2tQFNwWWhHPz6zHQFbFN9NkU4BkymLcULhk56Ptkp
         TJdrSwUOf6NOOs4rTJ5TcqFkxcWkyHte1bCnTvys/+FaKfRfsTSyJRaCFP6dOmAxPmhJ
         acn+fQuCoQsjT9g9K9/PcAmDZ2GOiuj6sr1sXDUZyQorFvO9UKuks9O9Wcxn0sG4yqBt
         l7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWvYsPyqyQkVlYcDtVJgxO9QLfuYEhdI84SsBdMe5p/aVjORt6ZAqOm2Xkhv3Hzj361O8Izrf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YSPm+GsGHhIFjAVGbYJj/KLrt2svsG5+/R4cfEkux8xeALGJ
	9v4B8viWeBUKhBwC9kJYf9COp5D+f5rXaUDGsO36wrqpkO9rjWl6BrT7lAk1MjilRZdDlyiXfr5
	ObS3ijYUUTqS9TMMuT4+/TKLmP9RRAalLBFq/gILp
X-Gm-Gg: AZuq6aIixR/eGsvagB+rYVza/KiHj8dXBPME5IIq4yQrjD1iIm32DOimg4bKVETuEfz
	8+nE24ZBpClx57Gk1X4c5eeKMSuTh7gwXOXA989PBQP5ws1vHolyDMQ/hCcl4egsu143ji73+Di
	LCMUeG0fhvdiCT/lFnOAg0Gv/b4MZEfjys7KtCTm+e6khD5nx3YOcdd2yFr09sHMYWocKuALFBa
	VTl/PcwRECNXYlvQjYXnKcW+hyeeP4ZFpbVi7MD2qo7Du/pFZyt8e78ttqSmfI974weJdmqAA5d
	BjalaoMJg2qSHfQKCbqwx0noWgxAVjz6tupa+Fpa4UTgEmU/OyQKLbYjBfKGyk5X86KCXQ==
X-Received: by 2002:a05:7022:41aa:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-1273ae20572mr5187717c88.18.1771203898170; Sun, 15 Feb 2026
 17:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215204353.3645744-3-kuniyu@google.com> <4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org>
In-Reply-To: <4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:04:47 -0800
X-Gm-Features: AaiRm51Pk6ofpK3ViL4G0QabdziltaHDnIs8gp385wI50EN3aieDUAmdV2XUR0k
Message-ID: <CAAVpQUCHahesdjJ_nKa1SETJpafO_B5hxEYWKWyfv3TdnB3gWQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258821-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,bytedance.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 39D461408AC
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 1:21=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2690,7 +2690,7 @@ void sock_wfree(struct sk_buff *skb)
> >                * after sk_write_space() call
> >                */
> >               WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc=
));
> > -             sk->sk_write_space(sk);
> > +             READ_ONCE(sk->sk_write_space)(sk);
> >               len =3D 1;
> >       }
>
> This annotates the invocation of sk->sk_write_space, but earlier
> in the same function there is another plain read used for the
> fast-path comparison:
>
> net/core/sock.c:sock_wfree() {
>     ...
>     if (sock_flag(sk, SOCK_RCU_FREE) &&
>         sk->sk_write_space =3D=3D sock_def_write_space) {

Will cover this part in v2.


>     ...
> }
>
> Should this comparison also use READ_ONCE()?  It reads the same
> field that this commit identifies as locklessly accessed, and a
> plain read here would still be flagged by KCSAN when racing with
> the WRITE_ONCE() added to sk_psock_start_verdict().
>
> Additionally, udp_bpf_update_proto() restores sk->sk_write_space
> on the teardown path without WRITE_ONCE():
>
> net/ipv4/udp_bpf.c:udp_bpf_update_proto() {
>     if (restore) {
>         sk->sk_write_space =3D psock->saved_write_space;
>         ...
>     }
> }
>
> This write can race with sock_wfree() reading sk->sk_write_space
> for a UDP socket, since sock_wfree() does not hold
> sk->sk_callback_lock.  Should this also use WRITE_ONCE() to
> pair with the READ_ONCE() added here?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/220428=
99757
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit is a small, focused data race annot=
ation fix consistent with the author's established kernel networking contri=
butions and standard kernel style.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Incomplete data race annotations leave additi=
onal plain accesses to sk->sk_write_space unannotated, which can still trig=
ger KCSAN warnings but are unlikely to cause user-visible failures.

