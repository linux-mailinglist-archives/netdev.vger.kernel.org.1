Return-Path: <netdev+bounces-123473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53367965027
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0D289E3B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAB1BAEC5;
	Thu, 29 Aug 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dybSh7Q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518461B9B40
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960597; cv=none; b=snHWFj+8YP5n2McyXOFWfH8jw2UbXfyOGrjjc1GhUGEO7bc3EOGOZrCEzUs6dmow1yXfVYK3+5BCyBQr3bCjTha988X3/INagyABE8mAfTc+PK5I+hLN9WdEAoCXTXExlQbT1Z5NENPkf7jjV7Sk0FVwRTy5+I/tV7+w3jFNcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960597; c=relaxed/simple;
	bh=ZtJSckVPkICb28+Azn9jm8zTtrlzliRM1HlFPgcv7oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6hByPVwO54geo4D7SBfJs/OzTcE5GBpiKStVHKCK91lknZsG9OYcy0V6Kbn4G8qKC5XoXjPxPPmaqYqPd2JMNhifXTpA+xjrZXSGKWto7y7HbQUFfiuEdO/Ms5FWCmmWsZmSoSqRUP4iSArLtwAebGgQYa6RIIhbyqlej03xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dybSh7Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE0EC4CEC1;
	Thu, 29 Aug 2024 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960596;
	bh=ZtJSckVPkICb28+Azn9jm8zTtrlzliRM1HlFPgcv7oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dybSh7Q8HkIqNdtwwInadaTS40jMFYRHqsRyYbPX70YwB/OORtCwptmBJTewNn8rY
	 PUIEjUgOzI4UkXF2+hlyuXCEgoa2OzDNw1OMmMB1boNVG8TyBco1p+tqDjhgoNed5v
	 XCEHXL9R1+V0RmGvu083KVkv2lJ4FU5RzbkP/bSdDv6Ar9SVgE/2+FqYMpZubRCxfQ
	 A90O47rOxdzxuxhxmlvyCP+3AiAnEIrMtN7h5e20+JtbcjDBhtwNt0XZVcwayT9bku
	 mDbhgHWfDmQkhRPLQVlkjsRTEr0ocgXAO6YKYQBpFwZy5CrNBNx6G+xG+kf4VEPnjg
	 rxNskLK/9s2JA==
Date: Thu, 29 Aug 2024 12:43:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me,
 martin.lau@kernel.org, ast@kernel.org, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: error check scanf() in a sample
Message-ID: <20240829124315.0d765696@kernel.org>
In-Reply-To: <20240828180246.GA2671728@kernel.org>
References: <20240828173609.2951335-1-kuba@kernel.org>
	<20240828180246.GA2671728@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 19:02:46 +0100 Simon Horman wrote:
> I was able to reproduce the problem on Ubuntu 22.04,
> although not on Fedora 40 or Debian Trixie.

Thanks for the info! Made me pause and consider putting the fix
in net, but it's just a warning..

