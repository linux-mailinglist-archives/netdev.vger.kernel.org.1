Return-Path: <netdev+bounces-45407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD57DCB67
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0736D2815BC
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B86E19442;
	Tue, 31 Oct 2023 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxtdNaYt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1142105
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 11:06:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279EBB
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698750402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeNTgEg8tsCK+iB2JBATlgJcpJ/vml1SpbMe3EquNfs=;
	b=DxtdNaYt+5CyTsu2rYhoUl91G+BUjzKGvY/uZ9Laip1t7bM5AhLJBD0egl77fUY4T0DAgr
	ZNB+i5ZZwxVDw+5PF3vEL7WeCzAlBqutQ+OMd1KICDCWoCMO7bowDtaCMWKLZrgrFF5fGh
	hPlche+sOAbCIu0nwFX8DBOjUSvffNE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-77YnTtd1Pyu4Odn3ceiJvg-1; Tue, 31 Oct 2023 07:06:31 -0400
X-MC-Unique: 77YnTtd1Pyu4Odn3ceiJvg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-542d011ca7dso535399a12.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750390; x=1699355190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeNTgEg8tsCK+iB2JBATlgJcpJ/vml1SpbMe3EquNfs=;
        b=KZMlVWWfu0/3QgqoUk3KzfZ5vFIBEytAFCQwEcWvL3f7cjLy4KVc0wITw8auiCdD6x
         s/Vo6O33Lom4PQTKfI+/fOASTXvm5P42YfUeELjpVdt2K7Az/POmTUaalDcYzhKR3t+I
         kl/u4hX9kH9a0t35icbY0P0DfnVOjXNCa2Piwkogytr03iAeohS9E25jdWxP1CeQuDHh
         RBEAltYZWHWXJrt4Hnt8iizCzKj4Y37I+nJuaNkBunl/xdTZ5FlX/9Y/XgdYcR0ZBCjl
         eGi7AYsftQ2/ulsmAIKdF7dQV1WubrFI2Ggv0rMWV5x7rUp3225qSWVJhb6ZsnZ+A8dD
         zNWA==
X-Gm-Message-State: AOJu0Yx1JmIdBwDmMfaSHqaw7wpHJTjevqg8pxWVD2HBRFTm6JpT2mzo
	JvK0uHpnI9BEt9mHKwRYfQ8SqmE0hDDHv6S4mt77dCvMzAYUu+E27TWFh+FyMl8/iuMT3HQcTUk
	FtEPcU9BDNmKL/f0M
X-Received: by 2002:a50:d49e:0:b0:53f:18f6:a153 with SMTP id s30-20020a50d49e000000b0053f18f6a153mr9697627edi.3.1698750389878;
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU3fW9CjMF9NxM2NJf+1GvsoCwESzcm25+DVXEtCmrvZvzCFMKH+ZzuSFKY7gpsIMYtpRC6w==
X-Received: by 2002:a50:d49e:0:b0:53f:18f6:a153 with SMTP id s30-20020a50d49e000000b0053f18f6a153mr9697604edi.3.1698750389448;
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b005434095b179sm942853edx.92.2023.10.31.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:06:29 -0700 (PDT)
Message-ID: <5a46ffb675addbed8a3dac176effb96eb2c8ca3e.camel@redhat.com>
Subject: Re: [PATCH net v1 2/2] octeontx2-pf: Fix holes in error code
From: Paolo Abeni <pabeni@redhat.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  wojciech.drewek@intel.com
Date: Tue, 31 Oct 2023 12:06:27 +0100
In-Reply-To: <20231027021953.1819959-2-rkannoth@marvell.com>
References: <20231027021953.1819959-1-rkannoth@marvell.com>
	 <20231027021953.1819959-2-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 07:49 +0530, Ratheesh Kannoth wrote:
