Return-Path: <netdev+bounces-252544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHJpAhuccmkFnAAAu9opvQ
	(envelope-from <netdev+bounces-252544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:52:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0F6DF54
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6C8F3025939
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546543C23B2;
	Thu, 22 Jan 2026 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7XHfinr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q56jVRtl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014E3C1970
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118733; cv=none; b=AMccOvoOICUdOstkCpzv73hCKlDV8bQtajFnXnxF4/B7PBrN1USvr7/SaNXU2Six2XU0CDWUXjJ6UVRF3l72D+P7vJ+JNWmHpbrYJVzsIPulukC6rT6ANg5AVSWogZJ1HDvh+6LWMJJEVmRsUaiuz6eg/JwqDOx0xQxCKjD5sG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118733; c=relaxed/simple;
	bh=vBKOE2qVFcm4p0Uyp9ThApwnQdHm19ApCeX565t096c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDr5b1a7kQzMRUX7U9Hk+QE70o+pFB8C0JgzDuDsIK/DC6sQ6ZOoNPPt3loYe1jnl8pnaZ8vtUPTcAe7usGPcQt/ZBQUdpGIPX1C9ppBdJECFC1QMcA0pD7d3fFZ9wCjry/+LdZwl8zZQxzVyz6fw5E8zecd+3bucRRyo5WHYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7XHfinr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q56jVRtl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769118724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW5gSdhItogFEcRflAqU8aOpgxsdIYIRekkLZQNMM3c=;
	b=b7XHfinrsLtiZINAkKh5Rt6SE1gBMHJiG1pyOE1lqS7awYyu1x/R/Ex8aF0fj1TZnfEBVV
	q2KLav2W0LyoFw7zCBkz8xW7aCWAEnutcYzJ0aQl2MSvnGuAWGSZcDgBY0zIEavX4uQeF8
	j8OaQo7kNRWOdtFJrnxnvLyVQD/S88w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ZZPSaNx0MVeuPg5CeBL0-w-1; Thu, 22 Jan 2026 16:52:02 -0500
X-MC-Unique: ZZPSaNx0MVeuPg5CeBL0-w-1
X-Mimecast-MFC-AGG-ID: ZZPSaNx0MVeuPg5CeBL0-w_1769118721
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso10114765e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769118721; x=1769723521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW5gSdhItogFEcRflAqU8aOpgxsdIYIRekkLZQNMM3c=;
        b=q56jVRtlBKjT8dYeZseyIRCVfsn0WXpevhaXR1OtnuwLMIOXIQc3CDbsqFtPMicyXN
         LY+ypQNuyHBv8nZ62BkbTw1rG2uo6gHc2A9VAAtA/p5zpzGU1iGppi0IANOGUf6F3PK0
         qF+UvSUp+A0/J/Ie9/8CYJKdbD9ij4YQSgVCZtSQxj7VYzItzIzTq/kQcX6luC3v0xcW
         XL5yb6J+1NiZ+SIZzQW8jc2bNT08qXIFT2b2Liy1jwf7FTQiYwFvJwjdBKjNoosspGHK
         YOHsQtB+mN8YwEsg6lsX6I7qDwTSIl3nd+Y/T1HOM88vBYaI731wAZ66sr3ALH8lAU0g
         mPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118721; x=1769723521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW5gSdhItogFEcRflAqU8aOpgxsdIYIRekkLZQNMM3c=;
        b=Pwhxa3JidFtRwRZdKI55iGNfoVf4HCmK6be8ZADlhIbiVA4V7UDKgmPYBdaQqCZA4q
         +NS5XN4urVz9I9X8dtNnU/ZrwJLEebZBdQ0QoYDcQE3XYRTzuKIJ7ZpbgiKcjUmaZFuV
         LP2z0dSXi4MomneSyKPZopNr/4Ed/NWxqRdyrS3mlC5aohGgV2JQLCYU03B2MGO0xTp5
         FzRPeYCm76n2AUNknjTHG1/Zmv6k75DBY2J7eKGtmOcagAx+Qc/T2W39m12tcpUSeBzz
         UC/Ye65wkp4ta6gkOLb29idlIWH5wnplr8W3hev3ZtmIqnWRkUIWiSUZRbsnuboA0Ol7
         iUBw==
X-Gm-Message-State: AOJu0Yy2rE5K8DwGTWmqEvpw1B8kGj/0tL464zTIwEm4hk7ug1WMUZvF
	sbphOWXG53vFb8JhxeMo8/47k34znmOloJiB0L70/YExzNgoUkI1nRyeGRHt8LOy/Or+rarhjAo
	7r8+CZttSEHT641XMj9SLYM8Sh4QRr2sWbVpMKZfW/frcnnWi+OzbV4VsaYMNFQ5k7w==
X-Gm-Gg: AZuq6aIhWjAHY7Jj67uFSWLB0UVucx1VZa/biGBwldF5oMjMu36kx5MsROgSBtPUV4b
	nSPu7bSToSaTmmMdJk/RV5hik1I+2liICchGkJmjq2fsufW9h/UdIt29aw9l4tPJ3DeotbLlE+s
	HdFtelgvLJu9MbI2/OpjJQHhFQAcgmlM3juQos/fz2+OcH/vYFshg2GWtzl9yavWek4gjUTDqIj
	hAzcQh6aHixxLTIKKBBTZ3jkTbvxMygjCeUG4vtkRDG0DPiA+mqG7fS3k6mFrtBPCUBA5x+kuR6
	6i5U6ac+h8qLSEiIAHCGA20cCG6h+rc9Rt17p9wEvUmu2GfIbz1pwyPF8B7GR//s1pnm6qcYiwX
	lO/UiL4ergwk/ulECkE+PH/W+uVIW5Qg4PA==
X-Received: by 2002:a05:600c:1f84:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-4804c947d4dmr17354475e9.1.1769118720922;
        Thu, 22 Jan 2026 13:52:00 -0800 (PST)
X-Received: by 2002:a05:600c:1f84:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-4804c947d4dmr17354035e9.1.1769118720351;
        Thu, 22 Jan 2026 13:52:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm1597488f8f.24.2026.01.22.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:51:59 -0800 (PST)
Date: Thu, 22 Jan 2026 16:51:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v16 06/12] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20260122165014-mutt-send-email-mst@kernel.org>
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-7-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121220652.894364-7-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252544-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 82E0F6DF54
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:06:46PM -0600, Daniel Jurgens wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Documented UAPI
> ---
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 03bd3d2c2b0e..b406f5f1c75e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -5724,6 +5727,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	unsigned long sel_types = 0;
> @@ -5808,6 +5812,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_admin_cap_set(vdev,
>  				   VIRTIO_NET_FF_RESOURCE_CAP,
>  				   ff->ff_caps,
> @@ -5854,6 +5864,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,

This (3rd param to virtio_admin_obj_create)
is the object ID actually. Setting this to 1 means it is outside
of range for group limit which should be 0...limit - 1 and limit is 1.

don't you mean 0?


> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &ethtool_group,
> +				      sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -5881,6 +5904,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,


same

> +				 0);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index d025e252ee26..66af9ecdb674 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -11,6 +11,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>   * @groups_limit: maximum number of flow filter groups supported by the device
> @@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[];
>  };
> +
> +/**
> + * struct virtio_net_resource_obj_ff_group - Flow filter group object
> + * @group_priority: priority of the group used to order evaluation
> + *
> + * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
> + * administrative object. Devices use @group_priority to order flow filter
> + * groups. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> -- 
> 2.50.1


