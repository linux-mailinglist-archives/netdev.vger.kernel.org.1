Return-Path: <netdev+bounces-299880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5nF4CMJlMWrkiQUAu9opvQ
	(envelope-from <netdev+bounces-299880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C5690BBC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:03:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=MnnYmzxT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299880-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299880-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05EA4305662C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713936A033;
	Tue, 16 Jun 2026 15:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4065322A1C;
	Tue, 16 Jun 2026 15:03:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622199; cv=none; b=ii2ppOyep0P6tdPSm4GhtalqkPEOfrZPVYnCNDh7dTDU02APjysP2KQbiJEAPz/R1nUEkyyC/Z0iNz9FzyNatlxO372Iqhwud/biGwlCigHRp8COB8ep1kFMNZdSHE2HUA10H8A0jL7kjHUwDS+JZHf2le53DugxOpvH1Esv9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622199; c=relaxed/simple;
	bh=xC+beP4a6w3VIhynN6Bo100Xb4uAkVRIkb4MDIWhP9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5QVQlca4Lp+qRsICjesnwC14noIq94Syt/rmV9FQAhZggK8lvAVsmVbkSLPbvk0ZPSSZF1X6wypDgwsm6+7ZFrmzqgO3e8RRhJk7dT8FBGujXDJ2EssO4sjYhBw7PsYvPqn6sUUiDOhplQaOuE7zsk2yZDIOUVx3naeOhmH18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=MnnYmzxT; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B6DA1011EF;
	Tue, 16 Jun 2026 18:02:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1781622185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BOZdJldyA9xjQSPbHtynyt1B2+NL3cHwnFTKNzeJ14A=;
	b=MnnYmzxTpoDkBkxeqEEUwVjjOGeJZtB9ee9alhl8qU/pmY6E0HLibQescqHzEwLHptkCuT
	x7JqE62HoGa48mNCPwUffgUKTsUxmEMMkIBDj8Lf+VWT9G/nZmfgJ/S0aDLsSOgmshXa+m
	NlLj02J9sp2ZQ5AMBZ5d7ezMkmEcOePpE9hBTbDz/j+IGmdjvEOuVjJphr8P4mtHwEwsT8
	7jA5HnLLCcGXPCfuyw4jM4s/rlfhYv+LJufAssEDScXREQRB14fgbarezI9Qs3dyt2WWp6
	YT5aHokJXJRbMvpARcWpejDMKRNRvIISb+9TDedlroKmuj5AJVpRKn4U6MXkWQ==
Message-ID: <772885a4-c755-433c-b076-ae7ac73794aa@rulkc.org>
Date: Tue, 16 Jun 2026 18:02:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
 <ajFFOJSdqpNWgohB@sgarzare-redhat>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <ajFFOJSdqpNWgohB@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-299880-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,bytedance.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rulkc.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[avkrasnov@rulkc.org:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC3C5690BBC


On 16/06/2026 16:09, Stefano Garzarella wrote:
> On Sun, Jun 14, 2026 at 08:47:56PM +0300, Arseniy Krasnov wrote:
>> Logically it was based on TCP implementation, so make further support
>> easier, rewrite it in the TCP way.
>
> Hi Arseniy, and thank you so much for the patch!
>
> I’d like to ask you to expand on the message a bit, especially to explain why we’re making this change.
>
> In particular, I’d like to better understand whether this is just a cosmetic change or if we’re fixing any issues (and if so, which ones), so we can determine whether this patch should be backported to the stable branches.

This is cosmetic change. I'll update commit message in v3.

>
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>> ---
>> Changelog v1->v2:
>> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>>   already added.
>
> Ah, okay is net-next material, please use the net-next tag (ie. [PATCH net-next v2]). 

Sure!

>
>>
>> net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
>> 1 file changed, 23 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 09475007165b..787524b8cb44 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>     if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>>         return pkt_len;
>>
>> -    if (info->msg) {
>> -        /* If zerocopy is not enabled by 'setsockopt()', we behave as
>> -         * there is no MSG_ZEROCOPY flag set.
>> +    if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>> +        /* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>> +         * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>> +         * handling from 'tcp_sendmsg_locked()'.
>>          */
>> -        if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>> -            info->msg->msg_flags &= ~MSG_ZEROCOPY;
>> +        if (info->msg->msg_ubuf) {
>> +            uarg = info->msg->msg_ubuf;
>> +            can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>> +        } else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>> +            uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>> +                            NULL, false);
>> +            if (!uarg) {
>> +                virtio_transport_put_credit(vvs, pkt_len);
>> +                return -ENOMEM;
>> +            }
>>
>> -        if (info->msg->msg_flags & MSG_ZEROCOPY)
>>             can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>>
>
> nit: we can remove this extra blank line.
>
> For the rest I can't see anything wrong, but a bit more context in the commit would help me in the review.

Ack, I'll update commit message in v3. Also need to check some reports about pre-existing issues from sashiko, triggered by this patch.

Thanks!

>
> Thanks,
> Stefano
>

