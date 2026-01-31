Return-Path: <netdev+bounces-255508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFcXJglwfmnEYwIAu9opvQ
	(envelope-from <netdev+bounces-255508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:11:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6EC3F5E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130193004C7F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE36364EA0;
	Sat, 31 Jan 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkcaNEBV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B0239E79;
	Sat, 31 Jan 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893893; cv=none; b=IB1t6X9kgsZyGvEz71TZeozoWWxyWakHVB/k9UEGQ/8igB+p0cSBf03Vhzdcsu8UFk1X2UPQRi8OrbwHhjIT8+P9svp3DsS7R1a6ewVM6rSH8QoYi2/B9hzn6FWm7nhyxeRo98LMR9ZSabdzPZrydiFgrNPel6OoJmyjxEnPp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893893; c=relaxed/simple;
	bh=ZmumTbCrYT1hQwjIqNBI5dJ3+Tbzc2Y1urg6lmvFMf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrjVmmytH7AXSyvi/FSo/t805C7rRGfc6XLVtoLV3MqGh1B/weZXVdkX/FXkqXA72pOXNTsnPadxrF1nJXhp7XggCwvhwuzPyoRcI24Xa9TAg1me4wm0oYnrkj0ph2e10yfvbEnkfrPIxGpcEM0b3Ql+cNKXAQZPj8qJLAY6apU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkcaNEBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E4C116D0;
	Sat, 31 Jan 2026 21:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769893892;
	bh=ZmumTbCrYT1hQwjIqNBI5dJ3+Tbzc2Y1urg6lmvFMf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkcaNEBVGUjZQcywaG27We4ef05UleeONxr40wrNdOdDk/iMRlfWjgB5Baykdm+ef
	 Yo+AlLqTuNyRX6wB8vzaq9ZRuqo+jLS9cMoWGvcOv7t8E8LNFO6BVld7Wjb/L9aRry
	 aHH4xYceNbUIf9r/sabiVurdyPBg+RCrnVzfG4NzmpOKuBskjTbJ8l8anV2B3d9Ttp
	 m1msRvu53zhuXuGSBV9KvcvGSkY6v4JUJ4p+7M32+4bMxi+rtLbMpVItA7TwSXKe0L
	 X8/JHMQL0H97pfdBYS+iYfGYkhmTHItDjmaF7/oOPVg40rDZEM7gDMrfN6iPkcF6jG
	 dP8kI0bsxJC8Q==
Date: Sat, 31 Jan 2026 13:11:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
Message-ID: <20260131131131.0d854805@kernel.org>
In-Reply-To: <20260130054759.1301608-1-rdunlap@infradead.org>
References: <20260130054759.1301608-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255508-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31A6EC3F5E
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 21:47:59 -0800 Randy Dunlap wrote:
>  /**
> - * __iucv_message_receive
> + * __iucv_message_receive - Terminates an IUCV path.

AI code review complains this is odd wording since the main body
describes reception not termination.

>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
> @@ -374,7 +363,7 @@ int __iucv_message_receive(struct iucv_p
>  			   size_t *residual);
>  
>  /**
> - * iucv_message_reject
> + * iucv_message_reject - Refuses a specified message
>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   *
> @@ -387,7 +376,7 @@ int __iucv_message_receive(struct iucv_p
>  int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
>  
>  /**
> - * iucv_message_reply
> + * iucv_message_reply - Refuses a specified message

Same here, refuses or replies?

>   * @path: address of iucv path structure
>   * @msg: address of iucv msg structure
>   * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)

In general -- Could we possibly delete the duplicated kdocs in 
the header. As clearly shown by this patch it's double the work
and kernel-doc will be able to find the definition wherever it is.
Kernel coding guide recommends kdoc next to definition.
-- 
pw-bot: cr

