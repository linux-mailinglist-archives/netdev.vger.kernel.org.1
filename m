Return-Path: <netdev+bounces-22135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C587F766266
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E791282610
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E017F9;
	Fri, 28 Jul 2023 03:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408A17EC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B254C433C8;
	Fri, 28 Jul 2023 03:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690514932;
	bh=76O3/OzQ12gtVktUqmmUnI31vjwENyYHhcDhdnLesc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feYeINk0/xC7jzO9w4HmVaeRKsCVxNQj4shmJ2qyB14aa24QSl67rYEmC+AvY9CnF
	 4EhFSZPunXW5IRqLid7tmGlqbH7nbdrW7JrrhlItG3oxFKyhxCFjpnDkEJe7jvWavO
	 ma5L30HN8JWFb6woiS6SrQ/9qygXeNxCJNkKw9EeaWj1e/HUjZMXBRCG7+rzyvhE7B
	 je52l3BvOSjdINUSbr7OY4HOelaeHRd3mhJ6gMqAk7Bn0JwMn7cdnFgiNZZqqBeI5x
	 C2lwBp346Tssdta0+IJguTfXbBPYCZHH6DU4Gys6bgqs4itPdtexVGxJo2SW2JZnEF
	 Ng1hzIJPaQPkg==
Date: Thu, 27 Jul 2023 20:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netfilter-devel@vger.kernel.org>, Zhu Wang <wangzhu9@huawei.com>, Simon
 Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 1/5] nf_conntrack: fix -Wunused-const-variable=
Message-ID: <20230727202851.5a7cc498@kernel.org>
In-Reply-To: <20230727202811.7b892de5@kernel.org>
References: <20230727133604.8275-1-fw@strlen.de>
	<20230727133604.8275-2-fw@strlen.de>
	<20230727202811.7b892de5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 20:28:11 -0700 Jakub Kicinski wrote:
> > We include dccp_state_names in the macro
> > CONFIG_NF_CONNTRACK_PROCFS, since it is only used in the place
> > which is included in the macro CONFIG_NF_CONNTRACK_PROCFS.  
> 
> FTR I can't say I see this with the versions of gcc / clang I have :S

Ignore. Just my stupidity.

