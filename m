Return-Path: <netdev+bounces-214865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C68B2B83F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FF34E8337
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63629200BBC;
	Tue, 19 Aug 2025 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A73/TsHF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625CEAD7
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576372; cv=none; b=IuQeew3SkXi+1XvGvYcsXx0LvyTcXZ92Tvz0iXzryTA2xW1Tl4I6XlS0N8JxDJVlDuYmXzBqNo7NbcQUM0zQjE6A5M8n8AOfRDL/mf0ULYpzoDos7fWKpLWgxIN1HniX5M/i8tqJMcq8xLmpYd/axH8n8nIdhzeRPbHS1ZxBuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576372; c=relaxed/simple;
	bh=05e3a3SurCkprk+daDNgdLibJMNr+3FeQ+hQgMXXfvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJFl1+PfD6dxIvxZL8xaaW5VyB9GeTdK0u8bBW01ajrYix6kwO9jhmNW1aFmTX5kCScnayaYNplvc9JBpRcK34X+myzDS14TmVPCnNp6day0Wp4MgG3Y9jhNFX5RMBubL1Ugfu/TYClz/52A4rAC6ATZLWbCMqLLKnbwq7Pcfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A73/TsHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A18AC4CEF4;
	Tue, 19 Aug 2025 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755576371;
	bh=05e3a3SurCkprk+daDNgdLibJMNr+3FeQ+hQgMXXfvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A73/TsHFXpYM3lo/fVY3rZJJL0XI6ovlo8rUOIJfYBGF3FxBd6vkdWnx+r5e6TBAx
	 ASHhQCkF/ezz1ZXP2tdIkSkTgG/7Dmt0oOzvYy8K/LS9KxQ9b06sl0XQBmxgLLPa5h
	 Nc3FcQbgy9/GCwh3W0YRoCwEiV8cZnxoURt+seFTHp/ZmUsZZiUfPJkF87ZA6odtKT
	 K3lbCtRLP4Vx8StF0FqiHWox1yrq82jZ5GhJvrmDMSnYQdKvdbZNB5ybR6TQ32KTwg
	 8zCXv7vzNU7QIIOHgdZbScls5F5FbDam0BB1sLd2U/HbDjbvY2CrPZoZvtUJr0Kqnj
	 N4TPliuBh12Vg==
Date: Mon, 18 Aug 2025 21:06:10 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dhowells@redhat.com, gustavoars@kernel.org,
	aleksander.lobakin@intel.com, tstruk@gigaio.com
Subject: Re: [PATCH net-next] stddef: don't include compiler_types.h in the
 uAPI header
Message-ID: <202508182056.0D808624D8@keescook>
References: <20250818181848.799566-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818181848.799566-1-kuba@kernel.org>

On Mon, Aug 18, 2025 at 11:18:48AM -0700, Jakub Kicinski wrote:
> [...]
> header. There is a hack in scripts/headers_install.sh which
> strips includes of compiler.h and compiler_types.h.

This looks like the last user of compiler_types.h in include/uapi, so
it'd probably be best to also remove portion of the hack from
scripts/headers_install.sh while you're at it.

> [...]
> understanding knows what that chain would be, given
> kernel doesn't include uAPI stddef.h, and user space
> has the compiler headers stripped.

Uh, yes it does:

$ git grep uapi/linux/stddef.h
include/linux/stddef.h:#include <uapi/linux/stddef.h>

> [...]
> Since nothing needs this include, let's remove it.

But yes, nothing uses compiler_types.h via uapi/linux/stddef.h. That
does seem to be true.

I find the change of subject between stddef.h ("nothing includes the
uapi header") and compiler_types.h ("nothing needs this include") to be
confusing in the commit log. :)

> [...]
> Builds pass on x86, arm64, csky, m68k, riscv32.
> The direct motivation for the change is that the includes
> of compiler.h and co. make it hard to include uAPI headers
> from tools/.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

If you can clear that up and everything is building, then this change
would be fine my me.

-- 
Kees Cook

