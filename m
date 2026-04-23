Return-Path: <netdev+bounces-280628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHHYLxDE6WkAjwIAu9opvQ
	(envelope-from <netdev+bounces-280628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:02:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A462B44DCCB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F0E3014BD0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43853DC4A1;
	Thu, 23 Apr 2026 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfkSKZ0d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKCfx5Z1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C83DBD74
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927694; cv=none; b=VGa3xnscWDgaap3DqaFo4ncwIvVoTOItfq3gsjq0u1K83zGvylHJk/3FdUoh/jxXFu9p8vGhzrQypbM5vj/NY3aV70BGKeeHsx+Ff2fXjRwjrgWNc9fxjYUmn1O2h/NTGoNFk+DrwAJYTGVTGqt0Y6HTx78VxvrKrF3JeR7BvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927694; c=relaxed/simple;
	bh=QzCiSb/LA/Ut5togtkAJ5NFWLSQz8LQCLtANZgKMTpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o45bcFRXqyAbQyTcsRpW8TcNhutbYkyE5JX2U5eaf3f4AqzLvzItUqul5FifbV/O/nXH8pF42+yLFfIFMcpXcaonpEndpGY16iYGK0cQoYdaPpSWKD/pmiV8GNVSOfRyH6PXbu+c7SJla0BOXj2ToESTKBioWMzX5ZBnzXThWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfkSKZ0d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKCfx5Z1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776927692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7TMV+5ulw9mIc+/zQLjcApELfOKAdT/wWOID1gLrF4=;
	b=gfkSKZ0dtuRWgtWdfZ6rGkFjdnDc18V5vDvM7/shu3w1oBkfwwIPpYzdg1EZUg+w+xOSRj
	Skf7kEUu+tmApTcd3Njvyz8xD0sWre6HO0wRj/H7aED1sFhWpP2mW2a7f9wsXN50wdrpxQ
	/dcWX0/ExPTzxeAm53KRwmm4qNeRH3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-kGd3VOCCMOq7Iz2h1KpYxQ-1; Thu, 23 Apr 2026 03:01:30 -0400
X-MC-Unique: kGd3VOCCMOq7Iz2h1KpYxQ-1
X-Mimecast-MFC-AGG-ID: kGd3VOCCMOq7Iz2h1KpYxQ_1776927689
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so61629895e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776927689; x=1777532489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7TMV+5ulw9mIc+/zQLjcApELfOKAdT/wWOID1gLrF4=;
        b=dKCfx5Z1c7cTDh2b6E5993W1zQonnSFFzfvQtKpZnneLHhBHfVVt7hVHsZ+5psYFdT
         wOWtu8qqxWuTmLzD0YTObR/kK4/69e+dJtQAPuaPeZh+2e+DcNWFAm1GmG5wq2e1myQm
         E/aYrN50r4PhD2EKCHmwIEMmCblQF7I66PxKfriNhQgNc8Rbsr10j9HxKBc+CR65ITW3
         2d/mJMvoagu+YAdNsaQMnDf4t83hTXt2XkuDv3PehmnHJ+OJM094HxbusWAGZexizIm9
         WjQYaxVCr/bTB2jQs35Vp6jb1+KEw+aUeR6nLvlm5fXaHqQ67AvGgpD7IJtCaN7K6AT0
         8rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927689; x=1777532489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7TMV+5ulw9mIc+/zQLjcApELfOKAdT/wWOID1gLrF4=;
        b=eveP7sHXtfDYD39Um95NQmQbsla92RAGyPYmnu3zqdqf1XYzzRSs4L6YFWUOEe8eYa
         iyCddkk1iVhYylvg2dwarEO37pd5xZJieTlaoZ7eBqAGBipvQPMo5a3CBPS3YyKIBFMp
         GAfAuURrRIS6JAUKigjfOxIfPx/Os5rA7oI+HfHG4sgC0KYmUCQbpYQUrg5ORHrmb++b
         y3CiIyBKzB2NfPZvFqX7cMaPA+zZTbmBidaCcYm+bxlecgOQior5JqFuQcbpTv7BBMZY
         VaCfJqbbzgHDcc37VtYYBL+EaPzTs1rqiN0dXsrW/Ww0Z9JQ6HHkFwVMPt3G/u77gCCq
         bicw==
X-Forwarded-Encrypted: i=1; AFNElJ+h10ilnAVKMblFUMmWbr/fym1IyM7NIRiTl6EEdswF2OBPbeMhBnEhsQux+fxhUj3kugzVgQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0TUpEFlbEMn3SEizswz0Tcg/vAWf1pe6qd01u4vaLajsmW3H
	ThDQdX9YJLYICqyrAhK+yLLQjcSKHY9Qml35Afn2aGA6NEJS7yHYg1jCmML5CRyjwRqocXBe4ip
	EnvN0CLhDrOIVhD5eOcHyGEOYXLRnNjS3Li5FULx5rU1YEuGX/SUn4d6aGQ==
X-Gm-Gg: AeBDiesFp3CwsBY/8DVbgMc9dbGJ+z9/RDuGIEpurgY8avyQaEQJxYpTfygy/Padyae
	B5WR5JCvvk85A09gv0Yonqx/KKSgeHJMNgocLwY6TDZrPVZuUed0oxyxR8i9F3Zflg9S/S/0Dqo
	L/lLhCANB80H7cyy7780k0WYSsM2T2LlotMYoN8VsNkcKJTpXTFKY8zXTqNcKOq6kEiwvgt3vqZ
	63LNh8sZKFs+nIFUR1iwNRPWpL/Jb7KMLbUb9ZJKF7EIXUFl41FJhgbZtN6MSXuLXXXebaQO0qO
	YFdHTLxyPH42ZvSFqjSCn6PkX7FO6goVqZTi4RB3oL96YdPbfIMpVxpy3ulg4CZQbX8J0I11dGT
	LHlYbBJAFFoPvDGRdUae2yoC/wxDUuwdUIyUIBHySpxnr998tFLgrcZbmx9Q6ehgZCBY=
X-Received: by 2002:a05:600c:a30a:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48a581c113cmr99215455e9.10.1776927689043;
        Thu, 23 Apr 2026 00:01:29 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48a581c113cmr99214875e9.10.1776927688526;
        Thu, 23 Apr 2026 00:01:28 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm186313685e9.12.2026.04.23.00.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:01:28 -0700 (PDT)
Message-ID: <1222eb4d-2b6d-44c6-96a3-03c42f714b4a@redhat.com>
Date: Thu, 23 Apr 2026 09:01:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: sync rss_trailer.max_tx_vq on queue_pairs
 change via VQ_PAIRS_SET
To: Brett Creeley <brett.creeley@amd.com>, mst@redhat.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <20260416212121.29073-1-brett.creeley@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416212121.29073-1-brett.creeley@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280628-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A462B44DCCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 11:21 PM, Brett Creeley wrote:
> When netif_is_rxfh_configured() is true (i.e., the user has explicitly
> configured the RSS indirection table), virtnet_set_queues() skips the
> RSS update path and falls through to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> command to change the number of queue pairs. However, it does not update
> vi->rss_trailer.max_tx_vq to reflect the new queue_pairs value.
> 
> This causes a mismatch between vi->curr_queue_pairs and
> vi->rss_trailer.max_tx_vq. Any subsequent RSS reconfiguration (e.g.,
> via ethtool -X) calls virtnet_commit_rss_command(), which sends the
> stale max_tx_vq to the device, silently reverting the queue count.
> 
> Reproduction:
> 1. User configured RSS
>   ethtool -X eth0 equal 8
> 2. VQ_PAIRS_SET path; max_tx_vq stays 16
>   ethtool -L eth0 combined 12
> 3. RSS commit uses max_tx_vq=16 instead of 12
>   ethtool -X eth0 equal 4
> 
> Fix this by updating vi->rss_trailer.max_tx_vq after a successful
> VQ_PAIRS_SET command when RSS is enabled, keeping it in sync with
> curr_queue_pairs.
> 
> Fixes: 50bfcaedd78e ("virtio_net: Update rss when set queue")
> Assisted-by: Claude: claude-opus-4.6
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

The patch LGTM, but waiting a little longer just in case the virtio crew
has some comments.

/P


