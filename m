Return-Path: <netdev+bounces-230159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D892ABE4C2C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00E214F1424
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A333CEA0;
	Thu, 16 Oct 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3t28COI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B132FF74
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633924; cv=none; b=PEPU9MNCXHjTYWhDiThzw3U5Bks6JXdww7GA8lA2cwXXd35Cwyj21oDqxTczCiPgehBm4P9ZeYY4mT1FJ1qEPiuceRV0s+ruAoPtwYMdbN4rRCyvPui9GeXQ8LrNWIIIR4AwsJUF7pMrXguhJRmqd+UKBDtV4+pIOpPZXPVOHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633924; c=relaxed/simple;
	bh=EoTmt3XVv4FgsbiT10WziGz+GgB71HkKxfgg14OhWZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiCfX65uRh+XKSApEAfRDQFzdP+D/6w4CCSR7zevo5SuJQcFfJgsNSCYFqP7pDbNP57an+Km5jnHfMm/6kYR349Vef8TGNxfHNUra83lzfHdTFFVnf1gygnWynAYVf7XYZrGqm3X+kWogwDI8w0Mm58/PsuFS2ypPaFMRNu37Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3t28COI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869A5C4CEFE;
	Thu, 16 Oct 2025 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633923;
	bh=EoTmt3XVv4FgsbiT10WziGz+GgB71HkKxfgg14OhWZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3t28COIEBpGw3TyM0Ggxy8QCXguRbRsbmkkP9RMkpOw5OSj1bqSfD9AVagcV3FsR
	 n05lzK56QYkaBELRN3v0dSEZPIYtk5TWx3YrlpoNld27N+IrpQbx3Zs9KJ1XhiE9Zy
	 euOl1gAcy+zFV7owi8Sc4Q0N7XPsDwq9FcJb9OUnSIyCpljbtNTxm4Ax6epTc6O7Xz
	 onTh6hUb+z48KAILyzKxME6BFQ7Dx2dKNvaJpUlm47YOLeYuEDEiYjtaxcn2SHmfQc
	 FRy1Vty3Lyowka60IECMZIgfwJMq+kGWSnI7HCt/HVlvNrZlIbRPkwANFLuxSyCMkR
	 P571wm6lhhqZg==
Date: Thu, 16 Oct 2025 17:58:40 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: Kconfig: discourage drop_monitor enablement
Message-ID: <aPEkQA6cF2-STgv2@horms.kernel.org>
References: <20251016115147.18503-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016115147.18503-1-fw@strlen.de>

On Thu, Oct 16, 2025 at 01:51:47PM +0200, Florian Westphal wrote:
> Quoting Eric Dumazet:
> "I do not understand the fascination with net/core/drop_monitor.c [..]
> misses all the features, flexibility, scalability  that 'perf',
> eBPF tracing, bpftrace, .... have today."
> 
> Reword DROP_MONITOR kconfig help text to clearly state that its not
> related to perf-based drop monitoring and that its safe to disable
> this unless support for the older netlink-based tools is needed.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

I think it is always good to guide people in the right direction.

Reviewed-by: Simon Horman <horms@kernel.org>

