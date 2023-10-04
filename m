Return-Path: <netdev+bounces-37966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750237B8119
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9636C1C208BA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2214AAE;
	Wed,  4 Oct 2023 13:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7C11197
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E64AC433C7;
	Wed,  4 Oct 2023 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696426662;
	bh=EW+SOzweDOTmUrhWR9WwK3lV4TdWi5kkhCLVjj1HcA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYGjqez448ydZT0pgKa0kY7NJM73unLs29TRkEh4OWDeLetzzUMoRrd98TB8Oz4I3
	 xdQKcKnF8Rh45lE17ZLTiHcZHREEyGyhw0DYADHP0WF7VY2KKxVQ3H4ve4+G8A+NUM
	 sWu/hx9Ec9iWHiG15FUg18KZ+HOOjMkt/mOotqOsquyiT1/s1CfvNBfLry4dOWiwx4
	 cuJvPLDZR96RLDddCV5iS4W0bTOq+nFUMW0ixnZfpS5vUeYich4qOPQtP6bpXSViK1
	 AbcQZt4iX/XPc7DegHuF0uWBjUOiu49LjmgwVxpC998aasjZv9fJPhf8bLEkGBdWSc
	 Wxn/v/kVFovrg==
Date: Wed, 4 Oct 2023 06:37:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
Message-ID: <20231004063741.0f53bc19@kernel.org>
In-Reply-To: <20230916010625.2771731-2-lixiaoyan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
	<20230916010625.2771731-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Sep 2023 01:06:21 +0000 Coco Li wrote:
> +unsigned:1                          threaded                -                   read_mostly         napi_poll(napi_enable,dev_set_threaded)

I don't see ->threaded being used on fast path.
napi_enable, dev_set_threaded are not fast path.

