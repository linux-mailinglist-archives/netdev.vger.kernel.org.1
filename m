Return-Path: <netdev+bounces-44421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9077D7ED6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE33D1C20EDF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8721CF81;
	Thu, 26 Oct 2023 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebky1cqY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3017D5
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:49:00 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BDB129;
	Thu, 26 Oct 2023 01:48:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so992690a12.2;
        Thu, 26 Oct 2023 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698310138; x=1698914938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7ze34EchX/27SSwpayDxZBsZvdn030bpVJnYH1TN7c=;
        b=ebky1cqYTdlTIu0LpyldbaL/y5WJFR/8ASKi9avgOlHyzoaVdCPdGlSCPyc1st4t/v
         CHQEvLvBXUz88vblFspm/wPJi7kNGAzEawsjU9Eqax1R4vSbYwuPOY1Euf/y/R/Aebrg
         zK/8nLKKiOwo6XMWRByriJLOIfX7U6pLj9WMe1vg6Pn4rlPMQYD2E6BOrWmESqbQ33H4
         EKHjzO+DAxnVd3CCmsLMqA+vD1qyToSKjfOBni7Ull8UgowmBlqsgbbfR0ib2beimD3n
         ECBkT8PJTYLi+B8piH1Jw2Wgm/U1H2t8EcUK8b+MfJbEtJXFIZPp46M8CZ8NqK65InkH
         PoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310138; x=1698914938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7ze34EchX/27SSwpayDxZBsZvdn030bpVJnYH1TN7c=;
        b=B6f9NdArYwms4/qfuwhY2wvG57TLVSMZotNA0kTp6v+GykIFH6lteEdtF9/BrCP2z4
         4Aq1vU08qVJymPZ5yTBO69nR97ZdpJxixccHhPQLZexGUxAVZoQ3Kqc6BAxng4gwh3+p
         Sq+WPCHu9Z1QTV9h8bTksvLuuRWm41WedaMkYRP6BAl9f3EGhXLIaVUGkeKIHSpMLY6J
         Gl74XkE/vIKkwdH8Gchea8sGoMZdqEk+yNyoR2TYNrAmGwlLnL/fUoyLXFYtMvJCZwjr
         wWSbtQ3NHUD3mKSeMJ+SnaDvnWRMp37V9Xt341/UZ6xh3rvcyJcl27+eV947Woq9Gouo
         D8Tw==
X-Gm-Message-State: AOJu0YzDzz1OCx+M2CGBTJCvCSizwu+94rswuj6VOtCZbfKs4+Vb2yUs
	cIRbZkuox+sz7RFMR95MEQ6AMZxReMdgAQ==
X-Google-Smtp-Source: AGHT+IELWK/AXGrWy9ydyRdEnqCeROKTMQt9o+/7nV3eJfjMQmTC5ijntEY7PFCGAparxz0sgFH69Q==
X-Received: by 2002:a05:6402:3552:b0:540:b95b:6ecf with SMTP id f18-20020a056402355200b00540b95b6ecfmr5292807edd.7.1698310137941;
        Thu, 26 Oct 2023 01:48:57 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id if5-20020a0564025d8500b0053f10da1105sm10936161edb.87.2023.10.26.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:48:57 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:48:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling mistake
 "Enery" -> "Energy"
Message-ID: <20231026084855.mfrqnzfk3uulwy5o@skbuf>
References: <20231026065408.1087824-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026065408.1087824-1-colin.i.king@gmail.com>

Colin,

On Thu, Oct 26, 2023 at 07:54:08AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

If the patch is 1 day old, please also copy the original patch author.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/net/dsa/microchip/ksz9477.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 2534c3d122e4..b102a27960e1 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -83,7 +83,7 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
>  
>  	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s\n", port,
>  		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
> -		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");
> +		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
>  
>  	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
>  }
> -- 
> 2.39.2
> 

