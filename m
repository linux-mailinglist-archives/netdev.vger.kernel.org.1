Return-Path: <netdev+bounces-21502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71E763BB3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E0F281CCB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1026B9E;
	Wed, 26 Jul 2023 15:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0A111A3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA22C433C7;
	Wed, 26 Jul 2023 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690386943;
	bh=fEVK1J7guObqNwMR+eb/MKdbo2GMjqz7CtMBK8GxFUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnxQ9Nb1TmvZAuLMsi7FkvbI8mleuSzAgLBIz3fyJAcO14ly/k8AlWwLm75Wki5S0
	 PGY6C9ruYIADq6Gl4LPRkagNlovDXftfIsQzCyQTm6nT3QBRckimvU4CwrC4nzRUMY
	 uhaV6NBXUCuwjg3c9CDcpqno6+GAomtSTabvVBwQcfDrtEXdOVdPUCJnNXC0T+Vd60
	 TRhWfsJpJclO68tqAEdZKTZJXnW/Jv+QQfwq4RVLcyI0IziaA/FRhzhXnywYjN67di
	 y6ZQ4jC1pQtF4oHTHCIXqsAaioeYz6EcwU+eeQM8+Rj3NfjlfK2/Smo+oYAfrY76+c
	 lJnfEqTRKHUUw==
Date: Wed, 26 Jul 2023 08:55:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230726085542.402bcb13@kernel.org>
In-Reply-To: <ZMEcm5dIShMa2TQh@corigine.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
	<ZMETxe6sXMRvJZ/3@corigine.com>
	<CAAf2ycnL3a2Q5dAk6n26PDdArZbXgL1Tg4dwodS96K523A90gA@mail.gmail.com>
	<ZMEcm5dIShMa2TQh@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 15:16:11 +0200 Simon Horman wrote:
> > As I mentioned in the cover letter, it depends on:
> > "tools: ynl-gen: fix parse multi-attr enum attribute"
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> > 
> > Should I wait for that and repost?  
> 
> Sorry my bad. I guess this is fine as-is unless Jakub says otherwise.

Right, just to be 100% clear, please don't repost, yet. I'll review it
as is since it's of particular interest to me :)
Simon is right that we don't accept patches which have yet-to-be-applied
dependencies, tho.

