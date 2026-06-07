Return-Path: <netdev+bounces-296169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VzFUAZW7JGox+wEAu9opvQ
	(envelope-from <netdev+bounces-296169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:30:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E713664E9A5
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:30:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j6O7qCmx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296169-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C66743004C88
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDB71A682B;
	Sun,  7 Jun 2026 00:30:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B231EDA32
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 00:30:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792207; cv=pass; b=ZEGHUjvgRZtOjOdFYREpVW5gfjXBCgLWuWClLdlLMekyyH1wGJZWNZGW4h4xloUzUIUlHqHZaVUQKqa2n0VuLFkybBFJsllJS3b5oBBfFC/Ds7nHONKU7ol9xcVDyrt6+cCja6KKV6yjA2AHyjqeG08TdOM2GgfOwMXt8kPW9do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792207; c=relaxed/simple;
	bh=bvm8XR80mK0+tJ7bOaj+iLMt1hixXvlRE+ID0KlE5F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8TBfkFcrqey8HJWOGrZ4EwtJOj237ZXszTiKOX7ahhU0bjKsuZYP59oxWXaeY9+8SarzsKR0tjXAjp1XrHcjXkmDVa0QQrjWMjoCTQXrbnhWhOf9txLW2rwPrDUW7zDUltYxFhDpPBj0Fq8G23rB0t8oRfGotfp5ehU50Wo2+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6O7qCmx; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f236418so1677026b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 17:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780792205; cv=none;
        d=google.com; s=arc-20240605;
        b=E30xx60k54DOFKSKu5ROs/xj2mQT1TPeyPp7oOCY2h4cyFlgKv5OYBla3xAd+jKBcJ
         lymL06H4YgdFcpgzcoMrWHYmshl4Rpl5Ccqi4iW9V2/rR46Db/rEg71X6lU5WrrfSGg0
         FqlvTy2caBvEe7yxjBD0lpNr+SEYKx4zmr6tVFnQKdvx2emcDGc5f7eyI9mb4q/PMIBn
         SHHxnCtuHEwZcigl1mUaKlwhnxt23lNcG3DqOYmWWFAcPlEpYka94LfnyL80D3V+B6lX
         wkkWgMYD1VMd6uwmpX2F7sQ72pAMrdTSfOOByy3m6jcxbnvGuZ7aRXbvkrFfZFh5VLIs
         /fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        fh=Z3gyTDLV792Xt6m5bDENW/IpwE4hTU4t1Xuz3YneztQ=;
        b=Q05DaqbIVaFrZI4NvpsSdf9P3Mjg5zHSeRpr9/nRcApOkasQdBknxF3iECOxg8P72H
         VTuZ6fdphEzBy3Cc77AUxUIUH8U7iz9CyzrcdOSqCTO9sogrstHwQSPPL15ETjfrWFmX
         lENRMS25LaBknfjxxYFpwrv+xSVwRdkfFM4fIDmPUIx5uzIoEm5SE6R3KzNRtGW5AVrt
         P4Pf8U/lQYqWXPOiFtJ2t91w+MkvDzSDaABv/jM2ESzZxALzgyg7O/2538GDONVZNbnX
         ANqT1wUfkyLFk2zJVZ2jQ1FCFS9EahSZnARUG375ZNRvXrPf56U5vPmp+vP1ui1gX6Rk
         NFdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780792205; x=1781397005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        b=j6O7qCmxHmH6zzs5K+Ps8rcC8Di7+YT41Qff8Lzhx8ErpXDz4Ug+EGVEWVqjmh2ZjL
         A6rO4CJi/O+5NKXtLs4gqaVpoSAKnj/+HFdL1ElI3JSq9DXYCtXzU3wNTgNN5yWyoknn
         aN5hsEgA/NK6t5aRjKtnKFKTah00YVsraSAI6c5AyqvBySoZSfGhi28r26X6H8uP9xaF
         YlcdifjqLhDQAAiul7I1qSR6bZfJG3i1o46v1v5OYk3XvViEdu6jukoXI50tImUoXbNs
         xrMYM+flEq1uINcgrPZAvHKIKOfZeUnqrdu8+PUE3QwqNjpBsr9anNHoogMNgQeRqpMY
         NVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792205; x=1781397005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        b=ezNywg+UxeBwhLBTZR8/LHusfjR+0vOo1NK4rF3IjAUH0eFuuQ55PA6SHtld+njVZV
         Lh82okbtir46dHqGhPrW/Ryho7YYRnElkpSBN8mJTDjaQiakeD7w0aciQmYte0zv6mDH
         +p1fndwcU7pbECJM+DDKzyAXrYv5oCUloICsAs8kyOQKlkat87Wd7KNrIjAvOFlcXMQd
         VAmK2NUyBlatdMAg7xsjOvF58cgV20FSWwOSBRvi++FF+2goYIU1iatB4gmaCjGTZQB3
         5CJrkeplGD76Kv6BSJQwgeAwHqFhxCN21nFDk4pcWHPKuObcHRkg2zJpGkuUP2IV0LcO
         rR/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ga0olegRu+zRC96dojn7zqxdAbrwkuBaPB+vK1l5I1gHkOBn3kV5NH587DjfLkjoEHcsftyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q+sttFpFf/AfwHwFZFmktx9sPIE7S8/kC/UXxTyqVvX8CnGX
	YxsW/V5nBhHSELLcNeVqpjsd1FVRVmV1hlHUkGpRR98dtXR3TEDaWNic7OogRsd7zFfgev9oTW6
	DZAccQwVK23zxQnYKY0d8FoCAS2Ipu+0=
X-Gm-Gg: Acq92OE3NTILAZfLCnKyqbjgfHOqxmUvO6mbtQhx2Rovu8yndc4KJtFuhChBXIku53Z
	OibpbEOvga+VOauHzaU02TCadVKdtTcCgWltFpSI0sBr8RxWY/Kk01Tx+7ki1t1/uXOhNjKLfKX
	CYjEWhJOWksKvK1ahUSWz/fT3btGWjKrPPnXDgiYXxuj8TeXqJJj7PN3iK22/8N4BBlZC9AZNur
	55eMcOsrPvutOAkEtSBq6eTrzNOIg4RbObuNWiHGp/kSahB3UPnvl2RpBmRjEstCReUUE3N8tpx
	aoK6VtqXxDVmx8GqS2HyH5kxM6WE8Dll/gHQnWJMG9AsMmRzbpo9E/Zk1crxBwYL5LmlnMkNwDq
	m0HATCXHf7SdMQqd6Ew==
X-Received: by 2002:a05:6a00:2441:b0:842:57e8:1bdc with SMTP id
 d2e1a72fcca58-842b0e718b4mr9040468b3a.18.1780792205031; Sat, 06 Jun 2026
 17:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d78954ecd94954653ee299400e98d74a03a6f7d3.1780603399.git.bronzed_45_vested@icloud.com>
In-Reply-To: <d78954ecd94954653ee299400e98d74a03a6f7d3.1780603399.git.bronzed_45_vested@icloud.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 6 Jun 2026 20:29:53 -0400
X-Gm-Features: AVVi8Cff1SYXJTyct_UzvU-aEB56DUj-CEcggirsskGphb4yopP6wOJDomNiapg
Message-ID: <CADvbK_cw+w+NSS+=7wJwEd5Z2ziBesVgc4nz4PepPDy1hjNZew@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] sctp: stream: fully roll back denied
 add-stream state
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296169-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,icloud.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E713664E9A5

