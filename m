Return-Path: <netdev+bounces-208631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20FB0C70A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366493A577E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FBB28C878;
	Mon, 21 Jul 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBjBKpgM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DF1E5B7A
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109792; cv=none; b=iBgTmZN6tqeqFp3XIofEzb0QfzeIKWb7A+ImlrzByX797pnfzdhn5t6xDQTO3qncfs8y71kVQ0JtNmxLbnU1H/MAOJqN5RtsfYDxBuoNUGVYrqoFteyagAzp+iTKeGGzsM2Y1+4jGZ9DNLzu4qA5Rg+RKpe1BddOq1I+03NEyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109792; c=relaxed/simple;
	bh=t5a8R6HOj2VrHyAxZ6c7FnSj6v6R0pA0biyErGkrwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdMdV2pkbeRnTuf0NreD7AN8PiqwYD6qkUZnxGnVcJqx6EidzALBlNoOoWTQlhfvOkDMSn/1MFrK1CGmUro6MG01GDn69BRD5sfVzQe3bzJMHxhSnbs4kF4bx/sCoRssuQRCjrZmoG3s5XmydJZdlPmhTEpHmSfSuqYhITj0O8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBjBKpgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8570DC4CEED;
	Mon, 21 Jul 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753109791;
	bh=t5a8R6HOj2VrHyAxZ6c7FnSj6v6R0pA0biyErGkrwR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBjBKpgMHiXb6KAAB0a605xYmWifmSuoD65oRFm88pVTn/nrlgAPGYyLF8iqlcIJb
	 rckJQtmWi4lk55DFN1bDJI5iws3s16+71bsJ6MzqdQOMCPEayt37LlCw5PukDJRJ1E
	 gYq3y1i5S98TYsqD1bTeSLkUICMT+gc+ySwM9quH1CgHcIiuLfME+ZsGTC+w3QouIT
	 rhSxqVHdtH8ezrb+DSCUts8Yp/la2k+4Lk/qPvChWQeppEwmzi71dg/w3Rc6l+vJvx
	 Vj4kDxTxCStpKxV+ufctCv0qnTuAbpV3cc/XerBl2GzSslHnaHUKTtsRcJc4YcJBCM
	 I5abN3SycO2TA==
Date: Mon, 21 Jul 2025 07:56:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pablo@netfilter.org, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: netfilter: tone-down conntrack clash
 test
Message-ID: <20250721075630.73f77af9@kernel.org>
In-Reply-To: <aHtD9xpFpCBkMWQ-@strlen.de>
References: <20250717150941.9057-1-fw@strlen.de>
	<20250718172634.18261f54@kernel.org>
	<aHtD9xpFpCBkMWQ-@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 09:06:31 +0200 Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > Hm, someone set this patch to Deferred and Archived in patchwork,  
> 
> I did. 

Please use pw-bot commands in the future, this way everyone knows
what's going on.

Quoting documentation:

  Updating patch status
  ~~~~~~~~~~~~~~~~~~~~~
  
  Contributors and reviewers do not have the permissions to update patch
  state directly in patchwork. Patchwork doesn't expose much information
  about the history of the state of patches, therefore having multiple
  people update the state leads to confusion.
  
  Instead of delegating patchwork permissions netdev uses a simple mail
  bot which looks for special commands/lines within the emails sent to
  the mailing list. For example to mark a series as Changes Requested
  one needs to send the following line anywhere in the email thread::
  
    pw-bot: changes-requested
  
  As a result the bot will set the entire series to Changes Requested.
  This may be useful when author discovers a bug in their own series
  and wants to prevent it from getting applied.
  
  The use of the bot is entirely optional, if in doubt ignore its existence
  completely. Maintainers will classify and update the state of the patches
  themselves. No email should ever be sent to the list with the main purpose
  of communicating with the bot, the bot commands should be seen as metadata.
  
  The use of the bot is restricted to authors of the patches (the ``From:``
  header on patch submission and command must match!), maintainers of
  the modified code according to the MAINTAINERS file (again, ``From:``
  must match the MAINTAINERS entry) and a handful of senior reviewers.
  
  Bot records its activity here:
  
    https://netdev.bots.linux.dev/pw-bot.html
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status

