Return-Path: <netdev+bounces-15041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59757456B7
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171101C2084B
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C3A34;
	Mon,  3 Jul 2023 08:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826A15AB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B203C433C8;
	Mon,  3 Jul 2023 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688371302;
	bh=xhiKOGFBIK3GyZ81/swuDdPj2WZczptt4L3dD836b4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b52litQ3xVEDGETfQ7h4zPXNeOk8CnDDA9P3xsxfhjuaiOU3gw53b8aTMFWJvme0J
	 5Nu3McSDvLPMcsVc1igMAaP0td31nKrhkpXSpbWvsQJqiscTJErvsqHOSMycBLfjEr
	 B2wseAiqRXh9ZKmE0kmvY5vNR0YTYXokbI2HC12a4ypmvLkrW2TnBy9Gs0H6J8TJ4H
	 qVTmD8NpmRZ0fwbxwOYD6hCvEhqFV89EQRGBZtvCw3s4UP41J9khyTq9YkzF6ngoQV
	 vDDMmF6EzRrzCwlzxyrszHpDekolHxkEjNoaV7BUEMX54dHOdxogF1JdalA5hGbL75
	 enwBa9Nhuh2bA==
Date: Mon, 3 Jul 2023 10:01:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] net test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-unpassend-bedauerlich-492e62f1a429@brauner>
References: <000000000000a6a01c05ff8f2745@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a6a01c05ff8f2745@google.com>

On Sun, Jul 02, 2023 at 11:19:54PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a6d7280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3945b679bf589be87530
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/disk-97791d3c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vmlinux-97791d3c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34ab/bzImage-97791d3c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com

#syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid

