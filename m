Return-Path: <netdev+bounces-46252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9587E2E0E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 21:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E4E280AA5
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 20:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C92D78B;
	Mon,  6 Nov 2023 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mat2w+Ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229381A591
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 20:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B47BC433C7;
	Mon,  6 Nov 2023 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699301965;
	bh=4zZA4Wz85LoJenAVGtk+Zzw9td9bLFDpuzsQXV+AbCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mat2w+Htma3YGx+9EgYiGWIAGzG8YRItQv83ijXIDUYorWNKhNVpDLxdczDOPekzc
	 U2mkaf+nGA3RkWAyjQ+DfSRQtc+LYNH+9i9imEsmMmfRb9gNeA5oPe8hCeqF9YAASD
	 8N+D+HCNhyDYzBt16Pjd8QkMdVS7zeQn3mp3PYQwER2d8NLJy4cajo0ZU+QCiTXANT
	 Xihz+SV4J1bdjNSiCn3acevzvptBWP6p+zJ4FJFvcpkVjPghvCNrHmNEgV3TY0eMAJ
	 RGJ2647zDfAHKr2fLRRz9bNIQyZyuimiHjZfV4vtyeYSZOLj2q3qWSI1HlpO5TN3f9
	 9hrpvSldipoIQ==
Date: Mon, 6 Nov 2023 12:19:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC Draft net-next] docs: netdev: add section on using lei to
 manage netdev mail volume
Message-ID: <20231106121924.2e078be0@kernel.org>
In-Reply-To: <20231105185014.2523447-1-dw@davidwei.uk>
References: <20231105185014.2523447-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Nov 2023 10:50:14 -0800 David Wei wrote:
>  
> +Managing emails
> +~~~~~~~~~~~~~~~

How about adding this section before "Patch review" ?

> +netdev is a busy mailing list with on average over 200 emails received per day,
> +which can be overwhelming to beginners. Rather than subscribing to the entire
> +list, considering using ``lei`` to only subscribe to topics that you are
> +interested in. Konstantin Ryabitsev wrote excellent tutorials on using ``lei``:
> +
> + - https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> + - https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
> +
> +As a netdev beginner, you may want to filter out driver changes and only focus
> +on core netdev changes. Try using the following query with ``lei q``::
> +
> +  lei q -o ~/Mail/netdev \
> +    -I https://lore.kernel.org/all \
> +    -t '(b:b/net/* AND tc:netdev@vger.kernel.org AND rt:2.week.ago..'

Let's add a sentence pointing out the b:b/net hack and why it's needed.

