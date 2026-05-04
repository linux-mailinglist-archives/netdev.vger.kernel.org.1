Return-Path: <netdev+bounces-284039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK4KJQII+Wnx4QIAu9opvQ
	(envelope-from <netdev+bounces-284039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:56:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8254C3CC0
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E1F302ED58
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2DB3264FF;
	Mon,  4 May 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8I0RQIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97737328B77
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928166; cv=none; b=kKHjSBOXSzIVcOW/qKMyehFQzV8YoGxkw3fVkg2FXD8ucdYJWqxG7xQGo3f7JJjk8GFqhU7T6u7ajUEs8DIU8i2xrXfdv7cL/2sJSdr8Cm98W3lae4XDL5UKU5fTTFM7nstKr8hq97p1t+dir0mPXGhD2TOL67Hqtdhe64O1azY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928166; c=relaxed/simple;
	bh=6b0uhsWOUueBJikO+3RxwH3ywe4vOaHqBvUoJ1iBG10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGTONmj8JHrF1GtfYeukw6WbwNQ1rGbssmF8DOeyrKfCs164oCBQKlDDwygDW3C4zC8Enysj65jWZe6EenkqVvFcP4LlQfTAJ4pFzd0hjwMek6uAy4rstYhKOAf8eQcFpVTWG+WiJnl6z/ldE/vnr5rWGycDP6fLcS9s8HWxdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8I0RQIW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba17c8cfacso15284925ad.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928163; x=1778532963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAEnOAPj5fUgAFUXnOyePT2fFfy+RA0tHhuCu8Z9sp0=;
        b=e8I0RQIWCDwpXPl0zwFKbvPBkUL4uuvj/YzwuEeRwSD1/RzGp6Ds2YnVgBznjkvqXV
         NgS/RiwiwRaZmkSJhvDrZ9wpsz61E3uI8uu6TFxaC27O8HUEWFMldbI27OjpAyJufE61
         sHtQkwdVOz0ieMakt03HswwGvApprhDBUHTxMfhqkrpN14E5ya1ycHM4DvInNz+MaxDg
         PoB18jN7QCmgr4sDXizPHaLnc42NHLHwUJ955HcezumMxiFHnmwh+bAoaSovB9J9/PVl
         PzxgB//5/z4EwNoxQACSPFB2UWcw6K61C78Vx3ebh4F6o0IS9IJGnPFsZhrIQ7ap83RC
         SQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928163; x=1778532963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAEnOAPj5fUgAFUXnOyePT2fFfy+RA0tHhuCu8Z9sp0=;
        b=fsYj6DniYM6/9VKJnlDqwOijoAJGcGKtUwjo9G/P+1ZBzhJccav8UfSsuJTE+I+b2h
         Z6K4/h1CMwmSkKOIIn7OoWNPT42pH2rM9eGnjyGUdyGy2I3xv9BaAtylOCASBCUVfaVg
         UJ84jqzMqlJ7CwrphjYfI1SMhh4zi7EmkxrTJri9ikOxkDG7pBMV8yk+/1RS7Q3z2wHt
         frkbZcgXq7MddsNR0slO5J8dqRg/OMytT1klRBP4WoBBlxeNvnnJ8uNy5HjNl7rkLna8
         sjRLoo/w/zcBYukxTWC/KtaON5a5GSAxUv5gMheun3zxFrCXwd9hq5myHFv1BJNWFCCK
         H+ig==
X-Forwarded-Encrypted: i=1; AFNElJ+hbDnoUEaLL0yDso8nIYmZsuCMLMMN6yfTlOqr/82uy+vFF1OnVwMbdeYvbC3zyAA+uB9+5WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxchLcyjldaT3FYM7URav8eFANnxcpzOkUkfdsqyJltuvlx71t
	r9wHJU8eXCCWb32Wf1a8v9OBSAFlyUU6bTq+S0zxk+xVYIBj5dDCm0y0qItz/ROPlg==
X-Gm-Gg: AeBDiespz420mIlPq5e2pqUNkurDzwDJOppDr+v1LwhWBiUWMkId+QxdWZuTduV29Pn
	Fr2+zP4e8gIsCt9ins0PCZvE52iRuFp7K/oDPWkiWwP4G5RZqx133PkYYlLk9iumwV7lAqHVjSZ
	B7/A5/QKIVYEYIQM5cQ5qLRo6k8wNabtb5PvEFsXXPT6k/+Eo72qjlIyb03HObkVbnjvLljif5o
	nKV/Y87bTMViwEWENhSKbR4ODJAnG8qtSNh5Lujm18D2t28RFWuLkJpGt9tA3+GlQTcuzSuh29c
	wfXDnHe5Of+xpiwDlUaLeaAxNGY+QpLDpJCr7TU7D8PkFB93c2VUrdxl+R27ITV42rujKEox8NT
	+KGfeTnrQsZaHjw7SW8dd/b9rYv9z3zBLnw8yR9evKPtYqxdIFiU5WHGI0XGr0Xm0CzY9BzbUD2
	F4ehPoCDinw/iRttq0als/CRd7cwxAooS1fOycwVOESOKAVIDgNAWIZbcURSKtmWLy6s+D1Egni
	tHDhw==
X-Received: by 2002:a17:902:f64a:b0:2b4:5a2e:98d9 with SMTP id d9443c01a7336-2ba53896e5bmr1405745ad.37.1777928162684;
        Mon, 04 May 2026 13:56:02 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm116816715ad.12.2026.05.04.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:56:02 -0700 (PDT)
Date: Mon, 4 May 2026 20:55:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
Message-ID: <afkH3pMJKkIbElhI@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: EC8254C3CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will
> need ~18MB for firmware pages. Existing drivers leave region_size as
> 0 and get the current default of SZ_2M.

I would like to get rid of the magic SZ_2M to make it easier for other
tests to use the driver framework. Can you make this commit update all
the drivers to set region_size? They can all use the same approach:

  struct vfio_pci_driver_ops foo_driver = {
          ...
          .region_size = roundup_pow_of_two(sizeof(struct foo)),
          ...
  };

