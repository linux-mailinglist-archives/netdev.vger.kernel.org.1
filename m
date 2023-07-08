Return-Path: <netdev+bounces-16211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9A74BD40
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CEB281975
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1263D4C96;
	Sat,  8 Jul 2023 10:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F91FD7
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 10:35:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F981FC7
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 03:35:36 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 368AYjAe047715;
	Sat, 8 Jul 2023 19:34:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 08 Jul 2023 19:34:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 368AYi74047708
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Jul 2023 19:34:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f70b043f-3444-a6d3-81cf-66af515a8b3c@I-love.SAKURA.ne.jp>
Date: Sat, 8 Jul 2023 19:34:43 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Potapenko
 <glider@google.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Aviad Yehezkel <aviadye@nvidia.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <0000000000008a7ae505aef61db1@google.com>
 <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
 <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
 <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
 <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
 <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
 <CAG_fn=VFa2yeiZmdyuVRmZYtWn6Tkox8UVrOrCv4tEec3BFYbQ@mail.gmail.com>
 <CAMj1kXEdwjN7Q8tKVxHz98zQ4EsWVSdLZ5tQaV-nXxc9hwRYjQ@mail.gmail.com>
 <CAG_fn=UWZWc+FZ_shCr+T9Y3gV9Bue-ZFHKJj78YXBq3JfnUKA@mail.gmail.com>
 <CAMj1kXE_PjQT6+A9a0Y=ZfbOr_H+umYSqHuRrM6AT_gFJxxP1w@mail.gmail.com>
 <8c989395-0f20-a957-6611-8a356badcf3c@I-love.SAKURA.ne.jp>
 <35970e3b-8142-8e00-c12a-da8c6925c12c@I-love.SAKURA.ne.jp>
 <20230706135319.66d3cb78@kernel.org>
 <63006262-f808-50ab-97b8-c2193c7a9ba1@I-love.SAKURA.ne.jp>
In-Reply-To: <63006262-f808-50ab-97b8-c2193c7a9ba1@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/07/07 18:41, Tetsuo Handa wrote:
> On 2023/07/07 5:53, Jakub Kicinski wrote:
>> On Tue, 4 Jul 2023 22:32:00 +0900 Tetsuo Handa wrote:
>>> I found a simplified reproducer.
>>> This problem happens when splice() and sendmsg() run in parallel.
>>
>> Could you retry with the upstream (tip of Linus's tree) and see if it
>> still repros? I tried to get a KMSAN kernel to boot on QEMU but it
>> the kernel doesn't want to start, no idea what's going on :(

(Returned from https://lkml.kernel.org/r/20230707180901.34c17465@kernel.org .)

It seems that a series of changes that was merged in this merge window
made this problem no longer reproducible. ;-)

Which commit should we mark as a fix for this problem?


