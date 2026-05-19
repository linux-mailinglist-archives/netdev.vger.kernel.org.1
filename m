Return-Path: <netdev+bounces-289287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPjxHfYHDGodUAUAu9opvQ
	(envelope-from <netdev+bounces-289287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:49:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C2578592
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C97F23032FD7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A138A738;
	Tue, 19 May 2026 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="axi1jPDH"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263937D10F;
	Tue, 19 May 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172659; cv=none; b=J7J1KFDnL/9q5hcPZVE2HfVBPswJ1aR+TBTZoqN5thfTcH1TAXg/szRob/k90I72cGOH1i259pQzu3kHh+2h7iTImYSoP5MFXK49QQfZW5Fn9rPYBMdT0+vbsKl4MgdDL2c9diwXUfEbczNJIAvA3E8fO0k70/T+mE/JtxxU3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172659; c=relaxed/simple;
	bh=Ba54tlaLzVS0tnkEUiadMTQemQZTXU53H6g52Xw1Q4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pqd58jaPaE6BjcTBYg91s7SfSGyXBX7p+KeZwHKggSh1mJ+QdaXVz2WN2b35r5qbnXJOHuDNac3RYw53G8tED2KyKI7usTwMfoxA4Tw20v+iJIH0xRYCI88iqPY4okDYVb0BlrnUSyrR0AjtVoBB/IBzhzc2zLzK+smqSUF5qFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=axi1jPDH; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 43BCD40017;
	Tue, 19 May 2026 09:37:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 43BCD40017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1779172647;
	bh=wq2XHzZwQG7ofdjqejV+Sf3LE4yTZqvjhYHDHUch4Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=axi1jPDHTZTyrBusIdQ53XIbLeNr4/1b269hdRGnUBfLwu9zM+unxUUGrT4WOqI97
	 B618CgvWiJo24vVwBOBmrudFNAZU5B4Q5dyrriWUcPUmXORlYe/EgeHHTWZrq7N35h
	 S9b1B58xPMB7g1QAsk204Kx3XaOZuxlBWPUnJTpIzMyZXlhMA+NtNhrGZ3rCl7JZ0H
	 4Ly9UtzZgl8Zam0NRScxYxI/5xlB25yFvpdJAwe0JGGeP5n28NimXVDLZjIq6WsplU
	 0m/5kRvW3J6H4G0Zct0aH9f2JNFneaLmRnZPjjNZXF9YMNLaTesiNRn5l69XOurGbn
	 h0yjJqevvOcYg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 May 2026 09:37:25 +0300 (MSK)
Message-ID: <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
Date: Tue, 19 May 2026 09:37:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Content-Language: ru
To: Stefano Garzarella <sgarzare@redhat.com>, David Laight
	<david.laight.linux@gmail.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <netdev@vger.kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	<kvm@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
	<linux-kernel@vger.kernel.org>, Maher Azzouzi <maherazz04@gmail.com>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin> <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat> <20260518115005.5f13bd2b@pumpkin>
 <20260519053951.1C60440015@mx4.sberdevices.ru>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260519053951.1C60440015@mx4.sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/05/19 06:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 105 0.3.105 c7fb587251b1312ef0d9243823bef7335f8fcbef, {Tracking_phishing_log_reg_50_60}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;git.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sashiko.dev:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203239 [May 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/19 04:09:00 #28206517
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/05/19 06:18:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,quarantine];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289287-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,kernel.org,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[salutedevices.com:email,salutedevices.com:mid,salutedevices.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 813C2578592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 18/05/2026 14:08, Stefano Garzarella wrote:
> On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>> On Mon, 18 May 2026 11:54:19 +0200
>> Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>>> On Mon, May 18, 2026 at 05:33:08AM -0400, Michael S. Tsirkin wrote:
>>> >On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
>>> >> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>>> >> > On Thu, 14 May 2026 11:29:48 +0200
>>> >> > Stefano Garzarella <sgarzare@redhat.com> wrote:
>>> >> >
>>> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
>>> >> > >
>>> >> > > When a large message is fragmented into multiple skbs, the zerocopy
>>> >> > > uarg is only allocated and attached to the last skb in the loop.
>>> >> > > Non-final skbs carry pinned user pages with no completion tracking,
>>> >> > > so the kernel has no way to notify userspace when those pages are safe
>>> >> > > to reuse. If the loop breaks early the uarg is never allocated at all,
>>> >> > > leaking pinned pages with no completion notification.
>>> >> > >
>>> >> > > Fix this by following the approach used by TCP: allocate the zerocopy
>>> >> > > uarg (if not provided by the caller) before the send loop and attach
>>> >> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
>>> >> > > Each skb's completion properly decrements the refcount, and the
>>> >> > > notification only fires after the last skb is freed.
>>> >> > > On failure, if no data was sent, the uarg is cleanly aborted via
>>> >> > > net_zcopy_put_abort().
>>> >> > >
>>> >> > > This issue was initially discovered by sashiko while reviewing commit
>>> >> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>>> >> > > but was pre-existing.
>>> >> > >
>>> >> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>>> >> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> >> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>>> >> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>>> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> >> > > ---
>>> >> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>>> >> > >  1 file changed, 34 insertions(+), 49 deletions(-)
>>> >> > >
>>> >> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> >> > > index 989cc252d3d3..1e3409d28164 100644
>>> >> > > --- a/net/vmw_vsock/virtio_transport_common.c
>>> >> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>>> >> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>> >> > >      return true;
>>> >> > >  }
>>> >> > >
>>> >> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>>> >> > > -                       struct sk_buff *skb,
>>> >> > > -                       struct msghdr *msg,
>>> >> > > -                       size_t pkt_len,
>>> >> > > -                       bool zerocopy)
>>> >> > > -{
>>> >> > > -    struct ubuf_info *uarg;
>>> >> > > -
>>> >> > > -    if (msg->msg_ubuf) {
>>> >> > > -        uarg = msg->msg_ubuf;
>>> >> > > -        net_zcopy_get(uarg);
>>> >> > > -    } else {
>>> >> > > -        struct ubuf_info_msgzc *uarg_zc;
>>> >> > > -
>>> >> > > -        uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>>> >> > > -                        pkt_len, NULL, false);
>>> >> > > -        if (!uarg)
>>> >> > > -            return -1;
>>> >> > > -
>>> >> > > -        uarg_zc = uarg_to_msgzc(uarg);
>>> >> > > -        uarg_zc->zerocopy = zerocopy ? 1 : 0;
>>> >> > > -    }
>>> >> > > -
>>> >> > > -    skb_zcopy_init(skb, uarg);
>>> >> > > -
>>> >> > > -    return 0;
>>> >> > > -}
>>> >> > > -
>>> >> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>> >> > >                       struct virtio_vsock_pkt_info *info,
>>> >> > >                       size_t len,
>>> >> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>> >> > >      u32 src_cid, src_port, dst_cid, dst_port;
>>> >> > >      const struct virtio_transport *t_ops;
>>> >> > >      struct virtio_vsock_sock *vvs;
>>> >> > > +    struct ubuf_info *uarg = NULL;
>>> >> > >      u32 pkt_len = info->pkt_len;
>>> >> > >      bool can_zcopy = false;
>>> >> > > +    bool have_uref = false;
>>> >> > >      u32 rest_len;
>>> >> > >      int ret;
>>> >> > >
>>> >> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>> >> > >          if (can_zcopy)
>>> >> > >              max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>> >> > >                          (MAX_SKB_FRAGS * PAGE_SIZE));
>>> >> > > +
>>> >> > > +        if (info->msg->msg_flags & MSG_ZEROCOPY &&
>>> >> > > +            info->op == VIRTIO_VSOCK_OP_RW) {
>>> >> > > +            uarg = info->msg->msg_ubuf;
>>> >> > > +
>>> >> > > +            if (!uarg) {
>>> >> > > +                uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>>> >> > > +                                pkt_len, NULL, false);
>>> >> > > +                if (!uarg) {
>>> >> > > +                    virtio_transport_put_credit(vvs, pkt_len);
>>> >> > > +                    return -ENOMEM;
>>> >> > > +                }
>>> >> > > +
>>> >> > > +                if (!can_zcopy)
>>> >> > > +                    uarg_to_msgzc(uarg)->zerocopy = 0;
>>> >> > > +
>>> >> > > +                have_uref = true;
>>> >> > > +            }
>>> >> > > +        }
>>> >> >

