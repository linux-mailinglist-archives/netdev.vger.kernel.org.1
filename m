Return-Path: <netdev+bounces-254762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFVFAc1Ae2nECwIAu9opvQ
	(envelope-from <netdev+bounces-254762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:13:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850AAF7D2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984D6306F01C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753963859DB;
	Thu, 29 Jan 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqI6iBWO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATYJxrXC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8223859E4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684892; cv=none; b=NOLovAfvPr23HLZV2p8PgYX6H2sUF3RlHGfO+wHT8lgsUmms4AO/bzG7plwmI5hJiLGbsXO2VrTaJ7c2FyzaiAO5ok4N1MUOsFujhQ3AAhUxxNqF8MPnXVJgs2dSJ6SHrttBAm5BvN+ZaS0AifQpzKUGLh+5jwEbFZjCWiCmSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684892; c=relaxed/simple;
	bh=ZpzWLfxWdzI35hED67bvl18C7frsG8QVBVGY1Td1kwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXmllO1FOGOh2lJT45zZFpYMOlx7sbi5ECkz43qTmXUiEiwkA3z4jeHljMBhp8c3CBmQmAGMVQ2Lvw2s8R925BRG7MH2GSqp5tynECJlJS9bNk4JVcnOXHrTgVzoHGb8lExsOABKgN3fGkU41h+u9JTbUWpDY0+ekHQI0OvR+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqI6iBWO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATYJxrXC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769684889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjyeEr/0YxMv+W2aN9EYwTKNL4Eg3DNxiBTghibwjm0=;
	b=LqI6iBWOPrUp5eqMQ+LAZs6jpvzykNBEWc0fpl7f4Do7gGmrCJFunLZvxdNeKknl04br9J
	xYuWNyitlH9IG84vxpsshRQQ+m4+nwt79H411uomcRSEzBEA3JXrKoB0pbFtFshOnH51Zl
	/O7qIPWv2KS1MCXxeWFMtmJwtMFBLIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-9OhhSiyCM-ah_vdUOOtJPg-1; Thu, 29 Jan 2026 06:08:08 -0500
X-MC-Unique: 9OhhSiyCM-ah_vdUOOtJPg-1
X-Mimecast-MFC-AGG-ID: 9OhhSiyCM-ah_vdUOOtJPg_1769684887
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so6967935e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769684887; x=1770289687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjyeEr/0YxMv+W2aN9EYwTKNL4Eg3DNxiBTghibwjm0=;
        b=ATYJxrXCJz8Y4aChUZmeIMgiXonOkJfa52AsnUpZwTavfhIUUeOFx3wPpPLbdu1JWg
         m6uFzWR9UmnBH+BuwOCX3XMse7OBrlgPtXWj8CVH0QaIxSfe945k/csKoUyDBaCBf5RU
         NkPM8YOUECKEtwbpnFKhiRstipjZBRJ7DLz/mhBFnqfhunJQJ6aedJBC+FXNpSDNKk1o
         nfsE+mCGxn9xNObyv6/e6jPmbOFcC9SZCuxy9rRowPnY1SklVFY+EXgz5b7ZDrAQRDGG
         fic2r7C1nsoJW2WsD2Qs55QXNSeyZFRfelQ7jhBYgRsIw92kIZfaFVA+Q3cQPvBh7Mdg
         ZQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769684887; x=1770289687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjyeEr/0YxMv+W2aN9EYwTKNL4Eg3DNxiBTghibwjm0=;
        b=Rq4aGTz1zxaVBE6JxQOym7NvMjEVR5Z5KBMU6T50t1ytfkZq0hijX1aqobpA5Ov2Ca
         iF6ViRzqPnSe1pGsQPfnyYelEl/rNiKQ/eU6sZdkDQm+uBMDc2krFUXORVrg1AORglmh
         3fMmWa+AoMP9wakWlRmMv6YN/isS3xchYE9du1UuDL4Wh/MBwR8Nd6+sPaIjELy6w2Xl
         79ZNDGfh3cvsDKX7tgy1vE7GKQHrW2f32jNzFINBAvTANAmSW2GtfVEceYVy0hTF8DVh
         wOR+pyFyQWc6pjl7sIqy4BYEWqhbUegkY9sb3ieT6KfS3bZ/wtD1zEQSpoUrFvtgPdvb
         tFLA==
X-Gm-Message-State: AOJu0YwWpajOobx1nOIBRxrgi/N816DDtn/F4IX1BgfZy1X8cR8/mJCJ
	ElMsYvSHaJTYrASl+SM0zlTqLMXUXYB7TlxUVwe2OX/vbximccHywkZKpPeiicGcGjxcKO3Jy8+
	n5Wb5mAwbMi5xNW+uNQVKiIiMRvYNQK0ICg5kz+gWA+W8mKQKs+H50oXgJw==
X-Gm-Gg: AZuq6aJg8JG+3uvk+ZW/4oBQat+V1ng9o3n7nVias9bPTGRzxJvS0xQUhTFnNyBYdRj
	KkMlmdLjWAPJGKFFSE19mjSUdlynpZwvB5cjlbEWZ5iUt2MUxup7F7ZAvcNt7rjegoPfNueCffj
	BOFNfz8lIiFah68urybRTMzlomIj+OYK2teACMwRbzFlwIGlf/hyUg4eFDrTbFh9VGU9DB54Vrq
	D/A6NF7irQCYyOinTFPTrtIifXCHk+gWgBu7gJRqI7teLWJv/g2OmqkGpRieu17yPgUSxgvooKs
	3ZaWxGXWbBqSX9anZMp0EO7RGDrMbo6opOZDOFVQ8nVr4MeVQ1YC1Qe9NNAVI+EvpzEcbks7P9f
	33PMrilfYi+y/
X-Received: by 2002:a05:6000:2387:b0:431:3a5:d9b2 with SMTP id ffacd0b85a97d-435dd1c1d77mr12493990f8f.39.1769684886724;
        Thu, 29 Jan 2026 03:08:06 -0800 (PST)
X-Received: by 2002:a05:6000:2387:b0:431:3a5:d9b2 with SMTP id ffacd0b85a97d-435dd1c1d77mr12493963f8f.39.1769684886252;
        Thu, 29 Jan 2026 03:08:06 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e474csm13833115f8f.2.2026.01.29.03.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:08:05 -0800 (PST)
Message-ID: <b906bf83-a2b3-45fa-b3fc-1a9242b783a0@redhat.com>
Date: Thu, 29 Jan 2026 12:08:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 1/2] net: vlan: always set hard_header_len with
 VLAN_HLEN
