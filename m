Return-Path: <netdev+bounces-14773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D9743C11
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 14:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3497A2810CA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB6101E2;
	Fri, 30 Jun 2023 12:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2614AB8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 12:42:19 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFBC212C
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:42:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b698dd515dso28370411fa.3
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688128936; x=1690720936;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbDHpcHBGV/GXKRXQp6C7hY79PoxtwM87bmH3IPRUy8=;
        b=S95nMNVjz21JUfBjntZ0OBElDugcT8Z1TpM/i6HCRSAH4biC7zVwu8l5DEomnXW6Qy
         O+xptjJ87ZL6y8b+OS3dXV9KKGrT2yEBQ5b1SM9KdqcOwXrQSrkvhWDxINH7qcTPz3vs
         3VDZu5mzPBx74+1YmlQv8nFYdG/cdAs0cMllcDYh++lsPyBVV+qOeXlPnQ3uyyI4bmPq
         ZceMvMn6oxxMym30xxlKu3KAXQVqiAQuG1Orn+jzi5WMx8FrWjqmQObSTKjmHrYtI8BD
         B21zqOk5NDrwBWYCgw6JDeTqVKg45lu1XHYyX0jJhgpQrp4pEWx9qDi6SyqobUmgGoaV
         ctuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688128936; x=1690720936;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbDHpcHBGV/GXKRXQp6C7hY79PoxtwM87bmH3IPRUy8=;
        b=Cup411kOJurQhBSN73AIqkHFqZ/FE5y3iLJwVrVpVNWDg8c9DfxgXSj4WE7HtJk8Kv
         GBwhBOg3FiEtvaCwxDbSUw1sobzRegLq3NNOPKjyjAd3xwNqUiL/1Ebyb+4pib0NmW5q
         GTvEeGIhlTHdjhr+rle5reqGidR31qnJ+zL+mjvTaLChT5ICfNlDOG1hLD2/NUXiu1u4
         Zz6bbqyRQMB5Htq3lsC1oHyLs3WWUG/+hO+oehhqZf0QZ3wGqWmiwVviTR2xrIFhyDtP
         2gb9jEa8uShCen1VLF7VQb+HVTOZ+m4G59/EUSHizjOHj136RA5eTMlfBk3/DXUxVR9+
         fUyA==
X-Gm-Message-State: ABy/qLa1qMsHxNK4rNVekX+H5ob4Tqo3ENGbFZnjn33nr5lA+VREXKIv
	H5+1ZswrmSMIKgOBR/eTzq8=
X-Google-Smtp-Source: APBJJlGTiAqSH2cksLdLr5lwKG+bvn2CYh0FyAsb9QJcO53Qx04dR+oUXUNEydEGJKBlJr21oFERJg==
X-Received: by 2002:a2e:3512:0:b0:2b6:d5af:1160 with SMTP id z18-20020a2e3512000000b002b6d5af1160mr839056ljz.28.1688128935594;
        Fri, 30 Jun 2023 05:42:15 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906370e00b00992e265a22dsm721727ejc.136.2023.06.30.05.42.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2023 05:42:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: Bug Report with kernel 6.3.5
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <ZJ1rC8WieLkJLHFl@debian.me>
Date: Fri, 30 Jun 2023 15:42:04 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Linux Regressions <regressions@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8555BEF-15B3-4CFF-8156-D5B1D6C24736@gmail.com>
References: <20F611B6-2C76-4BD3-852D-8828D27F88EC@gmail.com>
 <ZHwkQcouxweYYhTX@debian.me> <ZJ1rC8WieLkJLHFl@debian.me>
To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bagas,

Close for now , if i collect new info will update here .


Thanks,
Martin

