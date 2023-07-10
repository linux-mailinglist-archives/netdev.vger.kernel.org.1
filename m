Return-Path: <netdev+bounces-16363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840B74CE77
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AA71C20823
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05061569F;
	Mon, 10 Jul 2023 07:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BF53BE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:32:09 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE476106
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:31:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314417861b9so4134728f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688974311; x=1691566311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=byJr0xmC46iBq743abJgximnkiOFt20UZMaO06opogY=;
        b=X5fiH7o4AsekI7mkLf4fPTiLgEdyue6pPjKezkmqKfV3CDsrCmYH9m6ICfqZHgHjGg
         tJfneRt+0gzz5bBiAglMGwS8J25IcBbg7RodSTFa2BiPVK0qQbLKNGovfduSxekD3HTB
         yZ9AZKZd5cbF4GdZv/8cQ2mYpW9PPp19BgLcC1Vn6dvAbTRrFdQu4wGKeIK4u5fAj7sV
         il8NXX66xaP7FtVhd/CCOn3GMyH4gzdhfBHtJfuqt7gO+FgnGsaciGOnKm14m6Cb/B5Q
         KhAVeQMMoFvKwpAFoa3+gYDsEp6ZocF20Dh3fXWZoRaxg4NPh+z0NMfR9lV61gyDIDTk
         jl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974311; x=1691566311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byJr0xmC46iBq743abJgximnkiOFt20UZMaO06opogY=;
        b=do1j/Ly6cZc00dCjed/6iIOS9hTQzLft9zQ0eQ9IWo5hHWDnbxxbqsWHMkScuZNP+V
         SEu2Kiy00ANJqLuZMYj8FjuWe7PCHjBubXfNwCIlA/LPZgqreO8EeJysWu+0supHD+jC
         e/gwZ4AUs46NrzA2jCoxt7jl/MBzNavS4s3kFZqHao5JaqcSApdMXhu9VrX+nwJq20HW
         FIC/Zx8oy8xrLLYwsww4fGslYxic0W2vnsFScsFBe/+FcynfMuuC/uiARjAFbXWOU5Jd
         sORsuj7N7qckuFdbSUKp+u4OOv99FlvkN7cSIlTajOUapw50/8Cerag2h1Se+ClEoEtY
         1nuQ==
X-Gm-Message-State: ABy/qLYWI89XvkPw3toffOnuov6O+coWsaBWvhYw3oRjU/j9mlHufhTz
	EeIQnt9VnoxCmdWuBdHlMn6pFg==
X-Google-Smtp-Source: APBJJlGIJJG1aP9zcuRcTkdGAGVFewfD/2w036VUMfXBREZDOxc7KHHwsQ2h+DL5uPflOXk9HHB8lA==
X-Received: by 2002:a5d:6b0b:0:b0:313:e5f2:7cbf with SMTP id v11-20020a5d6b0b000000b00313e5f27cbfmr10307005wrw.58.1688974311144;
        Mon, 10 Jul 2023 00:31:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y5-20020a5d6205000000b003145521f4e5sm9813695wru.116.2023.07.10.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:31:49 -0700 (PDT)
Date: Mon, 10 Jul 2023 10:31:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yunchuan@nfschina.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/10] net: atlantic: Remove unnecessary
 (void*) conversions
Message-ID: <494050a5-4bed-44d0-90d0-e76726168791@kadam.mountain>
References: <20230710063952.173055-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710063952.173055-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 02:39:52PM +0800, Su Hui wrote:
>  static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>  {
> -	struct hw_atl2_priv *priv = (struct hw_atl2_priv *)self->priv;
>  	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
> +	struct hw_atl2_priv *priv = self->priv;
>  	u16 action;
>  	u8 index;
>  	int i;

In this case moving the variable is fine because it's related to
removing the cast.  But in the other case it was moving other
decalarations so it wasn't related.

regards,
dan carpenter


