Return-Path: <netdev+bounces-275695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMB/Ldz302k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2BD3A612D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93753302731C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D6390CB4;
	Mon,  6 Apr 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="CMEK/drn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA438F644
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499189; cv=none; b=p3dIX5g2PZb5SDT2XeoGP/WUn2wPjNYXYJW7mDDfKz9w8zCRkPNYLw5dk+5jssPIry8Kf1lI2nkVy098WOCWmOBDhgjTmN99Nr2XK1IAM/xs0hbGFAYANgRf5Vr55/lAyDHtVX8frqAnIEzIU/4mH8Ymc6cFfeDAqWZk3l5i1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499189; c=relaxed/simple;
	bh=mh0P+CfIYcSWxvr+OZtwfPYCJZ8um2WFI0KNtWOXvuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jekxMAO4UpwwPsoThhT1zQxP5jHmRRUBRXkLKT+f6lvlHH3QUotBcGkWb7toNmpHF+ZU7h+AfzuQ6rKv3Ud9KCWYPomeRnVBZ0x990AbIDtreRY7hlc8i4QAR9DAwRSz+49OkdHpTbharuZoy1rCSUY5SF+aXj/aPbWP8G1/dZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=CMEK/drn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad617d5b80so22148755ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775499188; x=1776103988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8ZAtLts4Kkdxrcnk7BLwL8oQAvPTMmoXke4bourEg4=;
        b=CMEK/drnYR1d11IAIF/yHrUt6cUbMGRmdufgSWaApHOxOskdIftUFMzmVaOJVYbhhh
         7j8YzL/+pcqTauvsR7bxJQpluMxoiIJZIzcTQZpkdLew6AuHZ4QjQXnph2BtQF1z89sO
         cTjYa/RomdQFnZzV85jeNmkxnPeYRUGl6NlMHBVF75HqBWdkrRR4D5vCKYNNCBWacm0u
         2MyntP0ft7GIuuvBrNA3KnP8HnTKGUR74UtTb5JBXx+i/aW8ll18H552onb8UNzE7GAH
         5v7o03H/Sdba2v+kzhWL4GyjLoPnn0V2hJx9iQL3aQSC4fxXKpI+466z7M+lJCX6tQQj
         gj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499188; x=1776103988;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8ZAtLts4Kkdxrcnk7BLwL8oQAvPTMmoXke4bourEg4=;
        b=qMJedzcONJzEgSdFa5N33xFPDZr03b3SIAWrJcJsUxjChGFgLqQT69DZAm+aIbSh9r
         RMbKRSto0VzmXGrJGKIh/hLHvs4Xntkrq6H7hFmE2zzxMm/VFL6z07lTCNOm5+XoQPcY
         OkNscnm5RrxzReqB3wtw1opDOemunkfQqTYzgb4fiGm/5Z5DpO0oPoLfBkrpPNqAtAPp
         VNY3ftmR9TM+9ZMEVEVsJFhjNQ6ThIZ/djq8+rGsVZUjQ+wD/cxFhb1zbUkye1SktVHv
         CJKwkvcVGjNclPIMWC7QeoMlIyzlQ69BXA/JLnJwE0GPdbjXw2oxrDSEEQmBnjM05Eq1
         OfJw==
X-Forwarded-Encrypted: i=1; AJvYcCXrAjqNZzPdGMGXyhe2CwFnFSh3q+tMH/RFBLyHmaeGXQlmim98M/mf8PKuS51GOc9vXdDCUCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdlb96J8qU7xsB9OmaMPwISaKC9gBCd+sIp/zppVlpjFxK0+5K
	pTEAPHLHcZBHqtf4HG2+ZgDBUVpqn14FqCA8YD5KUYHmzomk/KI5/pCg/isCYImg+bo=
X-Gm-Gg: AeBDieuUTvysbUwE3jztn5N4C7oVJolQc66YM3K5KA1+qjSzo9PFgkUcKel9Eir/osI
	xY0rlOkKhtnmuy0f1ope7Ln/a2bGSQWHMDNnp1FWAZGVq9qfCxcl+cuHeS0cMZS33JNq67eaXzy
	aomiqPveGn1cox8M7ln/Z5XAGdaTrt8eJINtXISoO2LtdGhd/50UFnjyxzXn1X5DBRxqJEG4M7W
	ufEGl5i8rYm9iuWqyJ9fHivutrsOtAbjTVdOrw9ZZFfx2Lbd7hBaEYe6Co9pURpBSc2yUGIEazv
	y2g6RM0UCGz+1cEyoVWafGUAR0bh3G8hAtdK/rwDyv3A+HU1aftfkcNrEU6u2gHs+9lvChPkyWm
	1iIDAUh2H8vimMgZp48d7Dn5QDXXBxCR5+/3ZJmOi3mINTUK9Yy9rQS5ul9pZ0zvqSLcScw6tkT
	qH9ksXb9PxpYmGKEY=
X-Received: by 2002:a17:902:ef08:b0:2b0:a957:304 with SMTP id d9443c01a7336-2b28163b7d3mr154337925ad.6.1775499188033;
        Mon, 06 Apr 2026 11:13:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27479d0fbsm191060195ad.35.2026.04.06.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:13:07 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:13:06 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	leitao@debian.org, shuah@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: adjust to socat changes
Message-ID: <adP3sstIvDb1CKKN@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, leitao@debian.org,
	shuah@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20260404230103.2719103-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404230103.2719103-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,gmail.com,fomichev.me];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,dama.to:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,fomichev.me:email]
X-Rspamd-Queue-Id: 2D2BD3A612D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 04:01:03PM -0700, Jakub Kicinski wrote:
> socat v1.8.1.0 now defaults to shut-null, it sends an extra
> 0-length UDP packet when sender disconnects. This breaks
> our tests which expect the exact packet sequence.
> 
> Add shut-none which was the old default where necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> CC: shuah@kernel.org
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 6 +++---
>  tools/testing/selftests/drivers/net/xdp.py                | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