To: Chen Zhen <chenzhen126@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 huyizhen2@huawei.com, gaoxingwang1@huawei.com
References: <20260126040426.2570396-1-chenzhen126@huawei.com>
 <20260126040426.2570396-2-chenzhen126@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260126040426.2570396-2-chenzhen126@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254762-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5850AAF7D2
X-Rspamd-Action: no action

On 1/26/26 5:04 AM, Chen Zhen wrote:
> When tx-vlan-hw-insert is toggled to on, vlan device hard_header_len
> will be reduced to dev->hard_header_len since commit 029f5fc31cdb
> ("8021q: set hard_header_len when VLAN offload features are toggled"),
> but the header_ops remains unchanged, ndisc skb will be allocated
> with this len and filled in vlan hdr in vlan_dev_hard_header(), but
> with reorder_hdr off, the skb room is not enough so it triggers
> skb_panic() as below:
> 
> skbuff: skb_under_panic: text:ffffffffa0535126 len:90 put:14
>  head:ffff916c04232ec0 data:ffff916c04232ebe tail:0x58 end:0x180 dev:veth0.10
> ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:197!
>  <TASK>
>   skb_push+0x39/0x40 net/core/skbuff.c:207
>   eth_header+0x26/0xb0 net/ethernet/eth.c:90
>   vlan_dev_hard_header+0x58/0x130 net/8021q/vlan_dev.c:85 [8021q]
>   neigh_connected_output+0xae/0x100 net/core/neighbour.c:1589
>   ip6_finish_output2+0x2cc/0x650 net/ipv6/ip6_output.c:213
>   ip6_finish_output+0x27/0xd0 net/ipv6/ip6_output.c:246
>   ndisc_send_skb+0x1d0/0x370 net/ipv6/ndisc.c:516
>   ndisc_send_ns+0x5a/0xb0 net/ipv6/ndisc.c:672
>   addrconf_dad_work+0x2b5/0x380 net/ipv6/addrconf.c:4258
>   process_one_work+0x17f/0x320 kernel/workqueue.c:2743
> 
> In case of possible crash from other callers, fix this by always
> reserving VLAN_HLEN in hard_header_len even if the header_ops would
> not request it.
> 
> Fixes: 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features are toggled")
> Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
> ---
>  net/8021q/vlan.c     | 5 -----
>  net/8021q/vlan_dev.c | 8 +++-----
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 2b74ed56eb16..a7b5da7f9999 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -323,11 +323,6 @@ static void vlan_transfer_features(struct net_device *dev,
>  
>  	netif_inherit_tso_max(vlandev, dev);
>  
> -	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
> -		vlandev->hard_header_len = dev->hard_header_len;
> -	else
> -		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
> -
>  #if IS_ENABLED(CONFIG_FCOE)
>  	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
>  #endif
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index fbf296137b09..9e81669bffd6 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -572,13 +572,11 @@ static int vlan_dev_init(struct net_device *dev)
>  #endif
>  
>  	dev->needed_headroom = real_dev->needed_headroom;
> -	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
> +	dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;

I'm wondering if the above would foul hard_header_len users to do
wrong/bad mac comparison, i.e. in gro_list_prepare()  ?

/P


