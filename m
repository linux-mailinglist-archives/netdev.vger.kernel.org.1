Return-Path: <netdev+bounces-30077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A83B785EAB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999D51C20C8B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F441F180;
	Wed, 23 Aug 2023 17:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F261ED43
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:33:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8B10C4
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692812032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1e7WPAoZS1Q25k5aGNu5ghcYVzyvCwh6N9VAdHsIss=;
	b=YQJuXJxUy5Lhqhwuv6f7ePj2XKUb0xWMum3bfsHonqXvJsXA0CXzlAoIUQqQxfO8S1fE8H
	TdCPa+H5iYYX/UyuD8zod1KBBtKdCcutv4DypYOBdSydw/jSfW3oMZJyyjhYJtfhxu4jdh
	zPtZu5VMH8HoBpbSyDJcurtmr/nkf74=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-JKzyP4YxMmaeoN72mim9zA-1; Wed, 23 Aug 2023 13:33:50 -0400
X-MC-Unique: JKzyP4YxMmaeoN72mim9zA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31aef28315eso2527915f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812029; x=1693416829;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1e7WPAoZS1Q25k5aGNu5ghcYVzyvCwh6N9VAdHsIss=;
        b=KgfDdRuOhxzj9cobB0pW/CPcwrFhC0Khl3MT59m2rNP6dZPomDw2gpsyt+8h8rHXNY
         WjOGF218/83vwzmaTsRpm24BHp+iaSh6rPwBm54pqaDAsOsZlC/xiVggpvibYo3/S5Zl
         PBIJBU97GYrNaWrn4kSHKX4N19JOJNEKWUgLHVEjamV6o03GGL/x2lOteD9TfwJIXldg
         aSFryT8tkzzHzfuxgaHyirbz0Sizb7/NHjsYnFltr/ay7jTT6wAB1LfffoBkuucyz+vJ
         oYE3FhVBS0MDuwxL9pSAMFvCk9CcAi57Z9LQylt7ymY7dPCUjUDXYNh6uazECCteLQEx
         7uVQ==
X-Gm-Message-State: AOJu0YxcAUBmHEMK0EL6vCf/D6WIFz2ai1lTDjhylPBp2N+M3dJ244lo
	H7EomnBaEePChZvDp1HXYQQpRTGeBJvdZmZqy4b7xDEmHZqBgjz9jIQMpoimOKP1EqLIFY2yFPg
	YpJAYerk2bKFMiWEShCMYtbQrpk3Z5JEW
X-Received: by 2002:a5d:6a4a:0:b0:31a:e6bf:9032 with SMTP id t10-20020a5d6a4a000000b0031ae6bf9032mr10009687wrw.4.1692812029554;
        Wed, 23 Aug 2023 10:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKlYVUokmq+5Exa9fhMwJu6RFGMPZiLn0PF/WUT83/jsXDEPsZb7/4LBqxEFA88iKXh/fd8KWIr1soIy1fIHI=
X-Received: by 2002:a5d:6a4a:0:b0:31a:e6bf:9032 with SMTP id
 t10-20020a5d6a4a000000b0031ae6bf9032mr10009672wrw.4.1692812029227; Wed, 23
 Aug 2023 10:33:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Aug 2023 10:33:48 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-3-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230819163515.2266246-3-victor@mojatatu.com>
Date: Wed, 23 Aug 2023 10:33:48 -0700
Message-ID: <CALnP8Zbq4puMU4-9EgTbJYn2MPiBc3Ygpaxnhmh-pqmDX7rXDA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net/sched: cls_api: Expose tc block ports
 to the datapath
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	pctammela@mojatatu.com, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 01:35:13PM -0300, Victor Nogueira wrote:
> The datapath can now find the block of the port in which the packet arrived
> at. It can then use it for various activities.

I think $subject needs a s/ports//. Because, well, the patch is
exposing the block, which contains the ports.. The first sentence here
goes along with this rationale.

more below

>
> In the next patch we show a simple action that multicasts to all ports
> excep for the port in which the packet arrived on.

"except"

>
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/sch_generic.h |  4 ++++
>  net/sched/cls_api.c       | 10 +++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 824a0ecb5afc..c5defb166ef6 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -440,6 +440,8 @@ struct qdisc_skb_cb {
>  	};
>  #define QDISC_CB_PRIV_LEN 20
>  	unsigned char		data[QDISC_CB_PRIV_LEN];
> +	/* This should allow eBPF to continue to align */

Not sure if this comment really belongs in here. Up to you but it
seems better suited in the patch description. Hopefully the next one
won't do something like:

 	/* This should allow eBPF to continue to align */
 	u32                     block_index;
+	/* This one too */
+	u32                     my_var;

:-)

> +	u32                     block_index;
>  };
>
>  typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);


