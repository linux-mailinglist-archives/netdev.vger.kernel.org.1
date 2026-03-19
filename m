Return-Path: <netdev+bounces-269234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBHBOHZIu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DD2C4346
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC173304C964
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55008245005;
	Thu, 19 Mar 2026 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CknM6L7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207C13AD1C;
	Thu, 19 Mar 2026 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881294; cv=none; b=NB3hyhe/CxHfqbb6hjOoCUxbYhiZV1pS2zwGs0SbqQyhACfwnwJI/ZwCGk+h6IOqvPLjVIP5RTaLpj0UWZo5PP1lzDtmIDh0obCJBEmb91yEbRQ2bkfaSbQZ19DS2helD5+nm8w2V4LuBvLNDmW7Rd9Vmxbmm5hnjncKREGhNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881294; c=relaxed/simple;
	bh=hUPnhryem7Z7L7HhT+6XI7VnZIDhNpkTyk83GYe2Gco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gbu2OccAOy0Y18cfKgx1WhfnG+XuGfrdVuJdCX6iOxx7r3GkMaOuGkcnvc/G3loKd002KfVDI6xQB9+IUCW10Qxlg6KPE4CfQx8P/mXEvhRWyObi0stsAAC+P588OOw4DN/mVC2WiQmDXIi45C7YddFoqH7z4MB2wNw1gGBeJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CknM6L7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58191C19421;
	Thu, 19 Mar 2026 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881293;
	bh=hUPnhryem7Z7L7HhT+6XI7VnZIDhNpkTyk83GYe2Gco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CknM6L7o5GW83o61zTnM2QSxykyIVSrYKTnqEg6yJDkHjRr0gam6ljOI2MIGnznlM
	 Nb3J9KcFMtVo6EsSAe7a8/sjXWL+RCyO/W9EZI3UunlXeGTjFuRH9Tvx8fUx3X1tVf
	 t2kWZkRM2wACnTveJpfzxCtqM0xU77MxmNsqUOGcCDwSIgDDu65kxOp15oPHG/zD5e
	 hp4/dKbbmfnFUUmEzkPcXBD2w/5qM2LWhIpmGXHOiN6+217Iaz9rritlnQtVohxN1Z
	 35Dm2BCfDgZ9UZATFhFjvEq9v8vfkhdJEDq1Qjh24gHUlzTi+jVaobISYelwi6+XRz
	 9CKwOp9pBEGow==
Date: Wed, 18 Mar 2026 17:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260318174812.2dafba4d@kernel.org>
In-Reply-To: <20260318162134.5906d048@kernel.org>
References: <20260317140141.5723-1-fmancera@suse.de>
	<20260317124904.552d57e4@kernel.org>
	<ea482a29-b9bd-4365-b771-2bc03bebad3c@suse.de>
	<20260318162134.5906d048@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269234-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 578DD2C4346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 16:21:34 -0700 Jakub Kicinski wrote:
> > This is test is applying the series in top of bpf tree which has this 
> > commit 
> > https://github.com/kernel-patches/bpf/commit/972787479ee73006fddb5e59ab5c8e733810ff42
> > 
> > AFAICS, net-next tree do not have it yet. I do not think I can do much 
> > about it for now. Will wait until they are merged and rebase in top of it.  
> 
> I see, hopefully trees converge tomorrow, else we can fix it when
> merging.

Looking closer and talking to Alexei the fix is actually in bpf-next
not in bpf. So let's just merge your code and we'll deal with the
fallout. But please still look into the fowarding warnings, of course.

