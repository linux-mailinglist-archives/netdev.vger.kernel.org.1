Return-Path: <netdev+bounces-15048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD0D7456E5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F30C1C20952
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF2A52;
	Mon,  3 Jul 2023 08:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A4A34
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C0EC433C7;
	Mon,  3 Jul 2023 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688371516;
	bh=agzuLGwMJnoQtsjjF+lM4RGUEzreGKDMB0+SK3+E2dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqoX0JWaaV/gNaHm1J7dEMzeudo6ev11Mty8a4tOlMB1fE3TmJl8OUWHHKP5vVWzV
	 2jQKJOwTBCWM1mSDWmra40R0JGyVaqYDr7pp5js6PE50DuSHA+hVmxYbgchtZdEFgV
	 nHqsi0uMYbhi6io5a6Lp8EwV00LANMel8vBB5M8mYczLRC0MLKA3zbl4bAYsFrUTTX
	 Qzf/j1VWc65OugpaZvf7K/c3ZmISy4X0MNaWvMpcVxu81KAE1pMaEFNT39+7TCd8no
	 mirpgRpxKaqxMbszIXYyBp6MAaZAlKERbhM3z7Emf5Iy+XYgvrZ5zOHFBZjwR1ueE+
	 AZVkXExSlI4tw==
Date: Mon, 3 Jul 2023 10:05:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] net-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-singt-zander-141e01ea4000@brauner>
References: <00000000000018bd0d05ff8e8ab2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000018bd0d05ff8e8ab2@google.com>

On Sun, Jul 02, 2023 at 10:35:50PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1391a15f280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f02ef87ef8bbb97026bd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/580f71d6d107/disk-3a8a670e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7d94a5879cd1/vmlinux-3a8a670e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4ef3ba2a581e/bzImage-3a8a670e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com

#syz fix: pid: Replace struct pid 1-element array with flex-array

