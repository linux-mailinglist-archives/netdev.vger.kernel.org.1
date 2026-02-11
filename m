Return-Path: <netdev+bounces-258215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CUyByw5jGlZjgAAu9opvQ
	(envelope-from <netdev+bounces-258215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB0122101
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2021F3004DB6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8C26F288;
	Wed, 11 Feb 2026 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeTfH09D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlL1ZlQ/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D062D6407
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797350; cv=none; b=WlNkXt6A1P6zx+LPfDVtS6enHMuphAOfcwEjx/Mf7ni1+Dygr49mxmQU/ZZnBS5/RVPW/L9wVrH50+DHVFouHub71Gq3nioFWfVBqfFGVEiSaeDmvtmgzs8UAjYfvZqh4ki05WmXF1Gz19EYNjFIS04K1azQfei81VNEaxlFq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797350; c=relaxed/simple;
	bh=6eXXMh8LWgw5UCCLiS87LTS3qgU3t6TL/DHgHSYap+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntzdj6atfueJSIZwLuOY/Ayd62MXiVvJiO/KM5VtJVEC2zs21x1ihfSGVQXua8IMr3hxV9NIQBEgooAC1w8iyErhVT0hlQ3I1Ejv9fi9paF84kQcl/wo7WCA2F6q6V+aYBe1YaYQax78PJjGAQwB8zoyETUovGAvvmDHmy3+QGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeTfH09D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlL1ZlQ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770797348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOfnDOTaGJCTNIhSFIFWenVIFLC4qtu2j56vdEhdYvs=;
	b=BeTfH09D4RyIGtTR8c2jvof56u+IjHvnYpjMnyNf1hjntOpwAHW2BReUrYhQRd2PMFOllt
	4Qt4kSabl5Jc53jfS0aQa1cN2jwsaNZW18yUrJwdZxEeI6MQIwVDhw8qFN63mOljarj2nS
	XkUUAXIZhsvN5oNSTCqJJiFQgVeBHhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-A8xcALg4PgOTOl6HFrRSeQ-1; Wed, 11 Feb 2026 03:09:05 -0500
X-MC-Unique: A8xcALg4PgOTOl6HFrRSeQ-1
X-Mimecast-MFC-AGG-ID: A8xcALg4PgOTOl6HFrRSeQ_1770797344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48336b182ebso24297975e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 00:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770797344; x=1771402144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOfnDOTaGJCTNIhSFIFWenVIFLC4qtu2j56vdEhdYvs=;
        b=SlL1ZlQ/D2ChOXfeH7vgx7wOSMj8aQxzemxHS94AQbnN32NdlnnPg72HqlU8vTlDln
         Bd30ZkWQM7FKNa5H3YagAjmkFGr/BoG8/2s0rGxDZIwW4ztxGSC1YwKwpqNWG7EJ+0nQ
         Hkqh/E6c5XTe1FoXhKVI67Q6OaMdn5IEXrR9TNy1FwQZD+gD9vynK/rCVvrWFpIsgphK
         sBYGCCf5CqRR/yYOL+Wkq8FA8yZrwDShtF8+YKW/eoqyK+qCYRpItaupj96LpyFVcf9m
         dfHo/gEITun3pk9GmC8yfllClGP5MaN2BzegIJT7IzSWXZFtQ/d2RT47TceBaDY8Ju/7
         18MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770797344; x=1771402144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOfnDOTaGJCTNIhSFIFWenVIFLC4qtu2j56vdEhdYvs=;
        b=hhVsz3notnjWxfGQtNP0soJv4aSiQM4LmNVgQfzU/jSjxTnYPpduMiNu58Hqowb4ph
         MkjV0GwzqSd5qexltTSDURGLnoQn4VR0EiOdtbjAJGjFmMrsOqO79LXeUM8sm2Ea6x80
         tzJ9RgQS7r9GTKcels0INWK67qZhDlInkAG+/0lqsV3cyoYeeKI/laiKOj/JxYYYz5Pe
         NkzQQUO4FCM25AtiAThH8aik29kQ6ExbhqsuQ2DJfM5nFOqPSbdHEiZb3alvzTto9z0w
         usE91pO63EuNrYTbfJlG1zdH0jdMfSZRFkrcAZFM0YUr4yp7/ZCXRoi59GFgrIJ/5lnT
         B0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXvpfCO+M9bjCbuW2KQ8A6BK3FvKT0i5tsVFTlhIyGBYUUl7CnG0DLAfi9XMo0OTV9mV53+0ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjSYlJpCtrzvhRkwWhpDMh60jtXS63cz5Yk/P7CXM0El9zl2n
	dsYwqxbSF7VfR1m8I358yv5qsniuiwYocA+O5E4DqRToCvG+TX6GlY8ueeDLpD7FoyNBeuWcGCq
	2uUT8iuf+G5lmtDmn/TzHze0DHJ3pyFMIk2CQoBtPx8V6rdN0iYufWaJ/kQ==
X-Gm-Gg: AZuq6aIUiMC9A5BWfZwor0vjU4YXtS981Ok2JPWTiDEvDgZQec0zLVpHJZAtI612WOr
	btwBV4hZpz/Iyim30uGoll2fiH2B0YeIv5TpKm5OaPFBUyr+JcGnqz9vnCLw0CBQISUAiV5YQfe
	pmD/u65JdItKx4qaeNXhXvp0GXZRfYvaq/uXMemHprkv/EgPr4Ejg+J7Z5cnYS888Ji98V20xM6
	9ak9wLPYf3bviFx0yEmh2o67H0mTcqI3zjtTIls+AcMMundAqw3L32Elj0vbHse1nXIVOoww8BV
	wqBkkvC9rkzsvthOwGOsCjtvIe5wH8iROehboqjNoLJK2lHJNmOGWPb0aeR8Ts40pLL2AiXbGPf
	glIU9jJf5qPGj2w+Gq3fZZLHk4qSNoV4gvNMczqwDa8S4yg==
X-Received: by 2002:a05:600c:4f8a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-483201dd051mr255133325e9.4.1770797344029;
        Wed, 11 Feb 2026 00:09:04 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-483201dd051mr255132955e9.4.1770797343544;
        Wed, 11 Feb 2026 00:09:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm36448905e9.0.2026.02.11.00.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:09:02 -0800 (PST)
Date: Wed, 11 Feb 2026 03:09:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260211030643-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258215-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43FB0122101
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 07:44:54AM +0000, Srujana Challa wrote:
> > On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> > > On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > > > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > > > align with kernel's standard RSS key length. Add validation for RSS
> > > > key size against spec minimum (40 bytes) and driver maximum. When
> > > > validation fails, gracefully disable RSS features and continue
> > > > initialization rather than failing completely.
> > >
> > > Hm, FWIW clang says:
> > >
> > > drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant
> > 256 with expression of type 'u8' (aka 'unsigned char') is always false [-
> > Wtautological-constant-out-of-range-compare]
> > >  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE)
> > {
> > >       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Which is kinda annoying because the value was increased in net-next.
> > > If Machael wants this backported then we need to keep the check and
> > > follow up in net-next? We could try to cast the u32 away but that
> > > feels dirty..
> > 
> > 
> > I'd say yes. the warning is harmless.
> > so
> > patch 1 - this code
> > patch 2 - replace with BUILD_BUG_ON
> > 
> > but i ask then whether this code was actually tested against net-next.
> Yes, tested against net-next (before NETDEV_RSS_KEY_LEN was changed to 256).
> BUILD_BUG_ON would always fail as-is on net-next since rss_key_size is u8.

BUILD_BUG_ON(type_max(vi->rss_key_size) >= VIRTIO_NET_RSS_MAX_KEY_SIZE)

why would it fail?


> Can we cast the comparison to u32 instead?
> Thanks!
> 
> > 
> > --
> > MST
> 

forcing compiler to generate code where we do not need any
really seems silly.

-- 
MST


