Return-Path: <netdev+bounces-193789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EABAC5EA3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A481BA3B35
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6A86329;
	Wed, 28 May 2025 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udsmR3iB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C212033A;
	Wed, 28 May 2025 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748394836; cv=none; b=c0mXC/IvDjq4F+cNs2YiNGAGn/n755OhOhD5HVk+5Jb7T70skmkyaAU8YcSfJsDDjmzRe3mKye0IgKhtwCwPp5HpDYnQ29JhSVFQ206PgX29baOzeoiDOgaKzgTfJISVQz5wErbn1Z7x3eqXhP/lP/4Y11GsTb9N3fKJTs7Ic9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748394836; c=relaxed/simple;
	bh=a5kL3lY59weGLWp7GHO5mf8W5sQANwNApjOL+vbZkj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9cWlHJ9yaejYoIV2zJ9GmwnZ2MdcFPBlqcP4KZ1i0BCHCtb3gGYZJvwE22I5KT6a+TvAs+voY25JqKDNzuXOq0xcfV+aMesTYNp3LjC1/oVYqBoAYlU6Om/KaGjZpEs/SatPAL1IufBpqMHq7rPaJL3FHTI+S3IC3pSK5xf0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udsmR3iB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C1FC4CEE9;
	Wed, 28 May 2025 01:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748394836;
	bh=a5kL3lY59weGLWp7GHO5mf8W5sQANwNApjOL+vbZkj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udsmR3iBD/aoWoP3PkYQd8POBeM/xOP26H3Lv0N1hW4WfgdLMPhpQJ9qB8395JXnd
	 1/xxoAZDXvmyRXeH0rFovx9L1smNYXT9bLmSYnajAopFUdi9Y8jPh/LtI4UPAUQT6V
	 hOuyCfAsOfYiGrQhxd/vVMI4UYB8qdYbLswSXr5qfbZYZQx47BV9Ic0AVTk1rceaEr
	 kACO0uapFnra+XsKJ2lXFPw07ORMk0STR2rB9z5zKnYzGLK+NFRLIbSdykgd94ugoi
	 aZP6sspA++D51VSEvYwRkOPQdfxJAIq9ukM/4BH8UZjMcNR+UvWJA8nTDaL6kqIqKl
	 PIzjirJPKeIKQ==
Date: Tue, 27 May 2025 18:13:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dlink: enable RMON MMIO access on
 supported devices
Message-ID: <20250527181355.493210a6@kernel.org>
In-Reply-To: <20250522233432.3546-2-yyyynoom@gmail.com>
References: <20250522233432.3546-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 08:34:32 +0900 Moon Yeounsu wrote:
> Enable memory-mapped I/O access to RMON statistics registers for devices
> known to work correctly. Currently, only the D-Link DGE-550T (`0x4000`)
> with PCI revision A3 (`0x0c`) is allowed.
> 
> To support this selectively, a runtime check was added, and the
> `MEM_MAPPING` macro was removed in favor of runtime detection.

Code looks good, but it doesnt apply cleanly.
Please wait for the merge window to be over, and net-next to re-open:
https://netdev.bots.linux.dev/net-next.html
then rebase and repost.
-- 
pw-bot: cr

