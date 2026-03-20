Return-Path: <netdev+bounces-270074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMQpCP66vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:24:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B64692E151B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2AEE3025254
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CED3A7F66;
	Fri, 20 Mar 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRw4CTbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744636E484
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041842; cv=none; b=Df5W/+4/sBFrQ83TWnePT4xpXh2hzV12SzVqfStnr8fRjnMeWoVyV8YHlK3FPja+u3slnNx1mq8djrF4bRGJPpagI3j/Fv7la/c2sP4QIxxUxAjTcVxuoo4z1Rf81lkEMETNhdOctuEHpXHhcxRvCH7GwZKzangjmKj3jaRe6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041842; c=relaxed/simple;
	bh=ozLFzhpVI2O2/f4t79l4sqzEcVkJzPQSj+jGAVH4sPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBviAuqhAT+bmg5cvThmyyRlq32vR0flu9sX69HAS/JxrUpiglFGH/6mIU5meghoXWM+xyuwZiNxN2Xy7fKrF/H1ZJP6EPolZQi6pWyiedENWc4LIi34Ez99wXDS41tJEZtNBBSnW7E3bDzysusbI3+tSyxJPdcGBuItrfrHE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRw4CTbC; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9694so2494441c88.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774041837; x=1774646637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc7L1+/6dVTTAc1rDpaFmgif5bqTxN/xlHF2dS1giug=;
        b=nRw4CTbCTsZveqJWZk+vOpb0upPF89+gzcVtzmiCNpiNQiMatFK3zM9pyTl5X/WCRZ
         jsvgykq9tv2XSArjzHu6/0GFfEaIhBAj50oYrf8LtGcwwsH/XqAKrlX6lf7OHR4UI1Zc
         xNBDBu150PCT/fvNJv18OPh3KhQ68+0PT+2SQohYPUvr3ZYZSzuY43m/CfR864EzVPXp
         KvI31anqfBXn8PL1DXv9F+dPsUqFJomWLbZOfivTe2vsbLUQprjU4l5PDrCPOraq7miB
         u+BFIJ+2ug1TdvMzRX+BjE/3Zh9MCvcRQ2nNqckrXMXBdgzmY42PK0iX+0spyDKdTOoj
         hqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774041837; x=1774646637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc7L1+/6dVTTAc1rDpaFmgif5bqTxN/xlHF2dS1giug=;
        b=i/bAGHfAHwN69pHkvCvU+KCxt+zvbasrG6FiEeOYbnzlGSyXPfScljl5M7ugavbMmA
         U+A55kOF7vro3qIwY2MVt3uWKRNs9bBnuxs68O/GotNqY5++2m/0xb0wmrCJXLHXkxI0
         GiP0P60lgb9/zoAp4vnBNAZAEwADEGJfkaQB4QHR6cQcyT8SBFSbGgpwiUN+Ji2MnOj9
         M4PTKUWp6LXXRIezwLE6v8q4c0a1jPbYc0qM0dKhSRyjOedS3Q3wP/E+vrOIQv+L81qt
         HT/yclJBw2Wk1Mo1QZXL7/berAzKDN7GyiiFUAH0pQLXD7VdiCWWoKzf7Ksv4F58gE/Y
         u6+Q==
X-Gm-Message-State: AOJu0Yyh8BQCSfk1p6zX3SjovazyyKJYJNh5/AsALHYFkxzuv/VunTGF
	pnCi/MB6vvSlTMu8gG75Z6xVJfiZZLeRNjXxA2XRJ6KmX4fCc5xLnIUf
