Return-Path: <netdev+bounces-293487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGChIR7WHGrmTAkAu9opvQ
	(envelope-from <netdev+bounces-293487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 02:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84261883D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 02:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 540B0300E5F7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 00:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62C1DFF0;
	Mon,  1 Jun 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om06fQzl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0531A0BF3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274712; cv=pass; b=Pa88q4xVsbbHb7PbwwrLDkaTY/L2h102D0Jh/UrLtxNsqRaC7RHHOKXIJ/ZRJ/johVel7U4GbZAXjbipawIlcTFt5ozXoP7sHPPevhvcIvTUltLw5qPHgezIYBC9V4ESrEWAwqHegwi0r5bPHTmc1VbshkzvFtnb5SSyd2BIwWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274712; c=relaxed/simple;
	bh=IZ4XZSF64CuwQFbBvvn/SOHeTNC96IzPW50aIXcYpmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yku37OWENmkhuB8KqVtUjxxC6mazlq9ThGEodNdlPQJqVmjB9BZ+d/0U6FtAD/dOrp1ZOC9ddXiCEXm6LB+5VbJfBuoJbfDv+mA10QPPcpIdCQEALWkRMuSrfjgrWGEHeVOHOaas/E6p/ZMtAe/f6eLDREk9dD1nn+BMYovyY/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=om06fQzl; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aaa51683so978395e9.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 17:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780274709; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+pXaKursQgSrSYr8bRLHO0suheVc/wfEWQE/qd7D+dZFdqCKm6wfyXRwBigxTAK0M
         bQcANkUf6pNZLH/iYYIzt7Kiug+OR2axuVJzNUBpkydFdYXQPGuh3xMSOWtiEPLbVXSu
         E0YPMERHKd6VfNV2d+3D8fUjm49vHTuSmbpO8j+vwvwush+KYxTpmmEsE5w/Z0PD/rhJ
         1TjOI9tAVyU2icymbILRxWPeHQt0yFkJb05JxGv9pmS3arwQDcak5HeR1xfFX8a/j/Fg
         s29B7Ix2R7H/ncKZuFYLnyR9Bq33YoslBvZjS65dTceaKp+fEyLRVEyMdG5dhbGmeMCO
         nQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        fh=OcIS5BjxRPwuIRS0xwiQnZX0EI4Us3KbTUWUzeYK2j0=;
        b=DmekFZ1VsY41x9j1Z3F6AdO1vyHUJ2aJXb3RMasVL3sjzSr1VQ7nJBs6TZfLJTIjtd
         dtKsWVoLWaTFB0FY+Ooz3PshhrTrl+l7eNO9oBIpP3DoNVhMkmOSYXIbmUjAy+3w0mqE
         9HYB1rqi+UguWSxP7z//sQC18Y0ddpt/hdbfVDsC9tJa3PWKdkBvRXCZ5FV1guvCgPsC
         rwYanQvSp7t51tsAK2y9ATr7ophQnJ8zakXKlNw8HsnRsnxDT/JpD9+x/LEK4k5y6iQK
         VCfFYQ2ckm8YHZiaFJOldorbHi2kJiNH38NWZMorThgDUVhrZ3/5iinmSmqTNpQUtqcT
         WkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780274709; x=1780879509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        b=om06fQzl9Pe7ZDw9yJtalGj8wV9NlNZQi0Ra6RKs32AYCE2qK2SatqyvAKdiWX8moH
         3xBtPBld5UiKtMCqZB70uWpcWbhh4vwbPrDofx/i2OcqUVJNvPjVgi+jT5lKTHwq/85a
         iYz+BD1MCJPADOdyC3uazqqcnhCsJ0F8DKkfmVXQjiy0Heg03EVOVVz685JCG6bZogId
         LxoXOAD+WqPuuCFWeD9cSyZmeyy9DmlglrSV9bhoQTQRRneNifVYogQbowunWgPkfX5A
         8p9xzbdNISDZxX99EFrRYnPS8G7gfRyBo7/R4CGL3YRt1JQYUEkqr9bp00+MNuFNjSSE
         UXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780274709; x=1780879509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NR2hmbEsf+lZOhNyIUzFrhZQ4twYIu9TsbQ2+1H9Yqw=;
        b=GYIyN67A4yzILIfFMQ8teOsXemtEH1ktnR8XwzlgTz/hNwkEkU8M+7zGGLb4/NPwmO
         5MK5O9MiXWkLcjyCfRwNn5huFAD2LSjKI+RSoK+mYg5qID/xFWMUkUsDFSYvMQjQ4bph
         v02kKj3xqNoDwq21Z+VSnhCISdiMVNSxpDQDM3uuuWHhVq8piN5B095K9L+m7urrzOKk
         aa8z5hSpgGLYf8gHc1XnFD/rWWB2leBcAZcAZ6IBydTkOBvn0UYmO0S+Xn8A+cVOcbri
         iPG2ZU0ryBMBN3wiMJaEfHNOVF6QZBmqq2X0hICmrQYt/9MUhSFNApumlTImzw/z70NS
         CASw==
X-Forwarded-Encrypted: i=1; AFNElJ8paWoKWor/8M7D5QlKoHc+imfpmpFEl1uzHj3YzXDWe4NeWtvfmr4kA3tg3Nwn6xpJb0X7I1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nCg2N+IjCwjiRAygv+1TTJsVJIlbjDDNxgx1lcpNUM2LnWjV
	JeYXQdD5aLJC1Ax4eaWfYq+VUoYkPDdDBRgPzHd8zmw9YDYMXo2IpM3at4MaY8QY4CqA95L6YP/
	P/WSypFWWsz9YemZUTCVfceseYnUvRkE=
X-Gm-Gg: Acq92OH7DirNxNQJ78kvqMStrXIc6dbh8xoAfM74UFmloD9UYREgw67gSkAEcKGUqRs
	nRof46/Mggv+hsxYOR7+krvlS9BLhybTHh6yS173fmDmj4lX0t32shKK7W0tyEpOr5lnn0dwlM3
	oAHNzYOS0jT91yZnIV7ah2You2BlkNNIvirHvH/VmuoLktIR5CceC5F/2ousUxLvmmgKiDi5QZe
	TnGs6YzRUPij23sHXY5u3Ld+FbfuZ0BCoMaJBQu8xahQJ8CjoLK2AQgtrMI5ZKySi+3TjVBhNub
	rXFPUmLYna6aRbTjeCARfGezmFOuAZ2YY0ZSVoJeJ7hjpzcPQHgidQBJSzqUz7LesQecv3LXvCQ
	/IqV0WY9cHk6V6aM=
X-Received: by 2002:a05:600c:4f87:b0:490:abd7:fd9 with SMTP id
 5b1f17b1804b1-490abd71214mr7854975e9.10.1780274708953; Sun, 31 May 2026
 17:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529151351.69911-1-leon.hwang@linux.dev> <20260529151351.69911-2-leon.hwang@linux.dev>
In-Reply-To: <20260529151351.69911-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 17:44:57 -0700
X-Gm-Features: AVHnY4JLy_kGPt9SuGY_PbelWeENHCrokYlfBWentfqbHu0QQiGfeVQh1WKtLPs
Message-ID: <CAADnVQLh7VEKAtckzz=XOVPT8ovpDQshvPPCWHDQu2OWQx27_w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf: Fix TOCTOU issue in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,fb.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 1D84261883D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 8:14=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Sashiko pointed out [1]:
> The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrent=
ly
> mutable memory such as a BPF map value.
>
> So, the memory of hdr pointer can be updated after skb_postpush_rcsum().
>
> To fix it, memcpy() the hdr to a local buffer, which will be used for the
> following checks and updates.
>
> [1] https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.o=
rg/
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..8009e427851f 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
>
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +       u8 buff[LWT_BPF_MAX_HEADROOM];

extra 256 bytes of stack to partially close a hypothetical issue
is not worth it.
Ignore such AI complaints.
Not every "bug" needs a fix.
If a malicious bpf user wants to crash the kernel they will
find a way to do so. Especially with agents.
We cannot realistically close all of the holes.
Right now the priority is to fix the issues that normal
users can hit and not bots.

pw-bot: cr

