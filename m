Return-Path: <netdev+bounces-66205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D483DFB1
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242731C22732
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2D1EB56;
	Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuMOAnmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFB219F1
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289360; cv=none; b=Ig6Qtfq6hMCI3quJK/AEddsoyxfL84Dl0IoYZKsvQ3jOd7Y8Gj+jouXJwAEIyEN9buWmdF6TAKA/gjPfGPT09/Esoi/kH1TSz7Z6Z/opwE6+psCHGdigmRbZdB/Cp6KhysVwXaXHkUUnGYZdvsQwiq2Yug0f+Dex/jc5OtDf31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289360; c=relaxed/simple;
	bh=8XaBTDIMQ7Os389dZeTpgc51FNFl/9H2eosDWEsCciA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bot8gtI5NpAcYxl8gXCXwDB9ixC8W3an4Ff2ZtWDRD0Dg2+Vdx6PzE5LAc7/5twdJAWuchp+9o4cJKqdWLdvvOiGsC1wfcV/p5skGB+ia4kfuFW0zc2w/yctQteWM3+P86uWvuPUqqqj8YnOLA1ao6t3qdNmrZxHGK/JshOkF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuMOAnmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F092EC4166D;
	Fri, 26 Jan 2024 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706289360;
	bh=8XaBTDIMQ7Os389dZeTpgc51FNFl/9H2eosDWEsCciA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kuMOAnmr2QPE6h2p80XKkJxGSaI+RLbSBg1n6xCpLXaChDrD1Ltlm70VRWVwxTX82
	 pkRoXMIaKQf4Te1r1mwcayllRhV/KLW1GJo8ElzUwkpulURPEo6ZqNW8IuKtpKEymX
	 c7d9gTMWkYnzWvPeQ6IxYqigewZ5WD4q95tqfWFS6dKwQQxFb3c4e0s3mUoqLR1HE0
	 H5FxOBjWyXCK9jI/k4xDwHPUz5fOlb3CfSKzzYu6KbZ4WZJzBmWHmjqQKTZ7PXf1Sk
	 P/k99mAQtON97IxjnVUsNWjBbpmUtYtXLcr4jXeuk5HPuRagGyW+Qv+1yIjvvldy8q
	 arAZw3yks6Cxg==
Message-ID: <4ef7815a-b219-4254-a0ed-948de82da87e@kernel.org>
Date: Fri, 26 Jan 2024 10:15:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] spelling fixes
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240126005000.171350-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240126005000.171350-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 5:49 PM, Stephen Hemminger wrote:
> Use codespell and ispell to fix some spelling errors
> in comments and README's.
> 

would be good to run those tools before releases. e.g., I noticed a typo
in one of Victor's patches yesterday after applying and pushing.