X-Gm-Gg: ATEYQzxlzmWrgsWdicRg+e3rRVOf1zVVBAYJoWKFUWptMGv4zTaXbrBsl/Kbwdnf05R
	FPj3Ob1JvUaywnjZslwV8xINAiRLFkIASpI999OjEBQGSHwfc65frBUXHKs75cXiqFZAo9KyUAa
	upIFntJp0Y4FETFi31S/nM8PR5/BpQ9M0Ia8MKlaegBTtJpBENhsW/uVXQA04OqzKkZFlARdskM
	B0HHWZqBUdCbzZmoCcc6fwyp2YxrHGejFqyoo76qzKj2dvDsv3ovz871LIZq4hrJvT6dfMKtEvE
	SpO98eVBY0wGKQvMc7JVsvT4x+LMUU4KWq21Nkub9WOGqQ24BVSuEwcehc0WACOSmWgn1HAq2/A
	9gp2iEwF0+PW+zJauv7BZS3hmICYVkscMJ/AbWfMweS9K2JCUgADLdZ8wJKFwnX7cfBy0MPhuRK
	4T/lT4gOiOgLD+0N5/pDingMj3Oo7C3pQCFXM4jr42osrMoneHsq4HZITANkN1
X-Received: by 2002:a05:7022:1601:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-12a726d018dmr2186785c88.35.1774041837053;
        Fri, 20 Mar 2026 14:23:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::140f? ([2620:10d:c090:400::5:f9c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a73407854sm3732795c88.8.2026.03.20.14.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:23:56 -0700 (PDT)
Message-ID: <1d708196-7b89-431f-bb17-177564196894@gmail.com>
Date: Fri, 20 Mar 2026 14:23:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Matteo Croce <technoboy85@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260320132356.63194-1-teknoraver@meta.com>
 <20260320132356.63194-2-teknoraver@meta.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260320132356.63194-2-teknoraver@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270074-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B64692E151B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> + * @adapter: board private structure
> + * @tx_ring: Tx descriptor ring
> + * @xdpf: XDP frame to transmit
> + *
> + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> + **/
> +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> +			       struct e1000_ring *tx_ring,
minor nit: alignment issue

> +		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
> +			     !(netdev->features & NETIF_F_RXALL))) {
> +			page_pool_put_full_page(adapter->page_pool,
> +						buffer_info->page, true);
> +			buffer_info->page = NULL;
> +			goto next_desc;
> +		}
> +
> +		/* adjust length to remove Ethernet CRC */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
> +			if (netdev->features & NETIF_F_RXFCS)
> +				total_rx_bytes -= 4;

Looks like, total_rx_bytes can go negative here since it is not updated 
after being initialized to 0. Is this expected?


> -static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
> -				 struct sk_buff *skb)
> -{
> -	if (netdev->features & NETIF_F_RXHASH)
> -		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
> -}
> -

The function was just moved. Looks like an unrelated change?

> +/**
> + * e1000_xdp_setup - add/remove an XDP program
> + * @netdev: network interface device structure
> + * @bpf: XDP program setup structure
> + **/
> +static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
> +{
> +	struct e1000_adapter *adapter = netdev_priv(netdev);
> +	struct bpf_prog *prog = bpf->prog, *old_prog;
> +	bool running = netif_running(netdev);
> +	bool need_reset;
> +
> +	/* XDP is incompatible with jumbo frames */
> +	if (prog && netdev->mtu > ETH_DATA_LEN) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "XDP is not supported with jumbo frames");
> +		return -EINVAL;
> +	}
> +
> +	/* Validate frame fits in a single page with XDP headroom */
> +	if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
> +	    XDP_PACKET_HEADROOM > PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(bpf->extack,
> +				   "Frame size too large for XDP");
> +		return -EINVAL;
> +	}
> +
> +	old_prog = xchg(&adapter->xdp_prog, prog);
> +	need_reset = (!!prog != !!old_prog);
> +
> +	/* Transition between XDP and non-XDP requires ring reconfiguration */
> +	if (need_reset && running)
> +		e1000e_close(netdev);
> +
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	if (!need_reset)
> +		return 0;
> +
> +	if (running)
> +		e1000e_open(netdev);
> +
> +	return 0;
> +}
> +

If I am reading it correctly, this can be problematic (maybe with very 
small likelihood). If e1000e_open() fails here, we will still return 
success. How about the following?

if (running) {
     int err = e1000e_open(netdev);

     if (err) {
          /* Remove the XDP program since interface is down */
          xchg(&adapter->xdp_prog, NULL);

          return err;
     }
}


