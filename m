Return-Path: <netdev+bounces-290319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIy1M3DUDmr2CQYAu9opvQ
	(envelope-from <netdev+bounces-290319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:46:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE55A29B2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9945B302F55A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545A37C102;
	Thu, 21 May 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFuj7Rl3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyLAEn3d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683637C0EB
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356732; cv=none; b=J/h9yzOrWHYmcCHEbRLEze7xbQ6vB7/L03rvJ56wkW2pee9YZLax9Bj405unVPCToAh7C+BWQgV7V2JpODRAsgvoBwkxGLnA6Am9P1Ld2fQFgEKvTNk3H8ZOsEjo9xC9EU5AQv99N0bdbBMT+LN30K0GUO6FpwWd1Aq9LsukTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356732; c=relaxed/simple;
	bh=HxL2mVpqGeWukkrHrqUp7lkfiZWZDF3J3N36wvgmCIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/1Lc3PnkYFSHMBAcq1op6ApL1tqYsi8DLTIJhF7qoqUx7Pwl7R7FZNVkhXlfE0LTtFXoNjNz+z9CNEVBQ+tgENYNC0Cnzt6CTmJ/Wg/qSqb5fpVQmP/f31YsKCCyY4AUhIhxi4ZvKDSjUR9XfgldakhBOZSb3rqVUZzqJqSBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFuj7Rl3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyLAEn3d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779356730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8pOkYp++jH6DC65duzb8derhbUuB6qIKQ5RkuirNAE=;
	b=SFuj7Rl3dvF0bG+RL4+VGqHPMBKjuKcTIGy4t8lZPhpgARVwM17yNWNPz7tH46k9B4m08x
	t0iKdzE4rid8SHgNIN0UqSU5GVKhLC3L063ZV4gX88b1p14VBKI7/1IUFlibNMa/9ml/T/
	dSvywF99Mcek7ExL7OAI1UQTnCxgbZY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-YWdWhjyeOHSxIFp7YZfScw-1; Thu, 21 May 2026 05:45:28 -0400
X-MC-Unique: YWdWhjyeOHSxIFp7YZfScw-1
X-Mimecast-MFC-AGG-ID: YWdWhjyeOHSxIFp7YZfScw_1779356727
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so43027195e9.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779356727; x=1779961527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8pOkYp++jH6DC65duzb8derhbUuB6qIKQ5RkuirNAE=;
        b=OyLAEn3dke9Yxh5iFwcxgdsGqTE9E4RjdXlt1F4TOvHh+whouM9XlPN5Fv+sPeQhmt
         wYP8tT3bwYxbvhWpUo91T7Ox9B9dgNorES2P8QqSfkPacFE8m1aUwyeZhd+QgqcCK6zB
         1AtZmsc2XYj3IdvyU1H4U247rO0OFDb17GngJ9+2FLGv/fDliJ4ZRxkCRza77p+RPPDT
         r4aJYxsi+u2VfU7tiyD/odrVO46h74v0tl3V4xX5S2BpUPDsPZ2R/CEgCHBDQasHXzbm
         C9wjevZSKa/XyWf7OBeGY40lq78nr9etr+4dzQsCRN5c13y9IQHhjE0gDmZF3SWLfS3H
         4YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356727; x=1779961527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8pOkYp++jH6DC65duzb8derhbUuB6qIKQ5RkuirNAE=;
        b=ewZ/G9+mg1i0J4g8SSaskFpIqTcN9kTY8d1lHDvFwQ9YfhXI3CpJcomJhvVDhgbqzC
         C9fv0fdD3wb2CP2stsSvLOlLveZ+m+N+OKP97XYUka+IkHs+H3eSP8H+/+44N/WZn0Ni
         67h36PE1o7iQ0KA1ikpNMKRzoOn7jR6rmVsV7KOOfeSEpMmhUV25RjeWWCCkZYCMuHKx
         5Jnfg9NoAxC5p3NSqEfATKmAA1iTy4ZtXKopYkarPoDvoo/sG8nwbm4BBXHLNs5E6xoy
         Mcnwa0UBgBKYyh4tPcMbfJBn4o1qyolmleMtkzg3tEPG7/2yGArWSO+nlzwNkezyB5EB
         8zdA==
X-Forwarded-Encrypted: i=1; AFNElJ9BoNCVCA4MrXQwNW9bCOFXMVMNnS9o3qL08th+BLK6i2MktKwlD+pfYscn8iiHzkj1C7hw8ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCNTB099CY3PKXsB6SqdnAOLOAtgCc9YCEylica11XS9XvYws
	7hD7LJmjjQfcNA8jTqXvWadhjdZ0Fu1qJBlBBFmNe/oNkj9gcnVFD9rpQ3T3KkB71+Xxi3N2ay3
	B2giBLfNLqb49lseDmabfhOcSlbt0ZGlQMpGWO1AE+1J9UaB34ikZTRPccA==
X-Gm-Gg: Acq92OFFLdsCFUKSQXQEUu1E1wKsmpxV2BCFVDDwwcV8pSRC1xP/wEiXZm+NiyVbhB2
	fF/Piv/ne8rPgw483WqmEWPpDxOempkHfq8ipKIEw141YuHR2tzs+qDzmidluooNZQ0WiBJ1R/Z
	3yn9wHjYO80TaMwGpSl4AYtdUS6ZbeCP1lADOlKRAc6qpZ48zsVLs13FfUY/v0vNoYGKgfimkO2
	CYenPVrQ6truEZz1aerJXAIJh14EL9oJosRBuwLHyxPhJsrkF++mte7mw5IxF/2xo92628EpBOs
	DOtOukrtk2pPtuZQ0qr3XnPkKVQzZe2vbhztye3g64yzANugqeugJrIAjjvCT0EVClRGIbpDkad
	ZTXfZD7YESjgsZv3svxI7VK+kAIUcVUXfsYSPSETz/sjYQfrvx4FRBJImRQ==
X-Received: by 2002:a05:600c:3149:b0:490:261d:7dfe with SMTP id 5b1f17b1804b1-4903602d09amr27351405e9.6.1779356727310;
        Thu, 21 May 2026 02:45:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3149:b0:490:261d:7dfe with SMTP id 5b1f17b1804b1-4903602d09amr27350855e9.6.1779356726833;
        Thu, 21 May 2026 02:45:26 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d9eca8sm52423715e9.12.2026.05.21.02.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:45:26 -0700 (PDT)
Message-ID: <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
Date: Thu, 21 May 2026 11:45:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibm: emac: Clear MAL descriptors without
 memset
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260517033621.1839397-1-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260517033621.1839397-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290319-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 79BE55A29B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/17/26 5:36 AM, Rosen Penev wrote:
> Clear MAL descriptor rings with explicit field stores instead of
> memset().  The descriptor rings are carved from MAL coherent DMA memory,
> which may be mapped uncached on 32-bit powerpc.  The optimized memset()
> path can use dcbz there and trigger an alignment warning.
> 
> The skb tracking arrays remain ordinary CPU memory and still use memset().
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 1fd7cb50c568..7ab5c944f5de 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -1161,6 +1161,17 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
>  	}
>  }
>  
> +static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		desc[i].ctrl = 0;
> +		desc[i].data_len = 0;
> +		desc[i].data_ptr = 0;

Sashiko noted that the compiler could still optimize the above to a
memset(). Perhaps a barrier() is needed here?

/P


