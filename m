Return-Path: <netdev+bounces-57035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33531811AF9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58571F2194D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0353F5646E;
	Wed, 13 Dec 2023 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HynhJwHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F6C9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:30:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso65515e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488610; x=1703093410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud4nfOobXZQvDq47QlxkiSF46Ucu7QIDNnbdFw5sapM=;
        b=HynhJwHSedBuF8ohYWGoQfi3QN5WbvgTl/3lM/Oez02EsJMhMSJu5aEzlnpUlYcorI
         pKkKYH1O7iYJ0SFfqnXd+Czo2YZUpX5wmyBpClzlqQH2ZfXFApT6SVU4NZW4By7HRl/8
         RXah/m48FIwtQNqev+LRo3VHV7Z2W+Xvg1curq8NeSFWgZjON5mmi6eTSr/a/a67Tpv8
         AZxkZHJH1ADmfDDiZHGh7n31847bvv68VjtVLGPcgxoG2kI3oXJZOFTJkucs5PLXnE6y
         bxhsILQ42Vl2YbIBQvbx5hJGjBqP057X0hBQk75XHkQHswK8n4gXqDoCuTKExwMJ5hah
         W55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488610; x=1703093410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud4nfOobXZQvDq47QlxkiSF46Ucu7QIDNnbdFw5sapM=;
        b=IZuv8U9d94FU1I9mWP3ioBAfSwAyqrU6ofgIJQ3knqjq0geL/D0UNKl7h4PsoxzZN4
         urOmVZbW7OwEPHOIJgAmpu1rnEKir+O1rNNb44c9r5o3uAaJ8KqIk3XPD4HlVtE0oBYI
         CqxNCvKZT1ig+0q9rQGEcbK3RQxFJNlrVUrU7RuxNz1ikMfmZGLXxgGP+GxWoPNwGGub
         3pjJOhfvjqCIbncEjX8qdFlMFdniiBSHQB8rByZ7RSj0eKN2sezIPWorUjmXYgCxUAje
         UAZpEetJweYO5s6h6j1u/4fnfy18ZM8pBeCzooWHFP3MSU/MlJWU/ojPSBl1isL0v8tM
         g47A==
X-Gm-Message-State: AOJu0YzJc6Ia9M2WPMdS0/WEGbwJMk6JH09QJOwqowsTBi5iHAC6v22c
	qWUuXdsSiKe8sU+BCcXKPw0P1WZ9j3uqrAO77nkqqg==
X-Google-Smtp-Source: AGHT+IG9guwwbMFRZh+JcqWp4zaV6jr+y0X2j7kIdpSJ8AxErouj3DwAjjtQejUU+PK+Sobh7hLJJt+RzSrjcYeDMOc=
X-Received: by 2002:a05:600c:600a:b0:40a:483f:f828 with SMTP id
 az10-20020a05600c600a00b0040a483ff828mr436112wmb.4.1702488610300; Wed, 13 Dec
 2023 09:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213165741.93528-1-jhs@mojatatu.com>
In-Reply-To: <20231213165741.93528-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 18:29:55 +0100
Message-ID: <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
To: Jamal Hadi Salim <jhs@mojatatu.com>, Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, pctammela@mojatatu.com, 
	victor@mojatatu.com, Coverity Scan <scan-admin@coverity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> It is possible to compute a band of 3. Doing so will overrun array
> q->band_pkt_count[0-2] boundaries.
>
> Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
> Reported-by: Coverity Scan <scan-admin@coverity.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 3a31c47fea9b..217c430343df 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -159,7 +159,7 @@ struct fq_sched_data {
>  /* return the i-th 2-bit value ("crumb") */
>  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
>  {
> -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> +       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) % 0x3;
>  }
>

Are you sure this is needed ?

fq_load_priomap() makes sure this can not happen...

