Return-Path: <netdev+bounces-261954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJgtBMvvoWnYxQQAu9opvQ
	(envelope-from <netdev+bounces-261954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:26:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 330441BCC05
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30FBE306467E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055A44A730;
	Fri, 27 Feb 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="mWU/cJrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6044CAC9
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220279; cv=none; b=un7/WnQOkc1ABCdD2ZBPGvU7eDHMrzZK9KYzHthzxj0k4bkcgEL5jmH2IGw+R/s6zm0wFeLeifXBbngxmQMfUl1ia4PBNZG0TEwqZbM5uHVQiu+tc9ZVnAMsM+lMcvZC/bgxbNR9A1ENzF5Zsko6aiBqeXz1v7RLwYvb8fD/3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220279; c=relaxed/simple;
	bh=tDoyG/PSSWdnKA6SviTsfOsD+L2zmDUAdsBbNauNTDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM5tYtmzNuulUW6wAtx5g0RYAZfBY3eueug4AKIG5pDe9yxDBCp5SwdlqbW380yo023CxCQv86+5YR42pHzbiOQjPJC0UuYX9pIamtf4BwbYBdrBVdVpNPlx5PJzve4OV3I4SqvfNdtet70sZUzVbSoNG66MFNa5JNyTqgWre48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=mWU/cJrF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaed195901so12476985ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772220277; x=1772825077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpCatXqi4kcl9dcw4n5ni49yJV5nue62Ax4bi/+HNLg=;
        b=mWU/cJrF7Hv6XBXB0HVsqXvU5OSVD01UsnQXoXK8l0FD+ymeXYCaz0enSdWV9o6a6d
         wBkP7BsiQIQ43G1u2Uumz6WdymhGSZpj4s25KUoeomceAusiT735Kc+XmOWnSOm7BoMl
         z9zB3P0fVuTkjaM852025uvn0wgsql9BRlK2qCVGhkJ93P6fj2TdmJwq7cMhkDtAA9D5
         a7iSFzNa5sef6Xo9zL/0mESQ00jFS1s8zPgoyMw++hqhiNEGDxpYXoMFeUFbWhTQmTUs
         zSKMo8XXOSAVDQhphoX04iCuizRJEo8lpnx6YC4Bsj1ltZHqZpYDbdkDleUBq37kQbKU
         5YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220277; x=1772825077;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpCatXqi4kcl9dcw4n5ni49yJV5nue62Ax4bi/+HNLg=;
        b=DDC00pbPQk0xzSCYvoXrDVMXV8xnqmw/uxKznDEKBaEJ/iKLCWrTWbheHk8XImkHx8
         jFLohuZlj5enR0efckpKfv8BGaBYRmDFvqF00KiABuxvbI48v2dAKKFprQTWcY2a/Z5E
         rrRlVy0sy23n33ard4UGRZrtLw3mRCo9uauyJwmcN7qbisPJ0HLRKQXA4KS5oqdBPH4b
         FXQee0kDrT+7k3BURg98HQNco1Wo9E+rLAdeGtw5djGsD229l7iSCGwRiy64S6r+ecp3
         7CP23XSoaJbW2Nr6uQqwLJ5WYRLSNDJKJ1keIldSZg3q73pYql1p3jiT9K/P9wLopBDC
         ch0Q==
X-Gm-Message-State: AOJu0YxZz9tEbtw1qEMrJSqMH291m+uUE887GmpKEL5nXhW2XQ8jY53b
	UPCpolIL3CKgwWZP25Zy7L5IGq5nPi/TfPu1e3uqBb884ZycmtpL+ZKz0HlPGkk0xDU=
X-Gm-Gg: ATEYQzzQ1vD6G8Rgjg132fAbbjhtbu5ieLzuEy4MSGa7AQifERtczKkSgWlfKYp5Wyc
	5U1fJSxvjgbhCdh3UuslJdqPZ4W+TjOt/CbhptU6s/QR0OatXX8ng3uoND04fCKWXnpsv8xlwQp
	7Hiyw9oQpJJ/EL72h6SUC4nWxGMdQw6ICRblDLHUowlemq/x3zcclM909H3v47DS579YZqUYR8G
	428yj41B1owcmA2OosRNFSdLiM+0u8EeEMf8DgLGRYgrdxA9vgnV+Gp2F84VnLWeX2hHQ2sZEJw
	AV+M0p0iaXYTdUivgklVCRSByuUx3q5VHI3Qcaf31BreyD3IbSqO4sSBbJMCSghCNvehkZQiB/m
	TF+4dmGrcrunTNEqLM8CXHulzZY8CbOa7ft6phc+2hLVLSD+osSXq2BZpYHFIRCU+AaGDyqXNzN
	aViZU=
X-Received: by 2002:a17:902:c950:b0:2ae:1ce5:61a9 with SMTP id d9443c01a7336-2ae2e02ac6fmr37384085ad.0.1772220277503;
        Fri, 27 Feb 2026 11:24:37 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c111asm64520455ad.21.2026.02.27.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:24:35 -0800 (PST)
Date: Fri, 27 Feb 2026 11:24:34 -0800
From: Joe Damato <joe@dama.to>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 3/8] net: ngbe: improve the reset flow
Message-ID: <aaHvchv+ufkoQSNG@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
 <20260227073450.23680-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227073450.23680-4-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261954-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama.to:email,trustnetic.com:email]
X-Rspamd-Queue-Id: 330441BCC05
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:34:45PM +0800, Jiawen Wu wrote:
> Implement wx->do_reset() for ngbe driver, and improve the specific reset
> flow.

It might be better to more verbosely describe how the reset flow is improved,
to make it is easier for reviewers?
 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 49 +++++++++++++++++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
>  3 files changed, 47 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

