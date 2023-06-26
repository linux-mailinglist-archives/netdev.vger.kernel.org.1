Return-Path: <netdev+bounces-14044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C073EAC3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B661C209C5
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284A125AB;
	Mon, 26 Jun 2023 19:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB3D505
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:00:05 +0000 (UTC)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85710D5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 11:59:57 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qqcbb3j51zMqHtw;
	Mon, 26 Jun 2023 18:59:55 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QqcbZ4T7mzMpvTt;
	Mon, 26 Jun 2023 20:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1687805995;
	bh=Rp8e/1RLaJ/xuqp2uYfEReDbnGzeQ5DGvewG/zWsFBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VPR0HlK1nc9903KzRFaGnqZer/CQ0zCy2kFFF+lh2wpFH2ymZL1IbR9MMIBaolGjz
	 0WmeQ6p+F8Dl4S+xFBfmVel3m+gq7wXuScNBDRvshV7z1GJ6J7k0euWiWHAtVwZEZ2
	 qusN8URnhgyroKm+MvsEpsB5Ov5q7EYS/7rGZjd8=
Message-ID: <524f3c11-f228-1519-451f-c992bff8be79@digikod.net>
Date: Mon, 26 Jun 2023 20:59:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent:
Subject: Re: [PATCH v11 12/12] landlock: Document Landlock's network support
Content-Language: en-US
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230515161339.631577-13-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 15/05/2023 18:13, Konstantin Meskhidze wrote:
> Describe network access rules for TCP sockets. Add network access
> example in the tutorial. Add kernel configuration support for network.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
> 
> Changes since v10:
> * Fixes documentaion as Mickaёl suggested:
> https://lore.kernel.org/linux-security-module/ec23be77-566e-c8fd-179e-f50e025ac2cf@digikod.net/
> 
> Changes since v9:
> * Minor refactoring.
> 
> Changes since v8:
> * Minor refactoring.
> 
> Changes since v7:
> * Fixes documentaion logic errors and typos as Mickaёl suggested:
> https://lore.kernel.org/netdev/9f354862-2bc3-39ea-92fd-53803d9bbc21@digikod.net/
> 
> Changes since v6:
> * Adds network support documentaion.
> 
> ---
>   Documentation/userspace-api/landlock.rst | 83 ++++++++++++++++++------
>   1 file changed, 62 insertions(+), 21 deletions(-)
> 

[...]

> @@ -143,10 +159,23 @@ for the ruleset creation, by filtering access rights according to the Landlock
>   ABI version.  In this example, this is not required because all of the requested
>   ``allowed_access`` rights are already available in ABI 1.
> 
> -We now have a ruleset with one rule allowing read access to ``/usr`` while
> -denying all other handled accesses for the filesystem.  The next step is to
> -restrict the current thread from gaining more privileges (e.g. thanks to a SUID
> -binary).
> +For network access-control, we can add a set of rules that allow to use a port
> +number for a specific action: HTTPS connections.
> +
> +.. code-block:: c
> +
> +    struct landlock_net_service_attr net_service = {
> +        .allowed_access = NET_CONNECT_TCP,

LANDLOCK_ACCESS_NET_CONNECT_TCP


> +        .port = 443,
> +    };
> +
> +    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_SERVICE,
> +                            &net_service, 0);
> +

