Return-Path: <netdev+bounces-30032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E37785B1A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120E428130B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4AC130;
	Wed, 23 Aug 2023 14:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7D9448
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:51:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5EE6A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
	b=blhen4WNWI9yf9U4FAra/gvRsZZT9eTnzlIK214su0rKtdvGJp59gGFLVwcepjm5tGfz/c
	Cj0EcMf1JCByjXv+GyWu+fjq2r690QNKA6QQwwo4uu5lROCz+tiLBGBeipCWwp0EQRMknp
	VXkP/h+3admA+WNYbvKlUKuebXdCecQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-bXg5Lu_aPFeEbSxZVwuytQ-1; Wed, 23 Aug 2023 10:51:45 -0400
X-MC-Unique: bXg5Lu_aPFeEbSxZVwuytQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe1cdf2024so36395395e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802305; x=1693407105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
        b=fEexnPWJ11eqhKGYwRb1uOj7q868Y8fmWBYI2x50rOj0W2lY98u5Pk60toYMeaFnlz
         XZB6DmD8ZPmdPnFj6uUGnH+QSDSa4aKLYhF1tC/j7yKTgNUKGn3onkGond6hxBUZ0BVl
         Hj4aSbzU7os48Lv9GE8Bna0WPhUKY/xypDvPm6jvqU/UyJNIRlCPMelk+wb3iM9kt5ek
         IA4lhQFttX4EwzNFKWylbTni5dFak8/KyPrTQOqbUBrFCRDYRTi8/b83MFV4foHvlEjy
         50cyc0yY8Gs68JyfKwoyMN6VF5SHPpwciD1WqAaBIx8x0vFV2REaVcftneWFNtDctUzg
         1rkw==
X-Gm-Message-State: AOJu0YzccRGqIJRL9fKetNiXvuaFSqoapJsz8YqbgrGF55dedJ6IeznE
	9esROPOQSuruGoDZkoibyrnZHxP9/yt9nA6gQ1dNfjxrO1L5/3wwvI6mPFkVWjSOyqiRas7ETaq
	0czCZpM/e4fYjg8yZ
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8627005wml.14.1692802304780;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnVRBi8PK6/x0AzFBEPxF4kWcVG572OSwM5kYFDDA4dIEo8xQwVJCkjQc8s2Db/MeOg5WnoA==
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8626984wml.14.1692802304433;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
Received: from debian (2a01cb058d23d6007d3729c79874bf87.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7d37:29c7:9874:bf87])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003feee8d8011sm11525804wmi.41.2023.08.23.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:51:43 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:51:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org,
	Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: Re: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZOYc/Uhb0RSUvi47@debian>
References: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 03:41:02PM +0200, Nicolas Dichtel wrote:
> The goal is to support a bpf_redirect() from an ethernet device (ingress)
> to a ppp device (egress).
> The l2 header is added automatically by the ppp driver, thus the ethernet
> header should be removed.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> ---
> 
> v2 -> v3:
>  - add a comment in the code
>  - rework the commit log
> 
> v1 -> v2:
>  - I forgot the 'Tested-by' tag in the v1 :/
> 
>  include/linux/if_arp.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> index 1ed52441972f..10a1e81434cb 100644
> --- a/include/linux/if_arp.h
> +++ b/include/linux/if_arp.h
> @@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>  	case ARPHRD_NONE:
>  	case ARPHRD_RAWIP:
>  	case ARPHRD_PIMREG:
> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
> +	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
> +	 */
> +	case ARPHRD_PPP:
>  		return false;
>  	default:
>  		return true;
> -- 
> 2.39.2
> 


