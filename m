Return-Path: <netdev+bounces-34410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCB7A4194
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F3F1C20CE1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F06FB4;
	Mon, 18 Sep 2023 06:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E31C07
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:56:26 +0000 (UTC)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9F0F3
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 23:56:23 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RpwYw44wgzMpvj8;
	Mon, 18 Sep 2023 06:56:20 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RpwYv6pBhzMpp9q;
	Mon, 18 Sep 2023 08:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1695020180;
	bh=W0JS7Bsx1CtCiU+24S/P6j4fgRH6Nm/XGb0DMnycSRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuCP25W3BWxawH4FD41ECC4I/T+/fGUZai+OpF8YFpl8xNgHCHuk6ncer63+nxfQF
	 CoKF35XYAssQVf21LhB3vIJJB/xrf59n91vR9uxpGuy1A4S2oBOCnMPyXr1u6TRmao
	 g1MaS+PpRZkv4AYsy8x2ekqJoqsgoLkFXWSgK/YY=
Date: Mon, 18 Sep 2023 08:56:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, artem.kuzin@huawei.com, 
	gnoack3000@gmail.com, willemdebruijn.kernel@gmail.com, yusongping@huawei.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v11.1] selftests/landlock: Add 11 new test suites
 dedicated to network
Message-ID: <20230918.shauB5gei9Ai@digikod.net>
References: <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230706145543.1284007-1-mic@digikod.net>
 <3db64cf8-6a45-a361-aa57-9bfbaf866ef8@digikod.net>
 <b2a94da1-f9df-b684-7666-1c63060f68f1@huawei.com>
 <20230817.koh5see0eaLa@digikod.net>
 <239800f3-baf4-1c7d-047f-8ba90b097bee@huawei.com>
 <20230914.ASu9sho1Aef0@digikod.net>
 <076bfaa6-1e0b-c95b-5727-00001c79f2c0@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076bfaa6-1e0b-c95b-5727-00001c79f2c0@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 11:54:46AM +0300, Konstantin Meskhidze (A) wrote:
> 
> 
> 9/14/2023 11:08 AM, Mickaël Salaün пишет:
> > On Mon, Sep 11, 2023 at 01:13:24PM +0300, Konstantin Meskhidze (A) wrote:
> > > 
> > > 
> > > 8/17/2023 6:08 PM, Mickaël Salaün пишет:
> > > > On Sat, Aug 12, 2023 at 05:37:00PM +0300, Konstantin Meskhidze (A) wrote:
> > > > > > > > > 7/12/2023 10:02 AM, Mickaël Salaün пишет:
> > > > > > > On 06/07/2023 16:55, Mickaël Salaün wrote:
> > > > > > > From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > > > > > > > > This patch is a revamp of the v11 tests [1] with new tests
> > > > > (see the
> > > > > > > "Changes since v11" description).  I (Mickaël) only added the following
> > > > > > > todo list and the "Changes since v11" sections in this commit message.
> > > > > > > I think this patch is good but it would appreciate reviews.
> > > > > > > You can find the diff of my changes here but it is not really readable:
> > > > > > > https://git.kernel.org/mic/c/78edf722fba5 (landlock-net-v11 branch)
> > > > > > > [1] https://lore.kernel.org/all/20230515161339.631577-11-konstantin.meskhidze@huawei.com/
> > > > > > > TODO:
> > > > > > > - Rename all "net_service" to "net_port".
> > > > > > > - Fix the two kernel bugs found with the new tests.
> > > > > > > - Update this commit message with a small description of all tests.
> > > > > > > [...]
> > > > > > > We should also add a test to make sure errno is the same
> > > with and
> > > > > > without sandboxing when using port 0 for connect and consistent with
> > > > > > bind (using an available port). The test fixture and variants should be
> > > > > > quite similar to the "ipv4" ones, but we can also add AF_INET6 variants,
> > > > > > which will result in 8 "ip" variants:
> > > > > > > TEST_F(ip, port_zero)
> > > > > > {
> > > > > > 	if (variant->sandbox == TCP_SANDBOX) {
> > > > > > 		/* Denies any connect and bind. */
> > > > > > 	}
> > > > > > 	/* Checks errno for port 0. */
> > > > > > }
> > > > > As I understand the would be the next test cases:
> > > > > > > 	1. ip4, sandboxed, bind port 0 -> should return EACCES
> > > (denied by
> > > > > landlock).
> > > > > Without any allowed port, yes. This test case is useful.
> > > > > By tuning /proc/sys/net/ipv4/ip_local_port_range (see
> > > > inet_csk_find_open_port call) we should be able to pick a specific
> > > > allowed port and test it.  We can also test for the EADDRINUSE error to
> > > > make sure error ordering is correct (compared with -EACCES).
> > >   Sorry, did not get this case. Could please explain it with more details?
> > 
> > According to bind(2), if no port are available, the syscall should
> > return EADDRINUSE. And this returned value should be the same whatever
> > the process is sandbox or not (and never EACCES). But as I explained
> > just below, we cannot know this random port from the LSM hook, so no
> > need to tweak /proc/sys/net/ipv4/ip_local_port_range, and your this is
> > correct:
> > 
> > 1. ip4, sandboxed, bind port 0 -> should return EACCES (denied by
> > landlock).
> 
>   yep, adding rule with port 0 (for bind) returns EINVAL then
>   calling bind port 0 returns EACCES cause there is no rule with port 0.
> > 
> > > > > However, I think the current LSM API don't enable to infer this
> > > random
> > > > port because the LSM hook is called before a port is picked.  If this is
> > > > correct, the best way to control port binding would be to always deny
> > > > binding on port zero/random (when restricting port binding, whatever
> > > > exception rules are in place). This explanation should be part of a
> > > > comment for this specific exception.
> > > 
> > >   Yep, if some LSM rule (for bind) has been applied a with specific port,
> > > other attemps to bind with zero/random ports would be refused by LSM
> > > security checks.
> > 
> > To say it another way, we should not allow to add a rule with port 0 for
> > LANDLOCK_ACCESS_NET_BIND_TCP, but return -EINVAL in this case. This
> > limitation should be explained, documented and tested.
> > 
> > With (only) LANDLOCK_ACCESS_NET_CONNECT_TCP it should be allowed though
> > (except if there is also LANDLOCK_ACCESS_NET_BIND_TCP) of course.
> > Another test should cover the case with a new rule with these two access
> > rights and port 0.
> 
>  I think it's possible to have LANDLOCK_ACCESS_NET_CONNECT_TCP with port 0
> with LANDLOCK_ACCESS_NET_BIND_TCP at the same time, cause
> LANDLOCK_ACCESS_NET_BIND_TCP rule is allowed (by Landlock) with any other
> port but 0.

It would mask the fact that port zero cannot be allowed, which could be
possible one day. So for now we need to return EINVAL in this case.

