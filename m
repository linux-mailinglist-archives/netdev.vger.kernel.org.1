Return-Path: <netdev+bounces-274423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJUXB6EpzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 887693860D1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35588304A229
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4A3314C2;
	Thu,  2 Apr 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="T0m6LneL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19435958;
	Thu,  2 Apr 2026 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118344; cv=none; b=YIF7sbMy0rlKcTRliNVh383wo8XSqHVnrXwvs0a/jPG1h6m5t0++OW5ei0bSiXUZgSTVcm0krkyQdHKKsWuFCPLvKrRwlDX04RSoskWSMmhG9qqKrBPsSE09/SPJSSp6IPLF4AN5u79zwFmbg6m3pta8fpIQRxOsBMQhYvwhnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118344; c=relaxed/simple;
	bh=WazBELmidOWFZeUlpkcMJnK5BF4AfWpSzb3HgA0zJYE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iJR6g+L8fNROJYrYbEG80uUCU7iYVzMpDwsyAF47TSTHL6OkKlgZ78HQ7tRodATPeqjLprNB4gQAJ2i4DkxIJAhScl6OpfOmiMLeGLstO2wWuaow8XyBtjtor3hxU4kmXBpZlMJhhSiNMlttkd4KMRsDmSUx0SrK5P+SCLBiIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=T0m6LneL; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C2B9A5849;
	Thu,  2 Apr 2026 10:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775118340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yERmGdmSHYIkXp7UksjKm55jnHNM2DSfFiQqHT5YTws=;
	b=T0m6LneLS+ojJEHRXy68YVB1+xlrfACK4tThM1qo4TfsXtRroUCpD/YdmNtQDMAm6sb0hB
	ImUoJ9/rT12TNTVBmEsdgUWBkEnP2JyV/3SZW+DvGAjTVFJRXmNLiYQ9nrlW2V2bjabDmf
	2yUkACQq3EuGpw2H9zwM5anbwzSk6HnnSYWKRTtktNdENnPaYIAG27CtzE7mrcwB/8rKG6
	qZWJW8s5NeeFD0JWxs7WJKdOJay16axtotl39A8OGPQnJIyB7psCEpEqDny0Ndr1HV1pS3
	vD9JocZAmqX1IG9SitrpzqGkD4go0tPXP7aod4gMMBUthFdtVEpqc9LzPBukaA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 10:25:38 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <20260401202702.0b0b6dec@kernel.org>
References: <20260328230513.415790-1-nb@tipi-net.de>
 <20260328230513.415790-4-nb@tipi-net.de>
 <20260401202702.0b0b6dec@kernel.org>
