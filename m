Return-Path: <netdev+bounces-14558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544774264E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB31C209CB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E114ABB;
	Thu, 29 Jun 2023 12:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6011C87
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:25:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335AF1BE8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688041540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo3tdImAdzQt1bSg9dpIf8+/mvpWr7Q4kdLME5s0JGA=;
	b=CuR3eE8c+ZWkhDX3VqvEg/6dCqdk/XBrvFle0exv1G78PV9SmVhAIuszUhQwmJIHiPSsL0
	j0qFaya5YfqJasjSN0ZiSza2PXpioTFzVA6JMzJYHTB1ZFWz99l3yRJHVrzeCw9pBa5Uf4
	pH5hnU9wxOgaSf2NpyaBrWa56MVMYWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-djrDPkmHOHKgzNx0mhoZcw-1; Thu, 29 Jun 2023 08:25:37 -0400
X-MC-Unique: djrDPkmHOHKgzNx0mhoZcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7533680123E;
	Thu, 29 Jun 2023 12:25:36 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.32.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C496C09A07;
	Thu, 29 Jun 2023 12:25:35 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Eric Dumazet <edumazet@google.com>,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  shuah@kernel.org,  "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 0/4] selftests: openvswitch: add flow
 programming cases
References: <20230628162714.392047-1-aconole@redhat.com>
	<ZJyUoSaklfDodKim@corigine.com>
Date: Thu, 29 Jun 2023 08:25:35 -0400
In-Reply-To: <ZJyUoSaklfDodKim@corigine.com> (Simon Horman's message of "Wed,
	28 Jun 2023 22:14:25 +0200")
Message-ID: <f7tjzvmmp4w.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <simon.horman@corigine.com> writes:

> On Wed, Jun 28, 2023 at 12:27:10PM -0400, Aaron Conole wrote:
>> The openvswitch selftests currently contain a few cases for managing the
>> datapath, which includes creating datapath instances, adding interfaces,
>> and doing some basic feature / upcall tests.  This is useful to validate
>> the control path.
>> 
>> Add the ability to program some of the more common flows with actions. This
>> can be improved overtime to include regression testing, etc.
>
> Hi Aaron,
>
> sorry but:
>
> [text from Jakub]
>
> ## Form letter - net-next-closed
>
> The merge window for v6.5 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after July 10th.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

Thanks Simon.  I skipped looking at the ML this time and used the site
setup for random German tourists:
http://vger.kernel.org/~davem/net-next.html

I guess I'll stop using it and just check the ML as normal :)  Sorry for
the noise.


