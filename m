Return-Path: <netdev+bounces-286912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJvVL3aIAmrVtwEAu9opvQ
	(envelope-from <netdev+bounces-286912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5378A518807
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6AAC3033F9D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE728BAB9;
	Tue, 12 May 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eANHHTvv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2823BCEE;
	Tue, 12 May 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550596; cv=none; b=KLCDT7Phj+czUtIK1gTZc8y9aOdCbq9V2MxC8vapgzeA9MTxuQJSi17y6RK/VYE+CMSYBjkh4+r3M/KhErGhkkMNhwlFPK58XPQrOI9vQCgHlS5RNsPav2YW0EwpbmMMWbeIg4S1bAktvltuXfhUeIFT2Bhkf8cgVKLgZKD/00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550596; c=relaxed/simple;
	bh=z4T+iyJAQq2qCH9xfuYbsexsl3+2g1bZUaLUawoeU1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPfVdQ1SeXklnRykYsKBSoC7H+Gyfa5iB3UTPxYjwlVFH/LarYcXh+U0Eq45Zvl74Yvvq8g96UJbETGtO9g0V063/axj5QeGm4L4/dTI9Qfp6/YBtz0CZCwOQz40xMh2b9vVqVs31QLf8xSAkLl5W7t0jngd/IGNJTLdOY9vsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eANHHTvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAC1C2BCB0;
	Tue, 12 May 2026 01:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550596;
	bh=z4T+iyJAQq2qCH9xfuYbsexsl3+2g1bZUaLUawoeU1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eANHHTvv38t9DVhAgtdXNHlIXhT60GGf5+JFSf6iLMN/h1yQ4yNB/VFv1snSeXQn2
	 uM6XMmSYqRvWxsAQIBPFJ7aROXAdmKsu/LcamXCT8SudWoGqdy7fIfJb+Rq3J7ddew
	 LRLf1A6TYR2JQr+DaLoIAm0bNi92UPTep1VSIdl/CA407cx0EfN7hgV9JE7r7q4LjH
	 UpfW0M6h67BugkIvJt552cYRC9OcEegPrmSY+GZlbgYpZbC7Ids6sdPSXK0ca3trwa
	 dzFv6d8tVPu+h1f2xP5Mu2tZHM5rLb7z+ZqIGZ6C0AUdQ3Aqwp3kS7nU1DPAz1Sj1m
	 vqWeeQED5V2hQ==
Date: Mon, 11 May 2026 18:49:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v2 2/7] r8169: add support for multi rx queues
Message-ID: <20260511184955.5926deec@kernel.org>
In-Reply-To: <20260508121802.2010-3-javen_xu@realsil.com.cn>
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
	<20260508121802.2010-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5378A518807
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 20:17:56 +0800 javen wrote:
> +static inline void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
> +					     dma_addr_t mapping)
> +{
> +	desc->addr = cpu_to_le64(mapping);
> +}

please don't use the inline keyword unnecessarily, the compiler
will definitely inline this single assignment

