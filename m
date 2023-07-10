Return-Path: <netdev+bounces-16566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A3D74DD5F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A611281437
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533A12B74;
	Mon, 10 Jul 2023 18:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2B14AAD
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D34C433C7;
	Mon, 10 Jul 2023 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689013981;
	bh=Pv/lcySJO1XElAFhqqvd4ig1BMThJRh3ymVy3haiYOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0sUysvFq2/EErWjQ6pNbUPnDRkgdK1x4lTcQnGR34CMyvsTAL5fmXjEXuaXW8fEM
	 Huky67w2Io4ttbGXWldeTI28Y8CM0q2j+9L7XDh1sDbJ5FJNdZ1YCmvdiUKpMGQWNP
	 T1BI98TSuIwjDBpaWp7j7V3CRPxI9nC/Q5MvbCbepE7kGkDR4UH7XHFDOZCFzSbdtu
	 Xr5yMBxiE6bF+YVuh+IcJaIh1PuxhS4eYf5xDvK2ya8Vzd5F/wJyGqEdncZAasExqU
	 +ySUD0BCGWeAgtVtiY1I4ULCD9881lfq/dANEISJiJpgHPxpmYePOwxBeOvkM7CNkS
	 Fu3yC8vLMtwtQ==
Date: Mon, 10 Jul 2023 11:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
 david@fries.net, edumazet@google.com, pabeni@redhat.com, zbr@ioremap.net,
 brauner@kernel.org, johannes@sipsolutions.net, ecree.xilinx@gmail.com,
 leon@kernel.org, keescook@chromium.org, socketcan@hartkopp.net,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Process connector bug fixes & enhancements
Message-ID: <20230710113300.10cba1b3@kernel.org>
In-Reply-To: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
References: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jul 2023 19:34:14 -0700 Anjali Kulkarni wrote:
> Oracle DB is trying to solve a performance overhead problem it has been
> facing for the past 10 years and using this patch series, we can fix this
> issue.

You sent this when net-next was still closed, please read the first
few sections of: 

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

To be fair towards folks who follow the rules I need to discard this
from patchwork, please repost later this week.
-- 
pw-bot: defer

