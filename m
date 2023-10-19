Return-Path: <netdev+bounces-42517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 685517CF1E2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC77B20F1D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31692134BF;
	Thu, 19 Oct 2023 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBOTQ4Rc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84334DF57
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:02:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3709121
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697702549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkgXc+bIQhSWbzeEfBW5BEA6kfzhB8N4rA+lukaPFCw=;
	b=jBOTQ4RcVtU0oszTW8TxYtgU8F0LhYQe9kUX5nB+PmXjX6/85bifIhrrrgI7NYiWtosayr
	TKoepKJRtsXvBsNnvdDdUXuDg7cg2x6J89C2ZCi4ZCYiPYlVRp7aT5IGVb7/z87+i0/qoe
	KqCL8RbkI8GoD4W+kUaBAUSh44WX8Mc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-a4B6TgO5OoGrpb10ovi7IQ-1; Thu, 19 Oct 2023 04:02:17 -0400
X-MC-Unique: a4B6TgO5OoGrpb10ovi7IQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-49ab22f0e07so422920e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702536; x=1698307336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkgXc+bIQhSWbzeEfBW5BEA6kfzhB8N4rA+lukaPFCw=;
        b=roVlu07kFbkjGCWPiSxxklDvY5GN9qE+M400YmKh0oVe6poKGxxiLzNe6It9sYxIa3
         adV63izgaJV/S/6dzpwuci9receuDZyKeStEdPuuvnn+PaPQSxRYkFibOOsKuF6BKlmC
         XrmdPQpamp0qAWDn7a3O9Hi7DqS7AQ321iyUf2N6d3OC8hu5EKGY5ej9O5ryM1kVNu+v
         aLRlxRIR3ABSrbgH5eSl8E/X255O9wFuIEKwtk82HJ+FYnbgZyshNVNJN3DbWOd5kr4o
         duD/U0jDB+kwY/bP7XE3u2vfn+oU5ZwrG8x3WmuITdl83auw9MHnQ5H6esEMd+mOx+OZ
         Yj2Q==
X-Gm-Message-State: AOJu0YwPNmd9y8Ooiy2EnSJ7PTMAw63MEx067kEIendgO9a7773mhXrs
	iaNqRFT+97TlT8lmRp8LxskCafydGCx4STp7vBrzvuC11zIoFfd6R2iCqmNjptJsNqix9VmnCbu
	8fE7nmPRCt9LesK4C41KHfkTB
X-Received: by 2002:a05:6102:308d:b0:457:bd7e:3832 with SMTP id l13-20020a056102308d00b00457bd7e3832mr884517vsb.0.1697702536669;
        Thu, 19 Oct 2023 01:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM/XVjCo5XISBz32LDGZnbS07IzVzgTcM3mHDa8Ity94U25ZCi2Au4jP8mNGnsxBXLMjaLcg==
X-Received: by 2002:a05:6102:308d:b0:457:bd7e:3832 with SMTP id l13-20020a056102308d00b00457bd7e3832mr884494vsb.0.1697702536230;
        Thu, 19 Oct 2023 01:02:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id b10-20020ac86bca000000b00419c39dd28fsm565293qtt.20.2023.10.19.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:02:15 -0700 (PDT)
Message-ID: <8c6a71aaaabc0a8ea4c36ce609cb097857b68a96.camel@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising
 memory
From: Paolo Abeni <pabeni@redhat.com>
To: Abel Wu <wuyun.abel@bytedance.com>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Oct 2023 10:02:12 +0200
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
	 <20231016132812.63703-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>=20
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
> v2:
>   - Ignore memcg pressure when raising memory allocated.
> ---
>  net/core/sock.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9f969e3c2ddf..1d28e3e87970 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3035,7 +3035,13 @@ EXPORT_SYMBOL(sk_wait_data);
>   *	@amt: pages to allocate
>   *	@kind: allocation type
>   *
> - *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc
> + *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
> + *
> + *	Unlike the globally shared limits among the sockets under same protoc=
ol,
> + *	consuming the budget of a memcg won't have direct effect on other one=
s.
> + *	So be optimistic about memcg's tolerance, and leave the callers to de=
cide
> + *	whether or not to raise allocated through sk_under_memory_pressure() =
or
> + *	its variants.
>   */
>  int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kin=
d)
>  {
> @@ -3093,7 +3099,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int =
size, int amt, int kind)
>  	if (sk_has_memory_pressure(sk)) {
>  		u64 alloc;
> =20
> -		if (!sk_under_memory_pressure(sk))
> +		/* The following 'average' heuristic is within the
> +		 * scope of global accounting, so it only makes
> +		 * sense for global memory pressure.
> +		 */
> +		if (!sk_under_global_memory_pressure(sk))
>  			return 1;

Since the whole logic is fairly non trivial I'd like to explicitly note
(for my own future memory) that I think this is the correct approach.=C2=A0

The memcg granted the current allocation via the
mem_cgroup_charge_skmem() call above, the heuristic to eventually
suppress the allocation should be outside the memcg scope.

LGTM, thanks!

Paolo


