Return-Path: <netdev+bounces-20510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F075FD0A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE21C20BA1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA552DF66;
	Mon, 24 Jul 2023 17:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2A1FC4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:20:47 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114210F0
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a5ad0720d4so4060131b6e.3
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219245; x=1690824045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jjikWmr9FsKFO5O1AtxhVTUjXG2I5Qke3uz5AVbRGY=;
        b=Z8d93MCGuIiYExzZ18BUOjEmNGEmA51Ttm08mj/DwNRLNbgCN2fkpQp2LLtuM2GL1r
         GkWD59FDvlLS9Hu4zpZERX3uwpASOz/h8ZieHeU9Fd063+COi0EX9n0iwJCOC8Hjaa0L
         ypIJHIosxS4nV8W6ZsMmzZpO3HsXV/MH/o+A7e5FqrsiT8rWfhh8NjDrUWcTZbmznDB1
         tsDZJH/CsrvO3dAdV+o/qDbWocIow2tjSxq/6GTi4wnODYpSoNHeZM8wKm8TrGK9WuF/
         2rFDvjByxGuY2BXCWXMzYo6oGYdGstvUTXZU2mLU8azEaE4weiEOS9IDeFwtUItpjCWV
         xtMw==
X-Gm-Message-State: ABy/qLZtyc4mjRob3O7Z+9bRkm897VyLoLaWlYxYZelOseDfsRVsEkgv
	zNuoIOmZaua64rvlOZbdP7HYHRi4kYaV+gBiIhCTlbb8/eD7
X-Google-Smtp-Source: APBJJlGNrlcAkikspfqaXegtQje/gdLFHH41Sfqg3J9deU/xIOfiC7rK5IxmHznQSyVncseLGB9s/gSmn2HTbokqPrRS8hoXjQMs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2019:b0:3a4:2943:8f7 with SMTP id
 q25-20020a056808201900b003a4294308f7mr20378188oiw.5.1690219245817; Mon, 24
 Jul 2023 10:20:45 -0700 (PDT)
Date: Mon, 24 Jul 2023 10:20:45 -0700
In-Reply-To: <13125.1690215929@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd577706013ed580@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From: syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, kuba@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com

Tested on:

commit:         0b7ec177 crypto: algif_hash - Fix race between MORE an..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157554a1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bccf8d7311b80058
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

