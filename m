Return-Path: <netdev+bounces-271477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAtjE/mtw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:42:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE23225ED
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B6630F6960
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8030CD92;
	Wed, 25 Mar 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RgZM/yfN"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4232FA14;
	Wed, 25 Mar 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431329; cv=none; b=AT+tYkQfLAd9T2CMZtlpZOGqNp2ulo34MqYqElDG24v1nJDnrUeBdhnjcWQKbBTZUouzCp96bGoHJ5vzHxJivdH8nOnRhnLgAMZK6MaLIDGHnRQIzHlBZn3G+p7JOVj54f3mCmOgZ5WxCHzr6iFPW104IiyGovUFE1jGz+UctR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431329; c=relaxed/simple;
	bh=AtcVS7doo0cKRIoG0V5SoR7go8tkrbBz6Smpy+neHKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAbaXWNmab3t4uvFdJGpwCTurrW770UyP379fZDQjSCAWZw/lE8wdvYNxpHjMUvz7+oCueLpXkJUPpZN0xkOnONEt1kxjsNa93AOG2ymEQI3u+TDuWkGo5y/qGPJYJtParIsgpgQ2m3wMnUK52ucfo6oxXBnjBn9dHSKFP+Rcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RgZM/yfN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TyJfWggum4hTPQqcIuHDMDd1blS+adBA6XDjzohGGKE=; b=RgZM/yfNODreEQKeyhl2nYpxFC
	jeZVqqBwkO/MvbBXzHLkTNHT/4+f5WmvhoRzapYEidvwsLrog3xQ2EHz4QgQH8utkLtaScGQP9KxH
	V1XmVh7K8EcbWRzS9xLy2vi+GXsCecxcLTYYAA/OVN+0jIgHv0btGCRuWqg0ZIiZj4AYq1XA9GbDn
	8iozRC8nTn5/ZiiuGHOMP6CpGpSqOsSIJeZie4i4vEGocfOvoC/B3uRMxR+Dn9UAcZVpVlIaRc3W2
	dcdizuVI7RtmnpsGeO3iGwevSLkNNsCZQlRNW6R8gR277X3CO89jRGOJYwOYZRw2SRZzBCOOxmk3O
	ldm2EwZQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5Kdy-008yqj-PS; Wed, 25 Mar 2026 09:35:17 +0000
Date: Wed, 25 Mar 2026 02:35:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Izabela Bakollari <ibakolla@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: add transmit timestamping support
Message-ID: <acOrt0LqV__xh_93@gmail.com>
References: <20260324160823.151472-1-ibakolla@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324160823.151472-1-ibakolla@redhat.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271477-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,amd.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9DE23225ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 05:08:21PM +0100, Izabela Bakollari wrote:
> Enable software TX Timestamping. The out of tree driver 
> also implements this.

"The out of tree driver also implements this" is not the most technical
justification.

>
> Signed-off-by: Izabela Bakollari <ibakolla@redhat.com>
> ---
>  drivers/net/ethernet/sfc/ethtool.c | 2 ++
>  drivers/net/ethernet/sfc/tx.c      | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> index 362388754a29..c0038b942913 100644
> --- a/drivers/net/ethernet/sfc/ethtool.c
> +++ b/drivers/net/ethernet/sfc/ethtool.c
> @@ -231,6 +231,8 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
>  {
>  	struct efx_nic *efx = efx_netdev_priv(net_dev);
>  
> +	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;

Don't you need to append SOF_TIMESTAMPING_TX_SOFTWARE instead of
assinging it?

	ts_info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;