> On 29 Jun 2023, at 14:29, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> On Sun, Jun 04, 2023 at 12:42:25PM +0700, Bagas Sanjaya wrote:
>> On Sun, Jun 04, 2023 at 07:51:36AM +0300, Martin Zaharinov wrote:
>>> Hi Team one bug report=20
>>>=20
>>> after upgrade from kernel 6.2.12 to 6.3.5=20
>>> After fell hour system get this error.
>>>=20
>>> If is possible to check.
>>>=20
>>>=20
>>> Jun  4 01:46:52  [12810.275218][  T587] INFO: task nginx:3977 =
blocked for more than 609 seconds.
>>> Jun  4 01:46:52  [12810.275350][  T587]       Tainted: G           O =
      6.3.5 #1
>>> Jun  4 01:46:52  [12810.275436][  T587] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>> Jun  4 01:46:52  [12810.275527][  T587] task:nginx         state:D =
stack:0     pid:3977  ppid:1      flags:0x00000006
>>> Jun  4 01:46:52  [12810.275624][  T587] Call Trace:
>>> Jun  4 01:46:52  [12810.275707][  T587]  <TASK>
>>> Jun  4 01:46:52  [12810.275786][  T587]  __schedule+0x352/0x820
>>> Jun  4 01:46:52  [12810.275878][  T587]  =
schedule_preempt_disabled+0x61/0xe0
>>> Jun  4 01:46:52  [12810.275963][  T587]  =
__mutex_lock.constprop.0+0x481/0x7a0
>>> Jun  4 01:46:52  [12810.276049][  T587]  ? =
__lock_sock_fast+0x1a/0xc0
>>> Jun  4 01:46:52  [12810.276135][  T587]  ? =
lock_sock_nested+0x1a/0xc0
>>> Jun  4 01:46:52  [12810.276217][  T587]  ? =
inode_wait_for_writeback+0x77/0xd0
>>> Jun  4 01:46:52  [12810.276307][  T587]  =
eventpoll_release_file+0x41/0x90
>>> Jun  4 01:46:52  [12810.276416][  T587]  __fput+0x1d9/0x240
>>> Jun  4 01:46:52  [12810.276517][  T587]  task_work_run+0x51/0x80
>>> Jun  4 01:46:52  [12810.276624][  T587]  =
exit_to_user_mode_prepare+0x123/0x130
>>> Jun  4 01:46:52  [12810.276732][  T587]  =
syscall_exit_to_user_mode+0x21/0x110
>>> Jun  4 01:46:52  [12810.276847][  T587]  =
entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> Jun  4 01:46:52  [12810.276954][  T587] RIP: 0033:0x15037529155a
>>> Jun  4 01:46:52  [12810.277056][  T587] RSP: 002b:000015036bbb6400 =
EFLAGS: 00000293 ORIG_RAX: 0000000000000003
>>> Jun  4 01:46:52  [12810.277185][  T587] RAX: 0000000000000000 RBX: =
000015036bbb7420 RCX: 000015037529155a
>>> Jun  4 01:46:52  [12810.277311][  T587] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000013
>>> Jun  4 01:46:52  [12810.277440][  T587] RBP: 00001503647343d0 R08: =
1999999999999999 R09: 0000000000000000
>>> Jun  4 01:46:52  [12810.277567][  T587] R10: 000015037531baa0 R11: =
0000000000000293 R12: 0000000000000ba5
>>> Jun  4 01:46:52  [12810.277693][  T587] R13: 0000150348731f48 R14: =
0000000000000000 R15: 000000001f5b06b0
>>> Jun  4 01:46:52  [12810.277820][  T587]  </TASK>
>>>=20
>>=20
>> Can you clearly describe this regression? And your nginx setup? And =
most
>> importantly, can you please bisect between v6.2 and v6.3 to find the
>> culprit? Can you also check the mainline?
>>=20
>> Anyway, thanks for the regression report. I'm adding it to regzbot:
>>=20
>> #regzbot ^introduced: v6.2.12..v6.3.5
>> #regzbot title: nginx blocked for more than 10 minutes on 6.3.5
>>=20
>=20
> No reply from Martin (MIA), thus removing from regzbot tracking:
>=20
> #regzbot inconclusive: reporter MIA when being asked to provide =
regression details
>=20
> Thanks.
>=20
> --=20
> An old man doll... just what I always wanted! - Clara



