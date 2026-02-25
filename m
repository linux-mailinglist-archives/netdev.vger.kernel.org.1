Return-Path: <netdev+bounces-261000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G+RAxsOn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-261000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:58:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9120199154
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 322E8304F219
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8363AA1A1;
	Wed, 25 Feb 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbiBh5Rg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="alUxviiE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817F25771
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031177; cv=none; b=aunuUHfnLf5JuVYN1YZXWse6oLCVNLX4+7cvvLYTk2vxCvCz1IPLDMhRAwmyW73+8qdiKwUxzTvUmx6pX+EC5WHTrmGBmL4pszZeVCcPiNaNgdx4eH4X4GtKlNpKicb4GVpqBJNYRXlbwuPOfQXISSgtEArV0t0h6cxfH0JvG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031177; c=relaxed/simple;
	bh=AIGu6G9iujcEAVsIP5DLMzpj29TirlF/QSjLuL8Lcj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLiK7KH/kOgOzc20mKBhLiTSw4Ho61N5dUDJN0gDgBTKBCEZbWfDnRE1hqWGeG0hZyjmKJclsdXK2DIam11MQTTjQBwSjh+nfi05KfaxrSqnXT6lKs6hwOlwF28Zx++fcIUcNHJB987YFiBbSUrFvVUN2sOmanyAsh47tePcsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbiBh5Rg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=alUxviiE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772031175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D10QZ+digOC1iXeyNRdDRk2hXA+8zGrZxyj1PPT8Oxo=;
	b=DbiBh5RgYKK69letZFkb0etMHCCbeeN4QGe60kL8mSpvz3OAPgPXHTsB/M5nA1nTI2hLTl
	44Q+zSpS83fjhfkweQtgYnECQgR9cdtFjWYo3JRSa5+CDhhGhVVY3UjAlRreqGc2Yxkc8g
	wRpWI26hn8Mqp9Lnu1B94pCJLcpjfjM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-sz1URfPmOfC1ha8q7KZU-g-1; Wed, 25 Feb 2026 09:52:53 -0500
X-MC-Unique: sz1URfPmOfC1ha8q7KZU-g-1
X-Mimecast-MFC-AGG-ID: sz1URfPmOfC1ha8q7KZU-g_1772031172
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48378df3469so9279905e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772031172; x=1772635972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D10QZ+digOC1iXeyNRdDRk2hXA+8zGrZxyj1PPT8Oxo=;
        b=alUxviiEjhubMhrFuNBUENiFw851XjH2WC/cRaW0hrUUQt4i+JA38DWc2Un40QwOe2
         l34KLBJdff8caRon/fhf8yZogQdp1/1oNGAAicPBU0sKNGqFGHndwSi11+fM5HeqahP3
         w/HmH27mdAvPt9sh8Ij86yg4xkMbYp7ALOCeK+7OX8aYEXxI7WyXOni24/PlJCn0hpgW
         KyCo+GrC8sbctWsZDhsSSDQQvzWBpVNVejepfqEODEGc1EXScIAVA2iYsA1kN8/JLcV6
         6sSKkHQ0VFiErb87Bjwkd/xiHT4ZkguIpG2Q85GRCzPi6My3mHiLCj36uTn69d5mmyqy
         8zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031172; x=1772635972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D10QZ+digOC1iXeyNRdDRk2hXA+8zGrZxyj1PPT8Oxo=;
        b=mlhcUQ5cakTWV/u5D1LuFqEf0Ns13WZfCLuxQLrbIB8vvn4IlnpWCHkm7JVhfkOoQc
         cSwSJ124KtMRxU36JsIYlHzfFd8ORA7HozfhRZMfD4xFeHliG5rZwXgvJD8Ws80PYhSW
         bFKcdkM51mHOUvbpWknI7tSJnbMuXD6riQ6xvq/oqyYU0RrWT5gZfwfq8Qbfp25/J73y
         XUpWD8fB8plvsKZEYhGvjViUlxZlf1uKj/cBLr429DcSFkowZNqNDQRfdz8QvNaoToJF
         MB+t+BRDoHsq0VtD7e8TUFo4gX2CQhzU9X//9mO9VifyaQspNZpxtmhilE3E3tpez69z
         6VAA==
X-Forwarded-Encrypted: i=1; AJvYcCXRIvy1kq2MhxMxh3Ses7MVadOiDwmmAhSI2FxGAsN01spYcN1CBAGKTaUz5oMOcqSF/1RAzF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNEX/kSsE7GDTSdnvkq3VNd8djgYIP7ozGxSgiEvJzxht29uB
	XLD6QItQ2ap4WUUQClvJTRMFE3mavYCSyXceEClXtgiRxi0UKyhuTA6WHsmK4YBn7/OI8b0ephA
	xIhw8MAK3MbWEaBQF4vMqMYoj7E8gniQaEJnjq9zT7JJAPiZ4F0I6luyS8g==
X-Gm-Gg: ATEYQzzGnCEYnHGoQcobk6Fj2E/WSJsUZ/kuwDbgQ6xmUQOv8zhVk7F3aeDkgNso5fC
	cwB2bjg1WGeU/z+kK1lqzOzgSfmEd00/miUUBwF6NZ565h1Az3AdKwuHVMPDXtbh3hqDn/WNYwa
	9lkXwxwzx/i4MxOk86vGLSV5wlTSbJbROwd5umfy2vluXvnj+S0UmvzGhU0CbPvnJ/Tj1+EYoGm
	WpHK3EIhuXwbJMazpWObqApu52B6XP39i8O3dRQ12jprqs1o6mXe6Ld6nI1RfDX0RsKJvErsInK
	kJzS76Ys9vL6QOYQCV9s/lST5G3fVnFUi20xy5d3PhToeJqM1IO0sDrYQeVELmPBNrhnCX+ete3
	O2oI2/bZcFrttOua1Q5rkUMyg/Fgx00ZD0haER7N6wv0P0Q==
X-Received: by 2002:a05:600c:548a:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-483bd73638emr69858225e9.6.1772031171672;
        Wed, 25 Feb 2026 06:52:51 -0800 (PST)
X-Received: by 2002:a05:600c:548a:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-483bd73638emr69857745e9.6.1772031171191;
        Wed, 25 Feb 2026 06:52:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19d6sm76376655e9.2.2026.02.25.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:52:50 -0800 (PST)
Date: Wed, 25 Feb 2026 09:52:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225095100-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <20260225145027.29d666ac@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225145027.29d666ac@pumpkin>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261000-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: A9120199154
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 02:50:27PM +0000, David Laight wrote:
> On Tue, 24 Feb 2026 12:28:50 +0530
> Srujana Challa <schalla@marvell.com> wrote:
> 
> > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > redundant runtime max check.
> > 
> > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > ---
> >  drivers/net/virtio_net.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index eeefe8abc122..768ad5523dfa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> >  		}
> > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > -			dev_warn(&vdev->dev,
> > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > -		}
> > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> 
> type_max is horrid.
> I did read the later discussion (but it has fallen out of my brain)
> but isn't that check broken and/or backwards anyway?

it is just trying to say "i check at build time that hardware
key size will never exceed NETDEV_RSS_KEY_LEN just because it's not
large enough".

> I'd also question why you are using u8 for a local (I didn't find this
> version of the file), it will generate worse code that [unsigned] int.

that's hardware format. but yes it should be config->max_key_size or
whatever it is.

> 	David
> 
> >  	}
> >  
> >  	return 0;


