Return-Path: <netdev+bounces-120314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B75958E7D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469751F22FA4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838C156228;
	Tue, 20 Aug 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDRGAic+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A97BB14;
	Tue, 20 Aug 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181281; cv=none; b=Dn7p251OdbjOj0AYPfPUi6rBw2oiDMqReN31EZXQ4GXwra7/tq56YCPoatAwBAQiE4u/R8BDIIK656eNhjT8NYTIcYOdutT9ujpj3K46XszSoGtHosOgBg/sDd2fPh+ANqSMntSt5Q2ZZyzOdbY4Nce6MYo2vJU+BMCrwxolIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181281; c=relaxed/simple;
	bh=O9lDwwEZLF3IPkdCIDjxG8Rr0iIiU8r/cXUtN84ZbYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuteQwqu1+2g0gQiQlrk0RASvQWdpRCbMp3NHUxAjinkA5hw3sEJd4DXokCVuS7yVCauLzkuRskvwSUChJ79QPg/aKhD6DDJxq2ImTkmxAPPJcWnmuZ1V+BGJrwADbrl/jEQ24WvZjHguFG4rvXAYXwdGA7YBdWluIahikpfA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDRGAic+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65068C4AF14;
	Tue, 20 Aug 2024 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724181280;
	bh=O9lDwwEZLF3IPkdCIDjxG8Rr0iIiU8r/cXUtN84ZbYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDRGAic+MPhG4mm6OAHH9arVzekQajz8/70B3gLBf3bLq4fYYzG4VnrsSUotTi+0m
	 gjHOZHeQhRvMggYC5a1cCBBYF1uRbmqa3phy8FxWa/q8aJYCtX12uJUIlgB2bFJH/n
	 zXQRK/UGlRGEA7afRTvMCLNtszrA2rz76BQ25oBok+JNc7fDcQdwCoBdhEwuDKcPoO
	 xqTWspEVCFia4uH7O2YdT5m16bHQPcEBzMPY+brHcFLdSKG6t+KuXZfZeMtf1rSfwI
	 LzMbOqzpN7+SFN0Zj++NMMQBLFxFxWsl8Q3VzX2csiothsURhwGTBwvO+9ll9I5clI
	 g1879KGTpuc7g==
Date: Tue, 20 Aug 2024 20:14:36 +0100
From: Simon Horman <horms@kernel.org>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v10 1/6] Landlock: Add abstract UNIX socket connect
 restriction
Message-ID: <20240820191436.GD2898@kernel.org>
References: <cover.1724125513.git.fahimitahera@gmail.com>
 <9a365e0c8effb68a891f9dde3ef231d592a06f61.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a365e0c8effb68a891f9dde3ef231d592a06f61.1724125513.git.fahimitahera@gmail.com>

On Mon, Aug 19, 2024 at 10:08:51PM -0600, Tahera Fahimi wrote:
> This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> abstract UNIX sockets from connecting to a process outside of
> the same Landlock domain. It implements two hooks, unix_stream_connect
> and unix_may_send to enforce this restriction.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

...

> diff --git a/security/landlock/task.c b/security/landlock/task.c

...

> @@ -108,9 +110,134 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  
> +/**
> + * domain_is_scoped - Checks if the client domain is scoped in the same
> + *			domain as the server.
> + *
> + * @client: IPC sender domain.
> + * @server: IPC receiver domain.

nit: @scope should be documented here.

> + *
> + * Return true if the @client domain is scoped to access the @server,

nit: Kernel doc returns sections start with "Return:" or "Returns:".
     It might be worth using that syntax here.

> + * unless the @server is also scoped in the same domain as @client.
> + */
> +static bool domain_is_scoped(const struct landlock_ruleset *const client,
> +			     const struct landlock_ruleset *const server,
> +			     access_mask_t scope)

...

