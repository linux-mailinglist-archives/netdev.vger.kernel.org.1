Return-Path: <netdev+bounces-27093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E945F77A594
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173A81C208A8
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD11FA2;
	Sun, 13 Aug 2023 08:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AF187C
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 08:26:38 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B44170D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 01:26:37 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2685bc4f867so3770024a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 01:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691915196; x=1692519996;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHx5pQ865kQdSV3oc1VTb4RJPNDKiF3qG2AurMf0uII=;
        b=TIcWZqb5rp2N8UcKghv3ko0eDpLp7eWC4F6lV5tGleLwzdeLgycmFu2iymVTi9C+1W
         K+sW3/rBLHJ4H1p8u0Xu0rkQ4IWaJ+XGL4HnPyA/kfV3d5+ZX7Xh1Eglj+Z1G0u9iSVl
         EJdMHODdBGx2kPOeyW5WRJMdUqVIawZJD5hgAte9LXA1DiDC1sOt//8dpKghQFYGn+Eh
         1jV2HYq2SgkVZ2jHH3tXFvH8Y5bHetOlZkzqd7ENOU6e+0N5kCkJ3RIQNHhoSSIeA+mb
         ajI4+Gq/iJ6nLzwhwpHMTUj5XobAnLeKrCEcQJUmWzgnEW1CC401f/O49gZ7qQQTrND0
         7HOg==
X-Gm-Message-State: AOJu0YwFb3KtLIhk6SCtL+aWVjwDKGTPmoZb0zL605fjl/SgwQR7uKbI
	HZ2A/H0WOOBwBWzuef0ZKqi2z0uGaLYZCaLGpKyB4FDDP47F
X-Google-Smtp-Source: AGHT+IGYYglPH140FdNSx5GvsuVJ9WH70GFQwHtLb3I+yri16v2vev+Mrj3Md4vQp1vtP9PmR5/bEgHfq46nCDEv22uWoOcw8OKQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:ed5:b0:263:f16:3192 with SMTP id
 gz21-20020a17090b0ed500b002630f163192mr1355601pjb.3.1691915196654; Sun, 13
 Aug 2023 01:26:36 -0700 (PDT)
Date: Sun, 13 Aug 2023 01:26:36 -0700
In-Reply-To: <00000000000090196d0602a6167d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000496a0f0602c9b43c@google.com>
Subject: Re: [syzbot] [net?] WARNING in unregister_vlan_dev
From: syzbot <syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com>
To: amir.hanania@intel.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, idosch@idosch.org, idosch@nvidia.com, 
	jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Tue Aug 8 09:35:21 2023 +0000

    vlan: Fix VLAN 0 memory leak

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ac8d6fa80000
start commit:   048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ac8d6fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac8d6fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=662f783a5cdf3add2719
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1604a23da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15261ffda80000

Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com
Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

