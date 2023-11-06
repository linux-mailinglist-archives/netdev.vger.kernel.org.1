Return-Path: <netdev+bounces-46209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D417E26EE
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AFDB20E60
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B7A31;
	Mon,  6 Nov 2023 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A28DAE
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:35:17 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1794
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 06:35:14 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3f5a58408so6376909b6e.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 06:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281313; x=1699886113;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=Q4psJN+hGsNryPRstP2S6VCqozR2j0ukcToXSvHD6svmuQHwY8oCJXAxVNltlghrwD
         qcKU6lP1/7r7UNU16qYFu7TAPRcIMEciAoPKxD7wj0kJBk/u2TA1SI0eP+RVhh+SW9Yk
         hntNKIfjk4xvBqLW4a6fgW38GHfWxnlVMeW3b7FgDS8TWhnWdPzWQTWKHvcOThNjnbpc
         ksnCzIIVUzQ6Nx1NvYTRgQNmwxd5+4dVBkhlh61osty9WqV1g3MJtqr9ZRDhHuqd0mT0
         20rZhMrxxL3Z4OK0Tk2JrXrieRejOWOcH+R26M447lrenUrCloovJJDZ6wbH4iV1PfGO
         AkSw==
X-Gm-Message-State: AOJu0YxqajmaAYjNNkCUToXnTrIehXqc4ZL+5f4BTkjEtFpTDSvw7+Cp
	U+8HYXmkoya6/AJDBeO6Olgzza7QQOoVST7+YCtZv9VejJ/e
X-Google-Smtp-Source: AGHT+IG/iI7FGWxO+tIpvDf57ygCjJyDFzHjpMxa+/pfuXhy/dTLktmDyG1XISzkLZn+1eHOTDmwVx+MQOuQC26hlSzHq7GEN+jT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23c1:b0:3a9:d030:5023 with SMTP id
 bq1-20020a05680823c100b003a9d0305023mr12427060oib.3.1699281313820; Mon, 06
 Nov 2023 06:35:13 -0800 (PST)
Date: Mon, 06 Nov 2023 06:35:13 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001579a706097cc3c9@google.com>
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

