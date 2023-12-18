Return-Path: <netdev+bounces-58577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D358173B4
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2551C232CA
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B2200A4;
	Mon, 18 Dec 2023 14:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0F18E03
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b77e8eec3aso393968039f.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 06:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910178; x=1703514978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=Z+Tk9LJ+W8tecOeKpgq/JEel3f2JgiDQhZJ70sRSoneulsnqwtbILVCz7GKinASx7k
         byz4ANB6cJ5P0V3DXKZmRVpn64EPBSFvxNZ1pNTWVLG+4itC2HTpnp2A6neK9bJtZ9L9
         B0usvXYOati7G601zE6WI6pDsvxmbeWmown2jZSddKPXFupkwha1valCWarOEz14ZYIw
         5WvY4LLZuSd5CJrnOAd2MUf72Benp+Sm5ySxGbj3bd/g7d8N0dJWEwOOyotFy24xbGFA
         vhwgoTS6LIdQP7Xzed0ajEbTmVq2Wy/mn54bl4opq6QHewnNa6+srgYIJj2Uy//YYoeN
         RstQ==
X-Gm-Message-State: AOJu0YzLYKmbgUPzNfrXyUsQUCfAbWd7j/Kt2xEY9OxZoCxZhDNYs3nP
	OPf9DGgRIJeD44+nfQmKcTbEbKMVUosVEX/FAMOjJrVyyszP
X-Google-Smtp-Source: AGHT+IFkNLsPR1axQYWCJ+SpPnOFsw/t4pfNw4EGH7RocShupcn9OymSX8sxcFLnEQuyCg/HvO19Z6BN6qQXhx9SP+LRAN3o0G5o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da01:0:b0:35d:70c7:4c5c with SMTP id
 z1-20020a92da01000000b0035d70c74c5cmr528892ilm.6.1702910178612; Mon, 18 Dec
 2023 06:36:18 -0800 (PST)
Date: Mon, 18 Dec 2023 06:36:18 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047de92060cc9ace1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To: Jose.Abreu@synopsys.com, arvid.brodin@alten.se, davem@davemloft.net, 
	dvyukov@google.com, ilias.apalodimas@linaro.org, joabreu@synopsys.com, 
	jose.abreu@synopsys.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@rempel-privat.de, mkl@pengutronix.de, 
	netdev@vger.kernel.org, nogikh@google.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, 
	tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

