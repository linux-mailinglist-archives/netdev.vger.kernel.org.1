Return-Path: <netdev+bounces-299551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WnoaICY0MGp/PwUAu9opvQ
	(envelope-from <netdev+bounces-299551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12D688C89
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=rMYdPpJ0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299551-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6291330917AA
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2A41325C;
	Mon, 15 Jun 2026 17:14:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6273ED5C9
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:14:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543664; cv=none; b=eAXeBinKUbK1wnl+jk9DprCzfi28Wx3immerJmT1ZO501OPuLS4ghFd5CyJkpH85VnWJ5uq0E5Gqh/MrQ3XJAaIIBs7MeXoQcnpOS2q4Y4Lz4eWQU34F8pNx+Ji/BB1v/eJJOCYpHpSJ8KKTbvqd6cwc+y2dqboO87OGGshO2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543664; c=relaxed/simple;
	bh=mCk47yRizlLhY11bjKyOzubEBEHZeT4fn9ccMJ1wm1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqIn61NQsZboCP9iD3nv1yxJW06gWY+nBfDdIDccWvHwcUcVHfyMDp6BCDIGG3HdPYmkOainkhqNqQn0gEAX12NLtD7cMDuaWmEVwiycUePAD4wtGJY58SNTxxEvTPa6PuQQKQHfGTyXRiXLvW2eSD/fPURxGWBBX+uwKwnKWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rMYdPpJ0; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pXweK5fIyyau43tjztJ/FnjY8m+83lKI0HKKOJB8Tuc=; b=rMYdPpJ0/ezm0HPqzUsxrMa61j
	oI4hoGGCuZC/OLwIiTB9daikvN8vwXoX2qH35uvNchdnVkvfaw2G7W1tPamfbEWjqjWlY9MY3yhZn
	RG0M2b3W+/+SABL8Z1kv7cK/ZN4p0rQsznXVH6RGa5c67KUTjjNR0vcgRSHGFodwwecutVQAyYIpO
	msBLPzSP3c8d18GtDDNvFrU+eAHFe/H5YDPBng43bc7PcDcKLk15q2TLVEKmshFbrA2wNpm1eAZra
	K3sYmnTaHlmGYDIY033kV0t5xq9Tmo3cvW/GZIKPF9g9wUKSfG4wgnSrXZnXDswdaZP6DN903xni4
	JPus0riQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZAt5-00DE9y-22;
	Mon, 15 Jun 2026 17:14:16 +0000
Date: Mon, 15 Jun 2026 10:14:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, brett.creeley@amd.com, 
	eric.joyner@amd.com
Subject: Re: [PATCH net-next] eth: ionic: delete the incorrect
 link_down_count reporting
Message-ID: <ajAye8LnVeqkcGLZ@gmail.com>
References: <20260615170153.592171-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615170153.592171-1-kuba@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299551-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE12D688C89

On Mon, Jun 15, 2026 at 10:01:53AM -0700, Jakub Kicinski wrote:
> The definition of the statistic is quite clear,
> struct ethtool_link_ext_stats says:
> 
>    This statistic counts when PHY _actually_ went down, or lost link.
> 
> Reportedly this is not how the device-counted stat on ionic behaves.
> The goal is to detect flapping links, due to bad cabling.
> ionic reportedly uses this for some firmware stat of how many times
> the traffic was stopped. This is _not_ what should be reported here.
> 
> Link: https://lore.kernel.org/20260610061830.51037-1-eric.joyner@amd.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Breno Leitao <leitao@debian.org>

CC: brett.creeley@amd.com
> CC: eric.joyner@amd.com
> CC: leitao@debian.org
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 78a802eb159f..f7dcfe3d032d 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -111,15 +111,6 @@ static void ionic_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>  	memcpy_fromio(p + offset, idev->dev_cmd_regs->words, size);
>  }
>  
> -static void ionic_get_link_ext_stats(struct net_device *netdev,
> -				     struct ethtool_link_ext_stats *stats)
> -{
> -	struct ionic_lif *lif = netdev_priv(netdev);
> -
> -	if (lif->ionic->pdev->is_physfn)
> -		stats->link_down_events = lif->link_down_count;

It seems this is the only place where link_down_count is read. Maybe you
want to kill it as well?

