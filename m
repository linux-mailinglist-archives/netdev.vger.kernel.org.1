Return-Path: <netdev+bounces-14202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361E73F7B4
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C97280F3E
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688516402;
	Tue, 27 Jun 2023 08:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96DEC2
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:47:13 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE4AA4
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:47:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so5952921e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687855630; x=1690447630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhRrQp9kwB/JPuri3mMCxNWRFjPtNc7aTqoHXZ2PZk0=;
        b=lvzBUb/hfT9Ftlo0BdHIgCVheBxQNG6CHX55BTH/QIS+n+/LGJsn74VAVLCwhkpn3P
         m7ZpaAITuoBoey3ok9MaPv86A/7PxaZs/4Cz6erWyau8xFMgOIyvNeJVfUx0P9WNhJdC
         636CbnKLbTvpl3MHspU1+niaybD+hdVxVwghs9ZXsR170nHClDKgTELC2RU7aCA6USgx
         V07kCX3LZOAKztnX9h6A9ERzvjOUJ53Tp7XfiU1EkKeXcDyOyk5gWsEfv+nKO79bQ49T
         yPd683oHCCSBIjWyMQlGaZ9/7AM0pMPVASBWJntdGU5Mbo7giKWHDEc57369rcLvBCkj
         PJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687855630; x=1690447630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhRrQp9kwB/JPuri3mMCxNWRFjPtNc7aTqoHXZ2PZk0=;
        b=ASM/+C1SVbrJB3hUusotF9vc8aqYy0XwhSeFgw7MqhjVcLLjilzG7Z1lHkEd2e8wAM
         0FOeK21IA9WSVZUzaOv+vYGLCfVI1sfrP3cMuv+XmKFi/+d+8lENJ0H0F9zbA6vaBtZ7
         XQaiNwo3M71UEiQiiHOF0M3rgy28/J92KriES+5bIwtUZc9khfOP9PA8t08FWl5kcxMe
         kLTFc86oIfDTvLR204gIco9PyileGEp6NkiwucuHSGR7WxUba0DBgmChv6opac7+0838
         /ypEN7c+A6Xuaj6JYxUO6XXPqrX2i1Jjow05tgN/TVG+swLaz+gg/9zBSF6HEELCAafK
         1r+Q==
X-Gm-Message-State: AC+VfDyXnD5FnAsKQQhEhnBm4J0wzvBvwp9IWESQO1ET10DQliKYphdd
	ILR1Lk784j7o9wNDVvNFxW4=
X-Google-Smtp-Source: ACHHUZ7y6GtZIzkcKeoZPB22IiLcbiHvVu32Osn8jAjEXE+W/reXM2mGUc8SFzymDPkb1lyihjcsUQ==
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id h24-20020a19ca58000000b004f8b3496938mr11359576lfj.65.1687855629753;
        Tue, 27 Jun 2023 01:47:09 -0700 (PDT)
Received: from krava (85-160-25-217.reb.o2.cz. [85.160.25.217])
        by smtp.gmail.com with ESMTPSA id a25-20020a5d4579000000b003048477729asm9727118wrc.81.2023.06.27.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:47:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Jun 2023 10:47:00 +0200
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after
 scm_set_cred()."
Message-ID: <ZJqiBHEijRY/x6Mf@krava>
References: <20230626205837.82086-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626205837.82086-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 01:58:37PM -0700, Kuniyuki Iwashima wrote:
> This reverts commit 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2.
> 
> Konrad reported that desktop environment below cannot be reached after
> commit 3f5f118bb657 ("af_unix: Call scm_recv() only after scm_set_cred().")
> 
>   - postmarketOS (Alpine Linux w/ musl 1.2.4)
>   - busybox 1.36.1
>   - GNOME 44.1
>   - networkmanager 1.42.6
>   - openrc 0.47
> 
> Regarding to the warning of SO_PASSPIDFD, I'll post another patch to
> suppress it by skipping SCM_PIDFD if scm->pid == NULL in scm_pidfd_recv().
> 
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Link: https://lore.kernel.org/netdev/8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

hit the same issue, this revert fixes it for me, fwiw:

Teste-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
> To maintainers
> 
> Sorry for bothering, but can this make it to the v6.5 train to
> avoid regression reports ?
> ---
>  net/unix/af_unix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f2f234f0b92c..3953daa2e1d0 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2807,7 +2807,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  	} while (size);
>  
>  	mutex_unlock(&u->iolock);
> -	if (state->msg && check_creds)
> +	if (state->msg)
>  		scm_recv(sock, state->msg, &scm, flags);
>  	else
>  		scm_destroy(&scm);
> -- 
> 2.30.2
> 

