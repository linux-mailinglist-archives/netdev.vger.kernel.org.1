Return-Path: <netdev+bounces-258524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCz8Me96jmmJCgEAu9opvQ
	(envelope-from <netdev+bounces-258524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:14:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633913234B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A55033050EF9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B61D8E01;
	Fri, 13 Feb 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhA9kspQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482738F9C
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945255; cv=none; b=uGWq4p9mgjO6N+oKHJ/zPT6F8xwAN0ieCXfK4KD0+3dh3OWOV+oav4MC+mmcBvpNBifH4pQ+cWk1awQjed5Kz4W230PczCMxQn4QX67TDMjSbOG4nXOuJc+fbkl82beCT3ns0J4RZUo0FXm06azaAzjbhSINe1emdnNf5ZzDdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945255; c=relaxed/simple;
	bh=md7cp6wH2+N6MD3mWQSj0qSboD+7rUfa+MjyvhsGzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Aci4XSK+y8OMgCs24XKp8MLrbsDk5Jc6BCxq1e5XJEbTj13elqg0Y/oZdEl0w2ohkra/1DPRlehW7KoI/to1xPszlTu78vZSgAqmLrfiD/XY/z9EjXjfPxyVpcga/CC8woubs824RLNjWsvUCjnDbwt0fD/tFSM/PXE5SP8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhA9kspQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7963b25e0ffso5404537b3.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770945252; x=1771550052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVvyXAJYhGKiBzDbhgb+tCE1hBe6OOdBiT7l2EEI8Wc=;
        b=UhA9kspQdso2Pr8ovtMGQ9KtJrpoiklHkLgdGl+QYBAAJm/+cR+VYFr2GmQEsDRkvd
         QRaUsUQxQ5rv6lNQi0PC30NhS9bXvCfJEAPJPUOeO3jvNoUwqGdjqB9WHJjYcQ2avyEF
         DqLylhi64EvBLwtO6dE+L/iS/LXaynjqxLptJsU56Hv1AXh5FtmyhHhrMQI6RJT662ap
         oFUTcWZuvNkOZRp0l5Ho6z3tM74bKybLUsNzZ41Xyn/en8g0p59jw7oywoimXYo7SU7x
         evH8hvyxLtiHiFZA2FbxeUXBkCQHAL6/ZcqxWoHaMWRa0B4v6t6umoUOG5fv9LAqM2TJ
         jx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770945253; x=1771550053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVvyXAJYhGKiBzDbhgb+tCE1hBe6OOdBiT7l2EEI8Wc=;
        b=CfrYxx2urBxEPDs5+BuBejG4qYp0VeJ74xsTXWXNz0O7e9MEjT9XUpyIbSLNGmLtuG
         enN5DaxgQMQA4viZjuye9tQRTQukdfxJ8VHga+rbsqCccPQA+RCKU39jKfpAHqZDUghk
         4trRZLy35m/EtUZhz81T8giJc+002gwQ3xFn2OJUtfDT7+o98MhQxthiG+RZLWu1TW6r
         050zUD1BPdOvE0ABKDN7kp9spGZ7HzMtw4Ztd40EsD/iqZ4EExbQvDXJ/xkB9RtvljO6
         MTcihfQ3VgMmTAwjU2e02pgZbzEQs10Lmqs+8FL8ZTE/A2l+OP3CEeiwbBa8F6TZt+r1
         p39A==
X-Gm-Message-State: AOJu0YwifKIHpZLC16mMvVEjFMV8cSG4ruyJpn+xT9LDVeDhX1hXbO0Y
	MWEy2IPUSdT2VU08DilTJT9n7qmj5EJDlqJExoCr3XO4oP23f1YvSv7Wy7z5xg==
X-Gm-Gg: AZuq6aKcvYvXw0j4oSRChQHHyaZGAkqxMqIwSn0bqpNT0bfPoy5b/gSnaUhRhUvvKBi
	FeRjPzf7SNF3MeMusTWysv1FtZak+wfJZImBds0Fq7z6U6TSvJ6WDKEgSj9oI54F/pdFkpzvlUb
	Hq+u15TTH9cqI0b1dO9WaX0KNxLQ3PnqepkPNe+8uMoS7qs7vsfFbUIj/qMCfwSEHq8vw1Ydpnq
	/j0L8Lfe81fxMiuhoeZpCEwyEfYEp7QMbEt6j2WI95XU0/a+rVCSuFpOsDkTuSXS8QoOtA53Zf9
	I9XwHLBhE4aOIUuZW8cr625+idHu26ud0s8gSXh8jlaY56RORqqHiVkJdoeGjR++v7qscoayJmH
	0cItQhYVs/7DHdcEpUmH7eZ6XiQnoSMDE39t0q5B2CTdS06Fjp7ilC6W8QWVJBeOi7LSIQZhgkP
	q8X4yGgpcAvZJlHhlVy3VnFFux/a+Fzd7GOkpt0EMRzllSRlKjtU7czeay3g==
X-Received: by 2002:a05:690c:e3eb:b0:796:2fde:5dee with SMTP id 00721157ae682-7979e899542mr7425397b3.34.1770945252544;
        Thu, 12 Feb 2026 17:14:12 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b3desm56788687b3.14.2026.02.12.17.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 17:14:12 -0800 (PST)
Date: Thu, 12 Feb 2026 17:14:10 -0800
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
Subject: Re: [PATCH net 1/2] vsock: fix child netns mode initialization
Message-ID: <aY564m7pM4pSj+/w@devvm11784.nha0.facebook.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
 <20260212205916.97533-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212205916.97533-2-sgarzare@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,devvm11784.nha0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3633913234B
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 09:59:15PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a new network namespace is created, vsock_net_init() correctly
> initializes the namespace's mode by reading the parent's `child_ns_mode`
> via vsock_net_child_mode(). However, the `child_ns_mode` of the new
> namespace was always hardcoded to VSOCK_NET_MODE_GLOBAL, regardless of
> its own mode.
> 
> This means that if a parent namespace has `child_ns_mode` set to "local",
> the child namespace correctly gets mode "local", but its `child_ns_mode`
> is reset to "global". As a result, further nested namespaces will
> incorrectly get mode "global" instead of inheriting "local", breaking
> the expected propagation of the mode through nested namespaces.
> 
> Fix this by initializing `child_ns_mode` to the namespace's own mode,
> so the setting propagates correctly through all levels of nesting.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: bobbyeshleman@meta.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 20ad2b2dc17b..3b629b4a0359 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -91,7 +91,8 @@
>   *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
>   *     mode, which is set at namespace creation and immutable thereafter.
>   *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
> - *     child namespaces will inherit when created. The default is "global".
> + *     child namespaces will inherit when created. The initial value matches
> + *     the namespace's own ns_mode.
>   *
>   *   Changing child_ns_mode only affects newly created namespaces, not the
>   *   current namespace or existing children. At namespace creation, ns_mode
> @@ -2912,7 +2913,7 @@ static void vsock_net_init(struct net *net)
>  	else
>  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>  
> -	net->vsock.child_ns_mode = VSOCK_NET_MODE_GLOBAL;
> +	net->vsock.child_ns_mode = net->vsock.mode;
>  }
>  
>  static __net_init int vsock_sysctl_init_net(struct net *net)
> -- 
> 2.53.0
> 

LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

