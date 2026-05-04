Return-Path: <netdev+bounces-284070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCX3HI4g+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F34C47A5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3074301B914
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1ED387364;
	Mon,  4 May 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXEFVUOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4B38656C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934475; cv=none; b=sEin81hjPLDUtHshOIWULfZjV1ISaeCLl0/Z3NiaXgvhsWHhI/Dx1HRhZK8BOMSfiT94VvX1mwDkc0vdRypB18KB7E2oJ0ys4Wy+BXSuq3DX9JybpsWg9IZreoH/ZHrziFGrdmpAjsnzEoyEZXKu4hNg4VM0lPrbtXA7pmG4mBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934475; c=relaxed/simple;
	bh=RzOqRkn/R0QNDsfK7K++CoXWWR3SbKNw/NPdyEFB+4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPMGK6MhL0OvcII412CdyF1SHDt9F7hbLSJz0aXPI/aPgy51Fv/0+4rbMz9gaHLlahHvmLLqEXhUIwRwZvX690diOkziwtJHEQVXmnsb3+xybRaiMx6DlWL6rIN05vhPsZrvpK/yGEO2LQWxSb64OWgPKNk6/qCFhFEQcAbVLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXEFVUOR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-358ed696623so2113344a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934473; x=1778539273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BrO7xosGb8uYxA7cSQfYj/uPUPleoSCzn2z5rA8SqU=;
        b=aXEFVUORW+VWRWX9PZ4Dj88eFq/r3Qi8qperJz4m5LEGZ1aPVScvbXQ2Ac1jckISiY
         6JCWu+p+s7UdfbqGa5GuPE3YhmiWfW5S0DurA3EYhgt4S9m+DrwwF3FiiAP0f3eYgU9A
         5yOEg830m3ph2AUyCO9u9nf9ZqyPX+UrKxLPOiSSJ9OZJvnyXabZZOPFiY3rjhmLPw+M
         Rq+bCCUG1m5g1hespIECc86mxR80ghIupUnkGQhjq+OGjsS7OOPcK62JgrPBCZkMMyMz
         o67a6r/hn6qzbhQN9usdHlGxclrTa7VZY3k8bLhcYV8bVFlz2eRKo+VP2CxuDoFLGM7k
         HToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934473; x=1778539273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BrO7xosGb8uYxA7cSQfYj/uPUPleoSCzn2z5rA8SqU=;
        b=kfsKvgB0NcEDzAi057Xcsi6J3VgIf8qFnNL2VZBjOgjwD81c7/1vpb1BjSoybK5zkX
         zx6IVRHwF/bJNKQcLx332rXWkv7ceaCn/YdHb8gqF5oaCAbVVTJItEvirN2sQTGKWUGm
         y7WcIMpZUrZkWYAkR2W816q82ifjTaL2W/BIVLYFXWlSsYpLdxfF9yLmfPtPLlwZb1Yt
         LAFicWRoceAohmEzAY3LOLe1oTJmi7EZwCAJbPE/LnJOptdqaEEJQN49xX3hpZ4foQjR
         pPswcj6bgfVCOrRsVtCZCdIirHMHCYE3Ek5O0qPXZW8QBugPv03EiuKShoVXK/PrFQUh
         wEuA==
X-Forwarded-Encrypted: i=1; AFNElJ8rxiPDWIdsuY/LKYPn5koFe2iLzRappgFyok2W0VzdEQXLCEhJ77KtRSLjkx+OvhfF8XSHPaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uJfekqMiyil3lw4/NB4bfY1nrO0F+TEUVgPt8bQme6mY9mlg
	D/yrtETJ2f+vuY7Z3/jzGOgtketClDIuVcLjJ/JX/gc8+c5oZMEBTYZuezqQQhG2Xg==
X-Gm-Gg: AeBDieu9e0zXUJLR82Gr2u+hN2uk993kT8I85FWDHGZ5bEHUoKrDkK5muYsmlwD/mqJ
	9E7dm9dqX8PJ3DDmloZ24FwZozlq9K8ke+03Rl3BTOihTGDT34pvVFHWSeKA8Y6TP7jvefV0qc9
	zBEiBFXGjXajgc0XPJa3XcA427+sMHHiGLMEBcGS40IIh6NDOLS6kCGUmhVpUuI32hZASBnYrj8
	A6V2emt+0/IuYu/yTMhXePUhZj/rOfNAwXNRdq02FzE2EoyWr/qCmsO2Snhqb7K9oHvnrhAvyth
	gb0TLMWCaaIEnDEFvveORyWLO5V4hpsiXb/8GZbUdjT9MGvEdn99+amLb7SMl9hIGYSnGPmbtHX
	7czJHFV6hRFfVrdOMEb+HGEqc/yclat+uIxVkXbU8lQ2zOaAlMDxGEXI2CdDKvjqeWPDtvRgjwS
	VX9YmUvKcBg2Df5gYClbX2gdWQHKtwcnKqETGbiDEtESmv2PQlw1S95MrtC/DQE9mO2hNtcNcgh
	Vr6cFsqGjH+OSMZ
X-Received: by 2002:a17:902:e547:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2ba535ae6c3mr4752285ad.6.1777934472389;
        Mon, 04 May 2026 15:41:12 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ee38sm111789655ad.16.2026.05.04.15.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:41:11 -0700 (PDT)
Date: Mon, 4 May 2026 22:41:08 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 10/11] vfio: selftests: Add mlx5 driver - data path and
 memcpy ops
Message-ID: <afkghFm9Vo-SfF5c@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: E91F34C47A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:

> @@ -1368,6 +1716,11 @@ static void mlx5st_init(struct vfio_pci_device *device)
>  	mlx5st_alloc_pd(dev);
>  	mlx5st_create_mkey(dev);
>  
> +	mlx5st_setup_datapath(dev);
> +
> +	device->driver.max_memcpy_size = 1 << 20;
> +	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;

What are these limits a function of? e.g. Is the 1MB size a hardware
limit? Can we change SQ_WQE_CNT in the future to increase max count?

I'm interested in this because for Live Update testing we've found it
valuable to keep the device busy for several minutes so that it can do
DMA continuously throughout the Live Update.

> +
>  	dev_dbg(device, "mlx5 driver initialized\n");
>  }

