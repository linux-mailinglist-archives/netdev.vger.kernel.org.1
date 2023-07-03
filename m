Return-Path: <netdev+bounces-15037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBF74569F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B827E1C2085A
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A61A52;
	Mon,  3 Jul 2023 08:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F74A34
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE8CC433C9;
	Mon,  3 Jul 2023 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688371216;
	bh=mfBAAuieedzUUs3qgaQmmXswARyTxd8nTL+YXcVHBmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTPqxj067fyYjuu4zOJCONAYbjtIBxedIC8PtL8VmaO3lv1WW3QNNrRMWrrOtaD6I
	 1/D7Ad8oa5bi8PruHWox4sMeq1+StfqVotgUUj49XHbqym3bMTBb9d9n2bjaUttsPa
	 YBzL8ovv1P8J7s/IAdy51DO9UenHmDopSHL2q2bht2nyB5dZm2xmLz0DNEdTcIJ20F
	 2jeK7fC3PlrC8oyj+YKs88tUw4NZeOzD9vRxS4F2fpOE6a7aGiAwEID+DhS1fshvnT
	 AExFedmYAR+LZKj/1bq3C2asW1LFOdYvJjVUA8nvTLN9Z9ULFfuC6dPjVuEAw1hlAp
	 Mf089WPRVX7BA==
Date: Mon, 3 Jul 2023 10:00:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-futsch-kuscheln-4c8d468de26b@brauner>
References: <000000000000246c3f05ff8fea48@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000246c3f05ff8fea48@google.com>

On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link atta..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=127adbfb280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=319a9b09e5de1ecae1e1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/disk-c20f9cef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vmlinux-c20f9cef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f8634183/bzImage-c20f9cef.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com

#syz fix: pid: Replace struct pid 1-element array with flex-array