Message-ID: <bc616b9914372a63c740c2f35f5dd8ef@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 887693860D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2.4.2026 05:27, Jakub Kicinski wrote:
> On Sun, 29 Mar 2026 00:05:06 +0100 Nicolai Buchwitz wrote:
>> @@ -2403,26 +2456,52 @@ static unsigned int bcmgenet_desc_rx(struct 
>> bcmgenet_rx_ring *ring,
>>  			goto next;
>>  		} /* error packet */
>> 
>> -		/* Build SKB from the page - data starts at hard_start,
>> -		 * frame begins after RSB(64) + pad(2) = 66 bytes.
>> -		 */
>> -		skb = napi_build_skb(hard_start, PAGE_SIZE - GENET_XDP_HEADROOM);
>> -		if (unlikely(!skb)) {
>> -			BCMGENET_STATS64_INC(stats, dropped);
>> -			page_pool_put_full_page(ring->page_pool, rx_page,
>> -						true);
>> -			goto next;
>> -		}
>> -
>> -		skb_mark_for_recycle(skb);
>> +		/* XDP: frame data starts after RSB + pad */
>> +		if (xdp_prog) {
>> +			struct xdp_buff xdp;
>> +			unsigned int xdp_act;
>> +			int pkt_len;
>> +
>> +			pkt_len = len - GENET_RSB_PAD;
>> +			if (priv->crc_fwd_en)
>> +				pkt_len -= ETH_FCS_LEN;
>> +
>> +			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
>> +			xdp_prepare_buff(&xdp, page_address(rx_page),
>> +					 GENET_RX_HEADROOM, pkt_len, true);
>> +
>> +			xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp,
>> +						   rx_page);
>> +			if (xdp_act != XDP_PASS)
>> +				goto next;
>> +
>> +			/* XDP_PASS: build SKB from (possibly modified) xdp */
>> +			skb = bcmgenet_xdp_build_skb(ring, &xdp, rx_page);
>> +			if (unlikely(!skb)) {
>> +				BCMGENET_STATS64_INC(stats, dropped);
>> +				page_pool_put_full_page(ring->page_pool,
>> +							rx_page, true);
>> +				goto next;
>> +			}
>> +		} else {
>> +			/* Build SKB from the page - data starts at
>> +			 * hard_start, frame begins after RSB(64) + pad(2).
>> +			 */
>> +			skb = napi_build_skb(hard_start,
>> +					     PAGE_SIZE - GENET_XDP_HEADROOM);
>> +			if (unlikely(!skb)) {
>> +				BCMGENET_STATS64_INC(stats, dropped);
>> +				page_pool_put_full_page(ring->page_pool,
>> +							rx_page, true);
>> +				goto next;
>> +			}
> 
> The large branches here are quite unusual, normally drivers fully
> prepare the xdp_buff and if there's no xdp prog attached act as
> if there was one and it returned XDP_PASS. Saves LoC and therefore 
> bugs.

Agreed, will refactor to always prepare xdp_buff and use
bcmgenet_xdp_build_skb for both paths in v6.

> 
>> 
>> -		/* Reserve the RSB + pad, then set the data length */
>> -		skb_reserve(skb, GENET_RSB_PAD);
>> -		__skb_put(skb, len - GENET_RSB_PAD);
>> +			skb_mark_for_recycle(skb);
>> +			skb_reserve(skb, GENET_RSB_PAD);
>> +			__skb_put(skb, len - GENET_RSB_PAD);
>> 
>> -		if (priv->crc_fwd_en) {
>> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
>> -			len -= ETH_FCS_LEN;
>> +			if (priv->crc_fwd_en)
>> +				skb_trim(skb, skb->len - ETH_FCS_LEN);
>>  		}
>> 
>>  		/* Set up checksum offload */
> 
> AI points out that :
> 
>   The status_64 structure is located at the start of the page
>   before the frame data. Since this resides inside the XDP headroom, if 
> an XDP
>   program expands the header backwards (e.g., via bpf_xdp_adjust_head() 
> or
>   metadata via bpf_xdp_adjust_meta()), could it physically overwrite
>   status->rx_csum?
> 
>   Since the driver reads status->rx_csum after executing the XDP 
> program, it
>   could risk reading garbage data if the headroom was used. Should the 
> driver
>   skip setting CHECKSUM_COMPLETE when an XDP program is loaded?

Makes sense, status->rx_csum is read after XDP runs and an
adjust_head could overwrite the RSB. I'll save rx_csum before
running the XDP program rather than skipping CHECKSUM_COMPLETE
entirely, so XDP_PASS packets that weren't modified still benefit
from HW checksum offload.

> 
>> @@ -3745,6 +3824,39 @@ static int bcmgenet_change_carrier(struct 
>> net_device *dev, bool new_carrier)
>>  	return 0;
>>  }
>> 
>> +static int bcmgenet_xdp_setup(struct net_device *dev,
>> +			      struct netdev_bpf *xdp)
>> +{
>> +	struct bcmgenet_priv *priv = netdev_priv(dev);
>> +	struct bpf_prog *old_prog;
>> +	struct bpf_prog *prog = xdp->prog;
>> +
>> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
>> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
>> +		NL_SET_ERR_MSG_MOD(xdp->extack,
>> +				   "MTU too large for single-page XDP buffer");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	old_prog = xchg(&priv->xdp_prog, prog);
>> +	if (old_prog) {
>> +		synchronize_net();
> 
> Why? BPF prog gets freed after a RCU grace period I think?

You're right, bpf_prog_put handles this via call_rcu. Will remove
the synchronize_net().

> 
>> +		bpf_prog_put(old_prog);

Thanks
Nicolai

