Return-Path: <netdev+bounces-283770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HXfOfxu+GnkugIAu9opvQ
	(envelope-from <netdev+bounces-283770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744894BB64D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C83F3015A4D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17C38E119;
	Mon,  4 May 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WM9h21GD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2938D011
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889007; cv=pass; b=iZGr0qBjukXOVOQv3lqy3TNSs8wHGWGbIZ/0tOj9cOXrR67DU+wJeGn2uqDHz6/F8AZDQwaTjkdrjUWEgQMUvNf0qltCA1nP35VM/A7Z9vN9y2+4WW9+Zo0X4BvYSAVwyzcX3WBh/JNxyTVM7yfAQMh/EtkQXKXZBzflZpWLi/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889007; c=relaxed/simple;
	bh=fTRrJjV34qZQDRuG23Tk+EmuUUwK8IsUO01i7mfimyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGAs/mu3VSeI2XfRROnJJnO9H8/qzde1E6kuuZqgbTfDr7Vj6oX46H+7W4ohQupG5xMbR0fIX9yPu8HQlIJ1ihDBACZi7kuPjisSC33J9HjL7v9j7OrCwkVEgcQ/THRLyiahLE+djh//TVdSQ0fY4bzn/8KVAw7Zwopcts/saX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WM9h21GD; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e614fdb42so34693591cf.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777889005; cv=none;
        d=google.com; s=arc-20240605;
        b=B7sf9xbfjDAxpije93Zt5FmOJVfSahqreBqt6zwMxivSw5EPDe21+IDVLqzP2cJndi
         LKHCm5mYp543eNKNmZYR/w+On37jwPAfxMhCVJ4f+uM1GMq9eXxXrfTGd02iu0NQjU0H
         GgZRWNcLv6hJ2KRdoxDsFCeW2x5A/I9+SuG4v6efbPZxE4azn3z82qyd+GFfRdMnG+45
         NjOCWfd/WvvoyUeLqMMxTdJrMj7ZTfu4TPodXiFLlHdg+YEHHwvvXBWSoS2CYUUc8DSZ
         g3ghQrQrM88td0jAUWpYWyzG5WLP3zdK2UMkIcabyEckIlrFafcn7j04dQIRgMy6Qb2r
         9JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SevCSvA/vlH8QdRGoRkpvzPTZ9TtM+vve4oLpHVSjLM=;
        fh=648PHnvz/AxizxqIRMmsSLmM873pHQ9JVuofgK2nylQ=;
        b=ZenKtbxHJHoZZEeA3zswHfZJ6+1XgcXdeThLMhEmV3AxNCTqSs8aqzr3bn7mvsJYBZ
         pKrLLBdFh0PKwGiFz35X5elAqnxQsVAtd3a40dAXxU2hDofOgKGQ5SLaz1LdH9D09tNC
         TyyvwG6Ds6H4/fgsdkur/aJwThVR6CE6Xv4IWHggGkSPFJ8z0BTNwGcdnuwVA/RbfN3B
         uwiUU2aSyKFMVuDVZSW3fDl/phXhs+mWfkvdpawnAG4Yd03ee5wPUNN2AqZ3kGJXzot8
         qEbJ2/sMWcDIaLPh7Q+zNOSOMmxYXgk94/EV9EyYqUbQNcde7ZHdLCrqXzJH7+VQbUwX
         XyFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777889005; x=1778493805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SevCSvA/vlH8QdRGoRkpvzPTZ9TtM+vve4oLpHVSjLM=;
        b=WM9h21GDtsZlmdku6+niHJn0TJGcK96fZDErIbd7ha1HKnJsLkX5mLpcGmIs9TafsH
         H9qEQ3RREpNorJ+UaH3ZUT9s5ruSvkxZf+3YOz4Sr3U+/3kEA08/Xdx4p3tDD8liG4ZZ
         xKMt6vKsrbsfD756RLogbZvoO2cglr/5CS8SDWsG2GNtscTUEscIw0y5y4yaZUPX50YS
         D26Bf2OcEr8OwhAq2ptP6iiHoFE17UnYolpf39upBHDnw7pLO/J+oeF0kIsVORZP8rOm
         nz0FHpWuoad0A6E8oBsnR59T1s73nrgGTCKSJzMMrvtJ8cHrr5L97uBHDTXKwlOvpEua
         kvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889005; x=1778493805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SevCSvA/vlH8QdRGoRkpvzPTZ9TtM+vve4oLpHVSjLM=;
        b=MWwwHSzu6CnEQh/HJg7o8vGQi34iSV35pnfO2FBklk7NG+mD7y00ZSudn19wWDahcl
         IHLdbLfuHO1v/XbsuVJJgJGgi+pbLxTHWL3mv0EZUBJs9FhTI3Bfq5yi+rMF5krlph5K
         ScNZZLPW3Mr+AVX4WtyiwpL8CGGkU7pGH8pkWH4q2FIdD1TN77UxEO25Cp2/vNyJo34T
         gniy8zTEiULrhnXmS1noWNXhfsD0NEqfoHs4Fqnf6n7I7RI9JhiVcIfl8bmbPABDvu0G
         QwFyLd8eUf/f0sHp9fmrI49MfDwW7TGFuzg5txISNaVRc4NQXERPljQ/8FT4y5W2uzbG
         B+dA==
X-Forwarded-Encrypted: i=1; AFNElJ8m4RSNlrnVxUZhQiDK6bs7akIZKDR5TcU63Tn5VsUygrkrjZF3Vqs+fg2WIdFb6uMwW3eRnK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/NhPWpx6YvCoXAHz07zQnn6Owhbp/BH1+YUJ9N3ZCZgclS7o
	hOGsoQgmdWrM7jJjK8CDa2/Zjrn4iMVKFfTx3bG0hQF7WjrIFlD5MXdO/24MiQ5gqc8R5SY5kxl
	dGHuG/6wQn6Y133ytvrhIISV+DcohUGO3MTxZOn4h
X-Gm-Gg: AeBDietjk/U6cWoIcVVcfknFJRKWg+hxBqDvpGMPpz8HrlOe9GGoYyw9b/kqdgd0Fen
	iAM/VW9t/wlUqmZD1QTiWjpJEO/ahNH8j2Y5550d98eT7Up3++OYLYTQ7vXQdAHvCXTpNyQ9JbG
	WpC75SrQA3YIylNfiWJC+EmieL99laqX9a69F+F88GYcVeuP/iH0MDdSqL8D3gHv+q8KRAvCIiL
	L6e9BMr2AK4sLTlisLkXK3YzEvapZmacmwEOgRRxhSADDippF3t3fntAUy80WGxDJXPHG/uEgjn
	UgxzqzH+EgyV1c4iQQmZUT1PZndVdLfgmMjj1g82ZBTTpAZ/bhhILQDPV35zV1qvXTqSk2Koev9
	W9JEYo+2HNwYej+DJukVjTCtx4wM8nMUMqkPRCL8=
X-Received: by 2002:a05:622a:a15:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-5104bde3d4dmr130942281cf.7.1777889004551; Mon, 04 May 2026
 03:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504055558.3470994-1-edumazet@google.com>
In-Reply-To: <20260504055558.3470994-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 03:03:13 -0700
X-Gm-Features: AVHnY4LLGg9Mgp5MqokeasqCI8yCsCOsgDWT6veVjvte6tFpkrO_6ZSTzVNYu8k
Message-ID: <CANn89iKgiGV=y8Q_x6Eb5Yym_6yXwBQgodLj0e5veUOHf7Cxtw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_sfq: annotate data-races from sfq_dump_class_stats()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 744894BB64D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283770-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, May 3, 2026 at 10:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> sfq_dump_class_stats() runs locklessly, add needed READ_ONCE()
> and WRITE_ONCE() annotations.
>
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/=
class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_sfq.c | 48 +++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index c3f3181dba5424eb9d26362a1628653bb9392e89..bf55e3d71ef4da24eaa5a7344=
4c14d809268ef54 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -225,7 +225,8 @@ static inline void sfq_dec(struct sfq_sched_data *q, =
sfq_index x)
>
>         sfq_unlink(q, x, n, p);
>
> -       d =3D q->slots[x].qlen--;
> +       d =3D q->slots[x].qlen - 1;
> +       WRITE_ONCE(q->slots[x].qlen, d);
>         if (n =3D=3D p && q->cur_depth =3D=3D d)

Oh well, silly bug. I will fix in V2

This should have been:

-       d =3D q->slots[x].qlen--;
+       d =3D q->slots[x].qlen;
+       WRITE_ONCE(q->slots[x].qlen, d - 1);

