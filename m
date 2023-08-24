Return-Path: <netdev+bounces-30357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3B787022
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2751C20E1F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D592890A;
	Thu, 24 Aug 2023 13:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEFDF6A
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:20:12 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA51FF9
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aeee69de0so4481257f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883167; x=1693487967;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe4qzeSoAEh8ga9tSe70m9ddk5MVjzxFHGdnBBynuDM=;
        b=R/JoQ8E4DU1WjZF81NmUv2L2Gu88tuuDLJRHw1llRzNF1uSJRyWYakW+I2jJzK9O7B
         LOypPgafALn8+sLypvjyesPcS5f+TgYkSvyrx1freZDFIxX/OBQ0fek9WifSEWAc7Xw4
         ogFyiQzM6DTAE5/td1ij92JuZu1Lz9/ll1QoxG9PGiAsRYU/4HN/+QYNJAQN/dEGD8GW
         v1xZxHJgUvWik3mW16Km+VO6vWSqW60O3NVIIn7m9YxnypQLUYWphkdVrK2iW4X3JdS8
         75zYmamo8ZnA5UDLklwB7bcLyxHy3PFNEhaVtT3E1aDppwaStxVE/A8oDWKeG9Nypf+7
         AnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883167; x=1693487967;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe4qzeSoAEh8ga9tSe70m9ddk5MVjzxFHGdnBBynuDM=;
        b=dqD1k6SapvzKHNt2oCWpUJEvTnWUbGqnZm+k4qCrsSSgPKrkMxEl9sAnw8G10Y/ySq
         KZgA7tc+2DA72ZcP43Awc2JR2qZmGwJKZzrhkDjka6gIs26ji8sEYZECHUMlUBv7ObWF
         MfwYfTz8K8cng/EFt8MRnggQOkh37OQjtOk7Ty/0isi4hfzAwrDZ97GS6a2IVdNx+W1r
         icQtGW3+zBd6fZvqUIa8xycjrN33jsXnA/XJzjkDdUYyFml3OjoiP2Cwxt0EF9Goe9p8
         up0kWYvOehqfbzSoWQVPNneXdmx8JdMWWEjqHNmUg1CFTUBksIYP1ruT/1z3xHlOEfkW
         y6Ag==
X-Gm-Message-State: AOJu0Yx6SoUyxMbx0Chz7aTeAukK1kS4go5hdl7/HaeLkMB1B6ExK0V8
	zk8xC+WsXVbIAFcajtLB+G0=
X-Google-Smtp-Source: AGHT+IFkTFQICFoKn0T0f1R7HS/gjeRd0+bDE0sLBpk8j8UtrB2pp+dT376sJDSsaXjnuOkjwyr1Aw==
X-Received: by 2002:a5d:4574:0:b0:313:f548:25b9 with SMTP id a20-20020a5d4574000000b00313f54825b9mr13183327wrc.40.1692883166704;
        Thu, 24 Aug 2023 06:19:26 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c231500b003fed4fa0c19sm2663200wmo.5.2023.08.24.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:19:26 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 4/5] tools: ynl-gen: support empty attribute lists
In-Reply-To: <20230824003056.1436637-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 23 Aug 2023 17:30:55 -0700")
Date: Thu, 24 Aug 2023 14:10:13 +0100
Message-ID: <m21qfsh9hm.fsf@gmail.com>
References: <20230824003056.1436637-1-kuba@kernel.org>
	<20230824003056.1436637-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Differentiate between empty list and None for member lists.
> New families may want to create request responses with no attribute.
> If we treat those the same as None we end up rendering
> a full parsing policy in user space, instead of an empty one.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/ynl-gen-c.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 13d06931c045..9209bdcca9c6 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -615,7 +615,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>          self.attr_list = []
>          self.attrs = dict()
> -        if type_list:
> +        if type_list is not None:
>              for t in type_list:
>                  self.attr_list.append((t, self.attr_set[t]),)
>          else:
> @@ -1543,7 +1543,14 @@ _C_KW = {
>  
>      ri.cw.write_func_prot('int', f'{op_prefix(ri, "reply", deref=deref)}_parse', func_args)
>  
> -    _multi_parse(ri, ri.struct["reply"], init_lines, local_vars)
> +    if ri.struct["reply"].member_list():
> +        _multi_parse(ri, ri.struct["reply"], init_lines, local_vars)
> +    else:
> +        # Empty reply
> +        ri.cw.block_start()
> +        ri.cw.p('return MNL_CB_OK;')
> +        ri.cw.block_end()
> +        ri.cw.nl()
>  
>  
>  def print_req(ri):

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

