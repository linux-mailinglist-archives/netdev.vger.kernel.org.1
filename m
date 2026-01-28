Return-Path: <netdev+bounces-254059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEezDuBreWnEwwEAu9opvQ
	(envelope-from <netdev+bounces-254059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:52:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD49C0D1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35CAF301750B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E285274B2A;
	Wed, 28 Jan 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9xkcCL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE261E8320;
	Wed, 28 Jan 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565147; cv=none; b=J9n9+jn6guSjmrqCe+Db7A9IQWuZpEkm7pRc4ytM4kYIFfCJ/NjsEduLNbltdgajKnBs6/WuJGl0CZpDVKvnKNZADxi1FeEeF3tO/Y8/iJX/UMRS3DsdbktHHCmm/9KG7mPkQqysRcW5J9lStzNw/XrHmW6TUbVMsfosyF9hAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565147; c=relaxed/simple;
	bh=RkFn9bdWVW3yZq+uVxyn0/nH1KXRZMzYjMlLRwwjcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXS8OOTSTMaS/w9a7GaWN25MVEqL9AvCKdbXclXFAY/WsUbYdK3/Oh9ssocNmmL+0JmIsEgMdNN0YHQm5sLrJSYiQadc2GFPL2T4xnzr0oQUw3QVs27lL6sb9GUBEO774KiBw/2c2riOg6Y2KiVJGBhmgr3Vg97rzAS4/l+Z/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9xkcCL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AEC116C6;
	Wed, 28 Jan 2026 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769565147;
	bh=RkFn9bdWVW3yZq+uVxyn0/nH1KXRZMzYjMlLRwwjcmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9xkcCL70aRrC6AZdsEwqEpSB0TMpL6WaovsunIbTsqC0dv/kUNDkarg7Uzh8xn7v
	 CPGmtTl9g6fFi2VOmD43podtjph24XjHXan6iLiSY5T5YxJvMtpxn1zGRb1vLHssNx
	 HirHszWQbW1624KM3lsyegHIR4iZXoL3tOXusEfHTZcTee5GvyJbu2ceC99EwTargE
	 xplLpw8ZcjAkzLnWYe/kv+JPDqTjsSM7tiXjwlOQkrZXqTFCJoVaCvMzERk0HQ7w0I
	 KI8t+by8a63toHyF5gbRJGLtOWwZb3PmMMKVDiOXoD6LtmgnUFpilgXZ4pcWFB1RZn
	 UNGg5WdixSjdw==
Date: Tue, 27 Jan 2026 17:52:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thangaraj
 Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, UNGLinuxDriver@microchip.com, Petko Manolov
 <petkan@nucleusys.com>, Oliver Neukum <oneukum@suse.com>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Krzysztof =?UTF-8?B?SGHFgmFz?=
 =?UTF-8?B?YQ==?= <khalasa@piap.pl>, Deepanshu Kartikey
 <kartikey406@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Foster Snowhill <forst@pen.gy>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Eric Biggers
 <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: switch to two-argument strscpy
Message-ID: <20260127175225.3982f93e@kernel.org>
In-Reply-To: <20260126035052.31216-1-enelsonmoore@gmail.com>
References: <20260126035052.31216-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254059-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,lunn.ch,davemloft.net,google.com,redhat.com,microchip.com,nucleusys.com,suse.com,fintech.ru,piap.pl,gmail.com,kernel.org,pen.gy];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90AD49C0D1
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 19:50:15 -0800 Ethan Nelson-Moore wrote:
> All instances of strscpy in the USB network drivers use the size of the
> destination. If given only two arguments, strscpy will automatically
> use the size of the destination. Make the code more concise by
> switching to the two-argument form of strscpy.
> 
> Also add a blank line after a variable declaration in catc.c to adhere
> to kernel code style, since the surrounding code is being touched.

Let's not waste our time replacing all 3-arg strscpy()s with 2-arg right
after we wasted our time replacing strxcpy() with strscpy(). Who cares.
-- 
pw-bot: reject

