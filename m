Return-Path: <netdev+bounces-18560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFE757A0E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01812811E7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04332C2D5;
	Tue, 18 Jul 2023 11:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDB945F
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:08:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49010EF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689678515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/D23IWoSLSFILOueJ1sqkvAVYDlEez/SkBsdzHm8uI=;
	b=QobEscaZBVRDFyu7dKKkCzNHjc07RB0RQnTA9yS7s0Izvmpq1CRLmAWU3yuCVySSPth8kr
	CRxAMPn4A8497auT+lVcVzPXRNyBzGi9GUuAbU5LakM+tuRIfg3AU7VkkG6R7rCNVbOItD
	VKz0oSqV2D1BdKrktKVcr5XYTKH+uAE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-iWyYpcV-NHWTNmmV3ajfag-1; Tue, 18 Jul 2023 07:08:34 -0400
X-MC-Unique: iWyYpcV-NHWTNmmV3ajfag-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401e1fc831fso10314921cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689678514; x=1692270514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/D23IWoSLSFILOueJ1sqkvAVYDlEez/SkBsdzHm8uI=;
        b=cqObH5EOWDrKHpt3z/L12bEs7a9M6bdc/XZZnfc6bV2YW9Q5Eg4qy2OVPOBqJ6dfWI
         le0C4wQvdN0lZM69MLGECIpSmkLxVCQpcJB2DkLOrEZihfd5T8VvJtu016ojOiaKCr+h
         iCG+Z42RXKFS03sNTvEivNnouZYlD9OYfqoag2lThErlz9Xi7i4C07oBAKXHJZGSpCSB
         3U4jBy1hfya7PlF3IS8MLjN/CUqKONY5bY0n/xRECm+9Rhq+fSRDGA7nebESFC8AFbkx
         C4qc0VD45GJD6nSeyOPJiIxyCP4Zq8lO7DMcJDMR849rmR1ZO8Rrgqn/Pc0Edk4qTix1
         Cmjw==
X-Gm-Message-State: ABy/qLbpDupZ/B3ZayCHzE46gK73NcmBB+k2bkoKu0rOjEM14C1VXF1q
	77UJurNAeb0lk0RUZkdI6WANYxKINHZzv/9QIVPOgiQ23PiNtrYo/Xo6aVBgrMrfN7l2uWtjgm1
	M+vhcRrrefsck/Bqc
X-Received: by 2002:a05:622a:1813:b0:403:59f8:25d9 with SMTP id t19-20020a05622a181300b0040359f825d9mr10942796qtc.2.1689678514163;
        Tue, 18 Jul 2023 04:08:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGhFXiTRLs4F3xnaUNh0orK4AP5HoC/bfuuBgboh4MQUDGnGejRCegiLOMSjuGkZVMtRDmDA==
X-Received: by 2002:a05:622a:1813:b0:403:59f8:25d9 with SMTP id t19-20020a05622a181300b0040359f825d9mr10942769qtc.2.1689678513856;
        Tue, 18 Jul 2023 04:08:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403cce833eesm572810qtx.27.2023.07.18.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:08:33 -0700 (PDT)
Message-ID: <02b2a11c2990fdf21e8cd2c582df67d5883f6eea.camel@redhat.com>
Subject: Re: [net PATCH] octeontx2-af: Adjust Tx credits when MCS external
 bypass is disabled
From: Paolo Abeni <pabeni@redhat.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	ndabilpuram@marvell.com
Date: Tue, 18 Jul 2023 13:08:30 +0200
In-Reply-To: <20230716091621.27844-1-gakula@marvell.com>
References: <20230716091621.27844-1-gakula@marvell.com>
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

On Sun, 2023-07-16 at 14:46 +0530, Geetha sowjanya wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
>=20
> When MCS external bypass is disabled, MCS returns additional
> 2 credits(32B) for every packet Tx'ed on LMAC. To account for
> these extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
> needs to be configured as otherwise NIX Tx credits would overflow
> and will never be returned to idle state credit count
> causing issues with credit control and MTU change.
>=20
> This patch fixes the same by configuring CC_MCS_CNT at probe
> time for MCS enabled SoC's
>=20
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM fo=
r normal traffic")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h    |  2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
>  5 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index eba307eee2b2..d78d72c0ca18 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1914,7 +1914,7 @@ struct mcs_hw_info {
>  	u8 tcam_entries;	/* RX/TX Tcam entries per mcs block */
>  	u8 secy_entries;	/* RX/TX SECY entries per mcs block */
>  	u8 sc_entries;		/* RX/TX SC CAM entries per mcs block */
> -	u8 sa_entries;		/* PN table entries =3D SA entries */
> +	u16 sa_entries;		/* PN table entries =3D SA entries */

This chunk looks like an unrelated bug-fix. Please move it to a
separate patch or mention in the commit message why it's needed here.

Thanks!

Paolo


