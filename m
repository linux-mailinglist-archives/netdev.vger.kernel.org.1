Return-Path: <netdev+bounces-294028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHj0FKBsHmrEjAkAu9opvQ
	(envelope-from <netdev+bounces-294028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:39:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB616289EC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E74BE30062E4
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A2331A56;
	Tue,  2 Jun 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OQYxl1j0"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E33290B1
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378780; cv=none; b=dgro1rjVTqVPMU2LmZFNFdAFP3ZG0tEZ5LnXCySDwDL4c/qNx+JqD/eutVStct2X5mpEF/uEWGGEOn6Dry9+qUN6Q4hPt0Ikr2vqP7VjwVPUDB0u+1xczmBdfbfUSsNvoo0mUr4AUwLFd0LcGhUsSsWLp+uAFhc4JFQuP6lCIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378780; c=relaxed/simple;
	bh=+FElo7X9gQac48qz+OcS4RcKHsZ021R7wgrdRHvjKbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkgPQrxcP8qp6V0FsofcTBWFEbniKKCpk+t3bzQ/Rtf6hryZgiihOHGaLrw/4Y+MIT+tNd3p10+EaBE4gE4j66Ul6pOj3BYP9cHyXkWuLNeWaBEdjoLUygk/OfEUvw5h6rADCRTVNhGL8vycpuU9ym26kj0pfCl/nuMJQW+aIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OQYxl1j0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0dde6aa-5e03-4f3d-8fb0-adfdd10cb173@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780378767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXk9VIGnTaHw+bzMRwdLOaFGSrYXgWsGbXFL2Z2hI60=;
	b=OQYxl1j0kkGXsb4fcq2bEWrcwAPahnM9g002pPiQj2JBdN9GHBmEnRpW9R/e5QweUVEgo3
	N2z2Xan0JKbpjTEpQ7ivdrMi67x/B1LOGlFFMbRZA4CCjwtu5Bh1sftIwXOTo6ABvOZfdm
	sfn9R3vMcAm13gSarI+aliCm/S5PKI4=
Date: Tue, 2 Jun 2026 13:38:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Content-Language: en-US
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-2-leon.hwang@linux.dev>
 <0fecd90a-d218-48dc-86d1-860ab2e7f6d5@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0fecd90a-d218-48dc-86d1-860ab2e7f6d5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 8FB616289EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/6/26 11:17, Jiayuan Chen wrote:
> 
> On 6/1/26 11:02 PM, Leon Hwang wrote:
[...]
>> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb,
>> void *hdr, u32 len, bool ingress)
>>       if (ingress)
>>           skb_postpush_rcsum(skb, iph, len);
>>       skb_reset_network_header(skb);
>> +    if (ipv4 && is_udp_tunnel)
>> +        skb_set_transport_header(skb, skb_network_offset(skb) + iph-
>> >ihl * 4);
>> +    else if (!ipv4 && is_udp_tunnel)
>> +        skb_set_transport_header(skb, skb_network_offset(skb) +
>> sizeof(struct ipv6hdr));
> 
> 
> I think GRE is also affected, why not unconditionally set transport
> header to network_offset + outer_ip_ihl regardless of outer protocol??
> 

Probably, yes. But, I'm not sure about this.

At Shopee, we encountered the issue that the VxLAN packets encapsulated
with lwt-bpf were dropped on ice driver. And, it is to be fixed by this
patch.

IOW, if someone encounter the same issue for GRE packets, he can fix the
issue by the same way.

Thanks,
Leon

>>       memcpy(skb_network_header(skb), hdr, len);
>>       bpf_compute_data_pointers(skb);
>>       skb_clear_hash(skb);


