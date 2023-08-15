Return-Path: <netdev+bounces-27580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3877C714
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C9528134A
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7C3C27;
	Tue, 15 Aug 2023 05:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33524418
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:30:10 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AE199B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 22:30:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-92.bstnma.fios.verizon.net [173.48.82.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37F5TlsN002022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Aug 2023 01:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1692077390; bh=KV8dziXjkt2w+JS9iEHu4PQQdHS/0krnQy5HzZLUJaE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HgRUJ5nFM8FqNUDGQuMtyqAjm6sgDHSZnNCFVsd4ImQ4jD0ZEIUlFu+gyzg6L54cx
	 bCds0BnTMCc9ptxiyfi7Xk6riBcdjE1/c+mJZXSsdP7GVti85+bylqf0oXq+vTZRZg
	 YJdxdK05EMkk6UCDBIK7ET0jROuNqpbJd1eXbQKNcfRufMS1zSa415kZOBX3oMcprT
	 vNmH1nfIUPUDJO6u2qKoQOSBOniUHKt5y8Fr5SSmnhKKtQYyvKFwtgw3HRlI5mrM+T
	 XLS7ZQP2K/lwDynTBXVMAGmY72VSegtRu2imOk0c9o0fOlgobDBVg5bHt7kkqOaXx/
	 R4NeIyGj6ArXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A9D0615C0292; Tue, 15 Aug 2023 01:29:47 -0400 (EDT)
Date: Tue, 15 Aug 2023 01:29:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, ksummit@lists.linux.dev
Subject: Maintainers Summit 2023 Call for Topics
Message-ID: <20230815052947.GA3214753@mit.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This year, the Maintainers Summit will be held in Richmond, VA on
November 16th, 2023, just after the Linux Plumber's Conference
(November 13--15th).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

Linus has generated a list of people for the program committee to
consider.  People who suggest topics that should be discussed at the
Maintainers Summit will also be added to the list for consideration.
To make topic suggestions for the Maintainers Summit, please send
e-mail to the ksummit@lists.linux.dev with a subject prefix of
[MAINTAINERS SUMMIT].

For an examples of past Maintainers Summit topics, please see the
these LWN articles:

 * 2022 https://lwn.net/Articles/908320/
 * 2021 https://lwn.net/Articles/870415/
 * 2019 https://lwn.net/Articles/799060/

Invites will be sent out on a rolling basis, with the first batch
being sent out in roughly 2 weeks or so, so if you have some topics
which you are burning to discuss, why not wait and submit them today?  :-)


If you were not subscribed on to the kernel mailing list from
last year (or if you had removed yourself after the kernel summit),
you can subscribe by sending an e-mail to the address:

   ksummit+subscribe@lists.linux.dev

The program committee this year is composed of the following people:

Christian Brauner
Jon Corbet
Greg KH
Ted Ts'o
Rafael J. Wysocki

