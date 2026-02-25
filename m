Return-Path: <netdev+bounces-260847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENNMNGPGnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:52:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE6195572
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A5B300B3D8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905342DF142;
	Wed, 25 Feb 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCAOYOr9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fByxP5cp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18C2C15B5
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012852; cv=none; b=UXTCTlqLYxFliUR+SR0B7Nrmq/V9AYm7c0i8Ql/cdHQD850eJc0RMwKugklz0khX8CYF+hh7JYQ+86hrJtHbkcfHTDPVGTGMzGyZ4hmnmXT82dmeJ3SUsSDH2KTss7lok4lK31VAhLrQAfFM/yJ1rxn7AGfz7ATLlkcx6cQLCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012852; c=relaxed/simple;
	bh=HvwqqTyWU4MEM1BeyGiTaHQSwuFe1MwTHpZ2P4LmB9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFVnOW7sLI2iVsr/1frzlz2r9MW1XEKmGIhzajsxGyY/zY6Hzyw0NVAHKrj9qZJOjVGFDJq5CV73478KDP0mKkGNRgRU0svpeOwUU0ibyw/M5zDXdquHLYLaCrJ6ktvHShrTVpcHXDLgbGIm0IBO6sF8qa494JfMnLuXh2d4cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCAOYOr9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fByxP5cp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772012849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSquBuVZ4YagCMgghq5ihwJ4c1q9qnubzSm6xWsh3ic=;
	b=hCAOYOr9wwlepxEq7lAJ9adLbaRYArDqIjbWVG4xAdrbuOzvjWYB4JTfDfX5yOZnyR3C+z
	yoG1cFBUjPkLIp352O47fPZnsRidcqyu+l0cksJ/hE0FjdoeNYujeS4CF3cVXVJdW6raff
	kETFsyocPzwnawEiTUAUIFMuAWbLslU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-up7tUkwsNVyOG-OXWeoa6Q-1; Wed, 25 Feb 2026 04:47:27 -0500
X-MC-Unique: up7tUkwsNVyOG-OXWeoa6Q-1
X-Mimecast-MFC-AGG-ID: up7tUkwsNVyOG-OXWeoa6Q_1772012846
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4362197d1easo5474805f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772012846; x=1772617646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSquBuVZ4YagCMgghq5ihwJ4c1q9qnubzSm6xWsh3ic=;
        b=fByxP5cpHtF8FteyEmtnWrir6DwVmnlMUcAcH9EwM5sRO4XMbcGxwdyw3/8AW/EL7L
         flCE2zx+TQXqYE8u9I4S42mT5KExfU4kPRZs+G3ZzegrJHMGD29zC4TzVbeRL5pJ7I/P
         n3ta+E6onWgcU06r9j+XGxKmnHYmT1RAxxk6Q13a996eHIDsxgU3imroKoq5gIcpVU1d
         bz5G/F9n0i6DSFxnbMxa93pWAKk0M8bDLyNxqCY/+9D9S9j/JVyPqHIlO1amnvOM6AHL
         W81MWTMbJX6+5oo/cBOgL5LumvtzxQzAnN3EmnEbCE2fYpICpDyiytCAd2shHqBFehyP
         ayoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012846; x=1772617646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSquBuVZ4YagCMgghq5ihwJ4c1q9qnubzSm6xWsh3ic=;
        b=UXroN7LgnCv34DfnHHz6WxFlX8NnxgCkfKXSxxMyeus1MF3gDlO0Gq3pw+zt9AoDxt
         kWdgPCATboP9sPNzPD8MQoJyS+z+rAi5UPyeMGJpohAqPbIBW2IFplJBtaQ1+iZvttjx
         allKHwMJdLssDdnd31jQxlZsWQ87vhwXJ0XivjZRQGNIw1CEFealujuh22LnudsYICmK
         Sax2GFpuur/Q4vKPkaLJu6OsWC9OCOVvUrH7nJpynKie7eiu4MZp0Su4Qh0hbVoOkX96
         alE4q3MfvOSFH62MMxL+OLFJ57p69UHN+Oy0ulW4wnvyHepAtv4EjnBMGjTz1cvG4uHD
         lVtw==
X-Forwarded-Encrypted: i=1; AJvYcCW44qe2yxhQhY5ThTLhJkD6bp/EWwjjjOAzLJDvE1FrZAmBO4WdpvAkkxTQz2jTlW3he/kkwQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjCvd5ahotjGnKqu48T7CLBWktvfqMq9y3QIEhcoJjFB/Og3r
	56+2Lyclrakr4mE4pp3F1yXs54RtStPAA0tv6+/9hNVIXciRJ86imcmieNHEUePOFVUn3GYh3Yx
	G0sHwFiuUlidtGogBvnip5nId9rpwIUoAJynSgU1gn1oyQn/5TbaEEC3/tQ==
X-Gm-Gg: ATEYQzyP8pZ/8qRkLpJmZieE2CUVH0kjhPmoCkiDTAF+DOKP5FJ2UIfZFyClfUoO38q
	oxsd3CM+kXT3y9qM1CxnNHn+74K+7etEP+WZpoBeMHWtFbJyeb5BoAZ+G+epWNN1unmFyBMpNGM
	+5zEdbcY40D9tU4kDTP+O/FxqKVnHLkGwaFYESg4zzEH9J9f3OgCJmkOGdfQK7iVxUXLGsSfbI5
	1TJ67n4GbuYvVC3jIdK+sCIh5q4GQr/30eYoPrb05JhIllbDeLalFsn9bmTsP2UE1AJjqTygGrP
	MPrXVUnx8PRc8MbtduHqsxizUaCiqgKnSZkHD9pwWIziOL9pERnJjOMP+r0pVzC1eGgufB2Jpm1
	/FXL2Alr1AfHMrh46JwTLG0tqDmcoQT1MVfp6jpO1BoMWwA==
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr3163501f8f.1.1772012846305;
        Wed, 25 Feb 2026 01:47:26 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:439:8f6f:1b25 with SMTP id ffacd0b85a97d-4398f6f1e2amr3163450f8f.1.1772012845720;
        Wed, 25 Feb 2026 01:47:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff27sm34467347f8f.22.2026.02.25.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:47:25 -0800 (PST)
Date: Wed, 25 Feb 2026 04:47:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Srujana Challa <schalla@marvell.com>, pabeni@redhat.com,
	jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, ndabilpuram@marvell.com,
	kshankar@marvell.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225044528-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 46BE6195572
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > redundant runtime max check.
> > > > > >
> > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > >  		}
> > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > -			dev_warn(&vdev->dev,
> > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > -		}
> > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > >
> > > > > Do we really need this check?
> > > > >
> > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > defines this.
> > > >
> > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > >
> > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > document the assumption.
> > > >
> > > >
> > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > the future, this check would no longer enforce the intended limit correctly.
> > > >
> > > > then it would fail build.
> > >
> > > So, does this mean we don't need to account for the case where
> > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > >
> > > Thanks.
> > >
> >
> > yes.
> 
> Why?
> 
> If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> violate the spec?

not the value of key_sz. If type of key_sz 


i actually do not understand the question. this is not what BUILD_BUG_ON
checks.

> > the code makes assumptions but it documents them and not
> > just documents them, build will fail if they are violated.
> 
> About this, I am ok.
> 
> Thanks.
> 
> 
> >
> >
> > > >
> > > > >
> > > > > Moreover, you should add a cover letter.
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >  	}
> > > > > >
> > > > > >  	return 0;
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > >
> >


