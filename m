Return-Path: <netdev+bounces-29841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B576C784E6E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600DE281240
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3315A4;
	Wed, 23 Aug 2023 01:54:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3810E9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 01:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C63C433C7;
	Wed, 23 Aug 2023 01:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692755652;
	bh=mH/uA7AJewPnCr3clledKxHkHEJDnXRgs4DTMrU9UxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cInSdojifUAVY+v7ctvgAud90yu0r4yEsPFY3GyhUoryE/0PLivoGKjs7xlV1eWG0
	 vyIrmpiAx2kxehUichmwd4o1KVWUxNjapy3SanlhsDoM45OJFpchJ+xlmWIJv8wKIY
	 RJ4/TnKunoOXTyKHnR7cdROj3z0nD4ptWEldhQWu5RJb1+gw9bsDiSGARE2BkbY8hq
	 kg8No2Db9Rlu8o0ZsLcRp6D0K4cOCz/vP//0t3HTvf+mb2KdM4kTUTIi79zWNI0DFw
	 CwnW8Xk1gMVekzmFPjltm0wTTJZM8U2yCse7BB2lqxk47xbVMqyluL9r5iaTH86h47
	 4y7Kw4gkrHUFQ==
Date: Tue, 22 Aug 2023 18:54:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>, Jiri Pirko
 <jiri@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net 3/3] selftests: bonding: add macvlan over bond
 testing
Message-ID: <20230822185411.52dad598@kernel.org>
In-Reply-To: <20230822031225.1691679-4-liuhangbin@gmail.com>
References: <20230822031225.1691679-1-liuhangbin@gmail.com>
	<20230822031225.1691679-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 11:12:25 +0800 Hangbin Liu wrote:
> Add a macvlan over bonding test with mode active-backup, balance-tlb
> and balance-alb.

The pw check you added says you need to add this script to a Makefile :)
-- 
pw-bot: cr

