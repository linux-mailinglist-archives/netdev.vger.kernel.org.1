Return-Path: <netdev+bounces-16795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99F74EB85
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CA728127A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4970182B5;
	Tue, 11 Jul 2023 10:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D6182AB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:10:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640C9E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689070233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAaRI2HB7shFH/GOt5adazTuOLs/wLT5lLnDm8f+nYc=;
	b=J/NBkWbnRg2HRSTAZuxc4ZK10hC20RQVhJmNZz/7TZUNo+/FipCyct6/xdqGgo6aBdvA4M
	1H14+nuemF+H81s9WzFAnX3VFxJGecGLSGyn+bhfih914SD4tOWT4p6K4OkYKlZWqOzN0E
	j99dCq2VnPu3n4H/WaggIP5qo9d0MLc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-f6WXiNF7OeS1SkIKkrsqWA-1; Tue, 11 Jul 2023 06:10:32 -0400
X-MC-Unique: f6WXiNF7OeS1SkIKkrsqWA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-639d9eaf37aso5931566d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070231; x=1691662231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAaRI2HB7shFH/GOt5adazTuOLs/wLT5lLnDm8f+nYc=;
        b=J8HLMW7zeQ27TrWpIttFImHh6fHltU6jRqDxVFEaz86RSCjrnprazSQ7gPNub5wlXH
         y72VTgn+vNUIxDw9+4tFthENDQGpYWYfyLfPYShnIU25TvBcSzSRHxIHt+rmeN/YmNt7
         ckuGLAcAZlPwl5b7xSL1kNqgvfnF9NCiNorajrEsSElNPuW4/UaUbj557MqdJSdB0/TJ
         X3vxR7w9y99Imt0RJpN9eRkK2TNPKrnbz9bP6NmjmM3umcF5bDz0rXTd1g+g+/p1O3vu
         rRqAC+0WmI+7WRnXAWIQznOpq7BvwiJQezh3hsMH+aEZrZfoM/5V1fW4MCFANmgX69NK
         aefQ==
X-Gm-Message-State: ABy/qLbeiFT6Flo5Q8GCZRWEK2Dm7/PDN2KZWICknxk8/yoTzxIN241+
	1+r1F4YAwRJn0CtFJFAkFTMgoRXEoMB0E2My7NIhuxHX4oXaOrIo/8lCLqet9f7ubQ/Ez+bZYhW
	iM/PgVYytqBiZ/RpI
X-Received: by 2002:a05:6214:400a:b0:625:86ed:8ab4 with SMTP id kd10-20020a056214400a00b0062586ed8ab4mr16136449qvb.3.1689070231650;
        Tue, 11 Jul 2023 03:10:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJNpTQHF5dIal2JIMOmAPbluvOOeq5iS83jWMQoJRoCuVDlwz2WEGt3fYRQ4qqkOiUKuS+dg==
X-Received: by 2002:a05:6214:400a:b0:625:86ed:8ab4 with SMTP id kd10-20020a056214400a00b0062586ed8ab4mr16136435qvb.3.1689070231300;
        Tue, 11 Jul 2023 03:10:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id e28-20020a0cb45c000000b0063642bcc5e4sm912402qvf.9.2023.07.11.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:10:31 -0700 (PDT)
Message-ID: <774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, michael.chan@broadcom.com
Date: Tue, 11 Jul 2023 12:10:28 +0200
In-Reply-To: <20230710205611.1198878-4-kuba@kernel.org>
References: <20230710205611.1198878-1-kuba@kernel.org>
	 <20230710205611.1198878-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-10 at 13:56 -0700, Jakub Kicinski wrote:
> Invalid Tx completions should never happen (tm) but when they do
> they crash the host, because driver blindly trusts that there is
> a valid skb pointer on the ring.
>=20
> The completions I've seen appear to be some form of FW / HW
> miscalculation or staleness, they have typical (small) values
> (<100), but they are most often higher than number of queued
> descriptors. They usually happen after boot.
>=20
> Instead of crashing print a warning and schedule a reset.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 +++++++++++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index b8ddad33b01a..bfa56f35d2e0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -690,6 +690,16 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt=
_napi *bnapi, int nr_pkts)
>  		skb =3D tx_buf->skb;
>  		tx_buf->skb =3D NULL;
> =20
> +		if (unlikely(!skb)) {
> +			netdev_err(bp->dev, "Invalid Tx completion (ring:%d tx_pkts:%d cons:%=
u prod:%u i:%d)",
> +				   txr->txq_index, bnapi->tx_pkts,
> +				   txr->tx_cons, txr->tx_prod, i);
> +			WARN_ON_ONCE(1);
> +			bnapi->tx_fault =3D 1;
> +			bnxt_queue_sp_work(bp, BNXT_RESET_TASK_SP_EVENT);
> +			return;
> +		}
> +
>  		tx_bytes +=3D skb->len;
> =20
>  		if (tx_buf->is_push) {
> @@ -2576,7 +2586,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct=
 bnxt_cp_ring_info *cpr,
> =20
>  static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bna=
pi)
>  {
> -	if (bnapi->tx_pkts) {
> +	if (bnapi->tx_pkts && !bnapi->tx_fault) {
>  		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
>  		bnapi->tx_pkts =3D 0;
>  	}
> @@ -9429,6 +9439,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
>  		struct bnxt_napi *bnapi =3D bp->bnapi[i];
>  		struct bnxt_cp_ring_info *cpr;
> =20
> +		bnapi->tx_fault =3D 0;
> +
>  		cpr =3D &bnapi->cp_ring;
>  		if (bnapi->in_reset)
>  			cpr->sw_stats.rx.rx_resets++;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 080e73496066..08ce9046bfd2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1008,6 +1008,7 @@ struct bnxt_napi {
>  					  int);
>  	int			tx_pkts;
>  	u8			events;
> +	u8			tx_fault:1;

Since there are still a few holes avail, I would use a plain u8 (or
bool) to help the compiler emit better code.

Cheers,

Paolo


