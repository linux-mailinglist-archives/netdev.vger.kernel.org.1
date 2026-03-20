Return-Path: <netdev+bounces-270100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMF0HWfSvWm8CQMAu9opvQ
	(envelope-from <netdev+bounces-270100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:04:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46F2E2317
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36878302F268
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846113876DD;
	Fri, 20 Mar 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="qJ7th6M0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87F3806A7
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047775; cv=none; b=D8xibzHOrOXZJB+RKvo8uDUp8g/hESKoQIUFmQxampZXRj1uKo4zl/bcJVc0i+koWSYIK8pFOr1FKXAXWUnVFeZOB5O3nQ1CyyfSPautLn+s8B8MTb1iA5gWxYdkzXjwi+XOKjVaYQqFMJM/Urcg3aQVjwvpAMcV/c6IQtc6CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047775; c=relaxed/simple;
	bh=uxsTfuBSWa1Vl1muYsJ8MHd32Ql9tjwtC8tJuO+juZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUp4Sg50v/NUuNfaI7S74tpylAN9/Y7JAE9lrF4fvPj+/+OMS85Rd5UE6RL+bslxk8afbXIX2l4tOXsC3KxawMcYXnyjFwdkk4uz2COumz5jXwsVxk85dJulKF1lAXeI69oGyZmossUQFFucoN1snK5fhmkN1juRuZ36XSwValc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=qJ7th6M0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaed195901so9615795ad.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047774; x=1774652574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfVUvPePCGYdSR1UQEMU0gOzquorWn/jMrt5yfApwXo=;
        b=qJ7th6M079uD1uFRFuwWwNN231TMx0J445mkdPKHk19NLXgB5u0UuMzVZK/1JeRNpc
         DgoFH9YRq2j3VWDSmKHrtQEr0ENGQhz4YHdety35vv0ipuh8yzEouAhjKemFLKS3t9z+
         YEkPVPbwb3tSGVqRtb67kpjK7G0oTBJYXRy/zG6wnGpEHgt8WZk0SAdN0MVcvSDjEoH4
         JsAu2m0Ccnpwb7eTrMZym79wtqR5oEEyOZFXHqc+ON/D+M3tQ0hRo8MEGqzpBsmStkZ4
         JnWJ1F7ftS2VtvWg+ZAkip6Oi9PXdlfrDeC0Fgn8dInys5/abyXmpsMDkAgLe2vTIDnR
         vAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047774; x=1774652574;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfVUvPePCGYdSR1UQEMU0gOzquorWn/jMrt5yfApwXo=;
        b=M9RcZXvVmAEGK/tIp0IsGp8y9R14gdcetxqBamkCF287TIWPEBL0Vk0Ic4/VEOmPsZ
         pPrypw2pcnV23gd0+AfPDmsJsb4p7Z/P7BwLCtXlW3qKNmhgHxUJMMzEQnvAz35Yroip
         SbOHC3Y8qShLnHlLzp1AdfUvCbu4o1Ls/bPXfgJ3QnuuHocg4e3CTYLiZyFqmkbSGVc2
         CxO3kYs1/vbhfP0DMA4NAz/swcpi2qvV6l+Qmd24tg69bfdDF/jEwjCwB7XPRPeeXqa5
         viO/4yXy9d2cZm3kNxk4perhELYu6D9eVIs+JVORWiN+eEaa1omrI5do5cupDVWqoPo4
         klhw==
X-Forwarded-Encrypted: i=1; AJvYcCXKx5KvoLsC+xd6jnAQPF+Pr0G6gdaeddDZnUgqOIEnrcBaLeChtyzJ/L2j1G8GD32FnmY3DoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx178VvcuTRLV0TRqvEHgyauGFpUADUOUfmCCfrcILqd4uet+wa
	HABzYEc3Ap/2zSyTxJGyJfpK27TYFOS36VzftKdCghBz4a+WoRzjNNu2LJROl0+ZveY=
X-Gm-Gg: ATEYQzwaggm8Afvx48Os/WDzhmwqiOZSGr3sB1uyCGSroG0Kpjx8MF03Z0HmkqGYdgR
	ZC1Tw4z2T+KQ+tJ1qhip78vrXhCQsUk74LY1IXK8Xb0tQPAAJX+acf5Z61vR1mTEADAy/1DeAUA
	NCmxbGFvbR/30rbTXrMcAeC4aQsrJtRAC+JRP/U6DCfIi305cg2AzXrw/sKF/BQyHnB+AavaD+b
	ij3qU5vgn8LaqjPsPZfqxypF1GtSr6G+vADGL6/SeBvuLys20/KuSoZ8/53Ztf10u0RaBilj1X3
	3T9aZghDDjuy2U0vPM0sPVFhnaZOKQfGP3ps54xnxjV+RUAwrRbB1yzXD5MNACMZZe7NcipRQqX
	tmsfObokYXELz61JiDvmnVkqnwlfKlbvMcEjrlhbr0JBdbyU2ikTV93do0DknqeiLBx72Y7VbQZ
	SmnXZw
X-Received: by 2002:a17:903:1aa4:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b08277cbedmr47601865ad.30.1774047773841;
        Fri, 20 Mar 2026 16:02:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365a668sm44639105ad.40.2026.03.20.16.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:02:53 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:02:52 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5e: RX, Pre-calculate pad value in
 MPWQE
Message-ID: <ab3SHAtAbfk37dcO@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
 <20260319074338.24265-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319074338.24265-3-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: CE46F2E2317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:43:37AM +0200, Tariq Toukan wrote:
> Introduce a dedicated function that calculates the needed entries
> padding in a UMR WQE.
> Use it to pre-calculate the padding value and save it on the RQ struct.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |  1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++------
>  3 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

