Return-Path: <netdev+bounces-14314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C75740189
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52750280ED5
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BF13067;
	Tue, 27 Jun 2023 16:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C21373
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638ACC433C0;
	Tue, 27 Jun 2023 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884166;
	bh=o7Yzvhzkv/qjsyn/g6Qg/Y7+cgdYE5C/HlsWPSvDEnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+rxlmWcjfIrlMIBqzqcNxWbFuXgJErYFrv25INhqxagtqsQxyD4lzLvm5i36QyYo
	 4Hh6LhlVqQrpsMKndbARr7VpJYVnAHtnKdIKDKm7ZEt7TAeBtJHawUMWbHqC8thIRs
	 vcLqiZS1C/PpfzEpf97KgwssPUzdkadnUldbPXbYc6KSrqChwAsQ1xdmCMFWT1eYkE
	 TZi2ZYAdkBkP6vODd9B5gOa9wd/JW7iRlx/AKSzbpm3M8yg95fjBINC5walB0K4G3L
	 lbXWUmpS6QhFNTrgB9LD3gcdSxZTRE70aKWhxT3A8G6UEt4dUEYK8fqOrecR6kkphJ
	 XCYhy6wGdi+5g==
Date: Tue, 27 Jun 2023 09:42:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>
Subject: Re: [PATCH v1 net-next] Revert "af_unix: Call scm_recv() only after
 scm_set_cred()."
Message-ID: <20230627094245.01753815@kernel.org>
In-Reply-To: <20230626205837.82086-1-kuniyu@amazon.com>
References: <20230626205837.82086-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 13:58:37 -0700 Kuniyuki Iwashima wrote:
> Regarding to the warning of SO_PASSPIDFD, I'll post another patch to
> suppress it by skipping SCM_PIDFD if scm->pid == NULL in scm_pidfd_recv().

> Sorry for bothering, but can this make it to the v6.5 train to
> avoid regression reports ?

I'm merging the trees now, could you send the follow up soon?
Could you respin Alexander's fix for me as well (make it a two patch
series?):
https://lore.kernel.org/all/20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com/
It trivially conflicts after applying this patch.

