Return-Path: <netdev+bounces-22982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B488476A487
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992101C2091E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D851E538;
	Mon, 31 Jul 2023 23:09:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D21E502
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:09:34 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62E1BD7;
	Mon, 31 Jul 2023 16:09:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b30c7377so27948551cf.1;
        Mon, 31 Jul 2023 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690844970; x=1691449770;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kO3L0ytrxVYNBLqwpAPV0dlFfKaVuZu/hK4nzSzzOY=;
        b=ArSz2NreawND8tZ7x8CoGw3GUy7PbWGw2+X2lTSBRr+WGBKEsl/80cG5cNFpb+6158
         4gEe26+QIVjZf13/2w9vKPCf7GuFcYB5ERXi9bz9qY0W0o36t/3BOa7bd29KI3sUvH5W
         +u4HATk6Bh4FOudE31fKcu/X2A6B0T81rUZPcyAFS2BvLzVqYXQCtJmk/7HTCYcmjXBY
         zQphWdGRAZs5apipJRP6JS4oTc9fEnmh6qPXjWWNjuBrjH4afTs7FiiRzUZGtVVE69yi
         kOC5yTdomL/PohTaowKD2o6eL3FaxNk25ILSWvLYYG9SRpdHkuUsstXkqnJm3N5RuJSy
         Fyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690844970; x=1691449770;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kO3L0ytrxVYNBLqwpAPV0dlFfKaVuZu/hK4nzSzzOY=;
        b=KC3DW464PFwR4oVTJzSWGGjnCCIkfcQ292qXQu6e19ijYTFeAw7O8VuUF4DzJZzdnT
         uovZshiMF00uVTimihctxmeJccRzMKnWdvZnIT/FSP+lP18S1eBP6PX1lc0JVxLAhZ1C
         HcNRk+UinQ+mjQgKr63JneywCXL7YfGpCKrc2ltbpmDt/L66VTjrllV0hdO+LhjAvdCP
         FW8PoMrGx1x1+HjHClD3OGEiDFES5DMIyzUdDu6nJzMzNvrtmAEqCpEHZbus6YQreBbw
         gJy3GdaVELFToLFicHGQad8H2M7zFq29X/shjnfGd4ooa9IX45KcQPM4GfpDjR3e2hSv
         PjsA==
X-Gm-Message-State: ABy/qLbGalx91HTxYP6ecNmWdYvL+vGwugTBjwcd9gnQchlJ4eO82qHL
	3BKDCdUER4+Mg5uR1smsYVY=
X-Google-Smtp-Source: APBJJlFHBtztdKD+2gJCwTLu4PI6FbwHH5IMJbWWjIOxgupndKdUT3+PLwWEG+w2HjV4Pf1yZCAlQw==
X-Received: by 2002:a05:622a:11cf:b0:400:a5de:172 with SMTP id n15-20020a05622a11cf00b00400a5de0172mr14092974qtk.4.1690844970036;
        Mon, 31 Jul 2023 16:09:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d7-20020ac86147000000b0040399fb5ef3sm3984507qtm.0.2023.07.31.16.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 16:09:29 -0700 (PDT)
Message-ID: <75f66d50-3bc5-5c39-1478-0e835ba4b899@gmail.com>
Date: Mon, 31 Jul 2023 16:09:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v3 4/5] net: dsa: qca8k: move qca8xxx hol fixup
 to separate function
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yang Yingliang <yangyingliang@huawei.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Atin Bainada <hi@atinb.me>, Michal Kubiak <michal.kubiak@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
 <20230730074113.21889-4-ansuelsmth@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230730074113.21889-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/30/23 00:41, Christian Marangi wrote:
> Move qca8xxx hol fixup to separate function to tidy things up and to
> permit using a more efficent loop in future patch.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


