Return-Path: <netdev+bounces-19093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2DF759A71
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80EB280F6D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AA3D3A6;
	Wed, 19 Jul 2023 16:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314F11C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:07:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736B1B6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689782849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7X/dXlu7cqEenBHZP4o3K8KNowVJyRMC9f7SDWfDNU=;
	b=YrLVau2wxza4bWZtUM85UhCVaXMO+qKcTXiYKRzulnU3n5z073qkEIjRYFR6K/3pOa5t4M
	gv6ki+7I7nhX8pdmAh16JfkCW+oTLiK4d7vYrjXZ0BKEgn42zZP6WK9IK4CveErE1UZzX8
	dIlc5Iu3RjPjI4Y6nWEBql2YtNCjpdM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-K8QH0uWmPKqZ311qJXQtBA-1; Wed, 19 Jul 2023 12:07:26 -0400
X-MC-Unique: K8QH0uWmPKqZ311qJXQtBA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5302E280D20B;
	Wed, 19 Jul 2023 16:07:25 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B61B492B01;
	Wed, 19 Jul 2023 16:07:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  davem@davemloft.net,  kuba@kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B Shelar
 <pshelar@ovn.org>,  Jamal Hadi Salim <jhs@mojatatu.com>,  Cong Wang
 <xiyou.wangcong@gmail.com>,  Jiri Pirko <jiri@resnulli.us>,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Florian Westphal <fw@strlen.de>,  Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>,  Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 1/3] netfilter: allow exp not to be removed in
 nf_ct_find_expectation
References: <cover.1689541664.git.lucien.xin@gmail.com>
	<74bd67f806666fd9a3975ae441c308128409ea32.1689541664.git.lucien.xin@gmail.com>
Date: Wed, 19 Jul 2023 12:07:22 -0400
In-Reply-To: <74bd67f806666fd9a3975ae441c308128409ea32.1689541664.git.lucien.xin@gmail.com>
	(Xin Long's message of "Sun, 16 Jul 2023 17:09:17 -0400")
Message-ID: <f7t8rbb7umd.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> writes:

> Currently nf_conntrack_in() calling nf_ct_find_expectation() will
> remove the exp from the hash table. However, in some scenario, we
> expect the exp not to be removed when the created ct will not be
> confirmed, like in OVS and TC conntrack in the following patches.
>
> This patch allows exp not to be removed by setting IPS_CONFIRMED
> in the status of the tmpl.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

LGTM

Acked-by: Aaron Conole <aconole@redhat.com>


