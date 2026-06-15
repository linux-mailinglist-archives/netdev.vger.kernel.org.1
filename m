Return-Path: <netdev+bounces-299544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id orltIxQvMGp1PgUAu9opvQ
	(envelope-from <netdev+bounces-299544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F53688982
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pnPimeq3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299544-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299544-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D025306B015
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1040F8E2;
	Mon, 15 Jun 2026 16:54:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0B411695
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:54:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542454; cv=pass; b=mY1yFlVJUiQ/Rlhc++dHXTlFNUS9LWepzjYTA+UJqoFl1BgYRgJ8n6tWVawm+TIExnGoip7oDguUWBVHSYR+NIompcvPGQUrLQhgUElXn/ap68PQrajo8dNog021Tg1av2XIlSLO1So8MHBZO30QMv7hwqqNjuEvx3cfdEPRRLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542454; c=relaxed/simple;
	bh=zEwHvDF/Oi5KrPI8PZGGTgCBVKgki0dlIsLL4ZGwkRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi5mr8yahSHvvqK3h5xZJP0owMNL2hPubNSCZrgCOo40lg7O8BmN4AtRqLi87zL7etlxExYtF88Yak1A7In9739KN/4EQACZUTshcYILEz6ESZFSVlw5qD/vwheBs6msTALQWYHL4D9iUfkl0gfs/DxgBeytTe2ifbmloqWgBdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnPimeq3; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177ad0cc67so30798031cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542452; cv=none;
        d=google.com; s=arc-20240605;
        b=dpAf1+PsVh06l/r+JiN+NI3w0iU9a+Ohr+FRDGzbds35V/tgXLkMT1YYUMMNCW2t6p
         yOBUmHpoH11vlAVt7s8d9ZjNDySve0OMLbFOMxTELZ79JRsJOEktQaCLS5lnxXczqMP/
         cVvTELfP8PaufzFSShjU/YoouNhD65LGMyhvwUoqxLlrxpcoDZOQgN4h57Mh+zqnFxtS
         AjVvr9yMKhMa1jNQ1ljGXkedWy8q2SHIqZk4ldYZRHlbPScV45a7yhd+e4M1sVvAWTHU
         iNH1oNmxv6sIm+0GKm34QihJyKxfb9TYiab6v6s9gVhwfeunvxj+XvdDa/pjqI63WRwW
         NwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        fh=2v+NdO+A9yLCsEo4b/bwyvlCHrOU3gpbpPGMZaLC7kk=;
        b=MpDXuXE6n666TG+yoE6SpMct2EAav4aJeaa+35nsA6TiiZnHIz6ktc3uqFEkBSMoSJ
         Lk1NzB32YjVA0fZkvhTOV/tYXFGLrLfHIABnKjovtrEB2mknoUBkgdv89okmIr9IblVr
         3EJJwxM3HS7M3U1AbLxIWZbzay+t2oojW9yJkwhwop0J+hd/O+Jn0Hfa2DmuPBohrzhI
         ORaazoDXm2hWVbg4ooDqSwDV3M9+esFQS/jvtMZFagYHbc4woy+wqw67ZrNcee2X3TiB
         UE9ylGXRA9Rd/gy1ukeq8nxSIC+fRwvdwgtWnZemi3rh2blkvDmfAkTrCWEu/KnQX5OI
         keaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542452; x=1782147252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        b=pnPimeq3PasLW2m/m2aPTBBuHtxjcV2Hijm+v89CPObPUDJBq9cRNcjd3WjM7p6z/H
         pn2K90CX+0tYvf9DWCdkeSWKS3xiU7tTesxW9ZRokRcTIp9ia27Or0oBOWhafGjwD6By
         ns0tDASzGDGDTvko3cTiyp0vf9zwhzd5sMf6oFcxBKA+QYKch1W2EjbkxcXSlO1ByStb
         4RXtW0PFrt9tVvtZ5rq5XH9gZX/klKTTbn2IXn9KFByyFkof5IA5FbePDX/WsEncnTvU
         mhcvDE00cWvt07YOjy9V8eYPfgNyj5qAhWV60iN46Iw1TV0kX8y1HXjfl9K4QvGNLa+t
         Dhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542452; x=1782147252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mywi67azb0tF9mzCm0wSWcis576R5CWVcMnbNHwMBko=;
        b=ixn7fimho0QMlXjIOkTntC/mH3uO20AeXWOVixYbuyxq4VtoiPTm8L0/On9R+RKpFY
         dJccfyWWk/2V0UBjymc+j46GcXhouGcqQsQbGnipwDU6M8mVB6TUtGf7shIAjHVuKTeS
         b07PqLhEl7TdIh30LceqPMJrWuOQorL+VygU2wADhkwibbNoQ+xdKkiIDow3jZaX1u3n
         X+wlS98rtW9IxcMjk0b/vl5seHw+1WHtYVyvqwsV6vqTDIKHypcn+QuDzFNRngLCBXAd
         qkNGSJAguxXytdwFKf6cdgB8nPqLECkVZmM8sR0ENld+5sf0B5Gfqz04m78pElTMFDmj
         6mBg==
X-Gm-Message-State: AOJu0YxgMjDPYHau4u0wB/QcEG74rbVtObzMuefIXfvJvCAc70onIy9q
	RamU/BFR5vh292GZe3nh0HZ64t4jqLSc+z+ia6Ax0INvEcuAC8dyg/PERlhN5Cc978XX3jGpVLz
	4l4Zjr1kGHG2oSkJhyMMJe5HYn4dl4J2+B+8u9cvX
X-Gm-Gg: Acq92OEK4IFNgp5W+4YWh1i9nDQbH46vePetlijv+xz2ZtNfXfI4dMDYhJq1q2qG/eC
	qVlwFvctBbw+A+a3w73LI2fn2xf3V6k1k5rqDEwDbvpx1zwSFX8kDzzjpA5IIUWVaNTjxCvFkaH
	flDsryQeEaBB5RLf4xRz0Q9jS+DbYwwfXtT4vDzmJy6aTknibkKw0jcIt7/a/bfFzv3bIbiNqL5
	zAzaPWljZlyKe27VH2B0yxl82E9df9X/X7wJcFtdBFMrfcJY+ZwzVK1tQZKPNP9am4r75k9ghH2
	15KQv4e7L4Rhd79n4dwyjAerjkege19e4itg9ol+5iJ29IJ0u/IOMzoHKosu9vZFjFvZHFIjYxW
	9txbrunDv6S+2cUb7nfvK
X-Received: by 2002:a05:622a:607:b0:517:a02f:171a with SMTP id
 d75a77b69052e-517fe4e576amr226669271cf.36.1781542451604; Mon, 15 Jun 2026
 09:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 09:53:59 -0700
X-Gm-Features: AVVi8Cdal2O6L20-PUAih4P0EZ9-LRL2uZJ_l9mNVqrSp_BUJSjPaDqeyqTpi_U
Message-ID: <CANn89iLwy0tsB5wMrREnGSvmPrThyCkjHEz0hpWbCiTJSG0NCA@mail.gmail.com>
Subject: Re: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, Kito Xu <veritas501@foxmail.com>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:veritas501@foxmail.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,foxmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28F53688982

On Sun, Jun 14, 2026 at 2:52=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> atalk_search_socket() walks the global atalk_sockets list while holding
> atalk_sockets_lock, but it returns the matching socket after dropping the
> lock without taking a reference.  atalk_rcv() then passes that pointer to
> sock_queue_rcv_skb().
>
> That leaves a race with close().  A concurrent atalk_release() can orphan
> the socket, remove it from atalk_sockets, and drop the final reference vi=
a
> atalk_destroy_socket(), freeing the socket before atalk_rcv() queues the
> incoming skb.
>
> On a KASAN-enabled kernel this can be reproduced by racing AppleTalk DDP
> delivery on loopback against close/rebind of the destination DGRAM socket=
:
>
>   BUG: KASAN: slab-use-after-free in selinux_socket_sock_rcv_skb()
>   sk_filter_trim_cap()
>   sock_queue_rcv_skb_reason()
>   atalk_rcv()
>   snap_rcv()
>   llc_rcv()
>
> Take a reference on the selected socket before dropping
> atalk_sockets_lock, and put it after sock_queue_rcv_skb() has finished.
> This keeps the socket alive for the receive path without changing socket
> lookup semantics.  A malformed or racing receive still drops the skb on
> queueing failure as before.

No idea why linux still carries appletalk.

MacOS dropped it 20 years ago.

