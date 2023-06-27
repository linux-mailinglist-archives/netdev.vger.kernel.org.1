Return-Path: <netdev+bounces-14333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC531740311
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331232815B1
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6161ACAC;
	Tue, 27 Jun 2023 18:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD113062
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 18:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF41AC433C0;
	Tue, 27 Jun 2023 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687889881;
	bh=iYtIyO/ySZzF+IOqcCHeQhRSytBBD9onL/5yGdI7F1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngOGXNaHdjsvIlZnF6+wsprKCBG6oiYmUo7UWH9qOldOrru82Gsd5DOlMImLDyOl2
	 Hha2ReO5/ORJUUDk9UD2sT5dJskIzJ6kpPi/GCaHL7z7ZouqkTj5YbeOMZuOR9Hjfi
	 3a+bQtdw0pjAhC9Xq1xEWY2jclbs0yYJzIPaNGU06hRGbxcBD7wSimGe1/CQohQYkr
	 193QgmOkDMnG88T68YtlFm0OgD6Nr4FFdorTwDLSwQjOPKNkVUPDLW3fcyjsfopSZ0
	 LxeY+RgDwODdIQlfD1AnJXwiuNcJHmoVAheTZmykwGuDQ9qbGVYk2DWJ+gLp2yp+0e
	 BOCzttu8uS/oA==
Date: Tue, 27 Jun 2023 11:18:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 gregkh@linuxfoundation.org, kuniyu@amazon.com, io-uring@vger.kernel.org
 (open list:IO_URING), linux-kernel@vger.kernel.org (open list),
 netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: Re: [PATCH v4] io_uring: Add io_uring command support for sockets
Message-ID: <20230627111800.70035051@kernel.org>
In-Reply-To: <20230627134424.2784797-1-leitao@debian.org>
References: <20230627134424.2784797-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 06:44:24 -0700 Breno Leitao wrote:
> Enable io_uring commands on network sockets. Create two new
> SOCKET_URING_OP commands that will operate on sockets.
> 
> In order to call ioctl on sockets, use the file_operations->io_uring_cmd
> callbacks, and map it to a uring socket function, which handles the
> SOCKET_URING_OP accordingly, and calls socket ioctls.
> 
> This patches was tested by creating a new test case in liburing.
> Link: https://github.com/leitao/liburing/tree/io_uring_cmd

It's a bit late for net-next to take this, I'm about to send our 6.5 PR.
But in case Jens wants to take it via io_uring for 6.5:

Acked-by: Jakub Kicinski <kuba@kernel.org>
-- 
For netdev:
pw-bot: defer

