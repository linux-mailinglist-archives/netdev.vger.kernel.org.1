Return-Path: <netdev+bounces-18219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21105755D95
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5FA1C20A1E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1009467;
	Mon, 17 Jul 2023 07:56:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12188493
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:56:39 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5893;
	Mon, 17 Jul 2023 00:56:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdb3f66fd6so2361589e87.3;
        Mon, 17 Jul 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689580596; x=1692172596;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzcBHck4XeBHsv947H53e4eFghSZzaJsuiWxGP5iqxw=;
        b=aK1icLPXTDR0xU45DBZUT5kFzZp+x7tjRpCAIZi/4/7gItfaY6xk8awYtW6SuS3AgK
         eOS8lt8Fl2y0lBeQOTLb2fWcCuqajJ4KEhWIQ0FO1dntZF1RN7GG8cOZO4U4u4zTTxby
         bN9Jda/tET2f4M9RnnbkTRhimJCssAMDJCbAFm1HbrNenuU5AsCIoEuZ4zyYr2fX0mST
         CdiABZdN94edkvKOSvNNVaDToYSlyeNLpO2NoIZQXzUyEIp753USAPsSHx9K7J9QDYBf
         S+Ml/Xq4wZ0Av9V6Mz36BwQSje86L6CMEZtAhl85YDC7bTYRBsyUVcQEfLvMt8qJQJ1N
         QgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580596; x=1692172596;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzcBHck4XeBHsv947H53e4eFghSZzaJsuiWxGP5iqxw=;
        b=NJ/CvB4XS3SSkfKo7W2HIrYqeF6AShxAT2UyGYWAJh1LQuiVr+yVtzt1xlQ2R9ATYE
         zit/FQIk3gm0bau9LOjH1dDAC/E+E7vGJ841lyQOAJgHLss7DHnMW2UjkOgw8oK+3Qww
         AbPp4HK1v8xdmk8mQpvXyLPKXrCL5+/13g2B6hLPssyLP/Q3eQ8UD9FDflVE4vG2DVEh
         GRjbUc3cUWOX+6OCS0y798XbfaxUUko+lUPpSmkLHvWpo2WSDHGjLwwuJwiwHCAFcmmI
         2pboeW4bMCl2pryhPVYVpGxygYc7eVffJlxSOdxzVBKKCvnVkiG4T6pLjIOjg30VUljZ
         jU8w==
X-Gm-Message-State: ABy/qLZDz7QbCJBpH1HIyhuRgt0noRk3eeRW/jhfyjCkR9/6TRnZp5S0
	Ca4C4Vr+bsysTwg/Zc9uEAcwowvh0/w=
X-Google-Smtp-Source: APBJJlF/d2LcLXm4aCAC3voDYWq2PYKTB8s9SeU39Eo8j6FYpcSeV/LHlzvm/BdU54Xs8ntQPKpVcg==
X-Received: by 2002:a2e:9c93:0:b0:2b6:e618:b593 with SMTP id x19-20020a2e9c93000000b002b6e618b593mr7671821lji.31.1689580595285;
        Mon, 17 Jul 2023 00:56:35 -0700 (PDT)
Received: from gmail.com ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c00c100b003fbb1a9586esm7384812wmm.15.2023.07.17.00.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 00:56:34 -0700 (PDT)
Date: Mon, 17 Jul 2023 08:56:32 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: hanyu001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: sfc: falcon: Prefer unsigned int to bare use of unsigned
Message-ID: <ZLT0MLWQ5Y+7tBC2@gmail.com>
Mail-Followup-To: hanyu001@208suo.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
References: <tencent_EE1674B8CDD721F12D12287A857E04C5DB0A@qq.com>
 <ab907800461dadf95c332a097f58e6f0@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab907800461dadf95c332a097f58e6f0@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The subject should start with "[PATCH net-next]".
Please use ./scripts/get_maintainer.pl to find the correct people
to send this to.

On Mon, Jul 17, 2023 at 11:43:00AM +0800, hanyu001@208suo.com wrote:
> Fix checkpatch warnings:
> 
> ./drivers/net/ethernet/sfc/falcon/net_driver.h:1167: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> ./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> ./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> ./drivers/net/ethernet/sfc/falcon/net_driver.h:1202: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: maqimei <2433033762@qq.com>

This does not match with the From line in your email.

> ---
>  drivers/net/ethernet/sfc/falcon/net_driver.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h
> b/drivers/net/ethernet/sfc/falcon/net_driver.h
> index a2c7139..d2d8f9b 100644
> --- a/drivers/net/ethernet/sfc/falcon/net_driver.h
> +++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
> @@ -1164,7 +1164,7 @@ struct ef4_nic_type {
> *************************************************************************/
> 
>  static inline struct ef4_channel *
> -ef4_get_channel(struct ef4_nic *efx, unsigned index)
> +ef4_get_channel(struct ef4_nic *efx, unsigned int  index)

You've added an extra space here after int. Don't do that.

Martin

>  {
>      EF4_BUG_ON_PARANOID(index >= efx->n_channels);
>      return efx->channel[index];
> @@ -1185,7 +1185,7 @@ struct ef4_nic_type {
>               (_efx)->channel[_channel->channel - 1] : NULL)
> 
>  static inline struct ef4_tx_queue *
> -ef4_get_tx_queue(struct ef4_nic *efx, unsigned index, unsigned type)
> +ef4_get_tx_queue(struct ef4_nic *efx, unsigned int index, unsigned int
> type)
>  {
>      EF4_BUG_ON_PARANOID(index >= efx->n_tx_channels ||
>                  type >= EF4_TXQ_TYPES);
> @@ -1199,7 +1199,7 @@ static inline bool ef4_channel_has_tx_queues(struct
> ef4_channel *channel)
>  }
> 
>  static inline struct ef4_tx_queue *
> -ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned type)
> +ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned int type)
>  {
>      EF4_BUG_ON_PARANOID(!ef4_channel_has_tx_queues(channel) ||
>                  type >= EF4_TXQ_TYPES);

