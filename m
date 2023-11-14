Return-Path: <netdev+bounces-47660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A577EAEC6
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E0FB20A79
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D222EFE;
	Tue, 14 Nov 2023 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLbOp/7B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1131F176
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:26:00 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE13CC
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 03:25:59 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso71931281fa.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699961157; x=1700565957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJjjImeTrPnGFwJKi3DEK+//Y6PKNxHHYUkeNZMR2FQ=;
        b=fLbOp/7BnyfjlNf5OieqtJSjt7htwTlXbsY2tWd/rRJIBCqE46I2GkUs4M2V8uJ2RD
         K4608gUIR8OFjQKT6ki8n8pvjDtKHav0l9O9hhSSKFomvuWTJXW6GAC/aZmGJPe/aYKQ
         AUkaDxrAdJ0pbQv5RfLygZ29Jph3IOfiwz5+1eEZUc+reUzhgnlcoYxq8hy+ti/8/ihW
         hW8FaRjWxuYtFmw7hAbCsZY7Tm8gQ73RpQeedYe5sRA5X/FthSIslpC2ERIJpK/kVFGZ
         nHvbJSWOrHPk/gMIx9lBBFHGmBwkhZrsl6OE2ahyDFWgm4nxvpYeOX1uQDCGth+GYcT6
         SJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699961157; x=1700565957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJjjImeTrPnGFwJKi3DEK+//Y6PKNxHHYUkeNZMR2FQ=;
        b=KV72Ch8Kf3T7rQS3vIUbxbW/tu0RpwMd46UUt+5w6wQKeqUqhCQNrhKkCW/C3SDhrA
         UrnNSZEkpvjjrXX3G1b1h19u6xc9LEmmk9OiO/wn1qCQdhvzxrKk8S7AYUQ23WcxQRvL
         tU6txckWyUbGon4yGkVZcXhmvcHtIhpxl0KyUKE15G18M3D26v+NZ35CstlWKa2ej2sA
         mHB8ld8G3mRBfaG6QN2uG8AhbuK43OHHm9w4nPyM1hgP/ea6iwWWV+vPu4EmjvpcxzVs
         exJzrTVqN3zCZgSgT3bHyK06/wYT1/maL0AVVgvKs4FVgw+kOAE9v+HIzSMnpOPXKZ35
         IOjQ==
X-Gm-Message-State: AOJu0YwhGOFu7Nc3gSUEt4qBz6IigzoODAWEFADak4HWLJZDgXCDMbB3
	zTg8yIZN0W2RHR1PS/VyisE=
X-Google-Smtp-Source: AGHT+IHCiIYyD7OSwv+FcDnQl+sMVYpGFNNghuAs72u5NvtwbUcOp8cx4d1yz0bcSQnI/lMmze1+3A==
X-Received: by 2002:a2e:3515:0:b0:2c5:55a:b6b5 with SMTP id z21-20020a2e3515000000b002c5055ab6b5mr1501550ljz.28.1699961157052;
        Tue, 14 Nov 2023 03:25:57 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s22-20020a2eb8d6000000b002c0336f0f27sm1286453ljp.119.2023.11.14.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 03:25:56 -0800 (PST)
Date: Tue, 14 Nov 2023 14:25:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: stmmac: fix rx budget limit check
Message-ID: <3enhwmz5sfuj6wb2h74xamyjsihiy4fagklqre7tojbwprnuib@t3w7ykzvofqx>
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>

On Mon, Nov 13, 2023 at 07:42:49PM +0200, Baruch Siach wrote:
> The while loop condition verifies 'count < limit'. Neither value change
> before the 'count >= limit' check. As is this check is dead code. But
> code inspection reveals a code path that modifies 'count' and then goto
> 'drain_data' and back to 'read_again'. So there is a need to verify
> count value sanity after 'read_again'.
> 
> Move 'read_again' up to fix the count limit check.

Nice catch! My local fix was to just drop the statement, but obviously
it was wrong. Indeed it's possible to have an implicit loop based on
two goto'es. So for this change definitely:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

From the patch perspective seeing how clumsy the
stmmac_rx()/stmmac_xmit() methods look here and in several/multiple
other net-drivers here is a question to the subsystem maintainers. Is
it really a preferred practice to design them that way with gotos and
embed all the various stuff directly to a single function? Wouldn't it
be better at least from the readability point of view to split them up
into a set of smaller coherent functions and get rid from the gotos?

I am wondering because normally it would be indeed better, but network
subsystem may have some special requirements for such methods (if so
is it described anywhere in the kernel doc?), for instance, to reach a
greater performance by not relying on the compiler to embed the
sub-functions body into the denoted functions or by using the gotos so
not to increment the loop-counter and preserve the indentation level.
All of that may improve the code performance in some extent, but in
its turn it significantly reduces the code readability and
maintainability.

-Serge(y)

> 
> Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3e50fd53a617..f28838c8cdb3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5328,10 +5328,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			len = 0;
>  		}
>  
> +read_again:
>  		if (count >= limit)
>  			break;
>  
> -read_again:
>  		buf1_len = 0;
>  		buf2_len = 0;
>  		entry = next_entry;
> -- 
> 2.42.0
> 
> 

