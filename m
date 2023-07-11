Return-Path: <netdev+bounces-16738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF97F74E99A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F112814F2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F47174F8;
	Tue, 11 Jul 2023 08:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93D171B7
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0521FC433C7;
	Tue, 11 Jul 2023 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689065927;
	bh=MZUIK5pK6WkVk7kP7tDBChilLdjdQIB7SQUyAfnyJTM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=K7FAFTlVczA01g5G9TanbPy2AAecoFjoXhbwGTf58h0FnkLh5gPqHZvBa0i772cJ7
	 M4WjPyftR7bc0HHQtC2pTPp0/7Ifvu6Zl6paKJNAwDYgOEriOM/RzduvzqKcYd3KoI
	 rAIfSLLO8Tf1sJHFF9nH1RgxYwIhudHvWrb8hHtY7fEpk8H3qGCsRlKVHg9ZRpziDk
	 hoGHr+EJd+iXGiBIIyyShiuZCe8LE67VUA3MqKw/o7ykOaK4CDZUMwj1Oa5ayvSf/c
	 I+NmYyxIl9v017oMpfauoVNqqc9wV5/mrUhsCVPrxqshmjQCKh3bSH/FD7CXmtoMbI
	 gU9oNrz3kNjqQ==
From: Kalle Valo <kvalo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Prameela Rani Garnepudi
 <prameela.j04cs@gmail.com>,  Siva Rebbagondla
 <siva.rebbagondla@redpinesignals.com>,  Amitkumar Karwar
 <amit.karwar@redpinesignals.com>
Subject: Re: [PATCH net 12/12] rsi: remove kernel-doc comment marker
References: <20230710230312.31197-1-rdunlap@infradead.org>
	<20230710230312.31197-13-rdunlap@infradead.org>
Date: Tue, 11 Jul 2023 11:58:42 +0300
In-Reply-To: <20230710230312.31197-13-rdunlap@infradead.org> (Randy Dunlap's
	message of "Mon, 10 Jul 2023 16:03:12 -0700")
Message-ID: <878rbm964d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Change an errant kernel-doc comment marker (/**) to a regular
> comment to prevent a kernel-doc warning.
>
> rsi_91x.h:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Copyright (c) 2017 Redpine Signals Inc.
>
> Fixes: 4c10d56a76bb ("rsi: add header file rsi_91x")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
> Cc: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
> Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>
> Cc: Kalle Valo <kvalo@kernel.org>

As wireless trees are closed for July please take this to net tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