Hi guys! Just some replies after quick look:

>>> >> > Surely that block should only be done if can_zcopy is true?

I guess no, since TCP also allocates uarg even if zerocopy is impossible -
it just sets uarg_to_msgzc(uarg)->zerocopy = 0;

>>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?

Hm, we can't enter block 'if (info->msg) {' when 'info->op' is not equal to 'VIRTIO_VSOCK_OP_RW',
because 'msg' is not NULL only for 'VIRTIO_VSOCK_OP_RW'. But anyway You point to right thing - check for
'VIRTIO_VSOCK_OP_RW' could be removed here. Just with comment why.

>>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.

Here I guess it is better to follow TCP way to make same behaviour, because exact
logic for MSG_ZEROCOPY is not documented. TCP also returns error and stops tx loop.

>>> >> >
>>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>>> >> > The caller has already requested a callback - and you can't add another.

In TCP implementation if 'msg_ubuf' is set they just use it and check for zerocopy in
the same way as 'msg_ubuf' is NULL.

>>> >> >
>>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>>> >>

Need to check it more. But 'can_zcopy' means that we fill frags in skb, have_uref means that we
allocated completion (but it could be reported with not set 'SO_EE_CODE_ZEROCOPY_COPIED' if
'can_zcopy' was false).


@Stefano, I guess current implementation differs from TCP in two cases (at least from first
view):
1) When 'msg_ubuf' is set: in TCP, already set 'msg_ubuf' is passed to 'skb_zerocopy_iter_stream()'
   (if zerocopy is possible) where it is used as in vsock in call 'skb_zcopy_set()'. In vsock case if
   'msg_ubuf' is not NULL we will pass just NULL to 'skb_zcopy_set()'. Yes this is will be
   no-effect call today (due to checks in 'skb_zcopy_set()'), but anyway - in future may be not.
