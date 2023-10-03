Return-Path: <netdev+bounces-37685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F142F7B69FF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 168FF1C20832
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A31250FD;
	Tue,  3 Oct 2023 13:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115B250E7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:15:30 +0000 (UTC)
X-Greylist: delayed 60528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 06:15:26 PDT
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5438A1
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:15:26 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0JGN1SdlzMqN0Q;
	Tue,  3 Oct 2023 13:15:24 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0JGM1Ml8zMppBN;
	Tue,  3 Oct 2023 15:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1696338924;
	bh=mYXOJz9gAA/llGqc8uja06Dbq61EdeXQL0OOvglJWBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bjXA7XOX13EKX+vc5LCkJetsHYHgzPULA+1gAEpaqNFZ9FusLSnpTbijlBTmaUUrY
	 Go4PIClN/Mzu3FvFYrxZIN7aLTMZqF6EU334UiM+U2PomHPmP2IXgtbzKlNz6XS/Kn
	 AgLUGGTixs44NQIt7DiNAxfZnYs+Px6a+AQNKhpI=
Date: Tue, 3 Oct 2023 15:15:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Message-ID: <20231003.ahPha5bengee@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003142737.381e7dcb@canb.auug.org.au>
 <20230920092641.832134-12-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
int-ll64.h like most architectures) for user space code.

Here is the same code with the (suggested) "%lu" token on x86_86:

  samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
  samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long long unsigned int’} [-Werror=format=]
    170 |                                 "Failed to update the ruleset with port \"%lu\": %s\n",
        |                                                                           ~~^
        |                                                                             |
        |                                                                             long unsigned int
        |                                                                           %llu
    171 |                                 net_port.port, strerror(errno));
        |                                 ~~~~~~~~~~~~~
        |                                         |
        |                                         __u64 {aka long long unsigned int}


We would then need to cast __u64 to unsigned long long to avoid this warning,
which may look useless, of even buggy, for people taking a look at this sample.

Anyway, it makes more sense to cast it to __u16 because it is the
expected type for a TCP port. I'm updating the patch with that.
Konstantin, please take this fix for the next series:
https://git.kernel.org/mic/c/fc9de206a61a


On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the landlock tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
>   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n",
>       |                                                                           ~~~^
>       |                                                                              |
>       |                                                                              long long unsigned int
>       |                                                                           %lu
>   171 |                                 net_port.port, strerror(errno));
>       |                                 ~~~~~~~~~~~~~                                 
>       |                                         |
>       |                                         __u64 {aka long unsigned int}
> 
> Introduced by commit
> 
>   24889e7a2079 ("samples/landlock: Add network demo")
> 
> -- 
> Cheers,
> Stephen Rothwell



