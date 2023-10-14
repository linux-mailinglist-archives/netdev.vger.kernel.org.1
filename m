Return-Path: <netdev+bounces-40971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F627C93C3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738FFB20AFC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E426FDF;
	Sat, 14 Oct 2023 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkG7/6rc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F163B0
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 09:27:33 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF5AD;
	Sat, 14 Oct 2023 02:27:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40776b20031so8136525e9.0;
        Sat, 14 Oct 2023 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697275650; x=1697880450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yqjTtNujnWMy88VPNV8UrR+LdaZ9WG6NKz13qE7MTmE=;
        b=EkG7/6rcELYTWZdbyasOiyeX9cnKK/pl8B9uTCLQOUCHXPBumMWycoQQu8iYdN4+rQ
         L8j8FdASQQPqlAp4oVRZtkVKXDh2HOPsBk6hKr0lgdCk/AWN8/Vicf4Et5h4QyxK9abw
         9JuZyVbaz5AwmpaLnuNzj0kF3liKt/WHlU9EvACk7y9HRXd5WxlDC3r4DekuC9Fo3mms
         6N4fOZl7oeHZEolDuxxktGgKdPX4CudeKCjKL6Ij1JwQl72Y2MVTTZ8XDFdldfEiCfHt
         Oia8AzUgSD3VRQgCVOcOGYzo8K+H7XBlgQBnYVK58sAC2waeZwBJUb2gzR57tXIKNPXV
         cvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697275650; x=1697880450;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqjTtNujnWMy88VPNV8UrR+LdaZ9WG6NKz13qE7MTmE=;
        b=UHYsWodLO9EZCadEaH6DvEvgXtICuNXz2KXIFc3MciuP4C53W7kZBcTfPjPGur4pr1
         nvpJ18sBijvHL/WzhdnjL+OPC6fRuDICLM7p+cyibEaWphR4fPhMLDv3qH1w/pns41VC
         tEP5ElilzxGIZP5QNmJhMY87eZirRB/hSAzXXBYzM2eFhh6oeG/dkDY2sJ6/ml1UEBJe
         8cx9qA8KbHTCPbbVwcTl4JKloSUkfz67FV97I8QjE5BW6tmZaCKkVmBYFcYtJBDhDTXF
         wt7unyEywxLQB4koRWwcuMNbOgIy1SMmo/lbCLG3jvrdkJJUHC6KA7NkLh/2h9UXpef1
         uzUA==
X-Gm-Message-State: AOJu0YwgJqsBnmoditjDdptyhDxbt2HcJ7bw5JYbYzRDfAsOln2aOOzd
	FxG2ttGTHAlPwwLomZtOyLc=
X-Google-Smtp-Source: AGHT+IEKzWJbvz9sdajMP9sZmmvJ1GgbFvXL53QYeHYszED8GAmWTvoPfVlS7CXVxkH04Co8ImitsQ==
X-Received: by 2002:a05:600c:3544:b0:407:39ea:d926 with SMTP id i4-20020a05600c354400b0040739ead926mr18548553wmq.9.1697275650125;
        Sat, 14 Oct 2023 02:27:30 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b004077219aed5sm1514878wmb.6.2023.10.14.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:27:29 -0700 (PDT)
Message-ID: <652a5f01.050a0220.6635d.5a6a@mx.google.com>
X-Google-Original-Message-ID: <ZSpe//2oYu6+cZws@Ansuel-xps.>
Date: Sat, 14 Oct 2023 11:27:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Raju Rangoju <rajur@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: stmmac: move TX timer arm after DMA
 enable
References: <20231012100459.6158-1-ansuelsmth@gmail.com>
 <20231012100459.6158-4-ansuelsmth@gmail.com>
 <20231013181305.605fc789@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013181305.605fc789@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 06:13:05PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 12:04:58 +0200 Christian Marangi wrote:
> > +static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue
> 
> missing comma at the end, does not build :(
> -- 
> pw-bot: cr

Sorry for wasting your time :(
Having to port this between 6.1 and net-next and it slipped in while
fixing the rebase conflict. Totally my fault.

-- 
	Ansuel

