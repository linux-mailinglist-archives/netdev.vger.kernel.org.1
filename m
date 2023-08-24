Return-Path: <netdev+bounces-30206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5FF7865D9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9233281423
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482724528;
	Thu, 24 Aug 2023 03:35:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAB24521
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5CEC433C8;
	Thu, 24 Aug 2023 03:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692848139;
	bh=sbR7aCuEj5eVbg6IJIuBs2lOlk3UoQ5wAtQPtb6P5QM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jdrlxtOciSK86Gccra7HgdQaq1QwQaIOy9bYBMypzD2OXPxtnudOXVnhXuK1985n8
	 UAPnVephZah7ctxQWK0qv55AyqQNHsotbvD5W9/+CDoLhIXfMZsL3gaS9chfJLew7C
	 uqbrT81BNoO1nfWEWunMj73EWmXxCYS2pTX/MaikwKnonlvDpbbCvrbeBpBqPoFqxj
	 Qcf+p93aXmJfe1DjqP9nGzh0imagLIKRa2w5NWjsaq6CZ2okUFAkQdI6V6ZD4EESuH
	 39OVMRQ7P0ZQzP7SQHJTwOVtquxT+/nKulB+/vQtftoNRKH/dTlF63SfdIZlS/qYFt
	 aVM59Q8oQY+YA==
Message-ID: <84bd646f-0e83-63ff-7374-822ad328af0e@kernel.org>
Date: Wed, 23 Aug 2023 20:35:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 00/11] Device Memory TCP
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Mina Almasry <almasrymina@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Hari Ramakrishnan <rharix@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Andy Lutomirski <luto@kernel.org>,
 stephen@networkplumber.org, sdf@google.com
References: <20230810015751.3297321-1-almasrymina@google.com>
 <7dc4427f-ee99-e401-9ff8-d554999e60ca@kernel.org>
 <7889b4f8-78d9-9a0a-e2cc-aae4ed8a80fd@gmail.com>
 <CAHS8izNZ1pJAFqa-3FPiUdMWEPE_md2vP1-6t-KPT6CPbO03+g@mail.gmail.com>
 <1693f35a-b01d-f67c-fb4e-7311c153df4a@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <1693f35a-b01d-f67c-fb4e-7311c153df4a@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/23 3:52 PM, David Wei wrote:
> I'm also preparing a submission for NetDev conf. I wonder if you and others at
> Google plan to present there as well? If so, then we may want to coordinate our
> submissions and talks (if accepted).

personally, I see them as related but separate topics. Mina's proposal
as infra that io_uring builds on. Both are interesting and needed
discussions.

