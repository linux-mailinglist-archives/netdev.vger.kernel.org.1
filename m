Return-Path: <netdev+bounces-285929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC6+JusS/mnZmgAAu9opvQ
	(envelope-from <netdev+bounces-285929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23194F98AA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78A0E3008C98
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F93EE1C1;
	Fri,  8 May 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJWrGFJo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="osQtdmCB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779024E4B5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258661; cv=none; b=NUXF5DTvZQow2Bubchto01dq3KuF4AJ9rJBqKeL6LJ68b4O+A/vM/k/Q5QWECJBagqHN37KnwxaTAs9sb4wLBf0TEHUGaaU3hmUYG7w1PTiryrq6nzRu3uc9d7Eu+Cf63wJBM4ZpQm1gq2OxbL+gqSj3hq8G1VAT/jpp7/WqyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258661; c=relaxed/simple;
	bh=6HxONNuo9hUowvo/qEANYYQGQ+cuOD5myJfGdZBXDF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nl/mTyxyce19qWjET4/eTR4kzF4EaPWu4ZjKl7ioodCz79ripmAQhAeYPQXiJZo/8pC6Qvpa6FT0yyxwNIU4fnZ0OXS8TxXeWLLYN9ToOla6UJUyPXU+f2WkR7akIBR2ClMpPNItiK2sZzphmtT64knLh1Y258F2KjrERmKLczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJWrGFJo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=osQtdmCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
	b=fJWrGFJon7/AjSYcSpiNFUGIMPH6YKMh+ld3El5nSE9Ssq8uVa8KTxjCMEYCILcnuh8pqj
	cFfl4qBq1dUWQfNlQXj8TkuBP/n7+uN82UzdPCxuBr9nd+Iq5zQmNjCJZIHWrzAALsNVD8
	4mHP87ipXIwP5lZIwHK1M2tNGcTVqYY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-R0DN7nHBOoyjdOeMTJ2o6g-1; Fri, 08 May 2026 12:44:16 -0400
X-MC-Unique: R0DN7nHBOoyjdOeMTJ2o6g-1
X-Mimecast-MFC-AGG-ID: R0DN7nHBOoyjdOeMTJ2o6g_1778258655
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso22698065e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258655; x=1778863455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
        b=osQtdmCBMDYAfIA3rwBMAOz9gxQtZKrdFlkaZtEmcR5YJLwQXAFSRApkvPXlzT/cGK
         innGIRapbb5poDII3yiI+7c6bCK2exnr4uH4zdNZmvYM37DBjThnCssLJmI7/dETwmgO
         SIVwlPxwwGICM8qIspu9FEU2nP8cGmXL1fguTOk6BEX4gwTuKDcTiJti2c/y5wPMDYWJ
         93Yk2ShamdAyoIewwbYDxvMoZX5/DKflakzMTu22qhaYsmqZfxWtpUcSqGk3loisAVyC
         xQu2LXRfoYikFev3uUVTehEB3yZ6iZBiIZBeeeZJYU98k+ySP/kAQAhb/qia1N+tw6Os
         1lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258655; x=1778863455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/FCT893ObSbmlIhFuQ0JD4F9cxfAK4253dqNQw9BmM=;
        b=DZgzqoazZIgGQkLixe/XOsWCmL1Gu/qIR3Wo/j0R/FnXvVOGG8JSni27sXk5SXToTX
         DmdQFQCHNr3bNH2k7Qakqn1p6+osCCc9TFcMENDnLCHagNPYKNl0Nz+xMaJ5pJUEUvQh
         TN5IkEQ7kajrq7yAdXz/NuCKpEQ5qjDBff6F2BKeM3xs7H4PnQGwwUBHAcYBrBB7+1sN
         gc/v/+nhPgBrWKjS2ywRITP2ZPuXzZ5nOIoexvRgJP9L64TiecxpWP4G7zpMzUYBIhWg
         Bu7tu1pPy2NCXlQY5NMy07m4FSesYT22ZQVEjAwEZ6KpLh/KvtQRWxUJGDWotNs5Esgp
         UZHA==
X-Gm-Message-State: AOJu0Yz1CdEJCsOAtaLZzHIeCXgiJokRTO+AFbOhRqUouJH6/HWvvyYP
	FmsIV8OtjvI91Uvg9YKeASY9mbnXdgDtNkI28/ijBqte2H3awEdY0avkfONAS6qf3tJE7CGz2tO
	f0TGsm8kWrnfVamjWYoCi509Xnivn+MGoQdvXUjG59/YJtKQApCYUtT0djlDIFgg+A/MD19aVdV
	KdSIIWkvB7rHGf5JHsTOYNDLV+qHvc2mIi5aAlxNNcuQ==
X-Gm-Gg: AeBDietNgTQkO1FBtgrmL//XiEZoAx7VWtlci3w8XFRpurLLa5FKBkdZqKmXoq3UEV0
	FEy38dn2CJu0qcQCFkXiDiHOYWF7BnJhkz60OqaKN7ALnId1dPI184nk5IXwSgxxWg1uYK7V65I
	HO6Ig/OmdA6hywTHlVlq6k/DyDyR8OkOSu9aGGRChbNsM98O9ySFpH65RXwMaSih9nNXSr7qkBf
	fLPK1lWa1A0WCjQkjJi3DvlfsMmFzaZMoewEPAOC+7quK7VbddDmcm4vedna34dJAmEDejUoOFF
	UHWU71SYBaJKdss0Nt0hF/nwpMKoVfnbCg81io5W9PBNmkcyIjZObavgMUjZNC4u2quLOcvEjyc
	o9d0aCn9P8MVd/H/+rshHt0VG0CSOU07Pmnwe3dpEwlBaxyaWGtsRg1Nd4IWuvsjQFA==
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000945e9.12.1778258654686;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr89000315e9.12.1778258654041;
        Fri, 08 May 2026 09:44:14 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3b31bsm6561025e9.10.2026.05.08.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:13 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Date: Fri,  8 May 2026 18:44:09 +0200
Message-ID: <20260508164411.261440-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A23194F98AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,linux.alibaba.com,kernel.org,meta.com,davemloft.net,lists.linux.dev,google.com,salutedevices.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-285929-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
virtio_transport_build_skb(), I discovered another issue related to
the offset and length of the payload to be copied in the new skb.
This was introduced when we did the skb conversion, and fixed by
patch 1.

Patch 2 fixes the issue found by Yiqi Sun in a different way: using
iov_iter_kvec() to properly initialize all the iov_iter fields and
removing the linear vs non-linear split like we alredy do in
vhost-vsock.

It could have been a single patch, but since there were two affected
commits, I decided to keep the fixes separate.

[1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/

Stefano Garzarella (2):
  vsock/virtio: fix length and offset in tap skb for split packets
  vsock/virtio: fix empty payload in tap skb for non-linear buffers

 net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
 1 file changed, 16 insertions(+), 31 deletions(-)

-- 
2.54.0


