Return-Path: <netdev+bounces-208829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113BB0D50C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076F01C24467
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F522D3EF6;
	Tue, 22 Jul 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XYGRkAO+"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755D2D3EFA;
	Tue, 22 Jul 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174588; cv=none; b=A0cdXWFHfBgyenc2SkmvsTZr2oiGE0lDmucK2+f2vL92e1X98avmZCqPkh7MQ0O0ek4WnFDhcP/qHSAZuxP5D0Akg6cuCbKJcKOCDeBSFww03M7SRDaScFqmk34W1Tx3C9YseIGd0yxQfjN6SMFECfjMsqsWy6S661M40J/ecpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174588; c=relaxed/simple;
	bh=m2/SoCy033eFdvUM3uwvIKWCZnJzqCos3X0mAJqgUTU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R2cK/uVD4I/f+ZtrNlaQjTiWr5kDT7iMhEA8pWlWSCHJrI8GnZpmSkSkYoA3dzqbGzaPtgYzZSVHBgaVRZZgBHQlADag/gvahBgLInXYyzwvoLRB9oRXDSgMu4reM59l7uUupT4pLJ1TzbFX6BKzncitrxHjf1OQH9j7wtXcTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XYGRkAO+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pliG9VjeTwO/N4yx9xnQv4JLuAZH9QSufm1+l9RWH9o=; b=XYGRkAO+rJYUMcNvPjEGp7bEkg
	uXOImkNSvHyxEJMWbNoVHZRKB9x/Q8+HcMrWBiTcyzp/dKEGWH8pMAW2ZSu4vWpwVBCkxzgshiCoZ
	E46Ql4qpVLXURPMpRpzliGsShet05EpBOFT/rMk4LixRCJhHR1AuZT3xDtzZYdEJTr0I=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ue8nD-00Finr-0I;
	Tue, 22 Jul 2025 10:56:11 +0200
Message-ID: <0861d960-d1e7-4b51-b320-c2e033b49f12@nbd.name>
Date: Tue, 22 Jul 2025 10:56:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
 <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 10:36, Paolo Abeni wrote:
> On 7/16/25 10:14 AM, Felix Fietkau wrote:
>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>> +					 struct sk_buff *skb)
>> +{
>> +	const struct packet_offload *ptype;
>> +	unsigned int hlen, off_pppoe;
>> +	struct sk_buff *pp = NULL;
>> +	struct pppoe_hdr *phdr;
>> +	struct sk_buff *p;
>> +	__be16 type;
>> +	int flush = 1;
> 
> Minor nit: please respect the reverse christmas tree order above

Will do

>> +	off_pppoe = skb_gro_offset(skb);
>> +	hlen = off_pppoe + sizeof(*phdr) + 2;
>> +	phdr = skb_gro_header(skb, hlen, off_pppoe);
>> +	if (unlikely(!phdr))
>> +		goto out;
>> +
>> +	/* ignore packets with padding or invalid length */
>> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
>> +		goto out;
>> +
>> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
>> +
>> +	type = pppoe_hdr_proto(phdr);
>> +	if (!type)
>> +		goto out;
>> +
>> +	ptype = gro_find_receive_by_type(type);
>> +	if (!ptype)
>> +		goto out;
>> +
>> +	flush = 0;
>> +
>> +	list_for_each_entry(p, head, list) {
>> +		struct pppoe_hdr *phdr2;
>> +
>> +		if (!NAPI_GRO_CB(p)->same_flow)
>> +			continue;
>> +
>> +		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
>> +		if (compare_pppoe_header(phdr, phdr2))
>> +			NAPI_GRO_CB(p)->same_flow = 0;
>> +	}
>> +
>> +	skb_gro_pull(skb, sizeof(*phdr) + 2);
>> +	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
>> +
>> +	pp = ptype->callbacks.gro_receive(head, skb);
> 
> Here you can use INDIRECT_CALL_INET()

I did that in the initial version, but then I got reports of build 
failures with the patch:

ERROR: modpost: "inet_gro_receive" [drivers/net/ppp/pppoe.ko] undefined!
ERROR: modpost: "inet_gro_complete" [drivers/net/ppp/pppoe.ko] undefined!

Should I leave it out, or export inet_gro_receive/complete?
>> +
>> +out:
>> +	skb_gro_flush_final(skb, pp, flush);
>> +
>> +	return pp;
>> +}
>> +
>> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
>> +{
>> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
>> +	__be16 type = pppoe_hdr_proto(phdr);
>> +	struct packet_offload *ptype;
>> +	int err = -ENOENT;
>> +
>> +	ptype = gro_find_complete_by_type(type);
>> +	if (ptype)
>> +		err = ptype->callbacks.gro_complete(skb, nhoff +
>> +						    sizeof(*phdr) + 2);
> 
> Possibly even here but it's less relevant.
> 
>> +
>> +	return err;
>> +}
>> +
>> +static struct packet_offload pppoe_packet_offload __read_mostly = {
>> +	.type = cpu_to_be16(ETH_P_PPP_SES),
>> +	.priority = 10,
> 
> The priority value should be IMHO greater then the exiting ones to avoid
> possible regressions on other protocols. i.e. 20 should do.
I'll fix it in v3.

Thanks,

- Felix

