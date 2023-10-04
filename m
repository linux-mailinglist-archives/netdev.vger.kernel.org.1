Return-Path: <netdev+bounces-37928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50D7B7DAF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 48889B207FA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F4111B3;
	Wed,  4 Oct 2023 11:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E11101FB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 11:02:19 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2C6D9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 04:02:16 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0sGG5VqQzMqBgl;
	Wed,  4 Oct 2023 11:02:14 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0sGD2t0SzMppKM;
	Wed,  4 Oct 2023 13:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1696417334;
	bh=ykMu7wUYzgFvuDZ0CG84JZTWl5H2yiOE35Ezb8Q8IBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGm6yXkxSlt7Dsy/LA1bJBD9HJ16gTSzg2aXKERwe1o0CJGBcfVv6Qe6CMp6Addnm
	 pw5b8tVBCrsxyutWFQjlfsrb1Oe26L2qfjjQkp+NM7iZ/rFM5dRy71KkNEZkyd5TYJ
	 sBuVUTjM5z0l9lqBJZNnSVZDjICADSuVibhMC+JE=
Date: Wed, 4 Oct 2023 13:02:15 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-next <linux-next@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	gnoack3000@gmail.com, linux-security-module@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Message-ID: <20231004.ieZ2eekae5Ch@digikod.net>
References: <20231003.ahPha5bengee@digikod.net>
 <0174c612-ed97-44f3-bec5-1f512f135d21@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0174c612-ed97-44f3-bec5-1f512f135d21@app.fastmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 03:40:23PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 3, 2023, at 15:15, Mickaël Salaün wrote:
> > PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
> > int-ll64.h like most architectures) for user space code.
> >
> > Here is the same code with the (suggested) "%lu" token on x86_86:
> >
> >   samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
> >   samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects 
> > argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ 
> > {aka ‘long long unsigned int’} [-Werror=format=]
> >     170 |                                 "Failed to update the ruleset 
> > with port \"%lu\": %s\n",
> >         |                                                               
> >             ~~^
> >         |                                                               
> >               |
> >         |                                                               
> >               long unsigned int
> >         |                                                               
> >             %llu
> >     171 |                                 net_port.port, 
> > strerror(errno));
> >         |                                 ~~~~~~~~~~~~~
> >         |                                         |
> >         |                                         __u64 {aka long long 
> > unsigned int}
> >
> >
> > We would then need to cast __u64 to unsigned long long to avoid this warning,
> > which may look useless, of even buggy, for people taking a look at this sample.
> >
> > Anyway, it makes more sense to cast it to __u16 because it is the
> > expected type for a TCP port. I'm updating the patch with that.
> > Konstantin, please take this fix for the next series:
> > https://git.kernel.org/mic/c/fc9de206a61a
> >
> >
> > On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> After merging the landlock tree, today's linux-next build (powerpc
> >> allyesconfig) produced this warning:
> >> 
> >> samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> >> samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
> >>   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n"
> 
> I think defining the __SANE_USERSPACE_TYPES__ macro should take care of this,
> then __u64 has the same type as it does in the kernel.

Thanks! I didn't know about this macro. We'll use that and print the
full 64-bit value.

> 
>         Arnd

