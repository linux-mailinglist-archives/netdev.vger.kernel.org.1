Return-Path: <netdev+bounces-241287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B41C82580
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141433AE4DB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18C32D42A;
	Mon, 24 Nov 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/pWjGPP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938632D0C0
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013906; cv=none; b=oaB/dim8a0debGuc3bh2v56n7+q7SR4l/PAslt5AfQzsE5l6uIOGt0QofBSSLvwxfxaOnJEkMZz3uKa3Dkqj/PvsV5IjfnQBeqQHuwtCDNrCF8bXN5aGLwJWNDLJopX8Zzx14dH06Bwxn1T7yNcObnZS6Kzjs1d3l3rQA1MheHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013906; c=relaxed/simple;
	bh=MYnjRhcGU93/edLNkMgYcrHuxocITcOkVUnH3Ba/ilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRTZmY2vcgK94A0pjO5f3kUr45S22LnoiDyjta1jJiR4YO4rlQ++/yiw4VNfKX44dUTJTm2tZMYWveB/baqn8wC/KMxVd6czo+tL8JgabN6tLROOjns8R1FYJ3qXldfQEP8FiazuqyNQPDY7hsF/rt7abKiWYhrw+KrZs5+3QnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/pWjGPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAB1C4CEF1;
	Mon, 24 Nov 2025 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764013906;
	bh=MYnjRhcGU93/edLNkMgYcrHuxocITcOkVUnH3Ba/ilQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/pWjGPPtk6JbVqGD8+FK1gi9mqY/Oxkw1vXacrJAugp9PHZctEbzlS6yJMl/7t6H
	 lGPAMt+PT1Du/PIegjZiIhLYZp9X7dcJBZuuCk3WmP4uKkMkfIfU7K2h3UigWRZ12Z
	 YdtMZqncbA+Ix/oduGoKxFKp6MbGr5pqfq43jf8G2F8vJuBz20NFaisD2fDFIYW/RK
	 DwgWZfGSVUnxXC1huNMRaj6OE4wa8smAsIOh9r2wkhBabvyBmlMcWqQTii8/yMDW5l
	 w3K1UCC7IugN9rtm4lDauC1ilZxdrBca07/AexUs6mDWCgslT8mFaHHl4iAo0U2k0/
	 N6n51oz1iZ4TA==
Date: Mon, 24 Nov 2025 11:51:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/2] selftest: af_unix: Create its own
 .gitignore.
Message-ID: <20251124115145.0e6bb004@kernel.org>
In-Reply-To: <20251124194424.86160-2-kuniyu@google.com>
References: <20251124194424.86160-1-kuniyu@google.com>
	<20251124194424.86160-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 19:43:33 +0000 Kuniyuki Iwashima wrote:
> Somehow AF_UNIX tests have reused ../.gitignore,
> but now NIPA warns about it.
> 
> Let's create .gitignore under af_unix/.

Thanks for following up!

NIPA says it doesn't apply:

error: patch failed: tools/testing/selftests/net/.gitignore:35
error: tools/testing/selftests/net/.gitignore: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Does it have a dependency in net or on the list?

> new file mode 100644
> index 000000000000..694bcb11695b
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/.gitignore
> @@ -0,0 +1,8 @@
> +diag_uid
> +msg_oob
> +scm_inq
> +scm_pidfd
> +scm_rights
> +so_peek_off
> +unix_connect
> +unix_connreset
> \ No newline at end of file

nit: missing new line
-- 
pw-bot: cr

