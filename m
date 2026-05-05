Return-Path: <netdev+bounces-284424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K87Ivn3+WmNFgMAu9opvQ
	(envelope-from <netdev+bounces-284424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:00:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A14CEF71
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69509300443B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB83C47DD70;
	Tue,  5 May 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mfvJ8Zmx"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463931F999
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989291; cv=none; b=HazvUAYibhGL5/M5s+NFohSY1OSLzjqkTzoSpdy3NFPPrOt1EcO6bh8lfCYYXJhVIBUQQLpASmZw3KWYEjVq8iTjSYJLVwYF6DPBUMsekZL7MsH7QS9sDCATAqAaon4GrfWyR8yjE5U/Ann0ApfSU2nMO6G16ZGVqE4hEnC5SS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989291; c=relaxed/simple;
	bh=MTvK9+C21xuIA06FzqrnqdYZc1ukHj+rWyuwu3V7EXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eplwCw3CZS12d0zkxKbniWkeA/Bk8Rqqk+Hr4tQ/WFXjtjVzAg04UQ9nuVpOaEgqedqYo6wn8jZQiqqPBQVnzEH0cJPYKhldD/u9XDRcO5ZN9bkxP/bOhDBX+BwNdEwJmJu2wqjWhKOZQP+6E5iBkGHUJM9UiQp4XHppiLTd2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mfvJ8Zmx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6eabe3df-08b2-4237-a989-a8e3a9bdf37f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777989287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SI4lfLI8eYyem0NJxVJ2GIm6PJT/ZtNkHhHLajT+gFs=;
	b=mfvJ8Zmx8olWsWDB/KpPcbRH3P2bve65awZzrMbCe6iGMVhvJcsINe7HiHohP+u+4nHaO9
	JL6jKtiuUCxlafG2S8orKQR8JvefShsXASjq7m9h3vDccVss6CksL8qzJvsUclk65/pjoa
	1T/LFchapCz/gz/ey6ZdxFgeMJOdANU=
Date: Tue, 5 May 2026 14:54:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-6-eric.joyner@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260501031555.43259-6-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 840A14CEF71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]

On 01/05/2026 04:15, Eric Joyner wrote:
> Several FEC error statistics being collected can be reported in a
> dedicated ethtool callback for FEC errors, so implement the handler that
> does so. This includes 802.3ck FEC histogram data that some newer
> hardware collects.
> 
> Assisted-by: Claude:claude-4.6-sonnet
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>   .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 78a802eb159f..fe1f753b6115 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -418,6 +418,56 @@ static int ionic_get_fecparam(struct net_device *netdev,
>   	return 0;
>   }
>   
> +static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
> +	{ 0, 0},
> +	{ 1, 1},
> +	{ 2, 2},
> +	{ 3, 3},
> +	{ 4, 4},
> +	{ 5, 5},
> +	{ 6, 6},
> +	{ 7, 7},
> +	{ 8, 8},
> +	{ 9, 9},
> +	{ 10, 10},
> +	{ 11, 11},
> +	{ 12, 12},
> +	{ 13, 13},
> +	{ 14, 14},
> +	{ 15, 15},
> +	{ 0, 0},
> +};
> +
> +static void
> +ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
> +		    struct ethtool_fec_hist *hist)
> +{
> +	int i;
> +
> +	hist->ranges = ionic_fec_ranges;
> +	for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
> +		hist->values[i].sum = extra_stats->fec_codeword_error_bin[i];
> +}

ETHTOOL_FEC_HIST_MAX = 17, you defined 16 bins, but iterating over 15 of
them. Looks like bin {15, 15} will be lost in stats.



