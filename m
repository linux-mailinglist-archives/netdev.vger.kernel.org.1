Return-Path: <netdev+bounces-79253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD88787D6
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE94B22A23
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC16605D2;
	Mon, 11 Mar 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaqatR1h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D7605CC
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182293; cv=none; b=Ga2q6ZdhmQJ5pkqiopPxLou6HmuNvbUmm+TyPj4pNmpAGpio/9P0eCkdLq/H+Z+zzwxuh72JablKgxMXG2/lXrGNPbgg+w77mL9ir3vYeAyyczV6Vp6z/SAJtYjh7Tsi2ud0scPvGEE3p7Ehw3jEfQdk+wTiauy81+B31hK+oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182293; c=relaxed/simple;
	bh=YCVvrNarbmR3C+Arb/8JQFTXtQ1+yZpI9pLP/OsjiGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELVhr8lj3XYOvPb9aYtDClk1N/AUaqgBsUViBxO/vuhagJ+eXywaKXlnhXx56M6Rnsdvct/aUYCJuqFlgngiZvaW4Vi7iBRaK+vDagmpAVlyOB+6YxWoGLNSjYMPFHPGDSIKSjwG3KSGfXQ3/hb3J9md5bBEFK2+A9KRYISx+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaqatR1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E34C43390;
	Mon, 11 Mar 2024 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182292;
	bh=YCVvrNarbmR3C+Arb/8JQFTXtQ1+yZpI9pLP/OsjiGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IaqatR1h5x81lRsYfktnWSAQxH9hwBi1NNjjlrEObz5csHEvOegV0PQEVN2BQHEBD
	 KH0Tj3U/mLogaOX6pebYdzzIHhP4UBHCVC8S2PtC1i/P8RGd04VMi4KdaV1CnS2eaB
	 0zNJmY+h9WCYHqIHfLYpj+q3kBIQqOFXqLxNxnp78V8EU3gWTR+dRJaqlOVigJYkuM
	 eYvXwishfiE9oguZ7UsnP7GdICCDaJ9UUa8xsQDSW0OcqZiP6QY5E1JYfIGZdqehlO
	 PCXtz8DQkfl8sQARCY/UVSzpvAXWesYQuNRLyfKn0RvYWchcjQUhsP76azDff2UsEp
	 cmo5t5uSAYk8A==
Date: Mon, 11 Mar 2024 11:38:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, kuniyu@amazon.com
Subject: Re: [PATCH net-next 1/3] netlink: create a new header for internal
 genetlink symbols
Message-ID: <20240311113811.4b878ddb@kernel.org>
In-Reply-To: <dce00532-d893-40c6-9ec4-df7ad3f47d7b@davidwei.uk>
References: <20240309183458.3014713-1-kuba@kernel.org>
	<20240309183458.3014713-2-kuba@kernel.org>
	<dce00532-d893-40c6-9ec4-df7ad3f47d7b@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 14:35:30 -0800 David Wei wrote:
> On 2024-03-09 10:34, Jakub Kicinski wrote:
> > There are things in linux/genetlink.h which are only used
> > under net/netlink/. Move them to a new local header.
> > A new header with just 2 externs isn't great, but alternative
> > would be to include af_netlink.h in genetlink.c which feels
> > even worse.  
> 
> Why is including af_netlink.h worse?

It exposes the internals of the lower layer of the protocol stack.
genetlink.c doesn't really need to know those details.

