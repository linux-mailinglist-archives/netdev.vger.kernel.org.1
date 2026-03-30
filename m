Return-Path: <netdev+bounces-273277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH3hMBavymnU/AUAu9opvQ
	(envelope-from <netdev+bounces-273277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:12:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FED335F358
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF923010D8E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F16392C2C;
	Mon, 30 Mar 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="VUhutQc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595638F22A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890771; cv=none; b=ud8E4D/Vi5qb5jn5O2tCRiQnHI98DjpGddvNrQ1tK36DXI6nTy1T2ozi/6kzN2X+EDLVGo5VDNxnCwQ++u7Gl3S2vaunHjEMgBgo62Ma9F6ZP2KsKuqC3FP8NJjqCl97irVDYhJMLCF/A9T80HRbnxwHsCd4auyC/eT5h+H6p+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890771; c=relaxed/simple;
	bh=PIY9xH2oKPJQ72QQcbMs2m4+d5XArppmCogZsGBe+JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHE2tH2IlZ9nS59aOOU0Pu7VRlCgQhpR3b6SwuP34GBKYo3DxR6Sd8qV9J3QbDuzY91ajHC6O1fbSrP/wpZC64ovCTlZ6G/GPGencbz0eQRTuUe+9oWoJEJy2aHluwCuYxDOmReUPWyCrxkfOx62I/vULi2mfjv8ufYk+p0uvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=VUhutQc5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8fba3f769so19220945ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774890770; x=1775495570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VDmlMStvbXfu9k3E4qng1pJWO1J0B0+NL3nwdJBDvw=;
        b=VUhutQc5Y0F9rTkzDV79Kpb9sFSBSu2W4jd2XHfVkrHPRqttEhRKjxMX/wJCbZnkJF
         cg9ekJw+O1c8UgGANU5T6j7bLtn/cmYTjZrQTMchSC9HEk00FCKc9/XJ8G1gCNt4Dl0f
         elyq5E8lEO8R/1r+TBatRy5yWfcd/7ZMoA3/oMHNj2pMalDpiqBRmMFlgqJi8fEdbW+3
         ibp3En6dN0GNc/S4wQg3Soh5M0WqPyV72SL4CazTxQKRNwG4c4n1TvS23G+F1FNPlr6V
         2uVqxu6jIsuXuU3jBsXscZdXkNT2ODFF1FtB+sAWc0P5dwnF29e40bK3qNa5Tzv2GT9F
         P8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890770; x=1775495570;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VDmlMStvbXfu9k3E4qng1pJWO1J0B0+NL3nwdJBDvw=;
        b=CxHZJiMgrTdj0oP2FortRPJRdpQeftehAVqQeXKpcxdF+7Osc49if2H6I5VGHvYQIP
         4PsD9ftKXIQG4inwr6hxhEdN8KY/QCS6yQqPfoTeOKGL4W3Pw9KkoIpVnVT+zins05NL
         EU0EZr9RXjRNngBAtu8yHxJjxUQpDFAyec0jXTqf0QwqRHqcBA7gq7wlI19GESN5eDSl
         EHFh+uJkine7tQwvytcku1oybWDeT7A4MGnJls7aIXDDBsuROC3BCEHtk2Z5x0dGJcV5
         uJCvdz5yiCHCm6bJz2ATmUlxCCja6KQSrL4fuHL6PxW8IfqwahVfQstolVPYNMvX9q3Z
         YNBw==
X-Gm-Message-State: AOJu0YxLDGGKcDgnF8KJBAo0K2PNFcv7nPTsEfbD77+UAyleU8Kp2fs4
	iIyob7QB5WhENcMvDPtbEBHbShMD1bSLPU8WMcRVIAb9DrT3ZbjXVC8HUfv6kL3XJE0=
X-Gm-Gg: ATEYQzyC8kmpvxPmmo0Y1qYaC2KtL9NwD4SVN8ySVGTfSGT+hpDlzodrKXOmr14aL/P
	P4D9GuWqt+Ud04WEY3MPwsS8FEn+2HY+wBnMN/wYmy2aRjyemgd3Tb1ZKbKu6tyox6r8M7n6JP1
	eDH7i1xMdwoD2fIhiGcngOmdSIWrzxO+md18vHsNPsVOXW9hWYgxOVHBhu75Zu6OtutxrV5LWEd
	GJbfR6P/vF4/8ePN01q6CZlX50NCj509mB3KaFdZ3PSPqUHamrhIShNbg4OFhBjptzV3vt33UKN
	37Dm2f3zKJTG0VdmiUueSqnBR2yVjnL6om/NGc6hJ6O2JldsHkIE9DO4B1Y2JeVOEQL47kEByhq
	tQ6oi5NE+YKOJos3/dPXtrOeeavFHRJOorRFkBvztfcrT0LusRJ0u0poFhpFbbzsT3wf8h0Jw5N
	hU1bux
X-Received: by 2002:a17:902:c943:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b0cdc033f9mr138875915ad.1.1774890769696;
        Mon, 30 Mar 2026 10:12:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642913sm84485635ad.10.2026.03.30.10.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:12:49 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:12:48 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org
Subject: Re: [net-next v6 11/12] net: netdevsim: Add support for SW USO
Message-ID: <acqvEDoJiiyW+rqI@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-12-joe@dama.to>
 <20260329152640.00d52107@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329152640.00d52107@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273277-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1FED335F358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:26:40PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:30 -0700 Joe Damato wrote:
> > Add support for UDP Segmentation Offloading in software (SW USO). This
> > is helpful for testing when real hardware is not available. A test which
> > uses this codepath will be added in a following commit.
> 
> Not sure we need to carry this in the tree.
> We have a bnxt device in NIPA, the code will be exercised.

OK, I will drop this in the v7. I didn't realize NIPA had a bnxt, but that
makes sense.

