Return-Path: <netdev+bounces-303319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j1o7NiIJRGo2ngoAu9opvQ
	(envelope-from <netdev+bounces-303319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A36E7293
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="CRUcd/lH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303319-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303319-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B7743050BFE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC844B663;
	Tue, 30 Jun 2026 18:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431823E123C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843668; cv=none; b=XrV0eXBt62CG3mj8TAPmwHaKFiQBGbWOJRQdspknSHNvPmtKwmSNgb65SyOnuVljEJf8Xff7r5N4PcNMYrkQX2uYVbK2Kx/0wG9HjIMOEaUeLtuBtYD4kMuNWzkSlwp2Xv4avsLepdvJjm9r3ij61zAk7uJpoAXZCy9T0KGdB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843668; c=relaxed/simple;
	bh=g43NaWyhe1XuAPy4jqKeoCd531sV5r17tjhHt+p3rjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMllZIDa+A8jBcbaGdyRWGSF9I11tzOoYEC5ygmpc6QBDYBQTG8CyQL+fYJffHcH/RsZ9CxPvDVFAoL1C0cvhMSOay5BGSOR0JfQygj3WqrP6TGuJqOG5YTzrFU1wiAnIr0+5SeyhRurQpJI6wDPCKuQAdGT/X11gRHKYL996o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRUcd/lH; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-84780c95e2eso1727728b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843666; x=1783448466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFxEXyhb9tJmWz/i7QeGFdi/A69GIy+FQV1JP5U8zsc=;
        b=CRUcd/lHrDDmexhaKmwcwmoiXu+yiyRriJVR+aKDo4YfXp+kUOJ3mqPqdcAS0yVHAa
         JHnTJGe2Pdvd5qE6u8WFew524giql5NxXCZnPvjS/PwqFt2VKZdXyGZEUpP9EzwNmRsr
         hwcAzTRVmfu99MreLsO2D/MIn/Ts1Y/Ls7W8Q5q73EjVpKKlCD0LBjniJFai6wSKjGYa
         RXblHQU5ciL0RGMKlXdoWzsbXHrHtg3OqQW13VY0gI4Yd4r2YGmAUKYEpvJoWPORQLnK
         c3LYw5ReaBVTUCPXOitag1vsZkqCACANIo2FGmSUe8xCSncm29HILyOg33VpsyoWBC1l
         k4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843666; x=1783448466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFxEXyhb9tJmWz/i7QeGFdi/A69GIy+FQV1JP5U8zsc=;
        b=Bt7ZEIK3MKblDLfWx7aENPCcJ8xloaSPkmTWVRlHVC95MsOl7SO5GuWp37uZ2vV+y4
         zfoZ614MBMdU7y/SuKe2ltu2UGvCPRY4/5E7cQR3/OzAXCYpZp2sSfRFhkb0RxDjwANX
         e2RDPsveqT1VJqa9bW3POl0PN5AkjDqfdzWHxoDm2ZUs2+Or1eVZ66IgynLdMUIBnD1m
         RfP1uruiNChHnt6MMGNsAxxGc0RsdFfqlxnBm3wbAq1lZdqG+NnHSWJ8tww4e0CrkWs0
         POhpLrGClF+zN1cf3c+xkti5sWT2PzvbnruUTuM8aPltZAm3iq6+XsTNd++TPUT9VJTq
         gLRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1GuWou3aSZaYXBSLiiTF5l1edZGt2G1uXa4Xgl15qXu4HusWgvV8pHm795hVRF74xgT5o/bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaX6UC2bIg7vTQ1F/yOxO3ZUz+v5CoHX5rwrGYZUR++dyaSxN
	Mag1dbQoRmSj5CzRZb+d5Nz9Jv7yqmQgdTOnBOpfxLUdIQoz25fs8QdB
X-Gm-Gg: AfdE7ck3Q545AQQT7+mx+hjLSSjefZKGkuZ+a+dRJs7xYEajshOBZKQJ7WbyCt0uHuq
	JdhKyO5G/zfTKPxAvizd0lXQko16+Y8FpAJuw775JwZhOpML2focdKwGyOemdrf0Sx1gGFFDfb5
	od7dQh0JMoEKOma3T/SLHWNU3f/fzwHSgdiiRLmj9tGfU3IwbtYn1Hh7pWlB6xRXCqQbmw+S3Mt
	gBbHJLT9Uy9bhzCzgxxtxtFabvnPxC7Y+1n5HVbH7mcm52zzR6AEOmYGjRuGqTXqVK5QTOImQZz
	QKmZ7fOE5QmartY8XUJ5QCesz9QQs5zz0H5Mi83nLg/Clr/KWUiqeqs7INpniuWo3MGrSaJYcIn
	NJTvfmSPPoTYKHw1DIP3/47wm9zeCsjmJtf0Dc3gkZbCueCYKj9v9eGOi84AA0MvCYgkjz7CPFt
	z+nJqleA==
X-Received: by 2002:a05:6a00:190c:b0:847:94bb:30db with SMTP id d2e1a72fcca58-8479f26f662mr3744838b3a.49.1782843666539;
        Tue, 30 Jun 2026 11:21:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03b9ffasm2523447b3a.59.2026.06.30.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:06 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:20:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/4] udp: convert udp_lib_getsockopt to
 sockopt_t
Message-ID: <akQI2pqFqSLztw35@devvm7509.cco0.facebook.com>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-2-193335f3d4d1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630-getsockopt_phase2-v2-2-193335f3d4d1@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303319-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 777A36E7293

On 06/30, Breno Leitao wrote:
> In preparation for converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, switch udp_lib_getsockopt() to take a sockopt_t.
> 
> The thin udp_getsockopt()/udpv6_getsockopt() wrappers keep their __user
> signature for now: they build a user-backed sockopt_t with
> sockopt_init_user(), call the helper, and write the returned length back
> to optlen. The helper uses copy_to_iter() instead of copy_to_user().
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

