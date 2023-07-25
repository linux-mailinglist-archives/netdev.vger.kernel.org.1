Return-Path: <netdev+bounces-20910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAB761DF1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422092817AA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4ED24169;
	Tue, 25 Jul 2023 16:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137F23BF1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:02:27 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F3B1BE
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:02:25 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a36b52afcfso11031265b6e.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300945; x=1690905745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYrN+166SJjRTzPRLQqH1H2WZ+LKvtSBI3v/6mM3uCU=;
        b=XEsoYR7iHIZbFHiQuZM/uiX/NjaL1tWbTbTmH0lTODeALrOXd8YdAqt8jrCi0QTCOU
         GDJUjgkaNdso38dIIlG1hUKCP7lDRwfkn9l7zIHnaB+unmwd5GutPoGP4kqzXfsObYBe
         1UDvtamot5m7uYkqQ9p1jpMz8cjDULhRIyJWKSJAF8/X43G0OpTLOFIHxsHE2ia+SXkB
         M+m/FPJdOFPhGzUcmzoC+uKtmATm83EDcXIe3p6qEEQkMslcmOt6C6aHdJRwfuKYjKG+
         1XXkIqfegYnjdMsSyFIsymEV2GKXVc8zCQDMrXVruDkqHar8/glPn1h9LvODDXtQBOQ8
         beZw==
X-Gm-Message-State: ABy/qLagfR4zLfhY4LI24cFLjY6l2EHsVW4nRYFH7pS8fLKHuxhu3+up
	GorAQAUyt9VufYvqGpM09CdPk8s8RZpvXDfL/XJneiJ8l3Fz
X-Google-Smtp-Source: APBJJlGXkX52G4eXyHWloF4CzCkRRIJE2m4tcBzyC92qEloDbaeV+IlGYdkjXcsjD5bzKsqPKNjZ3k70G1Mkz2BGwHGW0DFNLB8H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2025:b0:399:e5c2:f7d3 with SMTP id
 q37-20020a056808202500b00399e5c2f7d3mr27685378oiw.7.1690300944879; Tue, 25
 Jul 2023 09:02:24 -0700 (PDT)
Date: Tue, 25 Jul 2023 09:02:24 -0700
In-Reply-To: <104261.1690298950@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000621765060151db5e@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in cryptd_hash_export
From: syzbot <syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e79818f5c12416aba9de@syzkaller.appspotmail.com

Tested on:

commit:         b6d972f6 crypto: af_alg/hash: Fix recvmsg() after send..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11736cbea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cdac84c489b934f
dashboard link: https://syzkaller.appspot.com/bug?extid=e79818f5c12416aba9de
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