> Error code strings are not getting printed properly
> due to holes. Print error code as well.
>=20
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]=
")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>=20
> ---
> ChangeLog:
>=20
> v0 -> v1: Splitted patch into two
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++--------
>  1 file changed, 46 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 6daf4d58c25d..125fe231702a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1193,31 +1193,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] =3D=
 {
>  };
> =20
>  static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =3D  {
> -	"NIX_SND_STATUS_GOOD",
> -	"NIX_SND_STATUS_SQ_CTX_FAULT",
> -	"NIX_SND_STATUS_SQ_CTX_POISON",
> -	"NIX_SND_STATUS_SQB_FAULT",
> -	"NIX_SND_STATUS_SQB_POISON",
> -	"NIX_SND_STATUS_HDR_ERR",
> -	"NIX_SND_STATUS_EXT_ERR",
> -	"NIX_SND_STATUS_JUMP_FAULT",
> -	"NIX_SND_STATUS_JUMP_POISON",
> -	"NIX_SND_STATUS_CRC_ERR",
> -	"NIX_SND_STATUS_IMM_ERR",
> -	"NIX_SND_STATUS_SG_ERR",
> -	"NIX_SND_STATUS_MEM_ERR",
> -	"NIX_SND_STATUS_INVALID_SUBDC",
> -	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
> -	"NIX_SND_STATUS_DATA_FAULT",
> -	"NIX_SND_STATUS_DATA_POISON",
> -	"NIX_SND_STATUS_NPC_DROP_ACTION",
> -	"NIX_SND_STATUS_LOCK_VIOL",
> -	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_ABORT",
> -	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> -	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> -	"NIX_SND_STATUS_SEND_STATS_ERR",
> +	[NIX_SND_STATUS_GOOD] =3D "NIX_SND_STATUS_GOOD",
> +	[NIX_SND_STATUS_SQ_CTX_FAULT] =3D "NIX_SND_STATUS_SQ_CTX_FAULT",
> +	[NIX_SND_STATUS_SQ_CTX_POISON] =3D "NIX_SND_STATUS_SQ_CTX_POISON",
> +	[NIX_SND_STATUS_SQB_FAULT] =3D "NIX_SND_STATUS_SQB_FAULT",
> +	[NIX_SND_STATUS_SQB_POISON] =3D "NIX_SND_STATUS_SQB_POISON",
> +	[NIX_SND_STATUS_HDR_ERR] =3D "NIX_SND_STATUS_HDR_ERR",
> +	[NIX_SND_STATUS_EXT_ERR] =3D "NIX_SND_STATUS_EXT_ERR",
> +	[NIX_SND_STATUS_JUMP_FAULT] =3D "NIX_SND_STATUS_JUMP_FAULT",
> +	[NIX_SND_STATUS_JUMP_POISON] =3D "NIX_SND_STATUS_JUMP_POISON",
> +	[NIX_SND_STATUS_CRC_ERR] =3D "NIX_SND_STATUS_CRC_ERR",
> +	[NIX_SND_STATUS_IMM_ERR] =3D "NIX_SND_STATUS_IMM_ERR",
> +	[NIX_SND_STATUS_SG_ERR] =3D "NIX_SND_STATUS_SG_ERR",
> +	[NIX_SND_STATUS_MEM_ERR] =3D "NIX_SND_STATUS_MEM_ERR",
> +	[NIX_SND_STATUS_INVALID_SUBDC] =3D "NIX_SND_STATUS_INVALID_SUBDC",
> +	[NIX_SND_STATUS_SUBDC_ORDER_ERR] =3D "NIX_SND_STATUS_SUBDC_ORDER_ERR",
> +	[NIX_SND_STATUS_DATA_FAULT] =3D "NIX_SND_STATUS_DATA_FAULT",
> +	[NIX_SND_STATUS_DATA_POISON] =3D "NIX_SND_STATUS_DATA_POISON",
> +	[NIX_SND_STATUS_NPC_DROP_ACTION] =3D "NIX_SND_STATUS_NPC_DROP_ACTION",
> +	[NIX_SND_STATUS_LOCK_VIOL] =3D "NIX_SND_STATUS_LOCK_VIOL",
> +	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] =3D "NIX_SND_STAT_NPC_UCAST_CHAN_ER=
R",
> +	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] =3D "NIX_SND_STAT_NPC_MCAST_CHAN_ER=
R",
> +	[NIX_SND_STATUS_NPC_MCAST_ABORT] =3D "NIX_SND_STATUS_NPC_MCAST_ABORT",
> +	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] =3D "NIX_SND_STATUS_NPC_VTAG_PTR_ERR"=
,
> +	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] =3D "NIX_SND_STATUS_NPC_VTAG_SIZE_ER=
R",
> +	[NIX_SND_STATUS_SEND_MEM_FAULT] =3D "NIX_SND_STATUS_SEND_MEM_FAULT",
> +	[NIX_SND_STATUS_SEND_STATS_ERR] =3D "NIX_SND_STATUS_SEND_STATS_ERR",
>  };
> =20
>  static irqreturn_t otx2_q_intr_handler(int irq, void *data)
> @@ -1238,14 +1239,16 @@ static irqreturn_t otx2_q_intr_handler(int irq, v=
oid *data)
>  			continue;
> =20
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_L=
F_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n"=
,
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  		} else {
>  			if (val & BIT_ULL(NIX_CQERRINT_DOOR_ERR))
>  				netdev_err(pf->netdev, "CQ%lld: Doorbell error",
>  					   qidx);
>  			if (val & BIT_ULL(NIX_CQERRINT_CQE_FAULT))
> -				netdev_err(pf->netdev, "CQ%lld: Memory fault on CQE write to LLC/DRA=
M",
> +				netdev_err(pf->netdev,
> +					   "CQ%lld: Memory fault on CQE write to LLC/DRAM",
>  					   qidx);
>  		}

It's not a big deal (no need to repost just for this), but the above
chunk (and a couple below, too) is not related to the current fix, you
should have not included it here.

Cheers,

Paolo

> =20
> @@ -1272,7 +1275,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, voi=
d *data)
>  			     (val & NIX_SQINT_BITS));
> =20
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_L=
F_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n"=
,
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  			goto done;
>  		}
> @@ -1282,8 +1286,11 @@ static irqreturn_t otx2_q_intr_handler(int irq, vo=
id *data)
>  			goto chk_mnq_err_dbg;
> =20
>  		sq_op_err_code =3D FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=3D%s\n=
",
> -			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=3D%s(%#x)\n",
> +			   qidx, sq_op_err_dbg,
> +			   nix_sqoperr_e_str[sq_op_err_code],
> +			   sq_op_err_code);
> =20
>  		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
> =20
> @@ -1300,16 +1307,21 @@ static irqreturn_t otx2_q_intr_handler(int irq, v=
oid *data)
>  			goto chk_snd_err_dbg;
> =20
>  		mnq_err_code =3D FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=3D%s\n",
> -			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=3D%s(%#x)\n",
> +			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code],
> +			   mnq_err_code);
>  		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
> =20
>  chk_snd_err_dbg:
>  		snd_err_dbg =3D otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
>  		if (snd_err_dbg & BIT(44)) {
>  			snd_err_code =3D FIELD_GET(GENMASK(7, 0), snd_err_dbg);
> -			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=3D%s\n"=
,
> -				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=3D%s(%#x)\n",
> +				   qidx, snd_err_dbg,
> +				   nix_snd_status_e_str[snd_err_code],
> +				   snd_err_code);
>  			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
>  		}
> =20


