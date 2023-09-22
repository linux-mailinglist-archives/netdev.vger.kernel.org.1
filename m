Return-Path: <netdev+bounces-35789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3E7AB11D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0FB78282CB6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210E200A0;
	Fri, 22 Sep 2023 11:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF71F930
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:43:56 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B40102;
	Fri, 22 Sep 2023 04:43:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so270672566b.1;
        Fri, 22 Sep 2023 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695383031; x=1695987831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I3gNmUlZMGbKyjyOXpthLU4hKIFkiFyB/Tjb6zLBfA=;
        b=OL3deMoZ6Wl2Q5FwHCv3eZXPpK0Ri4tJq5EVxYMrIHfyt4fXJQMFYGTimVuMuM4PJm
         o6tVMiPKcbZESdZymIOBToj9xtXCjY7uldAm7T/zEfqjYX/c6Glg5KWOvpVPqiO+AhVg
         0hFLGW4g83ETBrxoToora7NHg+Zle5TdNcn3hUt6qkKakzhd05sazER8Yw/DaEYt0du9
         r52Uc+b2a1tnPO5QUtBQMrxfrGaLdYtTPdX0wWlZdfgKZQg1g9ai/DKipz2C9DlYVnUD
         pLWlYUBoZNJUDLUsp3poEVnJTbePuDOXNNORQ0/anIIZ03aHcx+PRCsCEtwXDQ+RG/DE
         Nckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695383031; x=1695987831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I3gNmUlZMGbKyjyOXpthLU4hKIFkiFyB/Tjb6zLBfA=;
        b=aH5SAM0vR7lyRh603/kPJ9/AiZB7RzH4kfZ6Y+Vttxb7a6vraKEaad5+bqqe4c3iF7
         t4SFZ5F2mSCttek9/z4Z/B1wYSXUqvBHKo+GYZibvukizMp/fe2SBsvOVGIzr592SVCR
         Pt6z60DIxO+t/j53ixMPazgEvZ2FUzcEhkaFGNrRNz98SYGgmmR0mkb9xAqb/4kYr/q6
         KeF1WvG4+wsLB8FLPiiX2ipiXsfTuXr8RwSat8pYYVLx1oZBjocvIOfG7hAP0A6pKV/w
         lPF+sYCVUfveQC6TWkB18kySpoDLZDUQ5GKpYvRSmXfbz/H7tutEZL+2S8uCFhrn3QYE
         yJvQ==
X-Gm-Message-State: AOJu0YyMSQPiUjHhOumInYM4NRqUnuzzCOpW9Ld1jTytzd+DB1oZzHDr
	J0xY8pwd1vlfTp8FZ8WKhY8=
X-Google-Smtp-Source: AGHT+IHbAXqA0Cb2XWyQ2fjc+0jrFxYIM22/f7Ic2xZbRFXNDej9vFnrqWPJSAAS359M2c/RD7DCkA==
X-Received: by 2002:a17:906:109:b0:9aa:e07:d421 with SMTP id 9-20020a170906010900b009aa0e07d421mr7270525eje.43.1695383031474;
        Fri, 22 Sep 2023 04:43:51 -0700 (PDT)
Received: from skbuf ([188.25.255.147])
        by smtp.gmail.com with ESMTPSA id f12-20020a1709062c4c00b0099ca4f61a8bsm2618242ejh.92.2023.09.22.04.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:43:51 -0700 (PDT)
Date: Fri, 22 Sep 2023 14:43:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v5 net-next 5/5] net: dsa: microchip: Enable HSR
 offloading for KSZ9477
Message-ID: <20230922114348.ivbfcgi7lkmcsymp@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
 <20230920114343.1979843-6-lukma@denx.de>
 <20230921193224.l3ojpdcsb4bpfl7d@skbuf>
 <20230922132904.750688b6@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922132904.750688b6@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 01:29:04PM +0200, Lukasz Majewski wrote:
> Unfortunately, yes...
> 
> The code as it is now -> would set for port lan1 0x21 and lan2 0x22.
> 
> However the setup shall be 0x23 for both ports.
> 
> More info here:
> https://github.com/Microchip-Ethernet/EVB-KSZ9477/issues/98#issuecomment-1701557449
> 
> I will setup this register from dev->hsr_ports when both HSR ports are
> known.

Testing after making changes is key.

