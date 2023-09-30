Return-Path: <netdev+bounces-37158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAF7B4030
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 32E491C20777
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67ABA4B;
	Sat, 30 Sep 2023 12:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0D8F5A
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 12:00:11 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4EE6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 05:00:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so3103a12.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696075205; x=1696680005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GTxYazO7tslop+1R5e/LRP9/RgHOwT+uOuEWmbMhAw=;
        b=pgvcZ8ef40BgdU0/wa4IZYQOGSHDSmL37DODRGWXZtnj7bsPDfE6M8ax1GIBiDtXR9
         Ej9obkJsi30kFd+YUZdjoa9EEP6PNFbjk2uB4pbSpSkG6BXzf5ZWPFilqi+hO34PLCJj
         lQnSrQjOhJps62YAfONRjhhQvUlxfl0QXoTBr0/6J3SAjhzUgU+WB1FVA4WisH5U5Kfr
         9ADAMpn2MloFClbRxvf8VcGJU8hP7UlEyY17bIBhuAJjwyNSnlrPF67hj2auxGTXJTuo
         vSRtfclMtSYnEQg36j4X5Lu0I/439EotBkNLWCg4eQhk/16baSTP4ku4opYO6+Vep/4g
         cOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696075205; x=1696680005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GTxYazO7tslop+1R5e/LRP9/RgHOwT+uOuEWmbMhAw=;
        b=pD0S+l1ZSUfR5g7qaOwBREMfihsObVtDPN/9l4S5IS6B0PXzfEtSzkLCViLCuFkR1i
         VwNO1Ht/+yFIfUla/WnqfqnBJObgfDDAOPkva8Jaj/M/kxiqTNe1IhWDbp9L6jAx+afu
         KyfynnLQeRFGGdxu/7MUEg77EuppSA1Cc7x813oNcxLV48ynBLpkIVndPX3OjoeBxYDG
         cN9cLZfovY/TpgsqXRirLEgzeFelngu3m/AvlqP/6Fizwp/NJh3GtpWiiMmhmBgl54+l
         XrwA9ac/L/Kn315Vrs7u/jwihZI58ZGp8EfyvZVwmXEXv2py9Zc5/TrMjQKYdzSsQ3cL
         NfPA==
X-Gm-Message-State: AOJu0YxVEsyGxMPtzlHSI+MnynkFVNeyCf4aFkcu4NPYq2eQ7wL9nLD6
	ux2wtkdj/h4zyh58t5SBMs1WByqsy5Grxm3LV8BNmA==
X-Google-Smtp-Source: AGHT+IGdzCjX3EBgqb4QPmapoSPJsqAAEbYgJDuzEACgLn7JbDrTrmgIjPOsc2vqbMgvrU34OmWNrGJLKX84Jip4SOo=
X-Received: by 2002:a50:8d17:0:b0:52f:5697:8dec with SMTP id
 s23-20020a508d17000000b0052f56978decmr32444eds.4.1696075204644; Sat, 30 Sep
 2023 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com>
In-Reply-To: <20230922111247.497-1-ansuelsmth@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 30 Sep 2023 13:59:53 +0200
Message-ID: <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Raju Rangoju <rajur@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 1:13=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> We currently have napi_if_scheduled_mark_missed that can be used to
> check if napi is scheduled but that does more thing than simply checking
> it and return a bool. Some driver already implement custom function to
> check if napi is scheduled.
>
> Drop these custom function and introduce napi_is_scheduled that simply
> check if napi is scheduled atomically.
>
> Update any driver and code that implement a similar check and instead
> use this new helper.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
>  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
>  include/linux/netdevice.h                 | 5 +++++
>  net/core/dev.c                            | 2 +-
>  4 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ether=
net/chelsio/cxgb3/sge.c
> index 2e9a74fe0970..71fa2dc19034 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *nap=
i, int budget)
>         return work_done;
>  }
>
> -/*
> - * Returns true if the device is already scheduled for polling.
> - */
> -static inline int napi_is_scheduled(struct napi_struct *napi)
> -{
> -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> -}
> -
>  /**
>   *     process_pure_responses - process pure responses from a response q=
ueue
>   *     @adap: the adapter
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index 133bf289bacb..bbf4ea3639d4 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_=
dev *rtwdev,
>         struct napi_struct *napi =3D &rtwdev->napi;
>
>         /* In low power mode, napi isn't scheduled. Receive it to netif. =
*/
> -       if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> +       if (unlikely(!napi_is_scheduled(napi)))
>                 napi =3D NULL;
>
>         rtw89_core_hw_to_sband_rate(rx_status);
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index db3d8429d50d..8eac00cd3b92 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct napi=
_struct *n)
>         return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
>  }
>


In which context is it safe to call this helper ?

I fear that making this available will add more bugs.

For instance rspq_check_napi() seems buggy to me.

> +static inline bool napi_is_scheduled(struct napi_struct *n)

const ...

> +{
> +       return test_bit(NAPI_STATE_SCHED, &n->state);
> +}
> +
>  bool napi_schedule_prep(struct napi_struct *n);
>
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cc03a5758d2d..32ba8002f65a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6523,7 +6523,7 @@ static int __napi_poll(struct napi_struct *n, bool =
*repoll)
>          * accidentally calling ->poll() when NAPI is not scheduled.
>          */
>         work =3D 0;
> -       if (test_bit(NAPI_STATE_SCHED, &n->state)) {
> +       if (napi_is_scheduled(n)) {
>                 work =3D n->poll(n, weight);
>                 trace_napi_poll(n, work, weight);
>         }
> --
> 2.40.1
>

