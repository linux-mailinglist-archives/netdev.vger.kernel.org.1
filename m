Return-Path: <netdev+bounces-13467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DF73BB71
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366DB281C54
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8121AD4E;
	Fri, 23 Jun 2023 15:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF5C151;
	Fri, 23 Jun 2023 15:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C576C433C8;
	Fri, 23 Jun 2023 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687533627;
	bh=p4YqjWlpHfO8CnjWmeHcdlXPNWLtBviMP1yIdFYTk8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O5nav8yk4i7R8Bxuad4YzSjTKcNENCreuMYJUXw2hQcEJi470MFVjfg3oVVw0Qd5B
	 E/h3b5PsjK8WM6ySOa8Pa/un2odzdkXyXWr9Znbl/I3sSWDAAAJC/keOhPJYtwzBl5
	 AKuzfoXv5jbkrvN+uaNgmcmcq+19En6tzkjgZKhoybY5xwMdSbmVTop5i80SreRUpC
	 Q1vSHPV3uw7a0IWSrRUV8ZHftSVR855VD2CeVckiO2SS5ZSdTNWsfSfJRjepSvACAq
	 7WGIg1AbbfGUUdY0FSikwshCoGNusmZ0mSTVqRJR2iG9LJJpu+cDnKf8YZGibR42a3
	 v70BIi37bCZDA==
Message-ID: <5c6dc00b-9e25-501f-1497-ce7f67694a0e@kernel.org>
Date: Fri, 23 Jun 2023 08:20:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 1/4] net: wire up support for
 file_operations->uring_cmd()
To: Stefan Metzmacher <metze@samba.org>, Breno Leitao <leitao@debian.org>,
 axboe@kernel.dk, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, leit@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dccp@vger.kernel.org, mptcp@lists.linux.dev,
 linux-sctp@vger.kernel.org, ast@kernel.org, kuniyu@amazon.com,
 martin.lau@kernel.org, Jason Xing <kernelxing@tencent.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Willem de Bruijn
 <willemb@google.com>, Guillaume Nault <gnault@redhat.com>,
 Andrea Righi <andrea.righi@canonical.com>
References: <20230614110757.3689731-1-leitao@debian.org>
 <20230614110757.3689731-2-leitao@debian.org>
 <6b5e5988-3dc7-f5d6-e447-397696c0d533@kernel.org>
 <ZJA6AwbRWtSiJ5pL@gmail.com> <e72f4c43-02a7-936c-e755-1b23596fc312@samba.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e72f4c43-02a7-936c-e755-1b23596fc312@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/23 3:17 AM, Stefan Metzmacher wrote:
> 
> I'd like to keep it passed to socket layer, so that sockets could
> implement some extra features in an async fashion.
> 
> What about having the function you posted below (and in v3)
> as a default implementation if proto_ops->uring_cmd is NULL?
> 

Nothing about this set needs uring_cmd added to proto ops. It adds uring
commands which are wrappers to networking APIs. Let's keep proper APIs
between subsystems.

