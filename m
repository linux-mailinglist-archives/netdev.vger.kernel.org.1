Return-Path: <netdev+bounces-291108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X7T2FVi6EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:31:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D95BF61A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E6C3014656
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415B28C2DD;
	Sat, 23 May 2026 14:31:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EB27FB2E
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546709; cv=none; b=Q+ebmPBkHHzQ55EdQ00E0Ez49qoHThAEm1do2z/22xHRg00Xmxe7pO83pM05SJ8K0wsAGCparkiL6gyhNhbnlJvORHB2IwOkdL5p3S9cu4YvfTkAv16p08+PRw79fLUM0YpgTCYd+dGK5tc4EXeh6eDLUpp48eXurRWSmMSfCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546709; c=relaxed/simple;
	bh=QLj/GX5k7eFyGfeZf3Wtm2oB8X6vtQ/bwHDCPYzJK1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPU3CbyIZyQf8HyfEbxDSbk5ycewpnQ4gpZKuWBPCVnzBsToNn0MZWnRaqTWe0LSz8siBtHYUypMF8fqQhMTvHetck3jUobGTpjKRag0XhfbwxQk+MxQw47JyIQff5QcTH370o6zj8jFhfmWO7BtSIeuKiZygI8l/6AbS+qE2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67f6d4f0d70so1104739a12.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546706; x=1780151506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuWEfTQYjsCVqVvHObEiNmRNaaJS3/KGoVEjCdjn4Xk=;
        b=mRG1Wztigd9f8lVOP9pawaf5c3qmY3bb7OFoEvVBk9p+eCs+UeiikH79EyCif5y+R8
         7JtLZ5O1L/fAQvqG+NMMeFjui/OKWPyXBmiX4ShWsVD6EIKuLv/zjsz+myc5qMRIvMZI
         X4WP/nu+nbBIq7BuBnyjhsyYIeHqDAcYknVU8e9vAERZKFN3GU7coVIOJVZQSeZqEDbO
         qn4W1zu9+ZCq9zzrXkNghSHUbX/6abo4KhTKe8AV9my/YrU3NWlKkkDuV273hAQGjx6g
         t2JchN5xevYeRHEMVIY9qN2V5mOXf/moAiTV97Bm3HL1rqEQldLK6JVJcHuMc3QAdgvo
         BHOw==
X-Forwarded-Encrypted: i=1; AFNElJ9by0vj6PEscRGBmcwTvImmGHhKSxayeua+bvV5i6wyaq8V0PsyG630/7njJ5FhcMzCpTRsW2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrk2CpLCrSntb7kT25cPz0m9Hk8+BS1hupNqSDgDV92rKw/kCn
	ayPzm0ROwCaoVdbOrQpz8tjiLuik8jz7F+a1+38q/mV3VIgBtw3SfTHtDIEHLlGzBDs=
X-Gm-Gg: Acq92OF+YmX0VZz6ib+sr11tHNMQxR+lS33EeJ8vHdrnoZKc7xdwW7vKS11PSpPWna3
	MqjQrG82/ToLF1rlSw/aNumKST2NXVLom1l9gu6ec4tBGJBdZrofCE7OeGiL1pgQJNp5qABFfKd
	fCyPnxcD4FaGYBiy5PdWyDEqDIeYDRIgcKXIV9vcYG9H3NhKr2A3hlyVaWDMv8hQ2r7qoHpd332
	bT3lQjHM1UTfSM+hmKYNhAicQvESw8DXMJP+qNTOd17a5GAGadUrQj1RNWAzvWTeWAACWcgJpel
	pnEF1neJhAHDTFy9C5o0kE/werVRiPe7P3U1sU1Du7gCxmG6jf5BvMKQHhWzowTaF2WcgnzpkD5
	etErobgTVrqdlrBUNivYQ9gdY3L5IRLEPMC/v3mup1oal9WBjqLZE3VYGJTthTCStodflAkQJXG
	8jJgdNd+bl9UABcDyKusGW1tjxBWQfjoM8pjo8fcnV9ybWzDaNfGg+7jDr9HYduNm+zymhsqP0L
	Iu7IWxQUjMOAoWVc9sE4tdPy3CcvuAQDBBVq73bYJ0JTNNvzQsalDyzSRlROaKQhFKmQZw+jGE=
X-Received: by 2002:a05:6402:4557:b0:66e:448a:31b6 with SMTP id 4fb4d7f45d1cf-6889cc6260fmr1414430a12.8.1779546706024;
        Sat, 23 May 2026 07:31:46 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdecae32fadsm98323366b.56.2026.05.23.07.31.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 07:31:45 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ea5252a63so265434f8f.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 07:31:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8j10C/66WNwRkhznz6ttoLllnHs3MGJ6Ggn+qQl8Nwg/9EhwWK9iuKpFNnoOLmv0GLF5vUl74=@vger.kernel.org
X-Received: by 2002:a05:600c:8484:b0:48a:56d4:7274 with SMTP id
 5b1f17b1804b1-490428ce814mr56748215e9.3.1779544847387; Sat, 23 May 2026
 07:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205071855.72743-1-byungchul@sk.com> <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
