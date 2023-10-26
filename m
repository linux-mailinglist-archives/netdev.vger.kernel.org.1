Return-Path: <netdev+bounces-44500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B77D84EF
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FB28203E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD02EAE0;
	Thu, 26 Oct 2023 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks5mvVjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0C8829
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42064C433C8;
	Thu, 26 Oct 2023 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698331281;
	bh=9SyyuORY2zYSCzQsTwPiQkU3KnJEYpMWJeLnJCAl+f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ks5mvVjUrk0ZoYqklllISEQ6kUBEWBFddWbTj7cpfCvgKsRiKNJ0dtdTM6Syh8l7f
	 Vgj448xqCCL7N4YYhxOwREaYFVkLAHnE4Pyi8zpjxRT2S0I7W/FdQbJWXhHtC4jsiy
	 ps8e8AidP1MzNkqM1UGsTGt5O7B/uOMVGEPcgJjvi0p9tjfAhgK/zIRDaQOViFvpJr
	 rTVJtCGkI2izwW9SvK5FrFGMmD0na/oJKINQpKNyaSyk8E+nON+a3o7pMcJuqPdXmV
	 RIpl17ULXKzDlIlSVuA9PH1XIxQSkEV3YufpyvM4Q+mWOvsPiFVPIyBMK6m11uic/Q
	 YJa7raZKo+m8A==
Date: Thu, 26 Oct 2023 07:41:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231026074120.6c1b9fb5@kernel.org>
In-Reply-To: <ZTn7v05E2iirB0g2@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
	<20231025175636.2a7858a6@kernel.org>
	<ZTn7v05E2iirB0g2@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 07:42:33 +0200 Jiri Pirko wrote:
> {'129': {'0': [type:0 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>          '1': [type:1 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>          '2': [type:2 len:12] b'(\x00\x00\x00\x00\x00\x00\x00'},
> Looks like unnecessary redundant info, I would rather stick with
> "as_bin()". __repr__() is printable representation of the whole object,
> we just need value here, already have that in a structured object.
> 
> 
> What is "type" and "len" good for here?

I already gave you a longer explanation, if you don't like the
duplication, how about you stop keying them on a (stringified?!) id.

