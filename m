Return-Path: <netdev+bounces-19614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634A75B6A5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F0E281D93
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381219BC6;
	Thu, 20 Jul 2023 18:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713A19BC5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:24:21 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DA2D5D;
	Thu, 20 Jul 2023 11:23:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d20548adso911720f8f.0;
        Thu, 20 Jul 2023 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689877438; x=1690482238;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx9RtKQ03Nd1GuwyZE0noO7TOti2z3ne8no8zAe784s=;
        b=jmdcc9prvj3Nk1J8/5XJfiTTkfWYn+BjtTwbUnUVLt1Ytq69Ux/NMf0BQdehKwxqKN
         uKi2uUicZtqCUOMh4KB7s91FSaO1IQCYaYUAz4gJ3tHvz6FJT+SNmNn7lg30vlEKXgpf
         Ti6iXqU1ex9KpgnjF61O36t5WTsPOs2j4XzpipW6qsE0AclZQ/+d5r0zEENIhL4SUDLK
         pAxBbSDZ0gY/cYNcl7zXioy/ZNAdCz8I1vcQrSk5dvqenGJXh/WGv8LlApTZfMg6sxdi
         TyCglpVeDQPTBCB/zcM9V4r2miNmJoqlYzn0mtX2NSzFeniY23+XVe6DCNEeJd+CgRhT
         OefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877438; x=1690482238;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tx9RtKQ03Nd1GuwyZE0noO7TOti2z3ne8no8zAe784s=;
        b=jcx4SejeuNyxCdVhy4XPH3HZQqbZfIHyk1zkhj/BMqnKrQ8pGk7+1oKzTd67AmciEA
         u9fVBWAMkMko6pGwhtteT7DseEJqn3XXecjkQa5wAlSbvrmnwZf7P66yWjiPDUiCQLWy
         XflMZnn/UIo0+IXXXgIU49azFX8Exzg97DXpxGE5CHQp8nGh16i1LY/jcRTG0ZDCp6fJ
         gDzTYi92iyeu+3W9uEo+knzKuEG5aQ9YI4yPM4MaWfY6X9rJz36Dz9AZdia8ovm6XJpn
         3hrIJXjCNTld2PBoQ//V0EC8PEy0xeezUK+ZmCW2Vo+HUsGdZxksizQGzz4OV7Fg6fpx
         rymw==
X-Gm-Message-State: ABy/qLYjx1PD0CGGc04nqvH0CSQiu17cJs6ayom1hQkGmz1ocLYrg10h
	oJTdRedKaYnYnO68AimeDZA=
X-Google-Smtp-Source: APBJJlHyoNH+nfkRuS5hV4IuhlxA0HDhX7nfF0PQfFOI23Z58N69P0JU+5GuxGGQqDB+ciUQvGtasw==
X-Received: by 2002:a05:6000:ce:b0:317:1911:fd7a with SMTP id q14-20020a05600000ce00b003171911fd7amr2750481wrx.12.1689877437799;
        Thu, 20 Jul 2023 11:23:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b003140f47224csm2004755wrk.15.2023.07.20.11.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:23:57 -0700 (PDT)
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
To: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc: Andrew Lunn <andrew@lunn.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
 benjamin.poirier@gmail.com
References: <20230719183225.1827100-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <50164116-9d12-698d-f552-96b52c718749@gmail.com>
Date: Thu, 20 Jul 2023 19:23:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/07/2023 19:32, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Thanks for writing this.  One question—

> +Reviews
> +-------
> +
> +Maintainers must review *all* patches touching exclusively their drivers,
> +no matter how trivial. If the patch is a tree wide change and modifies
> +multiple drivers - whether to provide a review is left to the maintainer.

Does this apply even to "checkpatch cleanup patch spam", where other patches
 sprayed from the same source (perhaps against other drivers) have already
 been nacked as worthless churn?  I've generally been assuming I can ignore
 those, do I need to make sure to explicitly respond with typically a repeat
 of what's already been said elsewhere?

-ed

