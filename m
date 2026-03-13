Return-Path: <netdev+bounces-267237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC0FLXFXs2kRVQAAu9opvQ
	(envelope-from <netdev+bounces-267237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:16:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2157F27B81F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 518C43139E1E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CA23AB9D;
	Fri, 13 Mar 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BFHCEcsf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41A20F067
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360946; cv=none; b=ZGC9fubMFcICSyeDZPuekTO5SuwQO7iO33DRhJJM9MY37NCMDlBj6d/IyH2FDA++o0TBE53cq54TrN5rDY5g+l+0awWWFyxGOzITT5s0/G67G41HCKoB5YKpsAAzwwNEK5/QN9llwXcoP9rauoOgCVnecXz1n1lRsy4xY1nYKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360946; c=relaxed/simple;
	bh=+39be/lM+pCjc6LDbwu3mE50qpIe2hDK+xdcHCZtNcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W80iZhXtIUsD7NOo4njJwsYCkqWuhhVUdarjY4a/G2foJGgULFTD1L75Iri6iOZaytLq9bQiiE5DQha/9vJWM0Sst/YjSMcGF601R3SOSkcpUzl0R5e9FKctGscokBmklp7PBgGMHLCXNM2iNwpDmEaCYyQUNhXaRjK7vJ8Zuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BFHCEcsf; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cd8c6e365eso158906985a.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360944; x=1773965744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wbnk6DhuujZQfq0+crBJouQzTV+20pKhVKIpYP5UqB4=;
        b=VCliqNPACIBPJ6sAWKix5kq28Xdwjdpa1bvZy4sq1TH00mxfJL90p6W5UIgJnhiGVr
         O9ccm9vAvonN5W3P0IncpK1ocDrxTvEDurM7IkIN34I/pAu4heQC9J3LOOTx2EU/z7zh
         w0huWcbGQTJytHu7WbNjlhOmJkzvNXHoCSB5pndAP4Fuvm/wA9ZCEcTAItRXFoJr+yYx
         knXkyDjQ9boFJmYpeElMWJ7YjmUEK1g+dYmSZB1XIdkKWjhCIkR+oWJR+iXMAAXLbHvB
         r15s6EkGG2gqWJciLxvN31UVOhDyxTlPyBAubeWMTx3HzpX43t3A4y+t9jr62RrIqaOh
         M3aw==
X-Forwarded-Encrypted: i=1; AJvYcCVPiMF6QruVI3SA0ba4WVWpypp+s9Q9KUoMRV22kwRjDqv5wzfrR+Jd/ZKpzrUSP7nmiqw4jEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztW3UeJ9vN/+zmdPOAOPLRsJl0IC9ceJ7niYUdHVWSwrr7nZv5
	JQNDgoF7H0zA+2/NsfrtxYEazGcGrS+ZRMnTDYMT0VjlijCoGX6onZ7iqmmrXAfD7WsQIUw4un1
	EUL+aa7X0s/opOnnGu/C6RMkcogqaUY88vQYJkuO9da2GFYgBdrKAC7jf8Whbr3fUwUfIqUS4rY
	RBnnyg5xe4I6u+cI/9CDFOxbQEog9ALM5A82/8xyrJCOWWQWhSB2U/TQV1Pm6mthuqFVH2CENqj
	EoWxiIjZ2owxYskjA==
X-Gm-Gg: ATEYQzzi4WFJhCraI/vPQaNdyO4/N5YtbVU2zt9GYRElVyDjgf/TwCWstxKKD3p9ecc
	kb77HIQdZaHQoVf4cjzLaZDHMSZ3vCofWjoes2bai/WavqaY5S8Ou+SadvPApcH4ihhSJ/Gme7W
	P4mhd56N6lizT7Oe80uTPCMd+f+LfWzF0LA4afih4fW9XhPLx456yuJBCCmOoXysac8z3goOIDu
	x5Y6rNFZg4gUIcLsVryGpRLELI0aUkNFvmaWXE4PmyI1GaKYpbewyYVT0m8q2rcGAG8xmKxN16M
	ayq2fSUnaTSnzHnS6XVAFtZo4cHTJ9bRAk2r/Ch0r1RpSIbvGaQcju+wn2+EpR9Gz0pvGKR8Ak3
	AzcEbtrKOgp82f0X1uMt61v7eu6K20Lwahx6fzkTcBlx1c4gwzhas/wr2ShSx4qpqkQG2fKiW2Q
	/knnu+Adj6oiROeBMYJuBGScetm9V1a5ZpqUY3MeHPB+An/MRcRMU48pFMJ2jt7jRQGg==
X-Received: by 2002:a05:622a:190c:b0:509:1a72:e332 with SMTP id d75a77b69052e-50957cb6dffmr19384321cf.16.1773360944231;
        Thu, 12 Mar 2026 17:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5093a138444sm6107261cf.8.2026.03.12.17.15.43
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50921f7da67so114153701cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360943; x=1773965743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbnk6DhuujZQfq0+crBJouQzTV+20pKhVKIpYP5UqB4=;
        b=BFHCEcsfqSi5aJVrDGqBDZS0fJOz6c7uIFU+iMGnfKwlp48MkoqtNo0tA2nVxfaTju
         msn9u9Qr+d4wl0UO7ittP90hs5Om+2L0XBapVKjU1YD8pHP4tgi33JOeA/YYeEYP+YUJ
         MxIVVpU3pW92rDxJOoo+/uIp68w29Be2Ohrpw=
X-Forwarded-Encrypted: i=1; AJvYcCWXv0ypMC1V1l5xhu5eeixImGjwWYqmmSOROCvskPgq//NzG02PVNfZc45mCogWBc8e+Zp+tfI=@vger.kernel.org
X-Received: by 2002:ac8:7f13:0:b0:509:e68:22d5 with SMTP id d75a77b69052e-50957cfece6mr18763111cf.31.1773360943430;
        Thu, 12 Mar 2026 17:15:43 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:509:e68:22d5 with SMTP id d75a77b69052e-50957cfece6mr18762731cf.31.1773360942866;
        Thu, 12 Mar 2026 17:15:42 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a116d86sm41390251cf.23.2026.03.12.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:15:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:15:39 -0400
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
	kuba@kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <abNXK9rAarFyvQc1@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-4-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267237-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,dama.to,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,lunn.ch,google.com,redhat.com,cloudflare.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2157F27B81F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 05:00:18PM -0600, Chris J Arges wrote:
> This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> It uses a similar approach as found in other parts of the driver.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 1f920464b426..25ecef1eb96e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  		default:
>  			break;
>  		}
> +	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
> +		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
> +		u8 ext_op;
> +
> +		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		else
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +
> +		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
> +		switch (ext_op) {
> +		case EXT_OP_INNER_4:
> +		case EXT_OP_OUTER_4:
> +		case EXT_OP_INNFL_3:
> +		case EXT_OP_OUTFL_3:
> +			hash_type |= XDP_RSS_L4;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	*rss_type = hash_type;

