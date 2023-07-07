Return-Path: <netdev+bounces-15990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E54874ACC2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82E52816C8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39268C1F;
	Fri,  7 Jul 2023 08:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C62BA44
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:20:30 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBC1FCE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:20:29 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-262d8c40189so2264710a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 01:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718028; x=1691310028;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN1UEoiyjNN/U7zWTps4glZc/qi7ZNLVVS2aoUJ2q4A=;
        b=g8wS3TRKdDIMp80ZD8wtF4c5kFw897yw9hkrJZ6Dp8UzfkFYHuNzpHRWt6SPQggZFl
         W0XjYlTZsFZyc/8jSxdxvGwNedJ2mMelI0KTkK6+JbtMoqZ8AmBayyhEgmGCH1Ag8xlu
         ER9C7EFFg6p7JoV4axnVwBktrJF4tChuuyyaOpAA+xSHehwCYQg57np0oWif+Y+NAH0h
         3BuU7GlizFrR8DksdzJ0WrnTDlb6estavcSu8tXHXyI2jUQAYvFwRa5KQqv47sMkxpc4
         YTasB3DCstD17+r9yeINV/EwJslHOHHLG01ujTCZU+wquq0U5URB2kt0Sq3kS+NYpZxh
         LYYw==
X-Gm-Message-State: ABy/qLYNLajrjUJcJBIdp6toIuYKScL7WMkWxXxhdv3qg9UxUfdntgzw
	8sSCD1WkP5dF1NRNDDTLEVWFFq/ukkHM1pHEhfyHwjVhQdGD
X-Google-Smtp-Source: APBJJlE53elBOc0PVBkPt5sMuDbxYXfNijnU6gTgY9iSg9CUfuKQG7NUjF7iYEWUsnBRxcEyGfvev30rDbJTXm2Ub6F9tIUO/Zk8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ce8f:b0:262:e5e2:e5af with SMTP id
 g15-20020a17090ace8f00b00262e5e2e5afmr3633167pju.5.1688718028524; Fri, 07 Jul
 2023 01:20:28 -0700 (PDT)
Date: Fri, 07 Jul 2023 01:20:28 -0700
In-Reply-To: <2224784.1688717214@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037530605ffe14e41@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From: syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, kuba@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mingo@redhat.com, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/main: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "main"]: exit status 128
fatal: couldn't find remote ref main



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git main
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136ff1b4a80000


