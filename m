Return-Path: <netdev+bounces-281707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJceGBBw8Gn9TQEAu9opvQ
	(envelope-from <netdev+bounces-281707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFA4801BB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65B0B305E9E2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD602374728;
	Tue, 28 Apr 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKlDK6/J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144829B79B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364692; cv=pass; b=lLy43jceZPB+zsdTVXjZ9nMz/egScYKlcovgFDn/FjQrbhhYzEoaO+vFNDfOEslGJJlcUZjxlwU89a66y0fxCsLijb1duv1whloL+CtJWZ4otJFwhjAZXcDOWUA0wNR53gIN0Li8h1IPxCvf/WhmpP92ugeX2RGrS+I+nRV1COc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364692; c=relaxed/simple;
	bh=rflQkKHjNVxCVgZtglvz+DJcNmjV4gDXBMOsyusJUg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+6z2U/nRO8umyXU929ZjuKV6pv5LHwg4X4Pww6SuIaxrYZ3nfiDMR3NyNt4Q9M7vStY9oTpWUbVbDLVKRqbKsRDDIsVWyMrpeHREBKjZwwfWUucPujeT0377FsfkMxgs+auDpUvVDGO642Fvf7m+ql5GFKM6SenlFktFEzGwDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKlDK6/J; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7982c3b7da9so105521117b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777364689; cv=none;
        d=google.com; s=arc-20240605;
        b=aFJXKciJAy5v8UQ304EQX5O194YH6on5RBhPN1yXupzOOUsnj6pIapVszIUvz92yL3
         /Spkwvg/Nzv9+hcP3u/dAUOV/DZ4cWB792YYlBJhE2Vwauk62nAzFGpebpf2uvUEH+HS
         piK63DkrIGdJ6IYWugxEpBQRIraO13YDqGYWmEM7sjmPv7PuZyhzyiRJjLD9FOVjPK7y
         meZe1rzgj35v7pgyRWLAvWv2ts7r4t2RmbbNmyjmDs551IKb3hu86rbZfycT9EhdftvF
         aujigfsmninrBfNsaHV7SJEk4MvqKypmCYYkvYQOMGHBtJTC+Zoypm2uUHbwWxqoSJ46
         v+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        fh=vWaYhdo5fvNH/TeR8ywzxvMHqr1D4Vw5U7oalyuL1LQ=;
        b=QZfFwYg2Bof4z6hqW/FIXuE560WuEbGTD22MCGNJeeKPddoIv/RVm00jRwSQ9tyBXO
         fQPB0ul2mFOrmO+vNmUWp6Oq9l1tsl6jY8R/RS+i4W5fNGgoM265vrfraCG5C+OBtJJT
         bghcZ5YdzGVUdXBOQfwOrX8t/V9N/8VjwcrA9W04miSU05+kW6a5QHr/X2jw7eIl4e5Z
         lQEZ0GhrF+6j+TXxiikrw++ahCRRcxclQAsAhuzYC6S/t8sFHU3/uAR7qIeAs1vq9Uyo
         iq2Q5ojqqQbWbJ/mHE9J5Fi1kybjgM5FTVVNfpaom2A4tz14eIzpslZNhzqlYydHAWTQ
         WAiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777364689; x=1777969489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=FKlDK6/Jv8kfNtGY1NX3h4cuGQWkh2bPTW7s66iUkenkESCJzpbNLojgUNBzDYprm9
         9kki5WolLEy4iP4IZ4NnwQihx9jf4egowH5WAba33+Y/OWmQgkweU1z7f6S5djyqJTrH
         HvAZlGXU3uq+ugZQomxwBSaQts3a+yRqX8z5CJTekmBpgkiim9ViESCEWAPkwXk7xdsC
         qkYoejn0VNDhBvEDV6mjENXKuKOrxO4gv0q0AFPoYme3nFCC+B/vaErA10V4qyvfc4Zu
         lvwCBXlasfqxv6fdHxJjDabhVhOFY2nnXcQmUnpn9mLRZm+znxQSAjedltgsdXTMtu8t
         UhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364689; x=1777969489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nbTPPIa6lE5He4gxsryrRCR65xYKtTO0ggHOsJlUxQ=;
        b=sRtOlQCVnqWJsBOtk/n8JsuZzwshvHtrxyXXT5qCfbqNJ2hRJY3BMWMjEyrI+jyyCs
         zui8aefWbNlVcRrxBSEVA1Im61YBgNwLbWnMsBhHfayp0l7BaULXemBPmyMIYwLKZU7X
         Y5oAdi/taJBk1nB3h1hAGzoiZm4+M5ONR1hSRQruWrzLhXkVCY8U1kd+Uzi9L+f/HHHH
         qxItZDVB3QnsY/FOh0ms5fSU/S7CvY59Q3XNcEFRvS73zbBZg+EIRND+tjEE51rBIT0P
         Dn/F8x/BMwxeZdp91mFbLpBFlVPv6R8uUj2agPhgCqhfaLhnuUThuWOBDmyC/Xr0Qikk
         P/8A==
X-Forwarded-Encrypted: i=1; AFNElJ/9kNYjxJMcy4nmionscPX1hOrA1AwkhEKrEiCrYErOAFk30zWIFTBxFxeI0WP61Uf+bj2UHPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXA6CTPNIzdExGra5qo62wOSOjp/fxeJ1CCA5/K0DIz1qGmpcc
	QjPvsvzzKp9Nd3HtfTwPVPW66tOkqxpXnEca+jcUC/w5D02w0QAiKH9O3WhSg4VkUwOOTK6UkrO
	wkBFvMKRDB0HeSbXvBjdSXsj0Z4ch/5Q=
X-Gm-Gg: AeBDieuVzcEeJldmHznmNqSifwaofR1hUT41e7oWVeUZ/ymB4wsxMf7vfDKmjwGFN9J
	pVi8nEnaQ4vEMBf9knOvJtyYvfc/5eb8LfomaS6BVFXJNMRXlHAMB8dImsQaFj9F5y94DTKQpsw
	Sb7wlUumQyBcxDs/pybXXI16nf707QMsI47XQ/K+HruI/18WOsk8sGpdm09VxeUvnM2d+9YwQM2
	Z5gMvt3VOZbdw25+ZpRJtkRxHsOQNuqqMR6spqjdEFXbk6TCnpnoO0FNVHtJCK32sao0kUOAdBq
	Bw2TPa5PJHesMdCm9/D5D5uPvrf+Om6imLbvMFPjcyPwH6a60rNGRWQOm2dmElWvpAlvPt9qy/4
	RcrK31jw=
X-Received: by 2002:a05:690c:2607:b0:7b6:422d:7623 with SMTP id
 00721157ae682-7bcf5212a91mr20867887b3.16.1777364688595; Tue, 28 Apr 2026
 01:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424150310.57228-1-kartikey406@gmail.com> <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
In-Reply-To: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 28 Apr 2026 13:54:36 +0530
X-Gm-Features: AVHnY4LkfkfcAbNkAqMYMqsD9ddBBMlOtODTH4wKfniL5RjT_dtXJ2UJOta3HQA
Message-ID: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CEAFA4801BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281707-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]

