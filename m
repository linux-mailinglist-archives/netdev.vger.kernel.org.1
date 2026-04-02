Return-Path: <netdev+bounces-274635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKRTIjWlzmlZpAYAu9opvQ
	(envelope-from <netdev+bounces-274635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 250DE38C78A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8175030388C8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3330E0E5;
	Thu,  2 Apr 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/jWpXbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404D361DA8
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150385; cv=none; b=FXTopr94WsnqmvwBpVzBWvaVOV0RPwUNDnbg5EoxzGfBKSB2q0asBu1sjwnuiRsc+lT+xFfEJx4R0jChzdffVR7DyP3Spm9wq0xLqfa686HFEzAym+3IDX0yXsFoeHDBJNN7Dx3M9MC0d4ySNQUTohheKht96vTs3R0sZuAPyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150385; c=relaxed/simple;
	bh=q+bH+MzBqzAaB1kR8c1eOTTKDhHAZs3b4rogy3u0En8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKeQDj+20VOXwr3l2JWceeR9ppmCGplKWRSWfYwWgScwqK7kqkFpI3DDoJJ6qrfojnfp3hzDmSH09WFgnwmrr6/A6OBxpk6JR3NOw39//akwxigIYrQEmxZSxl34fojgpe/M+MWyF7xuvjj5YpY+pEVQoSWPRo/q2YIGZq7lyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/jWpXbm; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a60975dc5so11621477b3.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775150382; x=1775755182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UIU0kC8Y0nz3yhV5FHyC+ln+Iwi4Xg/ywzP08MRwPg=;
        b=Q/jWpXbmJCpsaMf9hJxVN7/OFqY8dnsUkkjaXusvx9niIDk+Gv/byID300sg3SDcgP
         YYDnA0BOziMACBzn74bULiHqgb/9RVQi9FumZyT/xTZEJ8rSVABn7XqkJZklNCKyXmaq
         QfVT+ICT4t6YucftmbnRDpKh7UcC3VEnuHFUxH2jykTtNSh8ePakYUhExeqsvicyvOOK
         3XW+kOzWtbeA6fsrre3/Jd6P4NxmMcOGdxxRmuISxQRAmpgTsSrPpysHMB2QuY2nYIA3
         5ACZnJIk5WHouE+e1alo3/gBWpA1Dtq9PQPNVofEcwmnFe2Ps5MDFUOivaFvDblAezY3
         jvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150382; x=1775755182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UIU0kC8Y0nz3yhV5FHyC+ln+Iwi4Xg/ywzP08MRwPg=;
        b=shiTJu+xDu6tYw5YGSpslOIos58O7BVqSFjERbENkn9eFUL56iIoshIYp56+g5hSr+
         s7MNPg2WJ9JH/DpEY65xBmF2OmMuSyRMBvaMUWtWLcqorpaKMlEPnK4XxDD9csGcrODZ
         sjp+W5lL4+QqpaFNu3O7a0CKCBzjrfCXhN/xOEqHFlynbCtfOtTZ5VD3qNSYZ03gDVgt
         +N6ja4GWbE5qK/CiEWh2kInmOXgYZ2lzvY2UT2hH51FwniHBW07v9iF+ty4A5TZrdOlq
         SBDLQN0/n1jjeESnI1n4RhInmqjZfQ0ZWasfKKOUovd6nsyM+mk69STzx0A0GsAdhcDr
         dzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08a5qdgOybEhl1S5ZsYM7OzTrkTDB1wRCNMCC1+fcTdKLQFhr98vExlzFAIzxmjq7Vh1Yyco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zfRzM089UQg3JffiJGbFMWg5C7SLJQas0CZEV/1xsh3NTImA
	HYJs9xQj6+rW6LN1DbU/sTmEJGX9Brr3mzGG+XL3Vw0CYZNIuf5ShznNvaBMTw==
X-Gm-Gg: AeBDieuDE2tiH3txn9nHJCD/Mr1sOGdPEib4X/jT1rEFIlfSJVXkInYPmh20OCzK7G3
	2W8x8i9ysPXKn0XuFW9nukBV3b3TSjrtBxIugSzsGuvRihaw/MrAbP2VJgwEOpK8537Wda6bCnH
	YGbJLVkDORwioZhyMXFb/6HBSPsLLEejNnml+4vJX45fKFpelweDFwk+GzfE6zNHbatF9qMwtgB
	c1SwhJW9AkMtpZrL6zz25aM82HHnaqQVGgFdboUnZ3cIl3MZc1N+OZ/wqRvWupb2lFCeCB629uL
	FBkNvB9krUfkbEp7vESNQ7eB15ZDDQ7VZtDbCMbAmf9XEOgzkYhgfzUi+lGMd01LTNpOy23Tfmo
	bmSZI/QSZs2cO2/+3DNda2qXqDwOWZNdwkdrnBH/TlBsASQjLs72fVJNBgCScB0XwBtQxGbLJoN
	3aQjAFhXJkxcnoGbD32JCnyw==
X-Received: by 2002:a05:690c:6e87:b0:79a:da70:864 with SMTP id 00721157ae682-7a4d6152810mr1492807b3.49.1775150381775;
        Thu, 02 Apr 2026 10:19:41 -0700 (PDT)
Received: from syzkaller ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712f04aesm12714417b3.48.2026.04.02.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:19:41 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:19:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac6lKTabFc04Fl35@syzkaller>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402044637.73531-1-laurencerowe@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274635-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 250DE38C78A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 09:46:37PM -0700, Laurence Rowe wrote:
> A common pattern in epoll network servers is to eagerly accept all
> pending connections from the non-blocking listening socket after
> epoll_wait indicates the socket is ready by calling accept in a loop
> until EAGAIN is returned indicating that the backlog is empty.
> 
> Scheduling a timeout for a non-blocking accept with an empty backlog
> meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> of microseconds of additional latency per accept loop compared to
> AF_INET or AF_UNIX sockets.
> 
> Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
> ---
> 
> This fixes the observed issue for me:
> 
> 1. With loopback vsock on the host running Linux v6.19.10 built with
> config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.
> 
> 2. With Firecracker guests with current torvalds/master, v6.19.10, and
> amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
> CI and examples. (Firecracker guest vsocks are unix sockets on the host
> side so this fix works there with just a fixed guest kernel.)
> 
> I struggled to build a generic 6.1.166 kernel that worked as a
> Firecracker guest but the patch applies (conflict due to change of
> `flags` to `arg->flags` in surrounding context) so I believe it should
> work for generic v6.1.166 kernel.
> 
> Alternatively a minimal version of this fix is to just wrap the
> `schedule_timeout` in an `if (timeout != 0)` but that leaves an
> unnecessary additional `lock_sock` call.
> 
> There are ftrace's and reproduction tools at:
> https://github.com/lrowe/linux-vsock-accept-timeout-investigation
> ---
>  net/vmw_vsock/af_vsock.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2f7d94d682..483889b6d8 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>  	 * created upon connection establishment.
>  	 */
>  	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
> -	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  
>  	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
> -	       listener->sk_err == 0) {
> +	       listener->sk_err == 0 && timeout != 0) {
>  		release_sock(listener);
> +		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  		timeout = schedule_timeout(timeout);
>  		finish_wait(sk_sleep(listener), &wait);
>  		lock_sock(listener);
> @@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>  		if (signal_pending(current)) {
>  			err = sock_intr_errno(timeout);
>  			goto out;
> -		} else if (timeout == 0) {
> -			err = -EAGAIN;
> -			goto out;
>  		}
> -
> -		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  	}
> -	finish_wait(sk_sleep(listener), &wait);
>  
> -	if (listener->sk_err)
> +	if (listener->sk_err) {
>  		err = -listener->sk_err;
> +	} else if (timeout == 0 && connected == NULL) {
> +		err = -EAGAIN;
> +		goto out;
> +	}

I wonder if this goto can be omitted since the following 'if
(connected)' guards the connected != NULL case? I don't have a strong
opinion, just noticed it would keep if-else symmetrical.

All-in-all, LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

