Return-Path: <netdev+bounces-17342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4A751554
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF11C211F3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F9368;
	Thu, 13 Jul 2023 00:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E47C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E81C433C8;
	Thu, 13 Jul 2023 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689208380;
	bh=0pgs+dJC6SUNrv6qd4d/N/PGP8PY7LvpePvi57H08Eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXikFLbu4JyLCbZGbST6N4Jbdvh5xMilDa9T/2M+VlorWHbn+M5TsEvh7no6Zu3No
	 zBSbcf5DMN7u+u+eIfuTCbKY6MPxt7kQfdD38NRoKA1o20NGJhIL7JldRCvUU6CsJC
	 r8Sj5+Sokcr6DZ82jWCEdPxFoNODZEq2B8QrvSbCP51iWoDUrwXICFHS9L4xgFjvPR
	 JbzQYcuym+27CSF0msEg9kG6KmtJGEQxv4c8OYL31d6CoKGByfpGXxJ6v/OXZUy4i+
	 CXoRHFtxXtiURGVzuoyp4GzO0OPy2OXwn/h8UvNs+grYt/b6Ot3NjaAvTmDfPfhw6A
	 XQoLNuDKJENvw==
Date: Wed, 12 Jul 2023 17:32:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jianbo Liu <jianbol@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230712173259.4756fe08@kernel.org>
In-Reply-To: <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
	<5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 12:29:07 +0300 Leon Romanovsky wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> The rule destination must be comprared with the old_dest passed in.
> 
> Fixes: 74491de93712 ("net/mlx5: Add multi dest support")

This says Fixes, should I quickly toss it into net so it makes
tomorrow's PR?  The commit message is pretty useless :(