In-Reply-To: <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Date: Sat, 23 May 2026 16:00:36 +0200
X-Gmail-Original-Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
X-Gm-Features: AVHnY4Jzdbo-RS-M3p-EbMJdQhZ_EyUwot0ge9SpoXayUSqjrmRfCiJZJ7yo4J8
Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Subject: Re: DEPT (the dependency tracker) as AI review prompt? (was: DEPT v18)
To: Harry Yoo <harry@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org, 
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, 
	dennis@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net, bagasdotme@gmail.com, 
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com, geert@linux-m68k.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Josef Bacik <josef@toxicpanda.com>, Yunseong Kim <yunseong.kim@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[sk.com,vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu,meta.com,toxicpanda.com,est.tech];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291108-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kzalloc.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ysk@kzalloc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.974];
	RCPT_COUNT_GT_50(0.00)[170];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,locking.md:url]
X-Rspamd-Queue-Id: 8B5D95BF61A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Harry,

On Sat, May 23, 2026 at 2:33=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> Can we start DEPT as an AI review prompt, by documenting DEPT's
> dependency tracking model and false positive elimination rules as a
> carefully crafted prompt?
>
> While DEPT can identify deadlock issues beyond lockdep's capabilities,
> it is hard to enable in automated testing; without fine-grained
> annotations it can produce a high rate of false positives, and verifying
> them requires significant human effort.
>
> The open source AI Review Prompt has locking.md file [1] that teaches
> the AI how to review locks and detect misuse.
>
> If we can write a review prompt for DEPT in a similar manner and have
> the AI do the deadlock detection and false positive elimination, I think
> we could identify those problems more effectively with much less human
> effort.
>
> [1]
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/lock=
ing.md
>
> --
> Cheers,
> Harry / Hyeonggon

I think this is an excellent idea, Harry.

I've previously experimented with running DEPT alongside syzkaller fuzzing,
and many hung tasks missed by lockdep are caught by DEPT, but the resulting
high volume of reports makes it easy for issues to get lost in the massive
log output. Sorting through that output manually is a huge bottleneck, so
leveraging a well-crafted AI prompt to triage the warnings and filter out
the false positives would be incredibly valuable.

Leveraging an AI prompt to triage these warnings would be incredibly valuab=
le.
I'd be happy to help translate DEPT's tracking model into specific rules fo=
r
reducing false positives and establishing solid filtering patterns.

> On 12/5/25 4:18 PM, Byungchul Park wrote:
> > I'm happy to see that DEPT reported real problems in practice:
> >
> >     https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I=
-love.SAKURA.ne.jp/
> >     https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byun=
gchul.park@lge.com/
> >     https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@ig=
alia.com/
> >
> > I=E2=80=99ve added documentation describing DEPT =E2=80=94 this should =
help you
> > understand what DEPT is and how it works.  You can use DEPT simply by
> > enabling CONFIG_DEPT and checking dmesg at runtime.
> > ---
> >
> > Hi Linus and folks,
> >
> > I=E2=80=99ve been developing a tool to detect deadlock possibilities by=
 tracking
> > waits/events =E2=80=94 rather than lock acquisition order =E2=80=94 to =
cover all the
> > synchronization mechanisms.  To summarize the design rationale, startin=
g
> > from the problem statement, through analysis, to the solution:
> >
> >     CURRENT STATUS
> >     --------------
> >     Lockdep tracks lock acquisition order to identify deadlock conditio=
ns.
> >     Additionally, it tracks IRQ state changes =E2=80=94 via {en,dis}abl=
e =E2=80=94 to
> >     detect cases where locks are acquired unintentionally during
> >     interrupt handling.
> >
> >     PROBLEM
> >     -------
> >     Waits and their associated events that are never reachable can
> >     eventually lead to deadlocks.  However, since Lockdep focuses solel=
y
> >     on lock acquisition order, it has inherent limitations when handlin=
g
> >     waits and events.
> >
> >     Moreover, by tracking only lock acquisition order, Lockdep cannot
> >     properly handle read locks or cross-event scenarios =E2=80=94 such =
as
> >     wait_for_completion() and complete() =E2=80=94 making it increasing=
ly
> >     inadequate as a general-purpose deadlock detection tool.
> >
> >     SOLUTION
> >     --------
> >     Once again, waits and their associated events that are never
> >     reachable can eventually lead to deadlocks.  The new solution, DEPT=
,
> >     focuses directly on waits and events.  DEPT monitors waits and even=
ts,
> >     and reports them when any become unreachable.
> >
> > DEPT provides:
> >
> >     * Correct handling of read locks.
> >     * Support for general waits and events.
> >     * Continuous operation, even after multiple reports.
> >     * Simple, intuitive annotation APIs.
> >
> > There are still false positives, and some are already being worked on
> > for suppression.  Especially splitting the folio class into several
> > appropriate classes e.g. block device mapping class and regular file
> > mapping class, is currently under active development by me and Yeoreum
> > Yun.
> >> Anyway, these efforts will need to continue for a while, as we=E2=80=
=99ve seen
> > with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
> > Kconfig =E2=80=94 meaning it=E2=80=99s not yet suitable for use as an a=
utomation tool.
> >
> > However, for those who are interested in using DEPT to analyze complex
> > synchronization patterns and extract dependency insights, DEPT would be
> > a great tool for the purpose.

Best regards,
Yunseong

