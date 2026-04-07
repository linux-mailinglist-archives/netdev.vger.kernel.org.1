Return-Path: <netdev+bounces-276077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JnqCkku1WmF2AcAu9opvQ
	(envelope-from <netdev+bounces-276077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F993B1AC8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935AF305A432
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275D3A4514;
	Tue,  7 Apr 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="aGNRJyx1"
X-Original-To: netdev@vger.kernel.org
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608D3B38A1;
	Tue,  7 Apr 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578606; cv=none; b=HUJrBOEIV+/kSgabGXrQvb9BA1GPSdpZi3btDZFMynj9oR+pjzqQGcLb7eyr1Wfqr4etruCA6Akcp1E/BzP2uYQufjDZ4riccbTOK0icEthbxT5+PGf8mFzu7jg9sHpkWESrEPblR3bor2js1yZ0Jit6MLfkeKX4WLGIj6fAeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578606; c=relaxed/simple;
	bh=gPuPGbXlWRSbfUAJ0+MAkkynvcl+h/eihdVzlKzViU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LazpXwVYjpTXdZLJsWQCvnUd+HZqlUc72/2AwdL2gku6mufHbxvQ8lNTj1v5Uj+aj4eZgVCIMTTTMCrERSBPljfZG5TpijLw+OkvPUrJo+DKvFzYOwkoU25RGkDAjcN6k7IolXk5kqTn3iLs7CT2S/R2cq54y96Y8kmMDdxaNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=aGNRJyx1; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 5701A240005;
	Tue,  7 Apr 2026 19:16:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 5701A240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775578591;
	bh=+TUhVTfumybTv8koMfwzlnqEYgENz9VCASf0iuvfRZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=aGNRJyx1YqKYp0w7BV/27gEzzVJa+WBVQb8dYkvfvL8wN3g2nLdHDifOyT26A8DRZ
	 K5s885rIBMFEKpkAgtwC4IBuYQd8yig9dJmNx8/TwhKB31hv+omRNU1Ie2JE93tJuZ
	 oa4JZxxSM+6+ox2HiA9mjt/c9H0kXf8s12N23zNElxF796YA0ubr3WCcdtIGgg/2Fy
	 +K56t0WjQMbZqrG8hog0QqW83YrwJk+pwmxtZsT36NWyF9iv1OwB/hfNLSeLnRg3Sk
	 zw3qvyJ7Dwn0K5k4Vm52W160oy/RSCxRe8dmE55ghCFhc7lZgX+aOK3EZtzi9Q4/aL
	 YbXgXYtk0Qjvw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 19:16:30 +0300 (MSK)
Message-ID: <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
Date: Tue, 7 Apr 2026 19:16:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Content-Language: ru
To: Luigi Leonardi <leonardi@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 97 0.3.97 7b9690cd8d60a5fe8bc749a93264ffd09810adc5, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202063 [Apr 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/07 08:50:00 #28379041
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-276077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,salutedevices.com:dkim,salutedevices.com:email,salutedevices.com:mid]
X-Rspamd-Queue-Id: 75F993B1AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



07.04.2026 17:31, Luigi Leonardi wrote:

> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.

Hm, one more suggestion, but not in this patch: may be we can also remove 'struct vsock_sock *vsk' argument
from 'virtio_transport_send_pkt_info()', because it is also included in 'virtio_vsock_pkt_info *info' ?

Thanks

> 
> Remove it.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> I marked this as net-next material, but honsetly I'm not sure if I
> should have targeted net. It's not a bug after all, it's just a cleanup.
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..a152a9e208d0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  		return false;
>  
>  	/* Check that transport can send data in zerocopy mode. */
> -	t_ops = virtio_transport_get_ops(info->vsk);
> -
>  	if (t_ops->can_msgzerocopy) {
>  		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
> 
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-remove_parameter-f61a3e40cf90
> 
> Best regards,


Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

