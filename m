Return-Path: <netdev+bounces-283196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDRjEC+19Gl8DwIAu9opvQ
	(envelope-from <netdev+bounces-283196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC94AD26D
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6933017C0A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D43C2768;
	Fri,  1 May 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fByLrzER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12663C13F3
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644837; cv=none; b=NJmoZwVV4zuHXo37LbKcp00JCtVbCHqZSt+UziHLbxezb0wls5kmlH6lTQDQwu2Ior+gOngOiGlyYU8/Ac21SZxLWIV7HEPmkkxhgorvMr8eBKPSC0IFTJ04TpZ9HiZrynxdsJoqrmlRpfDVNMZiNkew4zUwJiiPBDgT2fndAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644837; c=relaxed/simple;
	bh=09xIVSIOCHld7sNJ6+3WxJZmKrRnpZPPPMGuyfUUpXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYiT4qzSwK5+j7tmnJc5/ZdZ3jqtHcJRtkSE+VJYAJD7t1tMmnl2e0BxLBs5I/FRipq1mkwA9EiQBC0pMvD72N/16iJUVf33nlIurQq+DmNHqlr8f/eHS218XZ/qQJ0Cnj1LeDXNZTdSiieRW37ZD+4dPhNWsvNa8cVDxMoiRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fByLrzER; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d880e6fbbso28131151cf.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644834; x=1778249634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmbjUGxD1u3NABfRek7G1d5V6wG4/EqTR/sOvz6Wzxg=;
        b=fByLrzERHPfMgWyirobyM1H2k5Dsh8sXkVm1z8Cfjiid25AE5CFrypKXvTkYUjuOF3
         dGCX0Sev6iB2MgwfFLHvxlePIhX4wZQgnsdI9Eb1F44iX14U2Gc/TTB5YM6sxjCKb8TI
         tYc4tWaMEvohFFKkV0wrMJtGmScOk6txc9iyZWqdLAKq0h1JUzkiSNKavpPNUjFWEUBS
         OKVJsHoDWRdK0fJX6VYCBx8fvkb1ZNSGVRK6fIGg4Loh28+oz3IMsiSTS4ndRpZuP9r3
         1DGffyiu8kG1j4phxluZBG3awNpAfqPBp8TwqAt0eMmA4RMzSXI+PP/y3BDajxQUD3jg
         uobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644834; x=1778249634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmbjUGxD1u3NABfRek7G1d5V6wG4/EqTR/sOvz6Wzxg=;
        b=sk0mJt6CHASH5HDPrH0vFoQx0hSZch53Pn6+hMN2j73gtAzcJimyYaN2a/V5ZS8oeJ
         teIoO4DFmh/7P9RK6NSAaBTdfXgb0yfbqc4XxdMW100nOridn4yyVgFaKBg6b1OCge0n
         h5/3G3G+0NORIdhQjkadNbOgSiBOkvzsv4Tv+fj9pC21TEQ3hl12eyEfijLtG4Z/RFMx
         r+5WR0Ke6NB0uh+WiJcfwJIQhPeogJjOatyPpkdN60jLyWJGcj2HqcCJFqCLZmYWAKpL
         mmfNOqGAKUNHQAuCrsscz3Hg+sjaF16IjffPllkyqVJpu+rxLx+/B5/sDdpQK+T2cVQ9
         d3+w==
X-Forwarded-Encrypted: i=1; AFNElJ9a055HbIZ87yRe3EX2nlyYzw6bAtjyMzn3j3lA9n5FYq8FvSKZrB2s2kanNz7gSn2B9NdfNO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh7egY4Ph0QFHqJRinJu1Vm3CkDH2CzEQeLywA5K2YEURY8PF
	sEh82IgN04G/3txDfE8hPf/GcKd8a9JRTc/uLAySlugjjDlQKvrWO3Br
X-Gm-Gg: AeBDieu0AMwZ1Z9jWMHvY1aC5MOGIwA0Zppcua5vHmZN52AqHd9nzGY1HMaCH7Hpdvt
	TNb6ZE14sKXG/aTxqxXQVc1NQ/up26ECzdpWYIJ5gAYwEnq/+YnBjUqisq/mDqAjMDgskwNwc2U
	gb8tja7dwR14gtkGAeFJZn1gjs3rqNxMFCCXROnzlekngsga0obkcqAM4FFiLxuK/DMyznQLiOp
	grY5riXKM60vcm+myZoCK73XB0eQD2fZeqhgWc3jYyd/qnEtSxzg4mLYjOTu4HYN0pJsqKct/9p
	gMsGmDPMYLTs9KrYVTFTBoNjgzvb5ra3TFnldLu6V7+tK6n+vjp9BuwNSFXBpGE5pKQJYb6zDtx
	BG8lWjSdPuKqF8N+wDOaCIe70zdnbs7Ml1QG2q4l/+d6799cNuLjcfBkgFKClFXuob0LqEd4fI8
	8X3mI85enIlnbxcDqdVkNjWZe1CcJ4AoeUuwLSXGelQgYh0ijmoeGiXpuwne0nQGaBl1ZHOid2N
	vPtJLXdax+LW3Nrf9M9a/l1
X-Received: by 2002:ac8:5d14:0:b0:50e:18f9:b5e2 with SMTP id d75a77b69052e-5102d09af36mr91940941cf.6.1777644833795;
        Fri, 01 May 2026 07:13:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:7cf5:7b4:6072:d3b2? ([2620:10d:c091:500::3:18f8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b86535sm17194531cf.27.2026.05.01.07.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:13:53 -0700 (PDT)
Message-ID: <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
Date: Fri, 1 May 2026 10:13:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
To: David Carlier <devnexen@gmail.com>, kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com,
 kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260430062033.20428-1-devnexen@gmail.com>
 <20260501130046.16008-1-devnexen@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260501130046.16008-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8BFC94AD26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283196-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 5/1/26 9:00 AM, David Carlier wrote:
> psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
> when psph->hdrlen indicates that the PSP header carries optional
> fields. A frame whose PSP header advertises a non-zero VC or any
> extension would therefore be silently mis-decapsulated: option bytes
> would spill into the inner packet head and downstream parsing would
> fail on a corrupted skb.
>
> Compute the full PSP header length from psph->hdrlen, pull the
> optional bytes into the linear region, and strip the whole header
> when decapsulating. Optional fields (VC, ...) are still ignored,
> just discarded with the rest of the header instead of leaking.
> crypt_offset and the VIRT flag are intentionally not validated here
> - callers know their device's PSP implementation and can decide.
>
> Both in-tree callers gate on hardware-validated PSP, so this is a
> correctness fix rather than a reachable corruption path under
> current configurations.
>
> Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
> Suggested-by: Daniel Zahka <daniel.zahka@gmail.com>


No need for the suggested tag here.


> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v1 -> v2 (per Daniel Zahka):
>    - strip the variable-length PSP header (psph->hdrlen) instead of
>      rejecting opt-bearing frames; VC/options are ignored, not refused
>    - drop the crypt_offset and PSPHDR_VERFL_VIRT checks
>    - refresh kerneldoc above psp_dev_rcv()
>    - retarget at net (was net-next)
>
>   net/psp/psp_main.c | 41 +++++++++++++++++++++++++++++++----------
>   1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 9508b6c38003..b040345d7273 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -263,15 +263,17 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
>   
>   /* Receive handler for PSP packets.
>    *
> - * Presently it accepts only already-authenticated packets and does not
> - * support optional fields, such as virtualization cookies. The caller should
> - * ensure that skb->data is pointing to the mac header, and that skb->mac_len
> - * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
> - * is not supported).
> + * Accepts only already-authenticated packets. The full PSP header is
> + * stripped according to psph->hdrlen; any optional fields it advertises
> + * (virtualization cookies, etc.) are ignored and discarded along with the
> + * rest of the header. The caller should ensure that skb->data is pointing
> + * to the mac header, and that skb->mac_len is set. This function does not
> + * currently adjust skb->csum (CHECKSUM_COMPLETE is not supported).
>    */
>   int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   {
>   	int l2_hlen = 0, l3_hlen, encap;
> +	u32 psp_hdr_len;


There is a style convention in the networking subsystem that 
declarations are sorted longest to shortest from top to bottom. Let's 
maintain that here.

nit: int psp_hlen might be more consistent with the types/names of the 
other local vars.


>   	struct psp_skb_ext *pse;
>   	struct psphdr *psph;
>   	struct ethhdr *eth;
> @@ -312,18 +314,36 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
>   		return -EINVAL;
>   
> -	pse = skb_ext_add(skb, SKB_EXT_PSP);
> -	if (!pse)
> +	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
> +				 sizeof(struct udphdr));
> +
> +	/* Strip the full PSP header per psph->hdrlen; VC/options are pulled
> +	 * into the linear region only so they can be discarded with the
> +	 * rest of the header.
> +	 */
> +	psp_hdr_len = ((u32)psph->hdrlen + 1) * 8;


I don't believe casting psph->hdrlen to u32 is necessary for correctness 
here.


> +
> +	if (unlikely(psp_hdr_len < sizeof(struct psphdr)))
> +		return -EINVAL;
> +
> +	if (psp_hdr_len > sizeof(struct psphdr) &&
> +	    !pskb_may_pull(skb, l2_hlen + l3_hlen +
> +				sizeof(struct udphdr) + psp_hdr_len))
>   		return -EINVAL;
>   
>   	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
>   				 sizeof(struct udphdr));
> +
> +	pse = skb_ext_add(skb, SKB_EXT_PSP);
> +	if (!pse)
> +		return -EINVAL;
> +
>   	pse->spi = psph->spi;
>   	pse->dev_id = dev_id;
>   	pse->generation = generation;
>   	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
>   
> -	encap = PSP_ENCAP_HLEN;
> +	encap = sizeof(struct udphdr) + psp_hdr_len;
>   	encap += strip_icv ? PSP_TRL_SIZE : 0;
>   
>   	if (proto == htons(ETH_P_IP)) {
> @@ -340,8 +360,9 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
>   		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
>   	}
>   
> -	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
> -	skb_pull(skb, PSP_ENCAP_HLEN);
> +	memmove(skb->data + sizeof(struct udphdr) + psp_hdr_len,
> +		skb->data, l2_hlen + l3_hlen);
> +	skb_pull(skb, sizeof(struct udphdr) + psp_hdr_len);
>   
>   	if (strip_icv)
>   		pskb_trim(skb, skb->len - PSP_TRL_SIZE);


Minor comments, but otherwise lgtm.

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


