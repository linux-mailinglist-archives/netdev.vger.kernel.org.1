Return-Path: <netdev+bounces-95676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E258C2FBF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 07:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C334CB20BEE
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17447F5D;
	Sat, 11 May 2024 05:59:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FB2CCBE;
	Sat, 11 May 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715407170; cv=none; b=rbiKzs+Dpus6NkyxjSiORX2OT0EmWvVCSeDh+ltKJQuNF3OsGXQgjke8aPzhbnyAYMOm6P8xeMpOlYTR8e5+T4sX8jE0DmjRp5gC6rNWIc/d31+3D9llKjCjrOuyA51robTuoWZIW45GQO0ulIF1IGLNboNpP6byGvEdl3pCrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715407170; c=relaxed/simple;
	bh=aVz2QS/W96fRfktT31yMRKLmBl2zY1lLn7nz3B6/dC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UVEbK36kpFfndBRWElCyM/wlSQizmyNCsmEafWogNS+AyJueTebSpqVlHclgdJR16kGfIdIR0BKWel0JWtdT/4M/F/RwqJvzYFfYoYi8oOxotk/ibKzsVZ3CRUbUJnfVN6gc8SZFMe0+35CJmhELZt0A3uk2WZmCdsTLFzFXqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44B5wRtv091972;
	Sat, 11 May 2024 14:58:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 11 May 2024 14:58:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44B5wQwO091968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 May 2024 14:58:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ce6d30c0-612e-48aa-9042-65ce3d880323@I-love.SAKURA.ne.jp>
Date: Sat, 11 May 2024 14:58:27 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in __lock_task_sighand
 (2)
To: syzbot <syzbot+34267210261c2cbba2da@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
        edumazet@google.com, haoluo@google.com, jakub@cloudflare.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        yonghong.song@linux.dev
References: <000000000000fafd5b06182712ca@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fafd5b06182712ca@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This bug report has fix commit but syzbot found a reproducer with that fix commit applied.
That is, something is still wrong. Any comments from BPF people on
https://lkml.kernel.org/r/8dc01a83-1bea-4e3c-a04d-9a9bd422a5b3@I-love.SAKURA.ne.jp ?

On 2024/05/11 14:39, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3e9bc0472b91 Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_S..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1372d16c980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
> dashboard link: https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116aa704980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be0fb8980000


