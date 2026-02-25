Return-Path: <netdev+bounces-260857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPEQDKfInmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:02:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC81956EE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98BDE3016AC2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DB3624B9;
	Wed, 25 Feb 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e44QXep2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYiCpTDm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA8322749
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013713; cv=none; b=JAYIfwhbHQbK1RnVuJMAU04R25dW3ue3Air5ZJKWhjsrhBaU0ASg1WlIYmjCdu7tIEFpvBasRa/jhoEcqjSbQRVTKYMhnGVdwa9vIX+Uyc9F8+hxvUoDtJbjXb+UAL79+FFhyh7873gSltyuFAi3eD2ibOpoF/rtRn94XBcISZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013713; c=relaxed/simple;
	bh=u9CvtSP91YekIS68SSQl4Vt/A8tkQgw8jEa8fPceo7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/QTZ8ljrMR+DOt/El3HcFfqpAMntDnc4FlegL90y5LAS4IRiZR9WdmUSqBqHR0Ty5Gd6fvZ5p66X5c9HQWDOZUGvhVnGERhfoQKeXRUS1iG3FqTDEq+ytts4NbglM7UzsMzmyTI+eGPfhTMLbaoReEGZ7JxU47JZ1Hge4JJ69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e44QXep2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYiCpTDm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qItuZ2RIB8SUFWGgO0o0RQca3VPYW8nU8swiC3uXqcs=;
	b=e44QXep2kMptJYuRZWsP7wIInz6mCGt/7YjDt4gYIFgQCliT9oIs6LF5t4+8iYAK/Poe0d
	OGLSXl82AVoLW2AiFhEFFQ7Dz42wMlv6dxmhPdvVvc1CadHMBir1tPnMK6DjfUMul36mSX
	Nei2ndBbZIrEzhCHrn1zTQPYU/5UA6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-96b8TGCQMM6YsAi7MBGQyg-1; Wed, 25 Feb 2026 05:01:49 -0500
X-MC-Unique: 96b8TGCQMM6YsAi7MBGQyg-1
X-Mimecast-MFC-AGG-ID: 96b8TGCQMM6YsAi7MBGQyg_1772013708
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48071615686so14819305e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772013708; x=1772618508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qItuZ2RIB8SUFWGgO0o0RQca3VPYW8nU8swiC3uXqcs=;
        b=FYiCpTDmUngK8hd5WmXuBmorOuS5iyT7hO4gLwceFqPCZboX1xNv7sq5RGIM0JVgxX
         2X+UlnHy61gtk+TtjQciLiJ0Zsy1WwY/UtckFH6Q4TPXciUFnLcbNrawzVHG14TS8MIw
         CD1+ds0jyapw2qXkveU99POOHBHTNkvB3sUyqKJ/CzAZb42KE2UcG39VEaR5ZKBhKxN0
         CE6Y1gXaVD2xlNiXHCWul/MUvY/vZdyPbN0jwWZdRIXKosNNGHytpFfsZZWEJWEmuCg7
         DUwubCe5Tj703EkCVJToxgmtz75WwwPjgrMibTl2SuJ9bBuMLGezRCg0/LS6JRcTuDI1
         7+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013708; x=1772618508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qItuZ2RIB8SUFWGgO0o0RQca3VPYW8nU8swiC3uXqcs=;
        b=Y+pv0HKneNuZWNIMVo9QdBx0lrTVWrTGb5Spj9RYiQy/vQa7EVtx8uXS1rQbJIl/po
         wj/rB3VZtnjwoL1pH74fO/XI8z9zVJbiamOuY0MAU3rjGM81JhrTPw+y7vuUemXga5Ut
         4qI1/EpsVQfo+qmJjrAcedybEm1YZT+3gqeNhd/E9LdeZxieP/6IvokaLoZ6LMuWLOYN
         WDgGV5/nuL+KKQefInt0PKh0BjNpFstV4A5QYQ4HRLyrJKyha+Kwzg25enKWl0lHVAc6
         catP6ixWp9hjmFfxblhntKpPW1pPtS0Uz8ENy/eEvwwSXnPJpd0bMZylaWZXn0wpEND3
         eoNw==
