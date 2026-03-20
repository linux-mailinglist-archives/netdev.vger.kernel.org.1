Return-Path: <netdev+bounces-270102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBnuBivTvWlcCgMAu9opvQ
	(envelope-from <netdev+bounces-270102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:07:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69ED2E237B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1969930405D1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2539099E;
	Fri, 20 Mar 2026 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="QJDVKa8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CF378D63
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048039; cv=none; b=Z7TJWqnun2zmaMxt4bq3n8tpgW3TKq37NY8OOnQD/tSMYP0q154pqMgBPBxFMdEFXVGUWP7IWhFi3ZkKdO+TAkUr7nKl8ITkNFt24ViI9wZoDNsfbm77OiROOgnGmwHFU8z1S2XvBzc05FptWtCHNdzTZE7lXC3dVohCzoTAEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048039; c=relaxed/simple;
	bh=vhh5f8BqOR3BFunaitjCFZrf/5fr92Up0kE/ShR83xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxWa3Pro21XD64OfVLcwt9xVJwGPse/kBaqxfReqmSHdZBGbczmZA3BdqaL9VaHPAj0QaXzBEg1AsfdvK/bojVMTsSlNL3OJf38IzXnac9rTVUWV/LYT3yg6utuTC1ITx9yFEssT7LGh3TLbVidSzDMSuYmos1KBYVDEyU5w8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=QJDVKa8I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a62714fe6so1212164b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774048036; x=1774652836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugrzy8U5XE3BV62lT1DuXlpfaQDw7/+LVR9/vo3V/dM=;
        b=QJDVKa8I1lMY07t7Jx3QthrguGLUvXakud5129meyXJSqHVqjGL8nfvnHrJdIxywAS
         WuJqakLpIsnHQAN8obxIyYCukQ4kxbr+Bu3/V3yq6N0FXvaW7ixfAPzv5kPmJazqNH2T
         CEopalODfpWYeBmHFZB+bFpVidMaCyaA2fTgHp7lWDUwtUvNsR0sxKdv8CS/p/AjtN2U
         sxSKAPLMeHwQb9o4yML30AR64l0up+ejJDu3MbFV2Ma98K9vMUrQDQRxlIEkUTmg+5So
         pJrgYzOoLkgmuPlvFXIKFiEid6VA7ufevHO3Kz7c46rE02YzCyb041O4SCM/UmPSAnZe
         gnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774048036; x=1774652836;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugrzy8U5XE3BV62lT1DuXlpfaQDw7/+LVR9/vo3V/dM=;
        b=SeZwQ0muedr/jfqbZY9ZSqCsvwKEGlXUEMvdVCanM5Yo9salP40+cI0dbZyOFAIEOK
         rsvc4MgR3mSyaiE4IlLevXXtyaf4Ke25kg1ITHC7/IIHkYkGngL7beN8+N9Jtos3x5FJ
         m00viX9Zs0X2+Ad+OshtjuN3v10BspQuT7HLrcqTf9HWM6CADBmJSLkYD0ROzaGAssA3
         fUEhoUYSrG5ZquXdfKvjx67jathebcA6UAMe3YYMAoNykVzZ2ulPDKetFIa20VRyca5d
         0fJqodi1sH+BfjvUjZmP9Tg2Wq5DEIJgNetSfytnDuhrddVHN85l7PDYPpRnAXhHbBhO
         AbUg==
X-Forwarded-Encrypted: i=1; AJvYcCX8KxOsRpnTxG2mwxpB/dVrPX5c6404Y7Mdo3Rmin5d4svRm+O2A6OxA5w6ifdcCaUpbyzZ3to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEmtyq1aTEJnImSZEOZDGa1oJk8uEy7HwixE8+f352QRnH6Q8
	10wSyila+975ZaG89+cBSLWdWes2VQGYfLAXmExDl8WH3Euyl1RU0S3Xsq7ppghPJRc=
X-Gm-Gg: ATEYQzxkCK3D46/0vnTELE8SxcCtsqkEupwqIQqpqG5fr5GxNh5Byn4AbLKffryJBK/
	wzcPJuuOJ0L+szMt4tcFJaz7jCUI2B4gujxhFEyU1lt6XqMwKQLS4RPKSoQ4XM+YeWGBFq94dzC
	ttqS02zAmxUnQAS1RJvG9sXnv3mDgocEUkfaYSCV1Yd/4zUeyXET+eba0hlLPWM+cCA9sGqEe47
	6C3ktJT+J3H8xWiI0eH6yK+6HH9j8nhXUT/2hwf3NUzyyF9MOWWGjrvLjfXMq+T0Ry9FFUfuenn
	BLzbgZkshfWH0cvjE1Ny7ziBLhhnAd5bt27RYuWWex/ew0UoKemnb69iA3fN9mwdI75o45Jf+8+
	P5wpakyCQlww67DtaWTjIgQ/+cwRawCPCel2LA6yJquYdv7OM5puQKvzbBKZcWjolvDZ9wdm38m
	mi6SI=
X-Received: by 2002:a05:6a00:4197:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82a7a7e5f12mr6357881b3a.7.1774048036628;
        Fri, 20 Mar 2026 16:07:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa79c6sm3145726b3a.10.2026.03.20.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:07:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:07:15 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/2] net/mlx5: Add vhca_id_type bit to alias
 context
Message-ID: <ab3TI1YgV4Lo6Xfe@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
 <20260319122211.27384-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319122211.27384-3-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: C69ED2E237B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:22:11PM +0200, Tariq Toukan wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Add vhca_id_type bit to alias context which allows indicating the
> vhca_id_type to be passed at vhca_id_to_be_accessed, which can be either
> HW or SW, note that SW_VHCA_ID must be used to allow alias to work
> properly after migration.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  include/linux/mlx5/mlx5_ifc.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

