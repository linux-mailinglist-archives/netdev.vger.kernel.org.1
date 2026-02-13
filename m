Return-Path: <netdev+bounces-258525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJtoJzB8jmmJCgEAu9opvQ
	(envelope-from <netdev+bounces-258525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885371323BC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 628B0302BD06
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D29225413;
	Fri, 13 Feb 2026 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBEQBN/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC66BFCE
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945576; cv=none; b=NtoyoXqE/CNRmAjN1EQfnxvEzJfSHuXeyvqxD0qGexGUWnvm0JhImNHZTnXhIMIheq26OClOO+97dzj82TojhkM1T2+hxf/zTzGXPRitouubLU6UpBvS0Oyp7+QOl1eaNmTdj4dvaMmzwnWogoOcn4E/3DdxPOrQIGRGxjFmXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945576; c=relaxed/simple;
	bh=pOqP7VM+mApaVUNM4EB88815+w4SRLILG/EjieeLe+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGJxPqbnb45nINWDg4QBFRG9wJCSAxRyznUjDEFyg4B55bQ78YhoWH/NgFcb/p2o7RA78Tifr/ZnnMwnlWc7EE94kV8Ju14PdU3xRv4hnvTU5vrdyKrBVY43DC/LrREgIQdLnSxEwzF5BF39oMYp/ZAwc2qori7gWE8xYf6VXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBEQBN/v; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ae1729637so398676d50.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 17:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770945573; x=1771550373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSR/hkZOakiS24NkJpFojfOy/j7sfQd+s+nYYhJiVE=;
        b=LBEQBN/veD4tconAj8h01XARaD7uW5xZ3Zy9/r9tNe9kYfNiJegbZW495L7ufV85wK
         HK1WL87VKwBHOuVTJYc5we1LcqHmhkdUCMlhDXFv2TwKIEHcs4Dcsg63kjoFs1xSs6aH
         elY4VW9ZR7zcyWHHMDj5n8ylLpQ6M84RJ0A8XPs5LntFbQiO95Ibqw8bBZXA02Hc8UIw
         +2Pah0EIKpzcDpXxX9bwoIsDOy7SKSmp0MPggj+uEl+r4HDSfcF4i/DRhcRjTIZmdArK
         N7aXoau6MO2VVqDa+/V2HaSp3VH+E2kPaFg53dG18Ef+24qOYl7kfYk3+HT/QGbDHI7W
         NWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945573; x=1771550373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdSR/hkZOakiS24NkJpFojfOy/j7sfQd+s+nYYhJiVE=;
        b=mu9tFNfZIJEMb94yowNUWPyKTrm+LxVT0OgYyRDyXLZ5DCx8vqBUhrIrJJljR7GB9e
         wMjVFI5Q2hS7cA+uGTjN7oCDVdMripAi273+KMIqGEw8jNZtYgZSeFIlZh28jU/V343f
         zlkWMtYDmzwNNoR9+Ae+nJKehlMCCNym0tf6xBnNkVR2oN7XVXgnjG71ATl0F++y/BsR
         BdMIN6L4RmeUWAJsBBWR99YW+cNNaC2hZxBSprgwQgKlMJz9MaqKugEuPNcCQVxLAQ6w
         n91WSLGETOxew5VrzK5/N/TdlFlgIZpILfr/mW5Vdm2ekspAOiZgleFXEKZ0vJ6Tf2uk
         xM4A==
X-Gm-Message-State: AOJu0YyZTU80MgcCmqWWORqbVDxcbpfyDoHOFrnhbhq0TZks3gUqqbLC
	QiqMiza9UoqzGAqEhk7OW1YdyN6mGM44a+JU9yfsU5oBIcGfi8a0uz0z
X-Gm-Gg: AZuq6aJ7a/CeVJSKLzcizlkB7cTsDkL4aNc45VpnRBBEOdc+d0zrFGVcslw404H9aZs
	6V+rjFm1gc/mIgovYpkYNB1ezEn98eaTNCPw5PpQHRHcVfkkn6kTLuecM3ZkqvGnkKg/fp2Bxyd
	Hm9fvgbYJuzh4W/tDDXGtP62gJ71WUpbzEi4ycf6KXcWOi9jclGb18+sH5beiew96d9zLqAphle
	TSQV6FLYLa9QfAXxYwkNv2bCsUCTBHjJQJaIbVn8TBYF5oV5pLz5LJnF6+w+Nr6U3WORNjLyW7M
	6fMsBq0SQoL45nphthCvq+MHBAZYjEcZdxxbHD7t/S8Ot8SnxbAPdsqrAfferTLDh2xIfW9YX1k
	j7+dC6Ms6ZGFenTBUrVRCuxfRmt/Ez5bN6xKooifVcqbsNKYe+6ZC5uXkpQCy9yH5ciiyIPkxvC
	rRQ425Wpsvze6sa5uMPD4W3pY3h4Mv5lZ57cnXTSstkwtzgEo=
X-Received: by 2002:a05:690e:4304:b0:64a:d1bd:8c65 with SMTP id 956f58d0204a3-64c19b63848mr65513d50.95.1770945572751;
        Thu, 12 Feb 2026 17:19:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc95acabsm6061484d50.13.2026.02.12.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:19:32 -0800 (PST)
Date: Thu, 12 Feb 2026 17:19:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 2/2] vsock: prevent child netns mode switch from
 local to global
Message-ID: <aY58I15Csp1CU8xI@devvm11784.nha0.facebook.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
 <20260212205916.97533-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212205916.97533-3-sgarzare@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 885371323BC
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 09:59:16PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> A "local" namespace can change its `child_ns_mode` sysctl to "global",
> allowing nested namespaces to access global CIDs. This can be exploited
> by an unprivileged user who gained CAP_NET_ADMIN through a user
> namespace.
> 
> Prevent this by rejecting writes that attempt to set `child_ns_mode` to
> "global" when the current namespace's mode is "local".
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: bobbyeshleman@meta.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 3b629b4a0359..9880756d9eff 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -95,8 +95,9 @@
>   *     the namespace's own ns_mode.
>   *
>   *   Changing child_ns_mode only affects newly created namespaces, not the
> - *   current namespace or existing children. At namespace creation, ns_mode
> - *   is inherited from the parent's child_ns_mode.
> + *   current namespace or existing children. A "local" namespace cannot set
> + *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
> + *   from the parent's child_ns_mode.
>   *
>   *   The init_net mode is "global" and cannot be modified.
>   *
> @@ -2844,8 +2845,16 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>  	if (ret)
>  		return ret;
>  
> -	if (write)
> +	if (write) {
> +		/* Prevent a "local" namespace from escalating to "global",
> +		 * which would give nested namespaces access to global CIDs.
> +		 */
> +		if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL &&
> +		    new_mode == VSOCK_NET_MODE_GLOBAL)
> +			return -EPERM;
> +
>  		vsock_net_set_child_mode(net, new_mode);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.53.0
> 

Thanks for the fix!

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

