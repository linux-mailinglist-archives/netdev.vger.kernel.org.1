Return-Path: <netdev+bounces-215359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B368B2E399
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCAB5E84B2
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A13376A8;
	Wed, 20 Aug 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIIAg+d6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57B33768E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710275; cv=none; b=df/GoCR+cNqNGx9ET4ae99fxbdz8WI3q5Cc8ES34eeoIpWRuEp2dv0L2YSUio6mdIrKSTbhf4wHm1vMoTlCE3gctL3Yf3ujY1PwgmwTSQ1rM9fxxv3erJLeZm061MmnOFcUSC4WIW9GkdeePxkkWIhZdgQnHbejDcK6tb/cqgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710275; c=relaxed/simple;
	bh=IEBjWzbl6kiCDYFZHoZmTEAuGpVV7AAE48D37VsplZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5bmgkQMWFm4k6/H1eF8X9+1vun831pYR8M57seBTFET/nhiNurZyV22Iph0gggBmRPiTcbYXwbqIov9n420VMnR+1gdP/iDcIWmyuGtbmNWl34TZWZOn1IHIusmizMCU7CL8gu2hoc+UmSU/83msBZohk5ujZquXUm9bbY9/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIIAg+d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B218C113CF;
	Wed, 20 Aug 2025 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755710273;
	bh=IEBjWzbl6kiCDYFZHoZmTEAuGpVV7AAE48D37VsplZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIIAg+d6FE6CTRy+0QXFEAsAF0szp4v7Y5IPJ8rEWM6JGFutdLOoH5p1AFBQT1MED
	 IXbs2EX+wqYk2Nv0wls+T9uGPkH36Ta5aoQptHOu4lmkoX0KMBoKyZfDHUwVluGL4Q
	 2KRc0KzuVpoqxgwmFE9igHyb6TRrltIEDhjLqW7+SkOKlLrkPNTJvzqoeY2QNSH1I8
	 ghGjkbwPy01bwqgOnJbCDQ1MJtYUCLJ42nBs5YKcVLSMiLsA7N6x5nrr9K5tGLHFe/
	 nQqwuAL9SXIoD+BKxv/19mribJQS2QNC61wHv/EK22lMkbD1uecxas9795v+GeRo0S
	 lps9ltzFx4B9w==
Date: Wed, 20 Aug 2025 10:17:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dhowells@redhat.com, gustavoars@kernel.org, aleksander.lobakin@intel.com,
 tstruk@gigaio.com
Subject: Re: [PATCH net-next] stddef: don't include compiler_types.h in the
 uAPI header
Message-ID: <20250820101752.63be03da@kernel.org>
In-Reply-To: <202508182056.0D808624D8@keescook>
References: <20250818181848.799566-1-kuba@kernel.org>
	<202508182056.0D808624D8@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 21:06:10 -0700 Kees Cook wrote:
> > Since nothing needs this include, let's remove it.  
> 
> But yes, nothing uses compiler_types.h via uapi/linux/stddef.h. That
> does seem to be true.

While staring at the kbuild bot report (which I can't repro :|) 
I realized this include is to give kernel's __counted_by and friends
precedence over the empty uAPI-facing defines.

Not sure this is the most fortunate approach, personally I'd rather wrap
our empty user-space-facing defines under ifndef __KERNEL__. I think
it'd be better from "include what you need" perspective. Perhaps stddef
pulling in compiler annotations is expected, dunno...

Would you be okay with:

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 6bbccb43f7e7..4c20c62c4faf 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -32,7 +32,7 @@ fi
 sed -E -e '
        s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
        s/__attribute_const__([[:space:]]|$)/\1/g
-       s@^#include <linux/compiler(|_types).h>@@
+       s@^#include <linux/compiler.h>@@
        s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
        s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
        s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index b87df1b485c2..9a28f7d9a334 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -2,7 +2,9 @@
 #ifndef _UAPI_LINUX_STDDEF_H
 #define _UAPI_LINUX_STDDEF_H
 
+#ifdef __KERNEL__
 #include <linux/compiler_types.h>
+#endif

? As you pointed out compiler_types.h is only included under stddef.h
so the special handling in the installation script is easily avoided.

