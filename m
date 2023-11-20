Return-Path: <netdev+bounces-49413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC17F1F4A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098D4281B3D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46238F87;
	Mon, 20 Nov 2023 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiNUXGpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B0BA4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:38:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ae5b12227fso70510747b3.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700516290; x=1701121090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dq4CfKUj5/ZaNFEkeLfqEzl0ki2CvJ4LAjxnKGFqLpY=;
        b=BiNUXGpP5wlEY+v5NUBfPrzAiXeoa31DcGU9rl1ZCVXkuOJ3GtBA/ZuyzlzDU8CaiD
         s2w659socGpf7dBbS7xZhnNlsXlPXmfjy+Qh1qZ+oSSF+00C2Vvpgp187QE1eAn9kSyV
         ntOjH31OFRbBF+Tb2Mim3UZge8rxIr3IMzU75HYw2HFMDBc/XQE01JOYo/wVT6GNhthe
         KM9QG+5Qf+02Ekx6bQmfzBthDVPoO3f9jxrORF4LwXNpJW4TIEmsYBPWDlV+f8n+rdHo
         a7CD9EDyFGiyOM1jVhVIQSSaD5uhwpmtKY3IPWB7LTep2xzG4cCBuW23PzATkYoNmIWq
         KKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516290; x=1701121090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dq4CfKUj5/ZaNFEkeLfqEzl0ki2CvJ4LAjxnKGFqLpY=;
        b=Nwa/+uWkvKZXT9YO8llIPj038Qre2qKwxdYZ8Zf//TWqyIZJw5OgMUjWWcz7jyIDwl
         icSnG8mcYg29jQK8l+agYqL8ufp1Y6+FdEaNTSoiN0nOD6YJf5Fx/7ZL/XwRFYP1NLRv
         QHZYf3Zkm9JYD9Hq3VHNErxwUO74hTIGrofW2D1BK1VaKBCy1GZaolhRaKVrhjlzrqo3
         FFd3DrzqOn39fUMcrD8HB3edMDDwj+z/wfHqCJqsRV+L4RVtAz6ajyGjKNvoyzN2MJW+
         iWdIkgyiwDwJzjkT9CNn2bEKmf4FCurtRczWLfzjRTB1EuR4zoWeRea30dkWuKHGFnyk
         pkjg==
X-Gm-Message-State: AOJu0YyRPrljMKGOIIdkLKP2fV8HdnhFl/Pb6pib31Co9+ANugE4rTV0
	9Ahyvzl7YOvxXWnRAu0r7cP2FtI=
X-Google-Smtp-Source: AGHT+IF5G39joqJfR/xXRnSv4jxlxoWo/M6mCYoU1xlmcfGOaqHKjpRBNQ9Ynfdgyr6ADX0c2lsN080=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:2a8f:b0:5c9:b457:d73 with SMTP id
 ek15-20020a05690c2a8f00b005c9b4570d73mr132946ywb.6.1700516289968; Mon, 20 Nov
 2023 13:38:09 -0800 (PST)
Date: Mon, 20 Nov 2023 13:38:08 -0800
In-Reply-To: <20231114045453.1816995-2-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com> <20231114045453.1816995-2-sdf@google.com>
Message-ID: <ZVvRwIUFOAP5lacY@google.com>
Subject: Re: [PATCH bpf-next 1/2] netdevsim: don't accept device bound programs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	Dipendra Khadka <kdipendra88@gmail.com>, 
	syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On 11/13, Stanislav Fomichev wrote:
> Commit 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> introduced device-bound programs by largely reusing existing
> offloading infrastructure. This changed the semantics of
> 'prog->aux->offload' a bit. Now, it's non-null for both
> offloaded and device-bound programs.
> 
> Instead of looking at 'prog->aux->offload' let's call
> bpf_prog_is_offloaded which should be true iff the program
> is offloaded and not merely device-bound.
> 
> Cc: Dipendra Khadka <kdipendra88@gmail.com>
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  drivers/net/netdevsim/bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index f60eb97e3a62..608953d4f98d 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -93,7 +93,7 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
>  {
>  	struct nsim_bpf_bound_prog *state;
>  
> -	if (!prog || !prog->aux->offload)
> +	if (!prog || !bpf_prog_is_offloaded(prog->aux))
>  		return;
>  
>  	state = prog->aux->offload->dev_priv;
> @@ -311,7 +311,7 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
>  	if (!bpf->prog)
>  		return 0;
>  
> -	if (!bpf->prog->aux->offload) {
> +	if (!bpf_prog_is_offloaded(bpf->prog->aux)) {
>  		NSIM_EA(bpf->extack, "xdpoffload of non-bound program");
>  		return -EINVAL;
>  	}
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

Forgot to CC netdev of these..

