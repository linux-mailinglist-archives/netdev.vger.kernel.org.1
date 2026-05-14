Return-Path: <netdev+bounces-287869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPiUKl+SBWrfYgIAu9opvQ
	(envelope-from <netdev+bounces-287869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E053FA66
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2E173006233
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028D3DFC65;
	Thu, 14 May 2026 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cUMSwEFc"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6010330662;
	Thu, 14 May 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750041; cv=none; b=IHD/apPdqIXjG8zGxgvFZ03C4p0CvmM963fWS9apVgD/HIkQR9gxcuoC2cKiJW7v8/rCJcBQRgPH5VyMYfMX31vz05t6ewYeJUAh38pSLmiPDY+t7yOtuBQAqoInyP3OjRe/VWIyzVmTmE00Pn20M2VruFZC13erOWhnQUf6c/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750041; c=relaxed/simple;
	bh=TnK7LZSciqBFJ/tzLk8Ak/sg9OmTxoanEmHaTcwzyd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4ZrtvhS/sI2ugndrtBxjr9X+MS6Y4gOP8jBJ34Eim1b0HDIJ7kHyWY7sGaxWNDpJBZbmDqcabrh1bIsJPLreEuEEIex6Ouqmw0lXnow3fUgy0PGpLGZ70Tl1jVZiTh+kuBoi7yC1H7fXl6sMthjnA9okgRfo5y9gkqby8f2vmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cUMSwEFc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kh+Dd9aFN9exZFS0jLwZT6VtajU6xJFmor/kWopXSqE=; b=cUMSwEFcZsf0o3zp2TcUUlI8RQ
	Qou6+oB/w/ntCk3wpIbPcjzH0gGrnjBFOO3BVGivSq8EilaaZykaVmJzJwXXGk29/eHfAGq3aoYhO
	1VSqUuRkKm2aesCOrZ99m2FwKgi3oyfkVp7cIGRbErUWO0RNk7dNx96gxWIXKYE44Do2FPiPNtZ1n
	HVoRcwvuL3tC9f6fmlVbwRecEWkHszgXAADPtkOoClS0M/MZx5/NFNUT1OeTQ9b2zBh4RdUtAsqBO
	f12+u4Qh0lBlTsHM9UF0L55V2clXd7MRBfQwjzUQSDN8N/1ob3448rRA4c6RdS2rfc7NKv0N0cyzM
	fkiXdKzA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNS8Y-003pcq-2N;
	Thu, 14 May 2026 09:13:46 +0000
Date: Thu, 14 May 2026 02:13:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v7 01/10] enic: verify firmware supports V2
 SR-IOV at probe time
Message-ID: <agWHnleaodwTcBKr@gmail.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
 <20260513-enic-sriov-v2-admin-channel-v2-v7-1-68b9f4141f4c@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-1-68b9f4141f4c@cisco.com>
X-Debian-User: leitao
X-Rspamd-Queue-Id: AA0E053FA66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287869-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:15:38AM -0700, Satish Kharat wrote:
> During PF probe, query the firmware get-supported-feature interface
> to verify that the running firmware supports V2 SR-IOV. Firmware
> version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
> CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
> feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
> admin knows a firmware upgrade is needed.
> 
> The VIC_FEATURE_SRIOV enum value (4) matches the firmware ABI. A
> placeholder entry (VIC_FEATURE_PTP at position 3) is added to keep
> the enum in sync with firmware's feature numbering.

Should you do something like the following, then?

	enum vic_feature_t {
		VIC_FEATURE_VXLAN,
		VIC_FEATURE_RDMA,
		VIC_FEATURE_VXLAN_PATCH,
		/* slot 3 reserved for firmware VIC_FEATURE_PTP */
		VIC_FEATURE_SRIOV       = 4,
		VIC_FEATURE_MAX,
	};

> +
> +	if (enic->vf_type != ENIC_VF_TYPE_V2)
> +		return;
> +
> +	/* A successful command means firmware recognizes
> +	 * VIC_FEATURE_SRIOV; supported_versions is available
> +	 * for sub-feature versioning in the future.
> +	 */
> +	err = vnic_dev_get_supported_feature_ver(enic->vdev,
> +						 VIC_FEATURE_SRIOV,
> +						 &supported_versions,
> +						 &a1);

In this case supported_versions and a1 are written but never read, does the API
need some refactor ?

