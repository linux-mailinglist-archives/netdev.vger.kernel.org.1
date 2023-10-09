Return-Path: <netdev+bounces-39066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E837BDA43
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FC1C208E9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A30182CB;
	Mon,  9 Oct 2023 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6fQRVGU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2863A1
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:50:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128ABA6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696852224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
	b=X6fQRVGUekm0B4f/MlPxIcOwEe8uqFroQiM/Z1UkeLIR8IXlz/8l5bIhfCp+i6N+FUnCGn
	GLdI0pim32A+DjQj0IO4h5JICUwM/xdJrGjUeZEWyKBUm70R14m3j1Q2Td9KHTVVOtKeOu
	702W5UzDIIfMUxlJCnQDCgkqBsxgPAA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-iSzEe6TjP7aXVQU4NIUl_A-1; Mon, 09 Oct 2023 07:50:23 -0400
X-MC-Unique: iSzEe6TjP7aXVQU4NIUl_A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so361982766b.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852222; x=1697457022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBRRUjtk0t8+rSFYxPYd7qzO0KgNPL4SOI4O3jVUvmI=;
        b=onF1zJtig9Ijg2smDe48mFed20XAHs1aPqs2kkU0brEomdkdEfn8KU7RkZOHRLMh9Y
         +Yoz61mmOnkaw4fB5yPbVTLUN1ryl/Z/4Giuu0AjOOYqSdiXC+ngiKrjoMHRUtR4eex/
         Lvn1kfLb1aoAxwcRCD/G6+MwJcIht0Yf5YS3HiKQo1AoH+2AEbZf/vL7J/M6hr3R6gZR
         irg7h/hUWMhiAYPfg0tyrJjc1ODGKOIk8JrgWPhrcTEgO/u0bU+ekXNMRjkj+DhR+5e1
         HJgPTQ47jb2XvKHoUd+Ow6uY+XqENAOVNrgrg6EqewOeOA33PSCkkGroS6qFetv5V5Rs
         Vnnw==
X-Gm-Message-State: AOJu0YwfFAaHklZ9kjFL+1eWRgseiacJPkPPp0UnM9yt5y2nhRzPbE5/
	UQQ9QUj+q2bKM1xeOQzfIeMq0xKULhUb2WIn/ToHFhlWyDvA2rKPY3eSx7p+fM9baAXM87cqiA1
	VAt3iKDD4Mr8tIfeo
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id gx16-20020a1709068a5000b009aa2c5b6591mr14399898ejc.9.1696852221873;
        Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOfzC8yt9O1EKKC6ulfMdWzK/Wyw5t8obuDTFM7EgyZXQHnZ2zQtwYH9FVSA5nqeIbOBRa3w==
X-Received: by 2002:a17:906:8a50:b0:9aa:2c5b:6591 with SMTP id gx16-20020a1709068a5000b009aa2c5b6591mr14399871ejc.9.1696852221495;
        Mon, 09 Oct 2023 04:50:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d393000000b005330b2d1904sm6058419edq.71.2023.10.09.04.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:50:20 -0700 (PDT)
Date: Mon, 9 Oct 2023 07:50:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com,
	pablo@netfilter.org, decui@microsoft.com, cai@lca.pw,
	jakub@cloudflare.com, elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Message-ID: <20231009074840-mutt-send-email-mst@kernel.org>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 05:44:20PM +0900, Akihiko Odaki wrote:
> On 2023/10/09 17:13, Willem de Bruijn wrote:
> > On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > 
> > > virtio-net have two usage of hashes: one is RSS and another is hash
> > > reporting. Conventionally the hash calculation was done by the VMM.
> > > However, computing the hash after the queue was chosen defeats the
> > > purpose of RSS.
> > > 
> > > Another approach is to use eBPF steering program. This approach has
> > > another downside: it cannot report the calculated hash due to the
> > > restrictive nature of eBPF.
> > > 
> > > Introduce the code to compute hashes to the kernel in order to overcome
> > > thse challenges. An alternative solution is to extend the eBPF steering
> > > program so that it will be able to report to the userspace, but it makes
> > > little sense to allow to implement different hashing algorithms with
> > > eBPF since the hash value reported by virtio-net is strictly defined by
> > > the specification.
> > > 
> > > The hash value already stored in sk_buff is not used and computed
> > > independently since it may have been computed in a way not conformant
> > > with the specification.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > > @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> > >          }
> > > 
> > >          if (vnet_hdr_sz) {
> > > -               struct virtio_net_hdr gso;
> > > +               union {
> > > +                       struct virtio_net_hdr hdr;
> > > +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> > > +               } hdr;
> > > +               int ret;
> > > 
> > >                  if (iov_iter_count(iter) < vnet_hdr_sz)
> > >                          return -EINVAL;
> > > 
> > > -               if (virtio_net_hdr_from_skb(skb, &gso,
> > > -                                           tun_is_little_endian(tun), true,
> > > -                                           vlan_hlen)) {
> > > +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
> > > +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
> > > +                   skb->tun_vnet_hash) {
> > 
> > Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
> > the set hash ioctl failing otherwise?
> > 
> > Such checks should be limited to control path where possible
> 
> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are not
> read at once.

And then it's a complete mess and you get inconsistent
behaviour with packets getting sent all over the place, right?
So maybe keep a pointer to this struct so it can be
changed atomically then. Maybe even something with rcu I donnu.

-- 
MST


