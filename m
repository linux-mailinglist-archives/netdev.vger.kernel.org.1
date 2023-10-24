Return-Path: <netdev+bounces-43896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9C7D53C6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649721C20381
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3032C859;
	Tue, 24 Oct 2023 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="equS3lq0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0F134B1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:19:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35E109
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698157185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LHDAQ5bt6PFREmfdQqDTjLBVx5CvlJgpZKTKibBhzg=;
	b=equS3lq0M2+t9LOqCQkXKpyjy+RDSGjnKMm3enpi5I4n9rjGzBkEs7n22Mj4wTCsnAcwwr
	+MsAfCrWWx2lL0n6ILI/fDkr2EZhzspl3t4+mP+lUsjzeY64g5Fs2+oHzWL1v2lOnrfA77
	yBmsiMEkrwrh7bvtkJK+SzFXqNwB9Hs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-vBdAtiMXOUe6cKBcDeIXow-1; Tue, 24 Oct 2023 10:19:33 -0400
X-MC-Unique: vBdAtiMXOUe6cKBcDeIXow-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-69eac5ffc69so3443316b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157172; x=1698761972;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LHDAQ5bt6PFREmfdQqDTjLBVx5CvlJgpZKTKibBhzg=;
        b=uYx093rdmyLSWMw6mhsU1sZ0ULJ2zXNPFk+oZpgntT2CHLoWvqBACkfPm69BxjvnG+
         pFHZIM2VxePfJ1RV4orrWZim3m18r4zZM8qhlr+Fh8MGLg0vEerxOBQjXW30MJIe6kq4
         +y6JMNsyfcllj3RRQLk+LuOGroDc74Ma2uv1ul07YHr96wk7hG5VMfBdWPrCnvNgZr+u
         WU7e9OP96Bl/iT/nF01sG6YJQ6rpeOYt3ni3qlcGv7Cw9p4Iku2YNf8qcL6+Am5gZNep
         YRBDj7hBWjjzL/Bs+auNKIVddrqxT5kED1q+nc+wjlZXFC2zsOHswsv4Uur7/HnH+vnd
         PNCg==
X-Gm-Message-State: AOJu0YxaYPKb5pxmfrOU02OcCUSdOvLM+/Eq3bESEGq2gVHkBQC+L1us
	zlE6i4XwewEOARlYu1lBDKjhSWPJjGikGINC/2WdpmZgpKvnq2ithxTVJTRTjidFWsZhDtMI3k2
	FKQq2ciUqa3vw77QK
X-Received: by 2002:a05:6a20:430e:b0:14d:6309:fc96 with SMTP id h14-20020a056a20430e00b0014d6309fc96mr2988412pzk.4.1698157172720;
        Tue, 24 Oct 2023 07:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGQWjZoTCfvmq4HN0bJjupcjDugD8G2wluUAPe8rRtnQ7V2omOYmSs6F7du1qO6htcvKSzAA==
X-Received: by 2002:a05:6a20:430e:b0:14d:6309:fc96 with SMTP id h14-20020a056a20430e00b0014d6309fc96mr2988387pzk.4.1698157172436;
        Tue, 24 Oct 2023 07:19:32 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:f0fd:a9ac:beeb:ad24])
        by smtp.gmail.com with ESMTPSA id z64-20020a633343000000b005898a3619c7sm7128844pgz.48.2023.10.24.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:19:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 23:19:26 +0900 (JST)
Message-Id: <20231024.231926.1671064705010862132.syoshida@redhat.com>
To: kuba@kernel.org
Cc: jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231023155314.50b13861@kernel.org>
References: <20231020163415.2445440-1-syoshida@redhat.com>
	<20231023155314.50b13861@kernel.org>
X-Mailer: Mew version 6.9 on Emacs 28.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 15:53:14 -0700, Jakub Kicinski wrote:
> On Sat, 21 Oct 2023 01:34:15 +0900 Shigeru Yoshida wrote:
>> Link names must be null-terminated strings. If a link name which is not
>> null-terminated is passed through netlink, strstr() and similar functions
>> can cause buffer overrun. This causes the above issue.
> 
> If strings need to be null-terminated you should switch the policy here
> https://elixir.bootlin.com/linux/v6.6-rc6/source/net/tipc/netlink.c#L91
> from NLA_STRING to NLA_NUL_STRING, no?

Thank you so much for the feedback. As I'm not so familiar with
Netlink, I'll study NLA_NUL_STRING a bit more and make an updated
patch.

Thanks,
Shigeru

> -- 
> pw-bot: cr
> 


