Return-Path: <netdev+bounces-271014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEVEMjV+wmnqdAQAu9opvQ
	(envelope-from <netdev+bounces-271014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:06:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79819307DD7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C04E30495BF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C83EFD06;
	Tue, 24 Mar 2026 12:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF473EFD04
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353674; cv=none; b=TosUoaMa++aOCfupIlV4UBqG7Ob5lIKXWpcNuH+Doch9oiomEjpC6rAIxXVtlqms0uer3DMr/eqonELwRAPpox7m/TCwAu4UHL9INTkXksBXtpHB/0psuVRx2HV7Q2Dccco9U5gL8a0FjqF1HMutSvlNgC5EbbggruqJMwKCVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353674; c=relaxed/simple;
	bh=ucshPHi/r6Ln9OLLUw1Xo9w6h7n35ATOisdL48zSMRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YGqid23DFHdo8tCbfrxfANxLFWkSW+5rN0X69ew2MKdMEGkIzBG73PQ3abYACTtuZ/xBegcdX9Xe9idIBPpW1EqXquCZ+YgeElwA4v7s1KCtPyLvPECcYBq7G3tS6TvtbAeUrBT4RWHdlOUAEb/2KODllJHXwcyPd3NacorbE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso11261095e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353668; x=1774958468;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRiyCKNjPgWGQoAyu/uLCQ+qyHakA6Q0r54A9iXZ9WA=;
        b=UH44S1QjecJS6mpAUGMo16hMkF9ck6RhYZWNMPfrr3oU0xf45QNNgyaVzCwy5TijfC
         nIWHukeo65z6TVhbV6yX5g7ygzg+jOG8LIcLBM2W6svjZ3iiOktefY08j08MSk+yYlON
         R8DmD/A/mBECn1YrPshmueVAZQsYEULABD5L8VnQqqO6e5QvzEFKnd08/RnerL7y2SOd
         EeF++AeGxJ+k9OvWCAUtYlvxgZWZSw9fRMy75of1HA2oMJoehFfPkr2E8iqXly7EaxKL
         DqAyejEVMXiQONUOwNTA6dUcm0BBG4QhxGikTuXnFANoN4Zdh/Fbvza650LpUNVrE3zi
         VQhg==
X-Forwarded-Encrypted: i=1; AJvYcCX/u6pq28uaHS3AUAHoCeoIrRYpOVUvFpPssqVLAEA3dzB2KRBJUxGc2m/TFduyZKWdDHtIywo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6c0LOmUIT+h5FsDXw3Odf2WxBF5Yjq+LvLliC5h39ffhFrCe
	DQ0ulhpU7GKpfEj9h54i1Mh1GHBH3IEKarNrkfTev/+i7U3j+57wSTP1
X-Gm-Gg: ATEYQzycQowcln43oqX27RlJBuDFDMVW3t/+Xddr6LoYMYoH/76kxy8Af9ExayAxDs3
	o1PX4AmZDpJ0CjDCd1erEbPpQrmhUKV9YM69OF8UTM3FfdSHsqdw9xcmTxDCcmKLaTL5sLzGRlP
	Inneny7lH5IKglkoeFJudpGoBq2FufAHQyEKeDU3sKplxTVWtOG0Q436uT0zpjZbQOqmSpt+1/6
	w0kVP3vLwAp8E0+w5KppAxfbRSCq41wsDKeL9fRMDrVafyM/pvjfvHbnRl0EQRiNq7c3nHK9Lqz
	GarhFw3eEiVe3S2pj0POisd1Ex8Tz50eRt/dDsuGUeO7HNuYC3sKQwiskmuwXYWv3qXoy0sBGU+
	SGJlk/HAbBRUpn5kmcKGNyJEm5+YH+n0cypjCHG7hTTsS/KdDXNnkmeoS9rsr2UlALo5JaHAxZj
	gvadGcsdYVNHjRjO6hRNR61hINMjWorXGoQOCLVa1rOJ06xL4ng5zVlZY=
X-Received: by 2002:a05:600c:8710:b0:486:d76c:fa21 with SMTP id 5b1f17b1804b1-486fee051a3mr221689965e9.12.1774353667662;
        Tue, 24 Mar 2026 05:01:07 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711022f37sm31213445e9.9.2026.03.24.05.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:01:07 -0700 (PDT)
Message-ID: <3813e7fb-e234-42ec-b05c-7bcb609de3ba@ovn.org>
Date: Tue, 24 Mar 2026 13:01:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/openvswitch: fix trigger-able BUG_ON after
 ovs_vport_cmd_fill_info
To: sunichi <sunyiqixm@gmail.com>, aconole@redhat.com, echaudro@redhat.com
References: <20260323071435.1945543-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260323071435.1945543-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 79819307DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 8:14 AM, sunichi wrote:
> ovs_vport_set_upcall_portids() does not validate the length of the
> user-supplied OVS_VPORT_ATTR_UPCALL_PID netlink attribute. A
> sufficiently large portid list can overflow the reply skb allocated
> with NLMSG_DEFAULT_SIZE in causing ovs_vport_cmd_fill_info()
> to return -EMSGSIZE and triggering the unconditional BUG_ON(),
> which panics the kernel on most distributions.
> 
> Any local user with CAP_NET_ADMIN (or an equivalent unprivileged
> namespace capability where applicable) can exploit this to perform a
> denial-of-service against the host.
> 
> Replace BUG_ON with WARN_ON_ONCE to prevent kernel panic.
> 
> Signed-off-by: sunichi <sunyiqixm@gmail.com>
> ---
>  net/openvswitch/datapath.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e209099218b4..50c2945081a1 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -2202,7 +2202,8 @@ struct sk_buff *ovs_vport_cmd_build_info(struct vport *vport, struct net *net,
>  
>  	retval = ovs_vport_cmd_fill_info(vport, skb, net, portid, seq, 0, cmd,
>  					 GFP_KERNEL);
> -	BUG_ON(retval < 0);
> +	if (WARN_ON_ONCE(retval < 0))
> +		return ERR_PTR(-EMSGSIZE);

Hi, sunichi.  Thanks for the patch!  Though I don't think this is the right
solution.  Instead of just failing the request, we should allocate appropriate
amount of memory for it instead.  The fact that the array is sort of unbounded
today is also a problem.

So, what I'd suggest is, let's limit the number of upcall pids for a vport with
the number of CPUs as it is done for the upcall_pids array on the datapath level.
This will give us some reasonable upper value as there is no point for the
application to have more handlers than there are CPUs, and the existing userspace
never does that, so the limit should be safe.  Next we can create a new function
ovs_vport_cmd_msg_size() similar to the existing ovs_dp_cmd_msg_size() that would
calculate and allocate the appropriate message size, so the allocation is always
correct.

P.S.: This patch also needs a Fixes tag and should be targeted for the 'net'
tree, i.e. have [PATCH net] as a subject prefix.  Also, IIRC, kernel requires
a full name in the sign-off tag.

AI review also points out a memory leak in case we just return without freeing
and potentially leaving half- or even fully configured port while returning an
error to the userspace.

Best regards, Ilya Maximets.

