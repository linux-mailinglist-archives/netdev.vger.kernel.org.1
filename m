Return-Path: <netdev+bounces-292463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MyJOClpF2rcEAgAu9opvQ
	(envelope-from <netdev+bounces-292463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:59:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE55EA803
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C7A33042357
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565738CFE5;
	Wed, 27 May 2026 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNDBSWsV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B883644A1
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919141; cv=pass; b=lUIPPeXuwJQbe+ncrhDkx607mpmmVId+bPNgmHSNPFDNVXmvKFZpjnU1JZsQCLqy7RKlQWeqn/JuZ6rtkuA+ZO/n6qUB0PTSGCj26ASlYCTf313T5f5GdySJbLSRBReV+xadqBVY9xVDk81dUxHz8kU9lKidSrflpnPqwmRr1bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919141; c=relaxed/simple;
	bh=jC31wbituFYGZEW8Zzrrqo2ywlxmr0q5hdPoo2cZcHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT4q+1RBSLUxax0tGXT/XclU70CdYPqT8xTABu/QmjtdHg9Ej8sZIXI+TcFJNKvj4LvslxesP4mbRDdtCljdr7dDwX7VLVgW04H1l6SLRo5OAoAGAiDvmv2vBqjmy1Q3SjtMIDnC14I60cS5YIqtN4k8j1RrLdZ0t54CuXAcslU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNDBSWsV; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so8806956a12.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779919139; cv=none;
        d=google.com; s=arc-20240605;
        b=gW2N6bPUaMSRDt2XD5XBJ+P65ogj6zycbGRdjE+JwSmeZPFFJGnyxaTpU1ixaROYwB
         9QRd3hfoyfvQqcfCPjZRhOEWan2AtUsxNU3OM6GmEUdFpVZFfDLMiMEVYoqyopVrbNW8
         HtSQuYITDHm3aMHhY0VQr/o3GtXXcOrfv+kifhTJB9yomk3W6DqqjheuEpARRCcmfACm
         h5uMJcMw98l/KYcae82hCXlLPged1YAvlwpHeeVnQ44ZVa0SVLUqQrOCr7itiGmFIH51
         B5DiUjCSUjXS4YnrBzlKQ9euWiNYs6G8eL2b9LOzOHxH8Y+UApuU8JYFM3ujx7EjcuoH
         4Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        fh=HJuL/PX4jx9hFj7Eu68shWFFsj/ZbGrfiBhbdYohS3o=;
        b=ElFkBrkL69ANCOjcb9SQ3yoR1lmvaCN1KDHqnDwcrBpT8ng9n2YyvjO8VKcx5JSJ/d
         CRKFOYomdQqQz2HjdBrLqSso7WZhPz8dt6a+bVpouHWwMJpuKpMd0T/3lXnxkf3UKeKt
         y0n/bFsDAdvNMi76+lOOO5yTpLJSkg3bXX2JHalyyBpTvioQDdYcqbfqNLJ7ZEQJ+Ju9
         YzmWfGgc6wzBTHe52vFed8WMzQbKEs2XZWPDsqt/fPtAIZUzAbYnoD8ZUtm6TeEV3qaH
         NGstF/VyNTDm5Y03VpXg0DXnXfb+pH+wPIiT/h+knnDgfYLnJTDla2lwEQLrQ5+QjXFb
         OrDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779919139; x=1780523939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        b=sNDBSWsV8GzXAn3KeLEUgipEe64GCWCsUMNNHq6pF72T+0xosd2JNzswMogNBQ2Ygn
         kGNqU+WVNNJQrmhTvN+WTLnCq9hXoQ1Zd6ypwpOi3PKInJYSVFNYHJMC2LdTYyz4GPb7
         A+iz1T8oBj9IxaCpIqdrIwYWHRveADKQRLCr0TKrwBFyWAjfPifpnm1SlNVtMeEgZBxV
         JQrv6AI3JQmhpBWIlbQPKn8FO4b75g/zIRk0yvaXLezy6peHWpUuLoLbOBTYprb7TsKF
         QN7ocy6kAAlpALQ5UVAY0HCHYPhI8rYZs4aH/c2L70K8NakNm3C+IxC0LWMRa2IbH2By
         bSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779919139; x=1780523939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        b=FsB+0lXiU4Ix0KWq0jkFgngS3K8PaGQHUJpYbLSNbq1B4kkyZxhAHPE0TO0lHNKb0E
         u34rpinEhEB6sMn2VoJjY7gT3oCBRkh/QO3aCPDFFNkECxK4lvjNDvbxFn9dSenX/W2l
         PsXnFnEsQ4FWlWS+jC647zh77B9CEpXN1aXXOaTBq7v/uZqpdjKeBLFZszzbED0VToLQ
         ogUxFYfvhKtSZ48s1X21IZQmYfa7uJf2RW4e4PpR5HZWygE0XDyLT+T5SuIa3bCwlP1R
         NN+AEOfXcQbtLnh5YeHtLz/C+l2+k5BfQc7f8rw92UzrYyA1RvL5/70VJ3LyybIDp8WB
         fTEA==
X-Forwarded-Encrypted: i=1; AFNElJ+J6tuTcPvx232Dl3TEkfg3fClmmmZaBblWsZYBdz9C6ysGWFUy79sYtIs1xhoSGZtKRCdNBt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylALRMn9qXQdX3sxjwPgOpXLtVhwBhq8boQ2PRitRfPGufmjir
	mShZan9pIuyeSserNIw6SpflT1Q0XyZA4wSUmswUYf2hfhl4qL8+6vFfr5ABqxxGhv/wnbjkkXi
	xc3m+wrQ7sfjBNIdIpOrhHeVfqDQYJDA=
X-Gm-Gg: Acq92OH3G4PNc/g1Wc57WWsalvKIuH5BkUrj+L8IRGV1mrv/9W2tQcViJklJlMM2MjL
	1BtrEbXTTcNuQVMulfz0YkfS5JlNoCbzGINdrrK82GAHmG0QzUHUM9xXjrQqJo+j4MwyczOpvZE
	hyrpGC0pZLXAk+tlOimLvu+PSUTwiYgs5f57erqiS43HThFZ758Fu+D9RPjyAqIZi/HGccSN8ck
	WEgTL8FKlzURzqE+WqvDSt+0wxxO3FIAFALmZYitfIC6hAbdAkvGahJy5bz2zAZ7R9a8fA9u+0d
	CR1eD9g4nWMJOCGvD63PM5YnhR1M6U1yctpsmpnbK2dEH5QoAWg/UcIaprJd0XXlJNarW4paALi
	BukMLYJ/JBdymzWwRpFVBsH0IUY2Wvh/r/hU74okElcLdWrQ/Uw==
X-Received: by 2002:a05:6a20:734c:b0:3b3:1951:48b7 with SMTP id
 adf61e73a8af0-3b328fdb6f0mr25812094637.50.1779919139431; Wed, 27 May 2026
 14:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779632544.git.xuyq21@lenovo.com> <4d56a975d40611822b2bd44f2f215e3534d76276.1779632544.git.xuyq21@lenovo.com>
In-Reply-To: <4d56a975d40611822b2bd44f2f215e3534d76276.1779632544.git.xuyq21@lenovo.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 27 May 2026 17:58:47 -0400
X-Gm-Features: AVHnY4Jdb7aP58sGcuX0n-QoBVJ_RUDZxn4MGj_N74DwHqdhDrKlIcv5hqVog2o
Message-ID: <CADvbK_dygG8qCDtG_LbsQ0=2PP4muNq2X7TNRqTiUMAoFjg5pA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sctp: clear current outbound stream on
 stream teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lenovo.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 87EE55EA803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:43=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yuqi Xu <xuyq21@lenovo.com>
>
> out_curr caches the outbound stream selected for continuing a
> fragmented message. That pointer refers directly to an entry in the
> stream->out table.
>
> When the stream table is torn down, such as during stream updates for
> association restart handling, the old outbound stream entries are freed
> before a new table is installed. Clear out_curr as part of
> sctp_stream_free() so later dequeue paths never keep following a stale
> stream pointer after the teardown.
>
> This keeps the lifetime rule local to the stream teardown helper and
> covers every current caller that frees the outbound stream table.
>
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..207e0a77f9af 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -186,6 +186,7 @@ void sctp_stream_free(struct sctp_stream *stream)
>         int i;
>
>         sched->unsched_all(stream);
> +       stream->out_curr =3D NULL;
>         for (i =3D 0; i < stream->outcnt; i++)
>                 sctp_stream_free_ext(stream, i);
>         genradix_free(&stream->out);

As commented on another patch, purging outqueue will also clear
stream->out_curr for the corner case via:

sctp_outq_teardown() -> sctp_sched_dequeue_done(last_chunk).

so there's no need to do it here.

Thanks.