X-Forwarded-Encrypted: i=1; AJvYcCVbZ5haXyyq+ZSPHc24zImjwoK+6oC3qdLFBe5OamfkZd9e3jUx4ML+MSzsUrwZFer16tRSt/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg79RMXQRh2MTbMiQ+oSjqIZm45pFcObMSzvHTL4gySUSrUZ5o
	Q6YU/DdiANwerEDULhusdPM9MTb+I90Y63v6t5B64OAfbVpdNhLwhEOqm7lViYKi9ayxcHjlfWT
	MGBMUM9Nem+UyR/c2o7DRgjjVWgS/mCtjLJge5OVObIRXmejb2hUUTjnl8Q==
X-Gm-Gg: ATEYQzxvQjYxVCCLYqlOLUh1e4AOx+EtZ9WY7IAwtx9DVYW+J60Zc9oHScyE0crWZMQ
	eGzLwp/6yBYPnz4CmLwA9CDkKsXGdw0Tc2mNVFj6p+iVSJF+RD6COeTIEn4mxUTg3mBJG6NPUfX
	UPQGxgAj2Bi+5QzvYJUZ3y37bolLhJvRLWe/19jYMGwePIqCRcX6qu/pwXWj5BICeSlAmAThRZd
	8GIsMj/Ay7E+w4dnBXxir6a0hYF90L5JuSuqFaYeNxrIAddNw+Z44UKa5QnLNvRMvqyrYOt6G7O
	VKp9qeHdI1BuPD87Xe6zUVrML8z6SvJBGvjalAD0bUuem147+xNxbKzXQiolI5hXyOWjU1tEUeV
	sAHLaFuKbJ9SxFth3kFORTT1ygVg9LZp/n+Vocir54UQ/Rg==
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr316810155e9.16.1772013707920;
        Wed, 25 Feb 2026 02:01:47 -0800 (PST)
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr316809155e9.16.1772013707338;
        Wed, 25 Feb 2026 02:01:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776easm8576745e9.6.2026.02.25.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:01:46 -0800 (PST)
Date: Wed, 25 Feb 2026 05:01:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225045757-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: E3AC81956EE
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:52:29PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > > redundant runtime max check.
> > > > > > > >
> > > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > >  		}
> > > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > > -		}
> > > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > > >
> > > > > > > Do we really need this check?
> > > > > > >
> > > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > > defines this.
> > > > > >
> > > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > > >
> > > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > > document the assumption.
> > > > > >
> > > > > >
> > > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > > >
> > > > > > then it would fail build.
> > > > >
> > > > > So, does this mean we don't need to account for the case where
> > > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > yes.
> > >
> > > Why?
> > >
> > > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > > violate the spec?
> >
> > not the value of key_sz. If type of key_sz
> >
> >
> > i actually do not understand the question. this is not what BUILD_BUG_ON
> > checks.
> 
> So this is the issue. Originally, the code checked whether the value of key_sz
> was less than NETDEV_RSS_KEY_LEN.


No, and the check was plain wrong:

-               if (key_sz > NETDEV_RSS_KEY_LEN) {
-

so if device supports a larger key then .... we disable the feature
completely? Silly.


But the issue is present in net just the same.

So I think the commit log should be rewritten to explain the real issue,
and target net, not net-next.

> However, switching to a type_max check means
> it no longer covers the scenario I described. Therefore, I think this is
> unreasonable.
> 
> Thanks




> >
> > > > the code makes assumptions but it documents them and not
> > > > just documents them, build will fail if they are violated.
> > >
> > > About this, I am ok.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > Moreover, you should add a cover letter.
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >  	}
> > > > > > > >
> > > > > > > >  	return 0;
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
> >


