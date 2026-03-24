Return-Path: <netdev+bounces-271221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIx6O5bVwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:19:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06B31AA3A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52676313DE17
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA239DBC0;
	Tue, 24 Mar 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZX/zuI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6038A28F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376010; cv=none; b=aTkb+16SarCtDhO9sNFP1OBvE3CcKasDn9SiHLTFuY8lUJk0uokrYWWGBAtdWEsdCsmgrK0TfBj5SA36GcLWy13a5xJ8luyFtG+OoxpsNPscI2xMta7jX2fnxwQ/cepyHyVVDZ8rI5K7vz3LhZ1VxPdS9145KYTbHf3ibvWnaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376010; c=relaxed/simple;
	bh=QZcNJB1ipbvlJzwc2mSo4w5C22TYRAQkkpmFKA+dYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFXirDvlcePk9hx7TpUnJdYJNlriQ997Vu8UCCUV5xObpmikXCrIEq1LpTB5ZHbOo1wKUdDKmLXCUH2m9521VS2TZRSXa2i4J9NU4yradgNl5BNLRVC0v0FiNgxy12tv+V/rD+cNV+FnR+NitSw6zvigYNKuJCf/7TFDItrHOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZX/zuI7; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128b9b7e3edso9779832c88.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376009; x=1774980809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4KIbqvhidbLdE2zkNvP4L5iPrMq8r7qV66qKB0JP/0=;
        b=RZX/zuI7n2B/ms6ZPA7cXaGVFuHx5NQkCqA+q4tNzFX0foHv9icwAU6QrHOv/1rHLr
         BqOmb0WuFpKcB6pSSLfYUS019BuZGcDupO6UGhRXn5+sG25BlGXJJYiZb0HpWWpC80SH
         8PE2W9u1YMTSdUvjtcMiwurQ33BS3GYN4Iuz5XsGvQ/bWElwF2TSbLjf+u8XBGK11PT0
         g7fRM3eFogeff1ag+phJz72XmlzFeyAVBCVbKfP+dELQsAN2PRoUauWvBSg5SXPUzCvi
         d8f2VFOtBEtRoRlvHhasIyLaR0L0g5GCyzs90EwO/WREDhvicB+aVv4ZBsBSZ5/f6F2t
         rgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376009; x=1774980809;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4KIbqvhidbLdE2zkNvP4L5iPrMq8r7qV66qKB0JP/0=;
        b=fidvKQjyezPpQFsUzqdG0yLSR5dsrgbxQWvD8b5b54ARjpLgK6mcaeJ8tijDiYMfuC
         2LhRGrD4Y7HasAYOZj8P3aVXmQEqr3p7lKx2LqIitBt1eTg6Vjzpf1nnERzFbmxTeMOL
         7uhui8S9ovsjwiW1poIiF6XlqRfMLEtvVFCSJpF4fY5qUunTdIqLNOKk753ZUH2jG4w7
         M8sbP8CWuZPGb6i11F5v0fGbvJ3CRljIsEfy7h8xByn8xwpdgZXY5BWEVoj5VjETorZF
         w37RdnAfOt0OD5SEW0SC8v/FJEfjZTBKURaQpIYBtwfusnfgBPqx6uNwPjwPK2Is6zHA
         z4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe7Q/Mtkg3uhShfSIfzTlDLG4HIFN4zjIBXzlKbRE+mJPFwP0RS8ivY09vfG+byzEiGvWRoFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYHINMrm0hfP8BAj310zSj9CKkyquIWDQQvPKpgsJvv5I98+K
	S556Hgkz0/gj7h6ujWMYJXH5zGSIXSuCw5cwaIjCjMdCqxss5ZExu9U=
X-Gm-Gg: ATEYQzxswot2sbyud7tUXLME55So6uC4tBC84wOdnOFvWq4doOAlRQJ8xDzfm3OcUW8
	+Uo4BaOfypEEKXGkkg3gnWRHPq0fpIqZ+n0cNiR+6FpmbUgoOiGk/U0hTZKqxydSemfddrcgMSE
	oVCupn51kdPNRgF9xfbaUXDTWbQOH/yxXY2JiyLKKBNh0mRtiPfBQk1BH8vzGQPSy+j8T9fp7Q1
	Ds2KxSdzSGTYABKTdVJbATTea7gQPVZw80XVDWkgp46skI2xVDksQp4Xh71WZzLECFMGYmWQDAE
	OfY77E8IxbBuU87HJaFWF2QPs9sb5HGmoEAG7W13QAHkkYtNtOLbR17FbCv6vB23NVvcPkuDEQJ
	zXmt4hgTkqqJ1sujAE2Y7/k6/2iJ88qRtxkR+Wdfrw1IIpBorhTdSvHcAsBUt+R5HBg/Uxo9WrT
	liZ7rRQ5eE++ZCcHE0G+devXNH9RNHg3T2bHwXrFcg+o1+QuRmhMm3CXW7q7BSvm99MP+TEfsZo
	bvRahODxQBKAozlqw==
X-Received: by 2002:a05:7022:526:b0:125:be41:db5b with SMTP id a92af1059eb24-12a96f200f8mr243112c88.42.1774376008513;
        Tue, 24 Mar 2026 11:13:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b35116bsm18984900eec.30.2026.03.24.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:13:27 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:13:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 01/13] net: add address list snapshot and
 reconciliation infrastructure
Message-ID: <acLURpj2nttA6De3@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-2-sdf@fomichev.me>
 <20260323162053.62a148c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323162053.62a148c2@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A06B31AA3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/23, Jakub Kicinski wrote:
> On Thu, 19 Mar 2026 18:24:49 -0700 Stanislav Fomichev wrote:
> > +EXPORT_SYMBOL(__hw_addr_list_snapshot);
> > +EXPORT_SYMBOL(__hw_addr_list_reconcile);
> 
> Why?  For the kunit tests?

Yeah, no good reason, will remove!