On Mon, Apr 27, 2026 at 7:15=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
> >Two bugs exist in virtio_transport_recv_listen():
>
> Two bugs, two fixes, two patches usually.
>
> >
> >1. On the transport assignment error path, sk_acceptq_added() is called
> >   but sk_acceptq_removed() is never called when vsock_assign_transport(=
)
> >   fails or assigns a different transport than expected. This causes the
> >   parent listener's accept backlog counter to be permanently inflated,
> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
> >   connections.
>
> Wait, I can't see this issue. sk_acceptq_added() is called after the
> vsock_assign_transport(), so why we should call sk_acceptq_removed()
> in the error path of vsock_assign_transport()?
>
> Maybe I'm missing something.
>
> >
> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
> >   the accept queue under the parent socket lock. However,
> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>
> Are you sure about this?
>
> virtio_transport_recv_listen() is called only by
> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
> confused.
>
> >   This means a child socket can be enqueued after __vsock_release() has
> >   already flushed the queue, causing the child socket and its associate=
d
> >   resources to leak
> >   permanently. The existing comment in the code hints at this race but
> >   the fix was never implemented.
>
> Are you referring to:
>         /* __vsock_release() might have already flushed accept_queue.
>          * Subsequent enqueues would lead to a memory leak.
>          */
>         if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>                 return -ESHUTDOWN;
>         }
>
> In this case I think we are saying that we are doing this check exactly
> to avoid that issue.
>
> >
> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>
> Again, better to fix the 2 issues with 2 patches (same series is fine).
>
> >and re-check sk->sk_shutdown under the parent socket lock before calling
> >vsock_enqueue_accept() to close the race window. The child socket lock
> >is released before acquiring the parent socket lock to maintain correct
> >lock ordering (parent before child).
> >
>
> We are missing the Fixes tag, and I think we can target the `net` tree
> with this patch (i.e. [PATCH net]), see:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> > 1 file changed, 11 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d..fad5fa4a4296 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
> >        */
> >       if (ret || vchild->transport !=3D &t->transport) {
> >               release_sock(child);
> >+              sk_acceptq_removed(sk);
>
> Ditto, are we sure about this?
>
> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               sock_put(child);
> >               return ret;
> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, st=
ruct sk_buff *skb,
> >               child->sk_write_space(child);
> >
> >       vsock_insert_connected(vchild);
> >+      release_sock(child);
> >+      lock_sock(sk);
>
> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>
> Also a comment would be helpful here to explain why we're doing this.
>
> >+      if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
> >+              release_sock(sk);
> >+              sk_acceptq_removed(sk);
> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >+              sock_put(child);
> >+              return -ESHUTDOWN;
>
> Since this is very similar to the error path of
> vsock_assign_transport(), I think it would be better to start by
> defining a common error path for the function and use labels to exit, so
> we can avoid duplicating the code multiple times.
>
> >+      }
> >       vsock_enqueue_accept(sk, child);
> >+      release_sock(sk);
> >       virtio_transport_send_response(vchild, skb);
> >
> >-      release_sock(child);
> >-
>
> TBH I'm really worried about this patch since both fixes are completely
> wrong IMO.
>
> Thanks,
> Stefano
>
> >       sk->sk_data_ready(sk);
> >       return 0;
> > }
> >--
> >2.43.0
> >
>


Hi Stefano,

Thank you for the detailed review!

You are correct on both points. I apologize for the confusion =E2=80=94 I w=
as
looking at an older version of the code where sk_acceptq_added() was
called BEFORE vsock_assign_transport(), which made the
sk_acceptq_removed() fix appear necessary. In the current kernel,
sk_acceptq_added() is already moved to after vsock_assign_transport(),
so that issue no longer exists.

Regarding the lock_sock(sk) fix =E2=80=94 you are also correct that
virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
virtio_transport_recv_listen(), so our second fix would indeed cause a
deadlock. I missed that completely.

I am still investigating the root cause of the memory leak reported by
syzbot. The backtrace points to the vsock loopback path
(vsock_loopback_work), so I am looking there next. I will send a v2
once I have a correct analysis and fix.

Sorry again for the noise.

Thanks,
Deeranshu Kartikey

