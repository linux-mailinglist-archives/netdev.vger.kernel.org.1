Return-Path: <netdev+bounces-266905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGp9KapCsmlFKgAAu9opvQ
	(envelope-from <netdev+bounces-266905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:35:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12F26D23A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C1C3074F21
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937837FF75;
	Thu, 12 Mar 2026 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPnI7niO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6B38C2AF
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290115; cv=pass; b=cOiZwIbPEUI6ptxaW88eJSWBzsTLQJG6b5liWmfkoq3DpZ2a/b2aGvMLd1PzGwsgFnwz7dtGF8bDD2Zzlmtu3fKJ9b3W7q0IZoR6zlF/XPAyI/084gO8dt8wZYHyVcCS8DJgFndQ7rhONrAzHetUMFnC82ra/fIihUtcdbocSsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290115; c=relaxed/simple;
	bh=WGYrCyYt2kAAqLlt+MfZ2Of3vO50hCdd2Y65131itdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeRodlwvdB5ZjnPRVQso/4bP8x0FRD3+/lpeYFucF+KEr9eI9COVqWBbiOgAOel5XFhdTjKz/AYbZ/etSdFDBWxbjy9ycaoEeLOzxnPli5caIawOBsBgp1SG3FItJ0Hy/rnb9ohQCo9IDOrRM5WNkQ/vtV9eqdm4JhXaSygg1ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPnI7niO; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso937946a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773290112; cv=none;
        d=google.com; s=arc-20240605;
        b=W9Qd+oDd223bI1NCWyn8R3lne3BL5wAnbprLSOMFBF1w2Hpvm1ihkbQxWtFfsDMAYT
         yIMVnD8FHwl/uBtHSvRg0NGCTSiz1KpUeUBkSWnHsyOJNe1f4sCwWs2AYSNrqMDCsIzV
         FtLBzK28nUyAmFajT63iBveMumaXhcoRCFz1bH/zcv+BXnnB86ooTD/UvX9xm1K6QJa6
         B4BpxO8poBVHXsD+coGhchbXiaoP+ph/Aa0VYYC/SflJMYaKzM1/ysczEtc79/fTS/2R
         gKArN0x6rQVM99bmspRrTd4WzOWnUMqa+pGXsCmqem9qgJ/vRs2vVVkw7Gbizc4ZCqLQ
         xqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNiTJvZ07+N6hJrE5XfRHdYlY1eJkpb+vUa8NDqe8Sg=;
        fh=Y4wHkS55rHDIGjmSbh441PRz8T+Lvuxl05Ccc+bbo/Q=;
        b=hKcUlPapD18H4TTBMwZJQ6VqzKraaRKbfwUf47h70tqZkEeaEOc/ZyQLyIHMf7wrSp
         2zl2j5oT4jO3hesuPEjhksyzUBOeFPADVDBnX7h0AOtwQH3lUuNmUxxD7ZEIdAjuEAPX
         fJn7isWEU+lbrrmhgjbWqCM95HKfC32TrWthwWLXi5JDrPr+tki4fdRoCFsOZ8Z33J8C
         gVQoXC4mdAq/kT4oyyxnr7bUv8mMIRqXp+qIPcLemrAJb7LU8qEiMr85+g22ck5XDNaZ
         tAolKvfs919jejJLdwepJMuTFhyCi8456Y2dl/6GKlDEKsNg1skyf48mjLBnDV74Xf3r
         G2Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773290112; x=1773894912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNiTJvZ07+N6hJrE5XfRHdYlY1eJkpb+vUa8NDqe8Sg=;
        b=HPnI7niOXK9oYYsv7B7JezffEecT1GSWxhmD1Re2Q0SL9o+sKmrimTilsLcx86lw99
         5N0UwGC1KMEgtVvQ35Db9GWnpdhnJfn4+7K/XaXhO++AgAY4Z/wCmXmfI+pbVFTXr11V
         dZ2ip2iDoIlkMKF5k76zS1693u/uXR5i+aPt+s98txE03RZqUixcyLHzcxT3D6qWMVX7
         dVAfYPQ7PiWbiBhzM8PgZWTzVxaTW3a42NV8MhYtcYnz8XwomyoZSu8y6GM8Z/W1wHkG
         nFgY1L+8Re278l/D9s5W19OoaISY20CRWnN36zlvi2zrimE31oPitFiAMpoH8B2bsrTr
         jVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773290112; x=1773894912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNiTJvZ07+N6hJrE5XfRHdYlY1eJkpb+vUa8NDqe8Sg=;
        b=sYwN6+LeJgnDmALbNYXaSi0lTXodaqxZFtgTa5ilVXy7oDCig7gOwSCCqMQnwyhVwM
         ikuHFV/oWryH8c0GEIE8fxk45LcGVQqW6f6VH26s4gzdAiqr0ETFWKNUvyEpFHVB6K6K
         6a8fB/Xwn7Q4mgrBCvwshnVYK3lNoDYBlYgKXxd371rnnNJYw80d7BGx7+njmppZp+Lw
         FPKZSvlVR0eJ8gRKrhbfEi0NVjbtSvzEqPa/bP7HtLCrZWeCvcdSfKAzWNjNLS8F7rQc
         8sStbImjh7V/c2PAcBH35e8dul4BgMQHo+SGz70wJAcKBzW4nf5spG1JfrTg8yUs8IUC
         nvlg==
X-Forwarded-Encrypted: i=1; AJvYcCVKGmlHM04+l9cJnlW44kFid1O02jHjH7mDTpjCjy0F0dRZwshLauXwuYhNx8Dq/Ss5Ag9o8ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6RJTT1kwysA6R2CxPWX4mZ2a7swwoernNo76v6YyN1gOg0P5
	SMVMZ/HswhCjF0WDIlbt+/L4IK1wG2kWP6EjjWbCqk1ASHXdChgLlKJGQZTiHJBxJb2rM56e1Ue
	RYfsWpitL1y+gNZWfA9hfi0ht8YkzyYE=
X-Gm-Gg: ATEYQzzFMJtxMwykmBGupKgYrzbRbWRJnNgIutz64fSbfhQOk90a3xnNOM4fG/yrFvd
	P+6LtIA69xMFL+iRnjRgFV0quSJUCQrdr/7ngHz1UQ1x2Dic+A6oHuMxutpfp5Rmro7q30QrUf+
	7cooXkxsfoIuVL/l/bcswTVhF6scfiTAhfW1IGySnznKyKaJkFgTMfINfSZuKg7cNifMLxYrRF7
	oTx9kNYOB5xLi+cv9trIv7PwBd19gY2ljHfwu/DBr0dUF4QGCMhQiSiMirxUnsUvRgoE4NnpoG5
	myOzODsOeiT09zOX/QQGUs8oeKfyCxR6X96NAw==
X-Received: by 2002:a17:907:3fa1:b0:b96:d904:9616 with SMTP id
 a640c23a62f3a-b972e52c1e9mr274840666b.40.1773290111766; Wed, 11 Mar 2026
 21:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312014804.5083-1-cel@kernel.org> <20260312014804.5083-2-cel@kernel.org>
In-Reply-To: <20260312014804.5083-2-cel@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 14:34:45 +1000
X-Gm-Features: AaiRm50W2K1LrJ8G3PLJFkDBJsXtQZEZ0hLSfrLqWSA0X9QvKQc3Oh3vWepX1P0
Message-ID: <CAKmqyKPkCLUMtdu=Jk6FxE7a1AP6zRDhESvUGMGuL5tNBe7pEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] tls: Factor tls_decrypt_async_drain() from recvmsg
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net, 
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,suse.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0F12F26D23A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:48=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> The recvmsg path pairs tls_decrypt_async_wait() with
> __skb_queue_purge(&ctx->async_hold). Bundling the two into
> tls_decrypt_async_drain() gives later patches a single call for
> async teardown.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  net/tls/tls_sw.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index a656ce235758..cedcc82669db 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -249,6 +249,18 @@ static int tls_decrypt_async_wait(struct tls_sw_cont=
ext_rx *ctx)
>         return ctx->async_wait.err;
>  }
>
> +/* Collect all pending async AEAD completions and release the
> + * skbs held for them.  Returns the crypto error if any
> + * operation failed, zero otherwise.
> + */
> +static int tls_decrypt_async_drain(struct tls_sw_context_rx *ctx)
> +{
> +       int ret =3D tls_decrypt_async_wait(ctx);
> +
> +       __skb_queue_purge(&ctx->async_hold);
> +       return ret;
> +}
> +
>  static int tls_do_decryption(struct sock *sk,
>                              struct scatterlist *sgin,
>                              struct scatterlist *sgout,
> @@ -2223,8 +2235,7 @@ int tls_sw_recvmsg(struct sock *sk,
>                 int ret;
>
>                 /* Wait for all previously submitted records to be decryp=
ted */
> -               ret =3D tls_decrypt_async_wait(ctx);
> -               __skb_queue_purge(&ctx->async_hold);
> +               ret =3D tls_decrypt_async_drain(ctx);
>
>                 if (ret) {
>                         if (err >=3D 0 || err =3D=3D -EINPROGRESS)
> --
> 2.52.0
>
>

