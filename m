Return-Path: <netdev+bounces-21088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3357626BD
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9402811B3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D92770C;
	Tue, 25 Jul 2023 22:27:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1E26B7E;
	Tue, 25 Jul 2023 22:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EF9C433C8;
	Tue, 25 Jul 2023 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690324051;
	bh=jnMVrAX0R5fEEcKbo2hvPXHCHTaSSBFsvmOODmFviuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+RyaSEBKXNENIXqvXLj7dqMIeEoD0Lsmyrou0YA7ms8CoO3VJBZUPqDR6RzuwB8f
	 vlUhuRzCdsUk9VsXE0/coaeovXV+C7IE4rSIoiqIR63DzP/tkLRJKvQhEYDBOKptov
	 H4rW+SefAsBiySkCuHu2ow/Vxc5GpS7L98rnJvRoSru8Ejxc6nXNSy0yEqKCa8c+7v
	 ZsmT9EviPdI4YqPugzqhLta7BI5EYsz5OvACd74o6sJ9RosGr4xBVeUrLSs3SsipF5
	 sjTqFddC9ttt9qV3UoIw5MLx6K1LTR/p6FuQNIqLoA4+7DjatxztazB2CeR6cUlkRI
	 r3/cEC/Q2u5kQ==
Date: Tue, 25 Jul 2023 15:27:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net 0/2] mptcp: More fixes for 6.5
Message-ID: <20230725152730.48dc011a@kernel.org>
In-Reply-To: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 11:34:54 -0700 Mat Martineau wrote:
> Patch 1: Better detection of ip6tables vs ip6tables-legacy tools for 
> self tests. Fix for 6.4 and newer.
> 
> Patch 2: Only generate "new listener" event if listen operation 
> succeeds. Fix for 6.2 and newer.

I hacked up propagating Cc: stable from replies in our maintainer
tooling.  Good opportunity to test that:

Cc: stable@vger.kernel.org

