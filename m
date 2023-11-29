Return-Path: <netdev+bounces-52125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71447FD66D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3492834EF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693E1DA37;
	Wed, 29 Nov 2023 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153410C9
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c604d8e6f5so881545a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260225; x=1701865025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm0iiEEDW67QXAU5hmtno74YGdHPjqHpci2ImvBkZog=;
        b=Y7QFVi9mkOf3tMAb0UgAXbrDZAmwrRZ9vhfJtua7ZCAiefv+qSgQbnPeem/bbDvSOB
         OgUPLjLLj/Ka3riynxVc3QbWUKOeK/oBBck8CmNB8AWezV7CaS1oeLTEtbdzGUTUVamC
         7EFOod9hUCWBoAFPDMl0h/z0/XrRST8PKdjiDQ4hrlkviwgJiVyY5p8Y/ROEWARIp8sp
         1Bob7/riuem5Gjqmg+Be65laGp4nafzF/IXGgy+S1NGZx0UVVWcfbhLcZwqfZDzlI+J+
         o2hkwcqOk8w/a0rYe1UF3mupsxRb61AiKIT9SKusWV0j0wFSwdm8tixFF05rE/9nL5pm
         et4w==
X-Gm-Message-State: AOJu0YwT3PIz+ufSeJb8oMjkQnwMVnAp5bW/sF/chsB85NHjQGM+90PV
	CLtd8UDOP4HNZJLXiMc3Mcibn1rtyfIJL46vL/FmyaLPw6dd
X-Google-Smtp-Source: AGHT+IHm5egSj7drq/h6+tM2rakLRXVKiS/fewy4S6Rq3VCjTdYJQzjNbgFLIYLHh4HPavMnmoOq+9UCKki4IZlbNFEDmoS03isK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:2b86:b0:27d:e40a:96d3 with SMTP id
 u6-20020a17090a2b8600b0027de40a96d3mr3758871pjd.2.1701260225232; Wed, 29 Nov
 2023 04:17:05 -0800 (PST)
Date: Wed, 29 Nov 2023 04:17:05 -0800
In-Reply-To: <000000000000d9483d060901f460@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006547d3060b498385@google.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
From: syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot suspects this issue was fixed by commit:

commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Oct 24 09:42:21 2023 +0000

    perf/core: Fix potential NULL deref

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17172162e80000
start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=429fa76d04cf393c
dashboard link: https://syzkaller.appspot.com/bug?extid=756fe9affda890e892ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db572b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10839a1b680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: perf/core: Fix potential NULL deref

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