2) Also i see that 'skb_zerocopy_iter_stream()' in TCP version has some extra checks which are
   missed in vsock - we only just call '__zerocopy_sg_from_iter()' to fill skb in zerocopy way.

But, I think, instead of trying to compare vsock and TCP versions best way is to just copy
current TCP flow as close as possible:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/ipv4/tcp.c#n1144
1) Use same flow of checks for 'msg_flags', 'msg_ubuf', SOCK_ZEROCOPY etc.
2) To copy data we can use 'skb_zerocopy_iter_stream()'.
3) The only thing that we don't need in vsock is dev mem related code from TCP implementation.

I can take this task, but pls need some time - may be two/three weeks due to another tasks. 

What do You think?

Thanks

>>> >> I kept the same approach we had before, trying to make as few changes as
>>> >> possible.
>>> >>
>>> >> All these potential issues seem to be pre-existing and should be eventually
>>> >> addressed in other patches IMHO. This patch one only resolves the main issue
>>> >> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.
>>> >
>>> >the patch is upstream now, right? So pretty much have to be patches on
>>> >top.
>>>
>>> If those are actual issues, then yes. TBH, I didn’t look into that
>>> aspect and left it as it was before. We should take a closer look at how
>>> MSG_ZEROCOPY is handled.
>>>
>>> David, if you think it needs fixing and you have time, feel free to send
>>> patches on top.
>>
>> I'm not fully sure how it all works.
> 
> Same here, so I pinged Arseniy who worked on that, since it seemed deliberate to have `can_zcopy` (and set `uarg->zerocopy` accordingly) only when it was supported by the transport.
> 
>> Especially the paths where msg->msg_ubuf is non-NULL, I suspect it should
>> be added to all the skb even if the ZEROCOPY flag isn't set.
>> I was just reading the one function.
>> But there did look like some very dodgy conditionals.
> 
> I see, let's wait for Arseniy's feedback; otherwise, I'll try to fix it next week. As mentioned, this issue existed before this patch, so it shouldn't be a regression.
> 
> Thanks,
> Stefano
> 


