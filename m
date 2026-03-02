Return-Path: <netdev+bounces-262944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMzfD5IYpmmeKQAAu9opvQ
	(envelope-from <netdev+bounces-262944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A588E1E6573
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03B25300DEED
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC131F9B8;
	Mon,  2 Mar 2026 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ggY0Ew6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19743909A7;
	Mon,  2 Mar 2026 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492942; cv=none; b=EhVoA9KcWZWO4GLk5+ZFm6VNPaCwyd3hjIUE3rzhPa5SLYt+bXoRldTW8tBVyy/zKjTeWNpZWxf+PIo4Erh7rWQPenHigSfjg6i2GjCTZrZNpFHLbgSm2e805QyCGoiAilIwKMdXFB5Fgl8Wgj9CkV7WlBw8XALmQW0mm6ANcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492942; c=relaxed/simple;
	bh=hcUXOFKhrp3kpT8BHkdEs9gDVgsGgcDq4srK9d98Gd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6VsC2r4CaJuxDAkdvNOdqoi6614EgR+nzwJdfdC2HaXXNR3IkI+KvptXKPytBYXEuKwu7tzcktuJfL3pS/4DvR150/31Ompi9MT+IF4Yj9/m9Kx0cKAAXhvuigqvCYRktVFRGsSNNnWR5Fhx+yXS+sfEEAckgLdPrY6UvSsCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ggY0Ew6a; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0C94160253;
	Tue,  3 Mar 2026 00:08:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772492939;
	bh=EhYGbHxw4AmfG52xIpE8yQXQi7g9XLK9MH4gEzKoMIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggY0Ew6aKnrycb4lexNGQY3Y8lEhg0V51z25bXGIaTTgGmgtZzQr3+x7IpQ4L0V1N
	 qpJ94Hx2iG3HewnXNniIoHl38OoPv1vUcEuU9xTndmBw7LQWqSyDlyas6bX/423PoK
	 3qt4OvFm7wMdtjLMAFMpMFIZebk9MOSfzYNgwFY3I5GK/egODh2ryuJHD6HqZuV6yN
	 WgpFW86TuexR41wHt4orNHvxtA1EabkKpjjTmmZi0mVdP7Dx4zpTpzpRCVq6+rfdbN
	 FbMRF6PgvgBvzRMYYjEPZgU422pNZxI8ExXeAi6uBlyO85V5cxQBGxhoqH4v5KX4/6
	 eQ9iHo6JUCkRA==
Date: Tue, 3 Mar 2026 00:08:56 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Helen Koike <koike@igalia.com>
Cc: fw@strlen.de, phil@nwl.cc, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] netfilter: nf_tables: fix use-after-free on ops->dev
Message-ID: <aaYYiPTO5JYOlhhY@chamomile>
References: <20260302212605.689909-1-koike@igalia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302212605.689909-1-koike@igalia.com>
X-Rspamd-Queue-Id: A588E1E6573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-262944-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,igalia.com:email,appspotmail.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:26:05PM -0300, Helen Koike wrote:
> struct nf_hook_ops has a pointer to dev, which can be used by
> __nf_unregister_net_hook() after it has been freed by tun_chr_close().
> 
> Fix it  by calling dev_hold() when saving dev to ops struct.

Sorry, I don't think this patch works, dev_hold()/dev_put() use
per_cpu area.

The nf_tables_flowtable_event() function used to release the hook, but
now things have changed since there is auto-hook registration.

> Reported-by: syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
> Signed-off-by: Helen Koike <koike@igalia.com>
> ---
>  net/netfilter/nf_tables_api.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index fd7f7e4e2a43..00b5f900a51d 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -352,6 +352,7 @@ static void nft_netdev_hook_free_ops(struct nft_hook *hook)
>  
>  	list_for_each_entry_safe(ops, next, &hook->ops_list, list) {
>  		list_del(&ops->list);
> +		dev_put(ops->dev);
>  		kfree(ops);
>  	}
>  }
> @@ -2374,6 +2375,7 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
>  			err = -ENOMEM;
>  			goto err_hook_free;
>  		}
> +		dev_hold(dev);
>  		ops->dev = dev;
>  		list_add_tail(&ops->list, &hook->ops_list);
>  	}
> -- 
> 2.53.0
> 

