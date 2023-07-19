Return-Path: <netdev+bounces-19101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910B759B38
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB681C210DD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F94800;
	Wed, 19 Jul 2023 16:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96F11C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:45:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170391733
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689785095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6d/NTzwM2RqC9pSRkVJyPWGkUYiKepB4u3+/8jlnuc=;
	b=LFf4Z2t33/IaQFE8eFS0coteYTyCe0teCihI00Kq0FK9eU72f1K9ePJnzfWh1khC9mISKH
	j5M2/pSQFvDhUkN53xU7fqPssavlUTOB9bNa0NzuCRhTL5YF0cQrt4y7zhZySAe+IRAwt9
	C4N6gLwcnPxPGehiqVjAlIlmxVwfFgA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-mdLv0YT0MYGZyCLjwoztcw-1; Wed, 19 Jul 2023 12:44:53 -0400
X-MC-Unique: mdLv0YT0MYGZyCLjwoztcw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993e73a4c4fso433969966b.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785077; x=1690389877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6d/NTzwM2RqC9pSRkVJyPWGkUYiKepB4u3+/8jlnuc=;
        b=e6kyalDywOdN7WF89Q7dkxHI2kG7C0pdkpzZnfhtGzc5Y2KWA2qQxJH3p3eOvLyD56
         U3jhsEf+sYEWe67NMoSXzGwS2jPQOwNZQT+L7lmwN9edLwpajFijpD1xPFU2yvRriVde
         hb/wuUIJAEBS8A2z6Yz8Ed35lO81KVyUrQrFHJFbWUTkn5+YHTPQuJ+KpiR3vWqkUyWa
         18+WHYQeWcWDIQqcKjxIaQkk7mF+UFu0GYwrD+pwRSa88WlaRSte8X0ZDFwzQbCHjLWH
         hqZvWmLXbBwCXhK/klSOiCDtuzOxbdT2eF0Orcpj7K3LHhSJXUIKOedkkbS7kI9/IlGD
         yxRw==
X-Gm-Message-State: ABy/qLYBhD1wzNxwkX6NNJxnoSUw8vrGiqhEZe4WbiHQS7U4EiwcYtvA
	8SF9bhTZFIKnQ0s8QhN8FOhagBd8c6nY747ORVDXL4frjRFy2w8qcqRONv5Nh43ZL/e75tIVo4b
	QkRCQK6OoOgTc4XQv
X-Received: by 2002:a17:906:3f1c:b0:991:e7c2:d0be with SMTP id c28-20020a1709063f1c00b00991e7c2d0bemr3181972ejj.63.1689785077400;
        Wed, 19 Jul 2023 09:44:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEit8OaIqk+up6AYCYLvX5G0kaZA6nVIFKbk2BTbUfAqZjOislxIt5OsOoi3f0T9dkxRQEgog==
X-Received: by 2002:a17:906:3f1c:b0:991:e7c2:d0be with SMTP id c28-20020a1709063f1c00b00991e7c2d0bemr3181959ejj.63.1689785077110;
        Wed, 19 Jul 2023 09:44:37 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id ke8-20020a17090798e800b009920e9a3a73sm2564317ejc.115.2023.07.19.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:44:36 -0700 (PDT)
Date: Wed, 19 Jul 2023 18:44:35 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: sched: set IPS_CONFIRMED in tmpl
 status only when commit is set in act_ct
Message-ID: <ZLgS87vz2IF5jf/q@dcaratti.users.ipa.redhat.com>
References: <cover.1689541664.git.lucien.xin@gmail.com>
 <4ffd82b3acc34ebd09855a26eb148fcd59fa872c.1689541664.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffd82b3acc34ebd09855a26eb148fcd59fa872c.1689541664.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 05:09:18PM -0400, Xin Long wrote:
> With the following flows, the packets will be dropped if OVS TC offload is
> enabled.

[...]
> 
> The simple and clear fix is to not remove the exp at the 1st flow, namely,
> not set IPS_CONFIRMED in tmpl when commit is not set in act_ct.
> 
> Reported-by: Shuang Li <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


