Return-Path: <netdev+bounces-42224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF07CDB9F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2166F280C64
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68F347A7;
	Wed, 18 Oct 2023 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ydoV8vlR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1073419C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:29:08 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E988410F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 05:29:06 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S9VWy4rS2zMq8tq;
	Wed, 18 Oct 2023 12:29:02 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S9VWw678zzMppDS;
	Wed, 18 Oct 2023 14:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1697632142;
	bh=XvR+t+nzc9jikEp2Q0y3jEkkGN2bEwNleUximI+3J+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ydoV8vlRpDd5cyYL6B9QN8BuHhh+/31e5yYvHsrU++nQgHaD9J3CuWWoJEWtoXQRc
	 /RrxhJMr6WDEaMTEK8WgwC5Crfn9wYO1vqdxyp3126/Ologe3OgJo33E8NQ65SouHf
	 GkqVIujlE88rDCrSjuTy7X8/+cnOUBvcKk0/WES4=
Date: Wed, 18 Oct 2023 14:28:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v13 07/12] landlock: Refactor landlock_add_rule() syscall
Message-ID: <20231018.uiP3miepaXah@digikod.net>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-8-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016015030.1684504-8-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 09:50:25AM +0800, Konstantin Meskhidze wrote:
> Change the landlock_add_rule() syscall to support new rule types
> in future Landlock versions. Add the add_rule_path_beneath() helper

with next commits. Add the add_rule_path_beneath() helper

> to support current filesystem rules.

