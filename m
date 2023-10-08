Return-Path: <netdev+bounces-38904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2817BCF50
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01B9281643
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DC15AD3;
	Sun,  8 Oct 2023 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B83C14E
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 16:57:30 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D249F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 09:57:28 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1dd8e6a7a86so6160265fac.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 09:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784248; x=1697389048;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0OpDAngG10xpmhVSxqYUkvqTPKRTSFUJShfAHatMwg=;
        b=derGRBH9jm5TR4lpVoJ5Fs3PHySIEzhU5zp2WkkHQgI0yKOPqZZMZ6HjwUE3VG9C+b
         wW5R0N0RE+1ZEA5nOmDALb3BZ0Z/on7SgOMjJkA7Qd/HsyoGmweXWocMkHFXLrU5fU2Y
         APZTBeeoFUZ7AKflKNBfaX8q2P7rxCCvuh5MA9CGFsqDgMUjPokSQED460t+bmuW5xZt
         zWaqjnAR4l4UZ85+nXu5MmleHOc/1vdiHABAtHwrjXPrwgAkX6G+h+8NIMeq1xBOPCJi
         khVZId90NrJ2BAAXfObNuk+bQQCLppONe8w3c+P7/EWWuA+Eemda/kENdT03py9gmalX
         IOyw==
X-Gm-Message-State: AOJu0Ywm34639ciQcu/kNOAJlyfLFRp24asrr6hWzXWWE4ktEXILZMe9
	TUC85e6nuTL7yFBOrcpttwx0liEDRn3QTXUYknHKM0Di0X5N
X-Google-Smtp-Source: AGHT+IGNcEiyFDgDYD7nh8JVTo7bGNGHXpMgWzyPRnf99gRX7e4Lt8LB8Qc28HMJTdaAFFi5OEXyWxgCeH6wR0WotHyC+ZOJnxz5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1b8a:b0:1e5:7dbf:c2d5 with SMTP id
 hm10-20020a0568701b8a00b001e57dbfc2d5mr3290437oab.4.1696784248369; Sun, 08
 Oct 2023 09:57:28 -0700 (PDT)
Date: Sun, 08 Oct 2023 09:57:28 -0700
In-Reply-To: <000000000000d730410602d76cf6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006278b30607375e8f@google.com>
Subject: Re: [syzbot] [net?] [wireless?] INFO: rcu detected stall in cfg80211_wiphy_work
From: syzbot <syzbot+b904439e05f11f81ac62@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jhs@mojatatu.com, jiri@nvidia.com, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e978e9680000
start commit:   cacc6e22932f tpm: Add a helper for checking hwrng enabled
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=b904439e05f11f81ac62
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a49fcda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136f8679a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

