Return-Path: <netdev+bounces-32914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF479AAEA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4B1280E49
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339115AC1;
	Mon, 11 Sep 2023 18:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D74AD23
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:55:07 +0000 (UTC)
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BC1B8
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:55:05 -0700 (PDT)
Message-ID: <72a6db5b-919f-117f-c6a9-6905e7c21f51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694458502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRP1PKEbEmPJeU4QC3w0XPHbGGtFVyjJmIhbIkzLL/Q=;
	b=LKh/90ApV70hqmTk2uKJoIrTszEGn1I5tDSxG0TqQbQYTt2iyaeNM+bmMJKhKDH7eP6xUC
	7O/kKWLtd5JjBYlkuLX/X5cD4WY+BuQ8C0c5yMZXN19TXUOvg/X8Nl95m9H5t5HEXmwKlt
	mnEKTh5CkXRgrt9+ltgwlmrtmRRG4L8=
Date: Mon, 11 Sep 2023 11:54:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net 0/6] tcp: Fix bind() regression for v4-mapped-v6
 address
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>
References: <20230911183700.60878-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230911183700.60878-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/23 11:36 AM, Kuniyuki Iwashima wrote:
> Since bhash2 was introduced, bind() is broken in two cases related
> to v4-mapped-v6 address.
> 
> This series fixes the regression and adds test to cover the cases.

Thanks for the fixes.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

