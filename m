Return-Path: <netdev+bounces-249477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E5FD19BEC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CD230E37D0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729CE2D73B1;
	Tue, 13 Jan 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb9QZb9S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EF2BD587
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316397; cv=none; b=Fcjjirm35t8SyHSg6R1/dYIxH5Ct2ZhazeCnesHossd97u2tr3OmlTVY5bpE+qETbVAptOjO/1ppTT74NFmOY9YHkCvsKiVMsj7JLRT4hm0NYEdUmfEuO1VPOKInVeMg1q28vnPcN7VTRWIpGrYKVvSoB8a/Zfqm+FffVKX8bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316397; c=relaxed/simple;
	bh=NHU3Ptgv9MB7YfbBit7NtNp5ITd56EPwuBv8LmzC+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ0kaXyHjaXf5PPdF4iO0Skyi8cdLPVTFrIYwnrwDQUaqAqpNOSFQUkqRH1jYj2CXRTbgMDTXBk72JjNtAiSApX8ox8KWqFQC+EpZp9goQ0tq5k37qBIO8YpYcZhaWcmZC7Nypy8YBJz0d71zrF1i4LJGzmWHPToaLnwX7qQhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb9QZb9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD20C116C6;
	Tue, 13 Jan 2026 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316396;
	bh=NHU3Ptgv9MB7YfbBit7NtNp5ITd56EPwuBv8LmzC+sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb9QZb9SeiSpALd11m6dGGYWIJoBfFw8QpRpjxOM5aOhD7qroB0KTPsXs6hh3HkTZ
	 yQU0AbojNo9sOKcaEj3TNe4F7ipcvv+cmGOQWnJjcRhd5ZBeutzamqn5fDlEzWJ8vQ
	 2Nz3M7Gkla5zSD7QLHJmfjozIWbsYf9AvM6ULrz077oXo17nCdJdFl5UfJN9OJf/65
	 D3ChFn9tn6zaDSexfD4XXXeYxMU6LQmNgGgmy7Bd/oaIwxhZYFV+7FwlU8VutJIvQi
	 kSDTpPzKhzSNUM+sysauDzfBzXkG0J9HnCX+JbfG9V50X4a6pU0gl3kBToZfkaCnaU
	 FMJtXz72kruCw==
Date: Tue, 13 Jan 2026 14:59:53 +0000
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next 1/6] xfrm: remove redundent assignment
Message-ID: <aWZd6TZwmT_Gtgbv@horms.kernel.org>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <393387273f8a903a6205f1faeb020ce92ddd61b9.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393387273f8a903a6205f1faeb020ce92ddd61b9.1767964254.git.antony@moon.secunet.de>

On Fri, Jan 09, 2026 at 02:37:08PM +0100, Antony Antony wrote:
> this assignmet is overwritten within the same function further down

nit: This assignment...

Also, redundant is misspelt in the subject.
> 
> 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
> 
> x->props.family = m->new_family;
> 
> e03c3bba351f ("xfrm: Fix xfrm migrate issues when address family changes")

And your Signed-off-by line is missing.

...

