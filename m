Return-Path: <netdev+bounces-239317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8589C66D4B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EC4E177E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E026B2D2;
	Tue, 18 Nov 2025 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seYmfsyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867526A1AF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429193; cv=none; b=lNIxeAOuVR7Uami188Vgaof1q7kV25MAaHHHSIU240j4KvGaFGUAlVQ/DPBAAtIEbxHZIIX8uI3F7nd+n4lKoZd7VWfdInUzzo/14jScBuldKw2fUa5c3o1rr0SQOX0YDMSxK3QCXi0wyVnDDf1rpNime0NmCy6kaBNAafbDI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429193; c=relaxed/simple;
	bh=KibZQ92mBKeJ8dueQTgMwBP40CZhKLGoQAU/W8Ix6XI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQmMONJrGq71C8mEYBS5PzP98W6JRPtl7LJPhG99vbXBFFMM2Bc6qmM7GqWQ29ZlJhxPZwb7dJu2md8FoMc3H+uLUFfwYkLqhGWpaYbojhvZgfTFa8gPfcu4KUU3cWjeX8UH+iqHNExw7EfsigjtSE2zDT4TK6QdvEjBHaevEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seYmfsyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B906DC19425;
	Tue, 18 Nov 2025 01:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429191;
	bh=KibZQ92mBKeJ8dueQTgMwBP40CZhKLGoQAU/W8Ix6XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=seYmfsyFqXdfDfWICAckOa1pqJ8eE20aZb50A1sT+anCiyWRQwLlVKM2ZoNRyv9Zi
	 WNKpn+7rWDG7UWzz11zzekUMRmFBPgOH2nojuHKkpUfgjUCAKvYbnq8bKeQ+dnf4oZ
	 lAj2+RfDhzlAuOchkz4LcmKVh4+NsIY1e+2bu4kfiQnORo1JiMiWkcRM1iLJGVk9ya
	 NxNna8pPsY3oflDpRLwvODH1behPX//7VgrNj5Kf4O2laNKfZ+okc2vV7aYKPkGfS4
	 xCKLnjJ7yZeewcLzn0G37bVGO/ZhHUCWMpErHiMXsyE9771SC2fbCRdlizUlxaEloa
	 odjmTT3OzjH9Q==
Date: Mon, 17 Nov 2025 17:26:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Aaron Conole <aconole@bytheb.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
Message-ID: <20251117172628.784c23a4@kernel.org>
In-Reply-To: <20251117174740.3684604-3-kuniyu@google.com>
References: <20251117174740.3684604-1-kuniyu@google.com>
	<20251117174740.3684604-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 17:47:11 +0000 Kuniyuki Iwashima wrote:
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 439101b518ee..8f9850a71f54 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -45,6 +45,7 @@ skf_net_off
>  socket
>  so_incoming_cpu
>  so_netns_cookie
> +so_peek_off

NIPA is complaining that we're missing the binary name in gitignore.
Probably not worth respinning for this but in the future let's start
using af_unix/.gitignore rather than the parent's .gitignore?

>  so_txtime
>  so_rcv_listener
>  stress_reuseport_listen
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
> index de805cbbdf69..528d14c598bb 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -6,6 +6,7 @@ TEST_GEN_PROGS := \
>  	scm_inq \
>  	scm_pidfd \
>  	scm_rights \
> +	so_peek_off \
>  	unix_connect \
>  # end of TEST_GEN_PROGS

