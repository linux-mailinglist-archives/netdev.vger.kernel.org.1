Return-Path: <netdev+bounces-15964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D174AA32
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A2A1C20F2C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 05:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89E1847;
	Fri,  7 Jul 2023 05:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A91FAB
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 05:10:26 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCF19B2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 22:10:22 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b895a08e3aso21332435ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 22:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688706622; x=1691298622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3odBP2k8JVrJYy1wa0Wfn0VRWmDTDDoVrfM0d6n+ayY=;
        b=Fx5kEBwj/mQzf4b972L+paRvrXMAiV+ViVgDIBZd3xxUyOP7eDjRsLWj/3pcPyAnK8
         jHMIoNyu8RMVp9axtNxBQbIU4uaL+4/uQr+sbyNRC6DwmBgPaeZpDAGIM+o2S0BYuamb
         8Cp445bJF4aJCzHMskEagCPimx4un3/cdtsK83oDGkcKwJT7HrpZMgBdY4ZCjPN9cKPP
         rzOoNp0ukXMH/MC5CjzGicvg7S2DH0SORY9AHFf3QMx6+IyeW5JR67/A+PabE+0A7C+D
         PI5Si/10b2fN3FwwBVcUGQht9iAbmggauXwq7hmkfosRlTLWpVElgGM+ufCmrFUhGHGS
         Dwxg==
X-Gm-Message-State: ABy/qLbbSzBuEVmXhuDt1FhEe7CjXvjFojBwsf9bn3cPBOssA2SEmfhn
	DnRvV3T1g8QdrNQJ7ho/Bqz0bkl1V9IOlKQ68oVtKsLrYsAv
X-Google-Smtp-Source: APBJJlFPEIIvaQ5FzGgKwrTTH+IL4zi+h8xLaZxAtxA/83enB/W2VDTaFHWmkb5XXkGxd63ab2vboDyFilTDCFmVWY2UF8XrN5eI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:e549:b0:1b7:f5be:c934 with SMTP id
 n9-20020a170902e54900b001b7f5bec934mr4087715plf.9.1688706621980; Thu, 06 Jul
 2023 22:10:21 -0700 (PDT)
Date: Thu, 06 Jul 2023 22:10:21 -0700
In-Reply-To: <000000000000a557cb05ff9ed03b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000554b8205ffdea64e@google.com>
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

syzbot has bisected this issue to:

commit b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jun 16 11:10:32 2023 +0000

    crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e4fa88a80000
start commit:   ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1414fa88a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1014fa88a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b9d48a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10223cb8a80000

Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
Fixes: b6d972f68983 ("crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

