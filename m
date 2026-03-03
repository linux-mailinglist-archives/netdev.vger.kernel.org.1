Return-Path: <netdev+bounces-263364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEUJNQUnp2nSfAAAu9opvQ
	(envelope-from <netdev+bounces-263364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:23:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B941F53F1
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CC0F300DCE5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789D36E48B;
	Tue,  3 Mar 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RzNN+vLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FE48C8B1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562152; cv=none; b=GgZeKDvO23jk7Qqwhzp6ndMpSGqPtqqnJ2erBDjEi5SgnVEuL6cSP69YnC2jO6w2Lngh9NxqEA5rBGiXTP856QhbYEXRErRV+khuSefSg/UU+OiVdf5uAL3M5JLWQ/+3B6cSzJCoiGCPN91g00GRcdUum/aI56M709zJFPz0Wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562152; c=relaxed/simple;
	bh=tpQuM+5W84CjfyPtIB/HGmRUoecN9Co8woJs1AoFHRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo+3xGs7f8+djXoECeWJ61l22bdu1lUf1l/PMwSpg8ZO66+qJIn7Syks3X+Z/Fm1IQkF3RzZ1t2sZDxikqFzKsuj3TYRBQlocIA2AhbtzpHMsC6gRhPUyj1P+7eEoovFDXQ0lOEMLoDXc5QvyjVvWm9Hw6v8V3gIdWFwOpCur8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RzNN+vLP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab46931cf1so45324955ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772562147; x=1773166947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buu7Uz55KYttMA+alRRNNRRlc+ACOAEsL4P+TKZKLiU=;
        b=RzNN+vLPpMzzPeOKrosA+GPJJhvCOtZ3HRH0potipfCgc1oCjsQ+mA5k5t2BvxCvT0
         p3+hdgmujTSosjR0R9JgV0SkHr3A4IAHHH/YKqUXtubdIWQPQbuZIf2pgZNA5c/F8hqR
         lyhsTDtO8+sYJdCoGwqmvL8scJsHt6dqRfahDHVh64Myz24c+2xMZAeLdqCglhQ6yaCl
         cB28YGvAu+nFNERycNm3Fgpt5P0QQDY+FRy1QPAtQ1+mOeBN1Bvye4raRAcEEbJU9L6k
         jknKpLGgZQOYQz9A0uuzHr4sUDRGXVGdOSDGCwISLccvcADircwgmJ0+g5F8XA9pt19C
         hPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562147; x=1773166947;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buu7Uz55KYttMA+alRRNNRRlc+ACOAEsL4P+TKZKLiU=;
        b=bEwfrHgS8NPtElNbTbE4SI+S7G8isiYndLdGpMbCrpEUvLHTkrpTR2WsAnH7VZgdDu
         vGwTfC3wkvDYRdqzw7GpcdLcIMUjdEl/L1nIfou2aL0QH57L8XCXjbeyWRpFeg52tLe9
         rwONyuZKH8Q2KKrCOsjT5Lg+/MnV1OGH4MfdQ3LMA5whpYcDbvXq9cYFQXlCYSf3Xl4V
         bQwn+zfTvClt7SX7A1EUdsSc2Hg9C4hi2+uzci1I/iKAPK+TjIOfk0lVbhNdqUBsZJDc
         TxIiG6iNxV3RVS4OG0F3jfPfI0zBUiqKRZH0kS1JtUTLBhnU9X9LRvL48AE8XN1uPnHd
         oL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuit8keK/jsNJHzjk1/pHmFj/EVEAUmoyZGUxmcop0oVfPqqCHou4BHWC3tt+RQtM5xtmTJNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtepJRES+uG8iWaXexBjlOVcbSMi1SvSHfEYYPiZqPDFsd0KH
	V2HI5RJ26Z3qF+QjU8L5b+GpX+HbsCWPmAJYLle3JWBEvzVlSqUuAgAsf9PUhse1GCk=
X-Gm-Gg: ATEYQzywd0nwZgvRnEzFP0OHjmkHjoI8HrTMyrkofV59Ed3ooqbdjrrXmQQdPh0X0O1
	jeES0nrtIepmEMvX1XC9MUHdafvZS1moyhQPgYscl7JXPOhpqqncvMXQjjvXDfTuDxtCG+NSmZD
	Ces8MSzhmlPu7sWfC+nA3WTPBT9tUu22XTxCTAVW2lfRkgH/FOEAyB1DpSEDZqK28wZtZacRIA0
	yLBCm62rVB9qHZCwWvWKyLQZP8mLjWYcksRNhYhpBFxvrgNW7IbWQIujOB6gzeum2lGyp7q8JiO
	jod/HveDKqE5zJUsA3Pq76dOAuOQTjpT218X+PT7L9ljMniUP/6uKyrAYscNAZIAb2gGyrMQOeR
	Aew3JGywS/f4BNai64h1Fir+JPLnFttpa0MiET2WlHJbzUiGZYib6DTtGtj8QPuc+jRRKcam8tC
	tr3OLY51U4+Hxzbw==
X-Received: by 2002:a17:903:1905:b0:2ae:47d7:e101 with SMTP id d9443c01a7336-2ae60c53f62mr27683895ad.1.1772562147351;
        Tue, 03 Mar 2026 10:22:27 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f283sm174125805ad.49.2026.03.03.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:22:26 -0800 (PST)
Date: Tue, 3 Mar 2026 10:22:26 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aacm4vPHq8V42lw1@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
 <20260303024510.644962-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-3-carges@cloudflare.com>
X-Rspamd-Queue-Id: 73B941F53F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:43:50PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ab73aad40593..c06033cf9f82 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15906,6 +15906,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
>  	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
>  };
>  
> +static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
> +	.xmo_rx_hash		= bnxt_xdp_rx_hash,
> +};
> +
>  static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
>  				    struct netdev_queue_stats_rx *stats)
>  {
> @@ -16790,6 +16794,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto init_err_free;
>  
>  	dev->netdev_ops = &bnxt_netdev_ops;
> +	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
>  	dev->stat_ops = &bnxt_stat_ops;
>  	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>  	dev->ethtool_ops = &bnxt_ethtool_ops;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 90fa3e93c8d6..34bb98709f2b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -232,6 +232,7 @@ struct rx_cmp {
>  	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_ICMP			 (7 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
>  	#define RX_CMP_LEN					(0xffff << 16)
> @@ -311,6 +312,7 @@ struct rx_cmp_ext {
>  	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
>  	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
>  	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
> +	#define RX_CMP_FLAGS2_IP_TYPE				(0x1 << 8)
>  	__le32 rx_cmp_meta_data;
>  	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
>  	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..1ab3d9f9b3ac 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>  				  xdp_buff_get_skb_flags(xdp));
>  	return skb;
>  }
> +
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct bnxt_xdp_buff *xdp = (void *)ctx;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	enum xdp_rss_hash_type hash_type = 0;
> +	u32 itypes;

Sorry don't mean to nitpick (also: I'm just a random subscriber to the list so
maybe the maintainers don't mind), but I think rx_cmp_ext needs to be moved up
to preserve RCT ?

You can retain my Reviewed-by (if you respin) because the rest seems OK to me:

Reviewed-by: Joe Damato <joe@dama.to>

