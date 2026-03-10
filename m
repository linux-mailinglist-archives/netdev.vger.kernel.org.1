Return-Path: <netdev+bounces-266357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD7SHmOVsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:04:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1CD258A84
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531D830CE0E8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567F3EF665;
	Tue, 10 Mar 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="wUJRshA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97F2FDC3C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180251; cv=none; b=ovr8tQUD8btVyYpcxkxjteqv+AKe4YY4+YonjbuCJxcU8poez3lrO4BF9GpZKNt0j+YHGkadk4O1wrSf5j3NwfkNL8EhI2wFg7ZaKAWAcf1+koOFva4IN7H71UO1pQxyFZkwi0Gk6xNprxzgrq9Q3+ppooxz5bZqGCAdFcCZXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180251; c=relaxed/simple;
	bh=X0jYres7RAKfvS4aOQk8bP0u7kzw0Dczk5OQQ6co5ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRYpUX6Ae/IwLch8ROa+enk1MT/iLmeILSXRKXfw26w443aHo0BJ55G8uaeVINE/xZIcOqfgfS5qxbsNnCz8y/7+r2/sxxs6XTTllojGUZbZH9ihayhdRPKDg1Q/+6COFt1qEmF1HcnbOiRHqutsJi0lh2QsaxF7IJfpCK34VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=wUJRshA1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a9296b3926so103956485ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773180249; x=1773785049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rRhnGis0WZpWlPXUYX9lgom+TN8jjMQV7lIc8SULHU=;
        b=wUJRshA1ZbgZHx8oohqXEVrapFeMWBj/BnXOTclN1O1HZ3EtKO3ONW6eyHcl2WB/hy
         BzOX0OQIZFq0/IuIHWr4o+NjQrpBOyG3Nh+agWDO70qHOMyhA727ciM+DdS2x6eY4KSP
         ZlzdGYzmwDjzm0t4Jjx9VBkzMVrkzt4PjdGjtCgAYoDdPwtYWdsBdDOj6CI/wH08Qg7s
         7uVKzi3UYlfDxUng6HpUjq9nU7SSydwS332xc6uCJ3lwJSNWZYve27hn4/Zdvu7oP7Ts
         jecmyCTqrgKxP2NLZve16Sy0TSIW/5EPAjltpksAt6/NzvLWrhMI5YHtdIUPieLrJNJZ
         Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180249; x=1773785049;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rRhnGis0WZpWlPXUYX9lgom+TN8jjMQV7lIc8SULHU=;
        b=bVxkmo2eX37Y07bvE5e9oQQqaS0j6XItmsDa10yhLFEr9lGn/4zM1MZ9lkLeSDQDiG
         8mGq5X8PjSODc0714K7TsI5yonzkV5bXLRomw3iHl84DgllfO15v0JcWLj4td6HCwH2f
         yg6h3ydGTFMLaYL9iGgk93WS7l7Hi78W+fCthOl3G0rAbif8cYaLBiU+R9NlrUb9Xb3A
         SXiOMo5GefNWuf6M8qxK6iOJH2gV/86BP7HNOPZPVsnp/WO1ri27Cc8z4Jd/faj3vToA
         mURnkrjwgcur4cHK3JbuTB0LSlr38GoZVF144CRdNVlOzjXQjNsR+TAXuQ0QT6/XJPkD
         nGLw==
X-Gm-Message-State: AOJu0YythszU4HyVpGGv9WHcXBEIGRE98VtTpkAurmreDnuPzZQ7ikFO
	pUA6njhNNbiAmL32CNoWavxayytysGNqjNwnXtK6e5VkCyYS6uNP2ee1eFfZdMSiK7zqpUHA+xy
	qeaE/cpA=
X-Gm-Gg: ATEYQzxykxoqqaA5jM7VSb1Pashy80dpeYoCMMywUJ1xnvQF7k2ycv2fRtcbcuuOq6z
	6gHmWsmvHUwhY+MyMG8xUR5B4Cq9K/uFMcrHBOpO0mJe7fa6KtE+0EfTnZGEpoVly27E5qo8vEB
	88SibUD4Gp9T6wVlQLMg0SYDeSZCnC9oHeNMeW7aehowvMjs/LdcVOKO+qj1cbM6llr7GzD6JaS
	S4MIzsZqUGleRnnvOv6r69d6vnr5c0/EPpVZFjKwcCd2ynaNfGC0mH2UukJmpzbR7PLLLjtaWe6
	PvmiGTw2NzI+Xz4ytGnW4WvFmlrpbNfmGz2jBBD4110fzFi/vJEdk7fuq3kU11PmNqdBbTmxSSQ
	h82t6GWTJpzAaWV9gOx2Kxkk7KCvaHe2tg5O35Thu2TgupSTanvoGOGh8tsx5dDB0adqT6hmM94
	qzPXFh
X-Received: by 2002:a17:903:1a0f:b0:2ae:8293:7510 with SMTP id d9443c01a7336-2aeae905468mr2932715ad.54.1773180249550;
        Tue, 10 Mar 2026 15:04:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm2560365ad.40.2026.03.10.15.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:04:09 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:04:08 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC net-next 00/10] Add TSO map-once DMA helpers and bnxt SW
 USO support
Message-ID: <abCVWEkf0n8Rdce2@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
X-Rspamd-Queue-Id: 1F1CD258A84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,kernel.org,lunn.ch,iogearbox.net,davemloft.net,google.com,gmail.com,redhat.com,fomichev.me];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 02:21:48PM -0700, Joe Damato wrote:
> Greetings:
> 
> This series extends net/tso to add a data structure and some helpers allowing
> drivers to DMA map headers and packet payloads a single time. The helpers can
> then be used to reference slices of shared mapping for each segment. This
> helps to avoid the cost of repeated DMA mappings, especially on systems which
> use an IOMMU. N per-packet DMA maps are replaced with a single map for the
> entire GSO skb.
> 
> The added helpers are then used in bnxt to add support for software UDP
> Segmentation Offloading (SW USO) for older bnxt devices which do not have
> support for USO in hardware. Since the helpers are generic, other drivers
> can be extended similarly.

Sorry for the noise; just realized this implementation is buggy.

Will fix and send an RFC v2, but this series is the general idea of what I'll be
posting, for anyone interested.

