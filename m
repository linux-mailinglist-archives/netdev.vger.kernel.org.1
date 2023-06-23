Return-Path: <netdev+bounces-13267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169E73B0DA
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 08:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ED71C20FBF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81F7E0;
	Fri, 23 Jun 2023 06:39:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EA631
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98172C433C0;
	Fri, 23 Jun 2023 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687502345;
	bh=iFBluZgbfn+sdQvZyC2wQEmmUJLtS9xT48/IO3SiJqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayRLooXwXW5LNUgFHZ2K51VbAoLQcGHUS+/Ce179Z37xQgxhXxLXimzO5+wKqj2Ze
	 gyoMICh1ojlhEqxFrWPFIdfckbNFVLcLHJnaj2xzxMVvTTYb6JkCF71VBCu8YkvQbZ
	 DXF9Ve37afETElX8dvHDIhXkYE68xTHV2qv8sVfs=
Date: Fri, 23 Jun 2023 08:39:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] io_uring: Add io_uring command support for sockets
Message-ID: <2023062351-tastiness-half-034f@gregkh>
References: <20230622215915.2565207-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622215915.2565207-1-leitao@debian.org>

On Thu, Jun 22, 2023 at 02:59:14PM -0700, Breno Leitao wrote:
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -7,6 +7,7 @@
>  #include <linux/nospec.h>
>  
>  #include <uapi/linux/io_uring.h>
> +#include <uapi/asm-generic/ioctls.h>

Is this still needed?

thanks,

greg k-h

