Return-Path: <netdev+bounces-297221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M6oHCJxWKGquCQMAu9opvQ
	(envelope-from <netdev+bounces-297221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EAA66330B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:08:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uq8BjBRM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297221-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE5F3058BB0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233B3C10BC;
	Tue,  9 Jun 2026 17:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71C32E6BD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:58:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027925; cv=pass; b=ZXPXEtDmIN6stifmF9cAV5qT1m8VTRPCBhaM4jDQ8u4/XCbf3RGBqd5f8edZSjScXh7TDHAXCJXjq3tQCqROnDnTf/BMzc7Svl/tri+0Z8VapKhui4IM8gg3yKYWgEploApoORBsIIeqHX+DRS55heHGDp1qS1WvACq7zojkM0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027925; c=relaxed/simple;
	bh=ybsezbay7k70lPOQonDhXOaQ/fkYTSjG31ey35ltwqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EISLZDoaRkouAwruKccQbZ3/kt+TLZ8+pw4A/4H/FsSZuzlTbXz0MlOFy5xn3ELsDZTolkfDbTiCooDsiHwE1Uxh4Gs9QgLU0X9OAcY5Eg/Ms+VZxrUns9+cCmH+rpYC83MTmKLjffY2gPyTnohrJja65mMgGuS/kQhuNZsBDNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uq8BjBRM; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175d339e8bso2587601cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027923; cv=none;
        d=google.com; s=arc-20240605;
        b=kZ0nCvq++SbyQLeW9DgO15YreLOj11gf0AztM14AqcFriK/1+G8gxoFnd/QpDGT5ue
         Jcbda1D+nUgUGN4kUef39bVclNG+jv485xmX7B7UZ8Z4TybuGWklfMGQOGMome+M3wYe
         r+Iv3zM1JXGEwRTHKAaOoPH/8Q/0bj7OZDKalwT8oiIJ7+Y6qIL/Ft76VaSZe2V3lrgL
         mkKIIAeOpbsI+IQARYiiuyO0o/6pM9gNpSp6rEbp1UPekFGBEiyr8vd9IMNdWO4oMs28
         Se0g2f1TdV/h9hAtlwHD6dDCmygOhm5HurFBG1yzy68Btkqq/QwuL1zC8xb28lxXO1HQ
         8u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        fh=8wi5jcYm/5oE0R4kks9Hjf400z3falXj3Q4/tsiMYdY=;
        b=X6xWDkzQv6GZIf8Lx4+9LprlnhCcfQssyCtmcbaH25qhI7RJH3ruDoz3osvYfJtd/S
         3kFyyVAxqbr/bYgG69hVVYZ/XXjSNKZhGxs6KPpdud2B7HqNhiJRK2Syp5V5IwSIfTLd
         fdJ0wp1Dff7ybMI5nH+sanesQoG0ctoo05l0G/Ij2SCFWfeuvaLSOvZZlWGGyx0/sj47
         PmyNUIPAhyJrBPNrRbDpLuKr4l6TGIWUyQ3GkebGFhcmRr+tcSEm53VFsDxABIINV+3P
         HBsjRliKisA9VPXaGzCL+znsSsg85f6KYRRRC3fAVnN+X7pEtn4t8pg5AXbvlVljfihw
         Bmqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781027923; x=1781632723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=uq8BjBRMK6RN4WOdIhKOT4vdaKifcO+F4oT5ZGYeNV9c0nDzbftCYWicIDWO7inBX/
         hk1EaQOr4tMyD9unFepPE9LfBXy0fdNXJv9VKSnGkYtmEfux1lpnKRx6UmQqkQcqubdC
         mlXFmiXyo+rCS5TXbzZ5DlU6RqLKkwRod0K2YU5rh+mTyxVACOFPYQMQ0X+kRsvjs8lS
         NF9VI2vE5jhZ8iHtTgOIe+8QHttVeuYXf4ba98UDuUMxT/aVgFfUxti1/U565oicj7fI
         71OZTFp3QQf/HW1fQmbmi98627koeQ73sXssKUsCVq/oYTM85TaRrscCbkXCBO65qzCg
         CH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027923; x=1781632723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=XnZdAmAGtFRHdeOIbtfcuIQW3LyrYhfNjWBHK8OXk0aEU0gkpRolPZ3oeUfAzwiyD/
         CdrTvbyb7GpHqd4VPBLkGr+DRRq70SNTZHGYEVTMPAnmI1ixpPVLEIxDVG436qf4TY0x
         VZPnGIGPDUUjGtyLCfcZ/fBI58gzqJD3fX6iDU1crL4/pG482F2hh2HZcIrqShzumBVA
         M+3KfVx6BvjMcWjLkfX6e0A+mCllg+E96CIpaug1GLViC4Z6R5NI0kgsoNHzXQuBsg3K
         MK8JHMgZevl+YkkAuDqDkPoq8z/2aPkCz8FtPKOKJ0hk55Ss7gk6mNA+GyQ1beELVRpJ
         2UXg==
X-Gm-Message-State: AOJu0YwpFFPyW9F+bzo/6U9D6le6R0rhGAT3CNUbuKxj8ztKYbFgD9MM
	HSCVjSg6qctZHzo2FE1C84varXhqs6Ud/tM7u7b2pOpyibX1oKFp5qbFGfeMA5bAuOuun7galdG
	Llh0ynbjE4nyWO8Eh6V6gsfAHnFilylnbgn7t7Y9gN5h91aEQ6vZUKjIcH64=
X-Gm-Gg: Acq92OEy1XETynZgFoeCZmm+0EPECF5BRYxd8pTCm7ItW9L0t9RBYHw6unO9vRpE8KJ
	oB2r2acxFpX/zASSDFx2ixj5oyv+V1Sbv3TTWir8/sBe8LJG2YJfVTm02AzZzIRhrSvHEIKnMid
	dRHKVeWykvvOcQxN/CQJyyzFLoMn9eCkK06mqn68BMCp5FMmmvTwian08Lfi9i1Q7WNHq/PIg5z
	uIXgSg0BhRn+kKDH8yb88i+oFIoDe+rn+xjp7lkyT2kZNDCCBMD0tFcuViwuHD76nsbZgY1bhvg
	HRXKIQduVOtR0aOTxmlrOY52hO264nefLXi4bYRH9O304w8iPl4ppd3iW3deEnc=
X-Received: by 2002:a05:622a:6843:20b0:516:4f62:85ed with SMTP id
 d75a77b69052e-5179b114418mr33538681cf.18.1781027922090; Tue, 09 Jun 2026
 10:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609004809.1285028-1-tavip@google.com> <aifL0f_QO1kocccU@sgarzare-redhat>
In-Reply-To: <aifL0f_QO1kocccU@sgarzare-redhat>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 9 Jun 2026 10:58:30 -0700
X-Gm-Features: AVVi8CdWuQeEp3U6i-IMth0fBQwGbxFj2zuxQPoE0fGsqs-1g0UsFmC0xhO_DaE
Message-ID: <CAGWr4cSY9V7JyvJWyO_YRR-9KJtp=OzAkDjjODJ9tM7orebZ5w@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: restore msg_iter on transmission failure
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com,m:stefanha@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:avkrasnov@salutedevices.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[tavip@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tavip@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,28e5f3d207b14bae122a];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0EAA66330B

On Tue, Jun 9, 2026 at 1:48=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Jun 09, 2026 at 12:48:05AM +0000, Octavian Purdila wrote:
> >When transmission fails in virtio_transport_send_pkt_info, the msg_iter
> >might have been partially advanced. If we don't restore it, the next
> >attempt to send data will use an incorrect iterator state, leading to
> >desync and warnings like "send_pkt() returns 0, but X expected".
>
> Thanks for the fix! I have some comments.

Thank you for the quick review!

> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index b10666937c490..588623a3e2bbc 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >       do {
> >               struct sk_buff *skb;
> >               size_t skb_len;
> >+              struct iov_iter saved_iter;
>
> trivial: reverse xmas tree:
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs
>

I'll fix it in v2, sorry for missing this.

> >+
> >+              if (info->msg)
> >+                      saved_iter =3D info->msg->msg_iter;
>
> What about using iov_iter_save_state()/iov_iter_restore() ?
>
> IIUC we may need to export iov_iter_restore(), so not a strong opinion,
> but it looks better to use those API IMHO.
>

I agree,  I'll add the export as a separate patch in v2 and move to
using these APIs.

> >
> >               skb_len =3D min(max_skb_len, rest_len);
> >
> >@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> >                                                src_cid, src_port,
> >                                                dst_cid, dst_port);
>
> What about adding a comment on top of virtio_transport_alloc_skb() call
> (or when we save the state) to explain that in specific cases it can
> advance the msg_iter ?
>

Good point, I will add a comment explaining this in v2.

> >               if (!skb) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
> >                       ret =3D -ENOMEM;
> >                       break;
> >               }
> >@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >               virtio_transport_inc_tx_pkt(vvs, skb);
> >
> >               ret =3D t_ops->send_pkt(skb, info->net);
> >-              if (ret < 0)
> >+              if (ret < 0) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
>
> Also, what about having a single restore point after the loop?
>
> I mean something like this (untested):
>

Yes, that looks much better. I tested it locally and it works fine. Thanks!

I'll follow-up with v2 in a day or two.

