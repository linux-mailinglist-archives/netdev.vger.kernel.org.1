Return-Path: <netdev+bounces-258333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBFxEgzCjGkmswAAu9opvQ
	(envelope-from <netdev+bounces-258333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:53:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBA126BB3
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76C203014511
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8683301704;
	Wed, 11 Feb 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYrjakXU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D621256C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832392; cv=none; b=Dgu92LBjaQ0RvG6GRaqTTS78cBUGQWTAG9ddTKz7j/pR/x8Nt8A0D+v8QwPYMJDfDL0llYBR2BnkZQJyhV9ZOYPsaIxS9u2YJu0IIxrf8E/bztpMUbGQI3XReT+1QMDGWLkCRy1VNG0OcZeMVJ58hXQjK2mfx1VOv6NuAAN2Ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832392; c=relaxed/simple;
	bh=c4dq5xUpMII4H2H8IBMNXRUIU/AIU6r+F0KqMfvj9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx8uBNmA9KoTUYuk+TDzR9OQPrIaVuxjn6CZ3XJ7ZmG0wdMLANHihXqs05QUDJVozo7NsV16xmrOtbbXL22w2wP5enx/PK4HM4Aqf+c8r33dsHQGlIZPhUacFzIsXfFAET4SN5apPMk98LP3nJKW492f+Gcen8+IE1SOEG0gkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYrjakXU; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649df393c04so2283786d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770832390; x=1771437190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWg6VNIdjfTRqaYdKKaQYNgfzqUG27HO2/zp5mmPnfw=;
        b=dYrjakXUi2wPSZ4t6+CG1WCK3y0guJbYFQyH7mBpLBwh11cRmsJF3pWSshBVsCGnXC
         AS9Uo4TYYmdbuwBNIseAFuv+c04LmvqEqwj0C2r9c5+A2m2FisOG98Ir5y5296Yzr2Nw
         cFquUCKvKqFlIhuBYEKwyTrYVnfmJKA6QHeAIK25m7RHZrpXzDsKr3zs5zcsUIDpWuIK
         dMmw0sSHKTBYP5yDTtSA6mLXrNSaRMXOjOMrhRPMAKyEQk3Vdrd712/qI9xYZrsXgCPF
         NlxjH56N489LYXVkK9Hqkbk3LjXN7InR9PrdhNHjg3TJaAft8yut2wHFLMGhwsfKsj9W
         1Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832390; x=1771437190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWg6VNIdjfTRqaYdKKaQYNgfzqUG27HO2/zp5mmPnfw=;
        b=GHd/j+81kpeMyrUy93KMteQCvufVZFUNKFp0jELSk4FlKEadey43TNyA3p7BkI/PYH
         uEYxLzP83fDimjzYAfk2HYK29zjQwGxdpuoV3VTpD1wFSApgx3szvckOOCtZMCjs2JBs
         FUy9da52mkB37AJCqCXEn4Gf/qClHqPxS4l99I27b289WC81iIOxwdbC7nOBW3wI/I+f
         v74cwDIvd4JJhI4atquH3PjqcTBzf8HggMeIgbv6960UMWydLYZ31AIbNp6I15HNfwza
         h4EzuujE4uzPGWByD4Z7RAjb5sTnay/EskTXm/gkFePjT8V/Y46r5AODqCj8lFQ52Rkn
         45WQ==
X-Gm-Message-State: AOJu0YwRYai/DaJX7D2Q1wUWjBmmbbfXmba5MppzgfiLz4ioeJ+L1ZBd
	/6YG0B3oYv4Im9BKM7Sx8Qn8CEXceYBodBtx4vZhC7sd6xngwA3654If
X-Gm-Gg: AZuq6aJfbNHdsC0HcHFynTClBEaLcWZHbkQocVmdudyxI8LYZn4fOou41kr3u2t/DDV
	x7oNTIMOToMs7t2gwJTVY2wEm7RePR0ONUTBXzaTql2DRgctLf4B6wnnxDbU8gFjPyYYdTPCdT1
	cbK5W6zEjBq1YlPEoMKOcbeedOuaG76Bxya12f16NU7p2qrX66EoSGe8Vf7yTkGrAcrKYVrBBzy
	6SyCHHqva52GbyQZvVZgG9amFoXZFg4wrP+Rf0CEYITWAVm7GCrCaN2vVPTIMVZd/+o8iP24kla
	IVcVBSXcKLlix67ddy5VuFOjW7YbxCNmdetzDJ0+OJgTDRI5csRroQYlRANlQAO4PZtnQbiBNRj
	BNSFpNXXIh4GApFic5jqELsoIN8ISIUMRBUDPl1JupSlo3fFEBiJzySm5gJhOcOUE7UGPW3IXDE
	qYQ1B3yjSjhnPgZcO28c+Vvvuw3k2pknROTOVOwfebYW2iGPopfOkLa13dXg==
X-Received: by 2002:a05:690e:130b:b0:64a:f2dc:2863 with SMTP id 956f58d0204a3-64bbaac25cfmr120778d50.47.1770832390535;
        Wed, 11 Feb 2026 09:53:10 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc87a3a0sm2562323d50.9.2026.02.11.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:53:10 -0800 (PST)
Date: Wed, 11 Feb 2026 09:53:08 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>, Wei Wang <weibunny@meta.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 4/4] selftests/net: Add netkit container ping
 test
