Return-Path: <netdev+bounces-285434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMThGAe//GnSTAAAu9opvQ
	(envelope-from <netdev+bounces-285434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:34:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37F4EC4B1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D403034E17
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6C3B7B8E;
	Thu,  7 May 2026 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgmDunZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962235B633
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171558; cv=pass; b=JABkT6ma0MQggjJSXU5Czu5sG8QhbpbB4MInRgMubZbgNXymtwyu0X7HKptPyNCmm1xEIrAWKpuS1WmNwdUn+e4I2gquJoLoL/bJws+SgZNEPKeAemcK5cmkEZmjJIZBsaeimQviMOas5Z/lTZM0M+mTZ4eY/rMFylMeal7XiU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171558; c=relaxed/simple;
	bh=8VRBFuEjBtdNxMc+0CLtM7mNvR9Ak+SZIaiiqsTAXjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fs0zzyLwXN8yFGTYVeldlAqKLT90V+19uoYP+rfNiWTZAf8RzhpgSAyrNWdv0JV/BPxnjLERT3zokxZ0UnbsIad8QC7dwoGr6HFES9g91/ZjCQ48npbCt/V/giH1lQLXjR6xGbTJmilcLAI/xaNM8gplFcQk4vQaIYisSgrKEwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgmDunZI; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51306c9f2e1so10063871cf.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 09:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171556; cv=none;
        d=google.com; s=arc-20240605;
        b=LROr3wwLUGpckzbyadwWoJqgW2S3iAMCDIo5rv50rXYKCMfygES4CUyF9X43Bk4Vpn
         +4J0kiQIXAZsfWlN66SlSEHNClWNWfYAwE8DUrBya8YP3Dq1a/J91T8+DGHgqwMOIUlV
         EPzlDj+qDPo46cyMF3vH5V3DyynHbTsy3uIqdmTwB200alsuchg7r9xFuTLnE/aZux5h
         HCX0djTs3lCZEuZ6E7Kgbz91RjhWiRIgPYnAj2XxrKlmKUGoTg87MXeNI+2plbH85X5Y
         nW5MjNMJlQswmXzgtquezlkgiKtmcPNbfBKxz/m6TVf6eD+rHy73rYf/sLAUc6/8qqN/
         X3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        fh=sST8+kxjdm//vFcDN4FlrOFeuZV28w9mXyTZNnGvdnY=;
        b=Q1MMX/INTySBiqsURKSbX/9Ne/rRpr6wL87e7yPXfNv1sBmzy5IE16t9WfxufKZK0j
         zozv99uINOtemLfk50f5hvoo2GZBdGqczpJHbIfvVfNNFv4b2mCtG/ZWvhMIKbUDqUnB
         lDoRVi6+7eLspSvpErMmOKRW/8n4e8iaTjtE7mcjZFOCUpXPhiZHA0316QF0To2jsMZk
         Y22xtk1B557pdBp0JGJ2/yAL0luvpPgXu/S/3WABPC/VlqEv5IUYZoyN1aem84BCExiT
         vjItaJ4lD1YTyp0qFmAiv9VsVjRYTsHEES2tpIE68GR4eWQgefnI1rg6oTLyhcQZr0qo
         8BMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778171556; x=1778776356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=AgmDunZIeLxTvkfSftkJV1MA1H5hfDJybGp7pUaJOtM1cja7LqZa4CE86yykJLa1hT
         hhU96IW63o8S4v/q/qYz1lilge6PSccenNx459D26SvbyVqaIAQAxKjODmeEecsPDUe2
         oFFkivASQ2ACt0BrzC4oGidF8gpg77RRI2odqmlCLW9/a+H7Jm17cEmNVbJ8c9pYIbR1
         Rhc/24tSHuYZRdcpO6GG6ppgi9Bcymb/QQMW+02Jbf9RjkCoe0ALt3Vr3qRsoBWJjPMl
         NvZbe0fhgkQJHnsPin1ZRivJSq42rKmgDnudgIaJsmDg5PUZavlhfMALZ7Cgfo+OVQTk
         XK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171556; x=1778776356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=T3TYezHdKxZNVbyn1tLjjVTsTLjQJ0rlbk4DSKsp2HhzFM0CH3USr3QZBNMjQhzk5v
         9BJ7cmF+H6czSueOXPoOgH44SUogCNkaFCZg/+OWgjV7nl3Et05+SSwlkrgKmWvaK7QY
         UsebehEYMX8hLMb+l4G3vHOIqGVrbRF1v+kqANBw5lNB2wQOAb4nti+U3dNdHSE8hd9R
         IjnakT6DDhRHeFRjvO9jtrdlrn1BfbUg0urpsgcdt7NaT822woB0aB71MnF/IDEO4pIk
         GE0TypC7I4Vr/inHc0B2JhrnoOLKAle+MnSMSj7znuG+USsJwtr64Chc+Y9a0qrE9T+K
         5BfA==
X-Forwarded-Encrypted: i=1; AFNElJ/2KHUFIKm43h1qEqQR1hnYyA8BJQXV9uHBYuyV32dP6mkzTaZv/xpapBOZaX6+iUh+2eEVVb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/rJTZ8ubaX9BinE10/UJ3OJ0PvcRlxSsO8dW+BIrr+ILTLId
	r+LfUeHctbnV5NgWQcau5+OiKiYdoSeak5kYOgnyLX/HUP3DSRC+R829gRlDMbyrORXGrIkHNNn
	udAbTdt0dK69Wdrgc2qlqHMTRcKfKM6EhSHdTGFUP
X-Gm-Gg: AeBDietehW3W7ZkE8U25xUp5xTnE3ACuapZFSY1ZWaVe7XPtVmBBtGcHtXbxFOtACnH
	qqEfohRgG6FEYd89l9tOBDS++pKUChhdaF3YKWx9sKba705SLOhLOhKR8wayCLNST8rHiDHQGsO
	UcCw6bOhpEeVltTvoP2DkIvy5G7jYYvysysSg5k7inz3De0yVMT3XV8091xMmFxfFqaRIdBBp0U
	WlEE3CtEa3lZ18EO6xyEMMEF3iMdMOYmB2bjE74RF0GDyzuOFAmzAMl749GAARCWZmwJrYzwhLC
	di5ygmixAs3AmXZZdpO6h3SrJAr9Jf1KpfdwB0dyKT+WviFkhj8F/UjSQB6P3WP3WDA8Yhgy7WR
	el8WzIfIihCLYPY4sq9UlbvtymkeHc5g=
X-Received: by 2002:ac8:5a16:0:b0:50d:9b07:9c46 with SMTP id
 d75a77b69052e-51461fa0213mr115677391cf.33.1778171555577; Thu, 07 May 2026
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat> <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat> <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat> <20260507073340.0604667d@kernel.org> <afyy9CeniTBF3o2I@sgarzare-redhat>
In-Reply-To: <afyy9CeniTBF3o2I@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 09:32:24 -0700
X-Gm-Features: AVHnY4K43sQ5GiXATqMbu7KFCF7zUxmTlewiAWXiJfdc41BJ0Cit2Qu3K7HJSFU
Message-ID: <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AF37F4EC4B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285434-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,salutedevices.com,meta.com,davemloft.net,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 9:05=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
> >On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
> >> >well if you want to support pathological cases such as 1 byte message=
s
> >> >that would mean like 100x reduction no?
> >>
> >> Yep, but since this patch is already merged, IMHO that is better than
> >> losing data in those pathological cases.
> >
> >We can revert if you think that the risk of regression is high..
> >Please LMK soon, we can do it before patch reaches Linus.
> >
>
> Some tests in tools/testing/vsock/vsock_test.c are failing with this
> patch applied.
>
> Test 18 are failing sometime in this way (I guess because we are
> dropping packets):
>
> 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
> Test 22 is failing 100% in this way:
>
> 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> Resource temporarily unavailable
>
>
> With my followup patch adding also advertisement to the other peer
> (still draft locally, waiting for Michael proposal) I saw 22 failing,
> because tests expects that can use the entire buf_alloc, but now we are
> reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
> double the buffer size, or at least digest an overhead equal to the
> buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
> AF_VSOCK has it owns sockopt since the beginning :-().
>
> With that approach tests are passing, but I'd like to stress a bit more
> that patch. I'll send it tomorrow as fixup of this patch, or if you
> prefer to revert, I'll send as standalone.
>

A plain revert is a big issue, now users now how to crash hypervisors.

This vulnerability allows a compromised guest (controlling
virtio_vsock_hdr fields)
to continuously flood the host's vsock receive queue without
triggering any memory
 accounting limits or reader wakeups, resulting in unbounded host
kernel memory consumption (Host DoS via OOM).

A vulnerability where a KVM guest can crash or deadlock its host is
classified as a KVM DoS.

Am I missing something?