On Fri, Jun 5, 2026 at 1:54=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> When ADD_OUT_STREAMS is denied, SCTP only shrinks the queued chunks and
> then lowers outcnt. That leaves removed stream metadata behind, so a
> later re-add can reuse a stale ext and hit a null-pointer dereference in
> the scheduler get path.
>
> Fix the rollback by tearing down the removed stream state the same way
> other stream resizes do. Unschedule the current scheduler state, drop
> the removed stream ext state with sctp_stream_outq_migrate(), and then
> reschedule the remaining streams.
>
> This keeps scheduler-private RR/FC/PRIO lists consistent while fully
> rolling back denied outgoing stream additions.
>
> Fixes: 637784ade221 ("sctp: introduce priority based stream scheduler")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
>   - Moved the `sched` declaration below `addstrm` and dropped the
>     `out_curr` handling. The rollback fix now only unschedules the
>         current scheduler state, migrates/drops the removed stream ext
>         state, and reschedules the remaining streams.
>   - v1 Link: https://lore.kernel.org/all/345886be48a66f70bad26ddcea6defb3=
8d1d0f72.1780439824.git.bronzed_45_vested@icloud.com/
>
>
>  net/sctp/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..5c2fdedea088 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -1038,6 +1038,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         stsn, rtsn, GFP_ATOMIC);
>         } else if (req->type =3D=3D SCTP_PARAM_RESET_ADD_OUT_STREAMS) {
>                 struct sctp_strreset_addstrm *addstrm;
> +               const struct sctp_sched_ops *sched;
>                 __u16 number;
>
>                 addstrm =3D (struct sctp_strreset_addstrm *)req;
> @@ -1048,7 +1049,10 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         for (i =3D number; i < stream->outcnt; i++)
>                                 SCTP_SO(stream, i)->state =3D SCTP_STREAM=
_OPEN;
>                 } else {
> -                       sctp_stream_shrink_out(stream, number);
> +                       sched =3D sctp_sched_ops_from_stream(stream);
> +                       sched->unsched_all(stream);
> +                       sctp_stream_outq_migrate(stream, NULL, number);
> +                       sched->sched_all(stream);
>                         stream->outcnt =3D number;
>                 }
>
> --
> 2.43.7
>
Acked-by: Xin Long <lucien.xin@gmail.com>