Message-ID: <aYzCBIACSmC0l+oA@devvm11784.nha0.facebook.com>
References: <20260210200419.3555944-1-dw@davidwei.uk>
 <20260210200419.3555944-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210200419.3555944-5-dw@davidwei.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258333-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid,lib.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei.uk:email,rss_api.py:url,rss_ctx.py:url,pp_alloc_fail.py:url,nic_timestamp.py:url,iogearbox.net:email,nk_netns.py:url]
X-Rspamd-Queue-Id: ADDBA126BB3
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:04:19PM -0800, David Wei wrote:
> Add a basic ping test using NetDrvContEnv that sets up a netkit pair,
> with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF program
> to ping from a remote host to the netkit in netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  tools/testing/selftests/drivers/net/hw/config |  3 +++
>  .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index a64140333a46..91df028abfc0 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -32,6 +32,7 @@ TEST_PROGS = \
>  	irq.py \
>  	loopback.sh \
>  	nic_timestamp.py \
> +	nk_netns.py \
>  	pp_alloc_fail.py \
>  	rss_api.py \
>  	rss_ctx.py \
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index 2307aa001be1..b6524040418e 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -1,3 +1,4 @@
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_FAIL_FUNCTION=y
>  CONFIG_FAULT_INJECTION=y
>  CONFIG_FAULT_INJECTION_DEBUG_FS=y
> @@ -5,6 +6,8 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
>  CONFIG_IO_URING=y
>  CONFIG_IPV6=y
>  CONFIG_IPV6_GRE=y
> +CONFIG_NETKIT=y
> +CONFIG_NET_CLS_BPF=y
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
>  CONFIG_UDMABUF=y

I did find CONFIG_NET_SCH_INGRESS=y being needed for the qdisc too,
sorry for missing that last rev.

> diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/testing/selftests/drivers/net/hw/nk_netns.py
> new file mode 100755
> index 000000000000..afa8638195d8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
> @@ -0,0 +1,23 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import NetDrvContEnv
> +from lib.py import cmd
> +
> +
> +def test_ping(cfg) -> None:
> +    cfg.require_ipver("6")
> +
> +    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=cfg.remote)
> +    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=cfg.netns)
> +
> +
> +def main() -> None:
> +    with NetDrvContEnv(__file__) as cfg:
> +        ksft_run([test_ping], args=(cfg,))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.47.3
> 

I had some issues getting this to work until I enabled IPv6 forwarding.
I wasn't able to tell if this was only required because of my particular
REMOTE_TYPE=netns setup, or if it is something that is required by this
test specifically? 

I'm also running this directly, but maybe this is done prior in
kselftest?

Best,
Bobby

