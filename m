Return-Path: <netdev+bounces-267235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILISFgFXs2kRVQAAu9opvQ
	(envelope-from <netdev+bounces-267235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:14:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D227B7D5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B06C0305F50A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8E27456;
	Fri, 13 Mar 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fWeBTqmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510039FD9
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360889; cv=none; b=KUHj2uHjdVeiFJxd6caQaIommQB2Ao218TMlAT6OpvXgsNKXw75agAT9SRajPsL3/aMa4Iv+P+rbk9DRojBHdqph3uFJ2UrZfzFJgwgQ4w7vpivHLscGt2iR7EvLaCKNjFMHa5oH7HHUGm0JUUFHydWc43iXa3EpHVeRe0a9k/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360889; c=relaxed/simple;
	bh=KdGdIosxGVCnVTmHO7nXcKEdC5Z/YV7CUzxv2yNCaAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjjwQCT2akSFWlJH/OChadj8L/TRzjW+Pr1V17NL/N/Lonnx62uXqFlwE9Adc5c6oIUcpJBR0kD6CbxoszsdMpl3CSFeesiVngKu1WBWeDA5AfHy5wsLtegpkBPcpkwP2zoJLenGR5rIeIVkDqsAKaC4Fz3TuqAEn69jXDXnGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fWeBTqmS; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56b1f4ddf83so1508468e0c.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360887; x=1773965687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkE3keE0SIqgIdKBzUwz50sfscGesq4fS8DBICuT/rA=;
        b=J0dGHqCql+3dD6K99CKj69Z5X/ocSRDffA0oLPa6x5XOnqel+mu8zevJsqwHtCIJCZ
         ZUoYFysCJVkOfYvzy8kJwJ3KX7IcRnAzWvt3okIh4YUTNc0RgQlUUuo12k+GxTsNHIOt
         iHFnSBStzQlSh405hFiUg6T74vli/RlpkXAsjj30MiNxIED9SSxJNAT2OyMzbtA6tUD+
         veHsnHUNuf9/JsOKgNBo2pSdjSnpxB/KVqbmtZd0vGej8LxlhMtcGIXFGLZOdN+zMpQk
         KrkassWjZ3fEidJzJqLTjRCcN9ivYmKQkQN535lF42hKe6baZ00CC+ID7EcPlkPqgLA/
         KX+g==
X-Forwarded-Encrypted: i=1; AJvYcCWUi0SsyEMMdV2unVnw4jKxMoHh5q5IMm7+tmRSyFY8UBqMq3P5U73wj8wikuV5S53/393ntfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSanj107d+OEkg9/a6gw+smJoDHN4A0Vyyems+wPnPe2oWKYe
	q0qmVY0jEQkTIXhANdLn6951Y200BiT5xFW6783dnv2hSpxSuOBS8+yLfqTLx+s2eFZc1r9JRRy
	qSQ9DTFaiT7vYVbhgDWvjiDT3O4vrNNcvEytpUSp9qJd7s82wK6Isyu0ZxOlIuOZrHBQtvxo27X
	MeF9EqtLFKuS2fI9Lz/OLb7kDW2bzP06jHQ84GA+I7SOPUnf0UY3BI6u/v70o17ntiS+7LheQHN
	xXQNPh49YBm64S3/Q==
X-Gm-Gg: ATEYQzwkYf5DB2kNbr4hf0vNExCZI+NF5oyUk+xD+eQkB4qjTCXYZUFvkeW/4lBCgsb
	6bXtMO0l/cwKGYQLpwpaHSN23ryUPUtm53Xzu6QO1mNW6ek5GmEHlzEM+wVfvLp3mnKvPcT+gn/
	95jeAwYkHffn5ha53FBMtHNAhSqiSihkbNNse+tsk8bzf/2IhxbFVXdJp3r8s73jIoR3KfT6bsc
	KAx4ibBessqUSW4alewoDQQgMF5qptoxSn9pjTF6z3i5d6vE033W3UXaDbl6wJ0rJGOjEdyCEyX
	SREsW3gUPSIT43ycmOoLvFhaaTwFF6dGkaAqg5XnIBw6g9eQFRL6bEKrlLW4Ss+yJqUe0Rs+vm4
	LImsSzgZQCJopo70AxWXaiiYXHQxGDc+ASp7uFHhYfECjLMH8cKAyGk0lPq4oB9t2Aim5SFYvwe
	NSKfcqBR9dVUHwA7QZy7w3lp+hekowL41aljIUCep6KusKuhbSY5qQw4cHiA6bE6/RlQ==
X-Received: by 2002:a05:6122:17a1:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-56b628dedcbmr521585e0c.4.1773360886919;
        Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56b4640ffc3sm805963e0c.4.2026.03.12.17.14.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fec8d44so1046227285a.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360885; x=1773965685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkE3keE0SIqgIdKBzUwz50sfscGesq4fS8DBICuT/rA=;
        b=fWeBTqmSs2Db3lmU9OqLpGJtClZ8Yw7CVuhYL6BOOyi9P+ki0qz/MLQSHS8X3vuCAd
         6jpA51Ef5t/6q22f3MAbnKvgkmU7lkthmJPuYyEccRKDGjOS5e55WOCSVEa/FjDlW9DS
         SRVJXDgtDVEH3NbtoTG3g7CJ7XHi70/ju31no=
X-Forwarded-Encrypted: i=1; AJvYcCVTvmEHFfGVzrE07/u7FeFwtaaCgb6HtP69MeMLoAYe0HVx7uiy/rxOBJZedME/np7+3kRG/5I=@vger.kernel.org
X-Received: by 2002:a05:620a:4153:b0:8c7:139a:bf48 with SMTP id af79cd13be357-8cdb5b20a75mr233369385a.49.1773360885654;
        Thu, 12 Mar 2026 17:14:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:8c7:139a:bf48 with SMTP id af79cd13be357-8cdb5b20a75mr233365285a.49.1773360885124;
        Thu, 12 Mar 2026 17:14:45 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm437647185a.12.2026.03.12.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:14:44 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:14:39 -0400
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <abNWL8L64m7rweRh@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-2-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267235-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,dama.to,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,broadcom.com:dkim,broadcom.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.gospodarek@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA9D227B7D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 05:00:16PM -0600, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c982aac714d1..ab73aad40593 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	bool xdp_active = false;
>  	dma_addr_t dma_addr;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
> +	struct bnxt_xdp_buff bnxt_xdp;
>  	u32 flags, misc;
>  	u32 cmpl_ts;
>  	void *data;
> @@ -2231,9 +2231,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	dma_addr = rx_buf->mapping;
>  
>  	if (bnxt_xdp_attached(bp, rxr)) {
> -		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
> +		bnxt_xdp.rxcmp = rxcmp;
> +		bnxt_xdp.rxcmp1 = rxcmp1;
> +		bnxt_xdp.cmp_type = cmp_type;
> +
> +		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &bnxt_xdp.xdp);
>  		if (agg_bufs) {
> -			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
> +			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &bnxt_xdp.xdp,
>  							       cp_cons,
>  							       agg_bufs,
>  							       false);
> @@ -2245,12 +2249,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	}
>  
>  	if (xdp_active) {
> -		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
> +		if (bnxt_rx_xdp(bp, rxr, cons, &bnxt_xdp.xdp, data, &data_ptr, &len, event)) {
>  			rc = 1;
>  			goto next_rx;
>  		}
> -		if (xdp_buff_has_frags(&xdp)) {
> -			sinfo = xdp_get_shared_info_from_buff(&xdp);
> +		if (xdp_buff_has_frags(&bnxt_xdp.xdp)) {
> +			sinfo = xdp_get_shared_info_from_buff(&bnxt_xdp.xdp);
>  			agg_bufs = sinfo->nr_frags;
>  		} else {
>  			agg_bufs = 0;
> @@ -2261,7 +2265,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  		if (!xdp_active)
>  			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
>  		else
> -			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
> +			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
>  		bnxt_reuse_rx_data(rxr, cons, data);
>  		if (!skb) {
>  			if (agg_bufs) {
> @@ -2269,7 +2273,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
>  							       agg_bufs, false);
>  				else
> -					bnxt_xdp_buff_frags_free(rxr, &xdp);
> +					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
>  			}
>  			goto oom_next_rx;
>  		}
> @@ -2293,10 +2297,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  			if (!skb)
>  				goto oom_next_rx;
>  		} else {
> -			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
> +			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
> +						 rxr, &bnxt_xdp.xdp);
>  			if (!skb) {
>  				/* we should be able to free the old skb here */
> -				bnxt_xdp_buff_frags_free(rxr, &xdp);
> +				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
>  				goto oom_next_rx;
>  			}
>  		}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index 8933a0dec09a..8c66698bde11 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -12,6 +12,13 @@
>  
>  DECLARE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
>  
> +struct bnxt_xdp_buff {
> +	struct xdp_buff xdp;
> +	struct rx_cmp *rxcmp;
> +	struct rx_cmp_ext *rxcmp1;
> +	u8 cmp_type;
> +};
> +
>  struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  				   struct bnxt_tx_ring_info *txr,
>  				   dma_addr_t mapping, u32 len,

