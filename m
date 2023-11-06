Return-Path: <netdev+bounces-46141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE97E1981
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 06:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38899B20F33
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A58F65;
	Mon,  6 Nov 2023 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WnUe5Oi5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1323D0
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 05:01:25 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB06110B
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 21:01:22 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7788db95652so288516385a.2
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 21:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246882; x=1699851682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgkGL13BgwhVaF5JvPkLO8u/Sq6KAYlBvK2AjFLPOhI=;
        b=WnUe5Oi5hQ642wF7YtxIN5yBpyXL08awHcmFcKjwGMFwR25lW4Q20+/oiD9TosMVPR
         olhPSWK8JdXqpp2BikpsILQljTIEgGxJdhqrswQKPzUnUW7+5lNldX7nOORaDzUx7hYk
         wICmTkYOiKx8w5EFZNhf0vtK6M8aeEWYM2oHshEb2I4B5Q4egX2AxMrFyXhGxzmEZKyz
         c019A/nW6Dnd9qAQ2EbxXO3fDxYQF42zYCortmM1WlnEJ68tDLuwCzetmuiCv5d1+msw
         gnwX0t6veUaEPyD7zBginAnzemkD0QE7qT1Fvwz9REjveVP+DB0z32rRYrAmc/gM6lBV
         cN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246882; x=1699851682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgkGL13BgwhVaF5JvPkLO8u/Sq6KAYlBvK2AjFLPOhI=;
        b=Gj0Jo8CE7LhFMVOKOCJCW4giomD2aF/p+4c7CGt4BvzoZGtkLGVeH8/szWae8E3UVK
         86LwUwwEypQv8AOK3h9XveWb1+TPKY7Q9ytzZJFbV/mf7VvUOWOHjKh2ViDBQ+zyldpd
         TPUzdHzzf4iba2rw2T/2JhLR6rB/uNupUdfIBrQ3y5GGe9psFtooC0Epe29qzMSojf7l
         kiXiShViA5q6C2AtJRkWzkkX0Kf1tKZKaRtI0vXi1b5J40gJpk384Ir57UZtfZ1tMaCF
         EtvUmLwL2KOyl3jao2MpUwfDM0jY4nWl+gX5T1BUtbemShu7dw0Qp29Mu6tHwRmcD/mW
         QIZw==
X-Gm-Message-State: AOJu0Ywq9LA0/rp9wTyRhiEb/4JtqGvofZr95HXwsmtkXXzCYhJtztjG
	qC25gHY7oryhSakvcTZoq02j
X-Google-Smtp-Source: AGHT+IEaTgvPP6kzsEEWzYutCxRoNhV4ImXyISw6RvmALCDNeOvp8z7ukff85hVdaAuaid2eKqqQIQ==
X-Received: by 2002:a05:620a:2844:b0:77a:5f8d:f079 with SMTP id h4-20020a05620a284400b0077a5f8df079mr11935047qkp.60.1699246881753;
        Sun, 05 Nov 2023 21:01:21 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a410800b007743671a41fsm2979825qko.72.2023.11.05.21.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:21 -0800 (PST)
Date: Mon, 06 Nov 2023 00:01:20 -0500
Message-ID: <df2ecc560256f98a4fddf66529b72d38.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 10/17] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM  hooks
References: <20231103190523.6353-11-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Similarly to bpf_prog_alloc LSM hook, rename and extend bpf_map_alloc
> hook into bpf_map_create, taking not just struct bpf_map, but also
> bpf_attr and bpf_token, to give a fuller context to LSMs.
> 
> Unlike bpf_prog_alloc, there is no need to move the hook around, as it
> currently is firing right before allocating BPF map ID and FD, which
> seems to be a sweet spot.
> 
> But like bpf_prog_alloc/bpf_prog_free combo, make sure that bpf_map_free
> LSM hook is called even if bpf_map_create hook returned error, as if few
> LSMs are combined together it could be that one LSM successfully
> allocated security blob for its needs, while subsequent LSM rejected BPF
> map creation. The former LSM would still need to free up LSM blob, so we
> need to ensure security_bpf_map_free() is called regardless of the
> outcome.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++--
>  include/linux/security.h      |  6 ++++--
>  kernel/bpf/bpf_lsm.c          |  6 +++---
>  kernel/bpf/syscall.c          |  4 ++--
>  security/security.c           | 16 ++++++++++------
>  security/selinux/hooks.c      |  7 ++++---
>  6 files changed, 26 insertions(+), 18 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

