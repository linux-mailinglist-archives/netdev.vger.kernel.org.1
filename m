Return-Path: <netdev+bounces-283804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN70HbuF+GkZwQIAu9opvQ
	(envelope-from <netdev+bounces-283804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:40:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1904BC893
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC4A4302A6BD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA63ACF06;
	Mon,  4 May 2026 11:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228B3B9D84
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894706; cv=none; b=Ofqb4oKwJF7B77ufleIjjyCFDy+Dl5k0D0lZQoGRn+45PWsWbHwVPMZQO9EOTK6fnm4j0pJWpKsasbApCmnFom9KGtlal1U8m3w9BfJB+Luj5G8zUAXPfNdKsJmCPS0fr4T1qTMq1A4ssF65B6cqC7FsZfTOtJDRdSGQqiqvl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894706; c=relaxed/simple;
	bh=+tA4qxXl2t+oEZbM3+Zk0zW0E9ezjZ0ohNt8AiULAVg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CyfXhB752Mb3S7if6DsQ07mXVuEhgJpnfNXqDMGOV/9Ivz6PM6l9hQYfQJxTbw+vOcLEyXPJXwkX5OZHFNRWsnyTWWJNdm80nvZ0+RX5WjrGNx/tbSLvu7oFUm2eAl3gdBwNkau8BQ5Db6QGzzMjHFzmU9WqF7aJsMhKyxWe96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-bc356898256so48275066b.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 04:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894702; x=1778499502;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQdjq+BZnrlheD2NvaoPdP4vjEP1u3bAcSN0nX5cZZU=;
        b=YQbR4bG5uwTlDyB1CMNiUrGkB2/8TQRTuiWB0pSmXEru1DUhYjxbY8AeIWj3adp2nz
         euw/+vwDtMKdcnf8qcj3zTMSv13BBTiMRJoTV5CBhLy3Wjh6mt0QjIfXBALWlb9ZaOSH
         uwCVh+yZ9QYHs+WK3NTdxQvmzv6QLv2zx2OLAWCh+ygO1TkQor83X4UscuhwjvmP2iKj
         PTfMBO1rSzCD1uu9ROaaVp1cUAchCyzIt3GCgEIxU3PruHp4b85s4s8wkRFbu/siMhmd
         03gzgea/hXZfcKeatZWH9yoAerLmK8NPQbzYbV6yAg+2ZVf4Mj2Fkdf/7USqU8PDvnSO
         XM9Q==
X-Gm-Message-State: AOJu0YzctHQ41/lc1w8khElHOroItsq1/JYC7JlFtr8KEM/kSvcEkBGW
	16joRnJe20tinAcLu9mH2kU0awVsrO2UiXQjAr57hrZ1AN2l6A79y1R5vT9jNSvi
X-Gm-Gg: AeBDiev1coK8eUOe85ucCI5qIPlqY3QmtQmL2gHh2t0fFkROBMKKkprMeD+OjenefR1
	bBffCKhFNwCvWkdGaj0SIW7msYsLDc3NEMLPunXJPU9M3ZXYV6pMqppwJU9PMASsBaoTuYyBgm5
	n/3YyUizJdseMHZTNXFcfawEqyxIoTdgdwcITGYP90mMUf5//LOYsVU4VHLMl6jJdnqcNPj/PNO
	J+kBRu3sQk8k3y6kr2GImkw6D4OiHiIowgXCHCW//4d37x+8V3ROO5GfEfaUI5XlN2y74VWH4wc
	wT+DBpEj4dZu3L/0dEEK3C5C/+TE8nH34MHhYCooOP88YcUqsnKfn5908yFjLMrhqxoE++XnxvF
	OgyoOPh/wRaCIoXcla6pXG4pyYzXYodWaYJFObD1/KYulAuqFt+APk7ubnoL5hDbURygwmOksRx
	QPLm6cO96WeWtaqIRgq5QLHeA96NJGiNzWsGxunj4qCcHUwBuABf3+ktTK4n1jywYJ9g==
X-Received: by 2002:a17:907:3e0f:b0:bba:3e2c:f3a3 with SMTP id a640c23a62f3a-bbffc68079emr357352866b.45.1777894701838;
        Mon, 04 May 2026 04:38:21 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b877d5ab2sm3384508a12.14.2026.05.04.04.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 04:38:21 -0700 (PDT)
Message-ID: <c51329ce-0af0-4b5d-93bd-5663b5d5c7bf@ovn.org>
Date: Mon, 4 May 2026 13:38:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Yuan Tan <tanyuan98@outlook.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yang Yang <n05ec@lzu.edu.cn>
Subject: Re: [PATCH net] openvswitch: vport: fix race between tunnel creation
 and linking
To: netdev@vger.kernel.org
References: <20260430213349.407991-1-i.maximets@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260430213349.407991-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1C1904BC893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,redhat.com,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,outlook.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-283804-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/30/26 11:32 PM, Ilya Maximets wrote:
> When a tunnel vport is created it first creates the tunnel device, e.g.,
> with geneve_dev_create_fb(), then it calls ovs_netdev_link() to take a
> reference and link it to the device that represents openvswitch datapath.
> 
> The creation of the device is happening under RTNL, but then RTNL is
> released and re-acquired to find the device by name.  It is technically
> possible for the tunnel device to be re-named or deleted within that
> window while RTNL is not held, and some other device created in its
> place.  This will cause a non-tunnel device to be referenced in the
> vport and tunnel-specific functions used on it, e.g. vxlan_get_options()
> that directly casts the private netdev data into a struct vxlan_dev
> causing an invalid memory access:
> 
>  BUG: KASAN: slab-use-after-free in vxlan_get_options+0x323/0x3a0
>   vxlan_get_options+0x323/0x3a0
>   ovs_vport_cmd_new+0x6e3/0xd30
> 
> Fix that by taking a reference to the just created device before
> releasing RTNL.  This ensures that the device in the vport is always
> the one that was just created.  The search by name is only needed
> for a standard vport-netdev that links pre-existing devices, so that
> functionality and device type checks are moved to netdev_create().
> 
> It is also awkward that ovs_netdev_link() takes ownership of the vport
> and destroys it on failure.  It doesn't know the type of the port it is
> dealing with, so we need to pass down the indicator that it's a tunnel,
> so the link can be properly deleted on failure.
> 
> It's possible to refactor the logic to make the ovs_netdev_link() do
> only the linking part and let the callers perform a proper destruction,
> but it will be much more code for each legacy tunnel port type, so it
> is not worth it for the bug fix.
> 
> Fixes: 614732eaa12d ("openvswitch: Use regular VXLAN net_device device")
> Reported-by: Yuan Tan <tanyuan98@outlook.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Reported-by: Yang Yang <n05ec@lzu.edu.cn>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/vport-geneve.c |  5 ++-
>  net/openvswitch/vport-gre.c    |  5 ++-
>  net/openvswitch/vport-netdev.c | 58 ++++++++++++++++++++--------------
>  net/openvswitch/vport-netdev.h |  2 +-
>  net/openvswitch/vport-vxlan.c  |  5 ++-
>  5 files changed, 48 insertions(+), 27 deletions(-)
> 
...
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
> index 12055af832dc0..a92ca8b37f96a 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -73,37 +73,21 @@ static struct net_device *get_dpdev(const struct datapath *dp)
>  	return local->dev;
>  }
>  
> -struct vport *ovs_netdev_link(struct vport *vport, const char *name)
> +struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
>  {
>  	int err;
>  
> -	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> -	if (!vport->dev) {
> +	if (WARN_ON_ONCE(!vport->dev)) {
>  		err = -ENODEV;
>  		goto error_free_vport;
>  	}
> -	/* Ensure that the device exists and that the provided
> -	 * name is not one of its aliases.
> -	 */
> -	if (strcmp(name, ovs_vport_name(vport))) {
> -		err = -ENODEV;
> -		goto error_put;
> -	}
> -	netdev_tracker_alloc(vport->dev, &vport->dev_tracker, GFP_KERNEL);
> -	if (vport->dev->flags & IFF_LOOPBACK ||
> -	    (vport->dev->type != ARPHRD_ETHER &&
> -	     vport->dev->type != ARPHRD_NONE) ||
> -	    ovs_is_internal_dev(vport->dev)) {
> -		err = -EINVAL;
> -		goto error_put;
> -	}
>  
>  	rtnl_lock();
>  	err = netdev_master_upper_dev_link(vport->dev,
>  					   get_dpdev(vport->dp),
>  					   NULL, NULL, NULL);
>  	if (err)
> -		goto error_unlock;
> +		goto error_put_unlock;
>  
>  	err = netdev_rx_handler_register(vport->dev, netdev_frame_hook,
>  					 vport);

Sashiko-gemini reports that here we could be linking an already unregistering
device since we're not checking the registration status after re-acquiring the
lock.  Which seems like an issue, which is related, but fairly separate from
what this patch is trying to fix.  It is also not specific to the tunnel ports.
So, should be addressed separately.

Best regards, Ilya Maximets.

