Return-Path: <netdev+bounces-20546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A2A7600E8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D31C20AC8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB710965;
	Mon, 24 Jul 2023 21:12:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6DDDC8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:12:45 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA1E7E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9e5ee1565so9744444a34.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233163; x=1690837963;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPnHeXIwNFVyZ0AE0V37vyCdAnCc/H92GAheB3cJ/4w=;
        b=Bx+Vk7dHFulYxA2ZDasS54iYMogzXKlCU8oHYgBqg09jrZgTYknDpqYt6PvJf7E5pn
         Efx7HDwWb1o/E4Zk2y5NUSLBTQA4npzjbuqng0pU8Sij9cj5ITQzH5q2aHvijEuNTp2z
         f7rcyZ4+adshRvfXuoyndtdbM3bP8qFGnkNf2py51rfV+8sZy1Je6UgfrmrqhCfZt7TA
         z6G/RZvkAlkWZwlvY7/tzbQmJ+kquSga7+3SmDhnruvrE9lZ2nAraPn2aGONMWybZnfs
         I6fFb4lg3NKNHcpCJfArU4O4zcM5UPNHh0e8ypoSUtyIWgYWtNrDHBsXx36Zqs+Pdmds
         EsQg==
X-Gm-Message-State: ABy/qLaIQ2N6snOsGGBHjE/zURF9ILxz9LM7Qnj04eJ/exFL6sLJjlz/
	C4H7pEPt8tDnunc4/6tqxT2K2sXkCAJ2hQDS//jvUeTYNt7n
X-Google-Smtp-Source: APBJJlEZpLKV/q4LE1/Q6WrdC8aon0BK6TGJhCbOn7xtLIBXrY8K3tRXJk7fN+kSn3DROS/NbpXFthJZJvUNqcYGhZ07hm7fnWGG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1519:b0:6bb:2244:cb72 with SMTP id
 k25-20020a056830151900b006bb2244cb72mr7592465otp.2.1690233163775; Mon, 24 Jul
 2023 14:12:43 -0700 (PDT)
Date: Mon, 24 Jul 2023 14:12:43 -0700
In-Reply-To: <19655.1690233158@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050862c0601421343@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From: syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, kuba@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> #syz dup: [syzbot] [ext4?] general protection fault in ext4_finish_bio

can't find the dup bug

>

