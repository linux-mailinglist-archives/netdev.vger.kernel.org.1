Return-Path: <netdev+bounces-275765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHcyDOsz1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298A3A7DE8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1323C303D89B
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDC39F192;
	Mon,  6 Apr 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re9RkG8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35904277029
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514566; cv=none; b=rFrw0fDBCNQAAlQldLJ11XBqcGR6O/d+5tcLYVhFL2cHFQ369AEUgXIjvRE9+s+snU3Dm5ev/JeTaBEYkn+p/UdP+B5PpKk8QKVJ04ROLC3FOZnf+lyYQi742juWhMNIFakRMkgYUp5e/FtxMgWRgOdq2s2DzdXGLmZSCS3KDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514566; c=relaxed/simple;
	bh=oGFj8ZdJ9wAHEhBVAcAYy8yNrlUyoeNEzQAFx2/LqYU=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=Q/YJiQWCKGTgr0g+n4KJZ1ml+XlG9vFTWEFyNaPSf0zxSr/Me78z3jYpNuoJ6sY8LeLfZZbom7e0OlI1RFEw0qg3hbuebx9HX2Q3JWce2Z56t+/crXAYiZUtLErQkNB4VTNGXZalqlamU8gMzMFv1EmtJBBKBXbSZ0odcN3wiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=re9RkG8o; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-47018d3416aso1537343b6e.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514564; x=1776119364; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0j0TpbigOpaEeYahAPvTjYh5IzyirGdfhQejjAlLUR0=;
        b=re9RkG8oGede5q9OT6YDI49uO9LCNYZ15YKgEJjymnD6JmjlPZrJ7o+2BTy1NttjXc
         uDbFBCW0XYHjzMOmQCYr8DJX3eBo4es3Vby+Goz2wVjNpu3N+LKmrYCXOtpY9Gggn2fT
         qTonDJ6OE/6+yVoy60Nu0OKSiCv1MZAjVXAWTWWzGflDJMiggakej/2fXMk8RqwVc2ow
         6RywmnuoEuJVBiT2/xj6M7uZ1QetgjVfg9M05DveW43VAsHalGQpUelIjm6uA9MNssFR
         yEatAIW2AkQ2i/MrKWWCAos2AaDCJZKdU2/kX7P1irg37HWsCusMEOS9ES5jMq+63S4N
         uj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514564; x=1776119364;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j0TpbigOpaEeYahAPvTjYh5IzyirGdfhQejjAlLUR0=;
        b=HRA31vYVTnmywCS8zYQWml6yvvaUfyh8+b8iaenDTNJtJMJtp0XAPUCsrtmzQT1Zu7
         fSILrLSaXiE/KCNja6kZRNXRSZtnlUZZe/6X0pf8B1H6lPnrlL03slf3zFt89O3sA/s0
         MzNJdlha52cMfV4YaOGAT19yHGNd8DnEn4vVsY5d/hdscOg9N/CxGn21k+IBICOOsMlY
         FQrOiHSJSIxL2B6bH6pSV5WUK/CD/xum/FMlMoWj/DSVswcYs+99gRwbZ9TGcpYblDZS
         4yPHv/koyDhSbNgUuhAh0SkCqs7xq/HcsZzF+8JUPJxq2NGDVG5peiYYv0DwqkBriMGg
         y4AQ==
X-Gm-Message-State: AOJu0YzH76BlCKc9dftxbbaVOhzMI0drIe6FY7qUASrHS6+IIpUaAsAL
	0irQcznPKKn0eHeZwTJiBI4oK/IkUVSaN9D8qgyUgpIzfa/gRSaom+RU
X-Gm-Gg: AeBDieuIo2nms0UF0b90ZAVdr/rY+zTU/fuj8PcEoXjBOaB9jqTMism3b9itOLZacip
	PaKEb3wgZllIswyaEsNmnh2dU5qzZiLaRyo0K7Fwn265o36ghfmU6yqMQMUxsJZPncwHREs87c8
	yXpN0a6iVA1vuGyFiATFpCXfkxPfCaB6KGz7AWVEXa4Y0MGB0iK9cvSpRi68S3KE5n6Zouvef0x
	jT6xKi/MLdiVF4L2HtzSHy7DJSHMAPfKrnVSShvwl8E6B2FmCK8bsCTwh12zBwFRXKud03AGztC
	hd1Ej3UVYvuctjUbRDsd9sD18+APhL8KjsEyIICLfgunliQ63bG3gqhytP6h+xK9ZcnINmmt7lF
	vLPwsOJrAN8FITIeGRaPsbqNvZLpErB+oUCYHjudLWT39VoHi9T8WkK4Yq5wBJsNUA6cMSRGYf5
	HunV8BOZHFFyfSH3dAWQ==
X-Received: by 2002:a05:6808:4f64:b0:466:f60b:19d7 with SMTP id 5614622812f47-46ef851bf3amr7701803b6e.1.1775514564196;
        Mon, 06 Apr 2026 15:29:24 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d93167969sm8753572b6e.14.2026.04.06.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:23 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:23 -0700
Message-ID: <16c203b2e5b0546022800e12d8bd7a9d.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
In-Reply-To: <20260403172707.28e71a27@kernel.org>
Subject: Re: [PATCH net-next v5 02/14] net: introduce ndo_set_rx_mode_async
 and netdev_rx_mode_work (61d75e67dcd2)
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275765-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9298A3A7DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu,  2 Apr 2026 15:55:23 -0700 Stanislav Fomichev wrote:
> > +	if (netif_rx_mode_clean(dev))
> > +		dev_put(dev);
> 
> let's toss a netdev_tracker into this reference counting
> but overall the work stealing is looking cleaner than I expected,
> nicely done!

Sure, will do!

