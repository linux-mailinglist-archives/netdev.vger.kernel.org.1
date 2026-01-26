Return-Path: <netdev+bounces-253495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LwSJUB1d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:08:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2729589524
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FA7F306A1BD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB233BBCB;
	Mon, 26 Jan 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmHfvy1O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88B33B97F;
	Mon, 26 Jan 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436230; cv=none; b=cKwumvi2tUEbI0UutONPy/l+1uy3ljl2YJkZtxbphzMaYBtbIB+BHvQ05sMYqPAyIGeLfyLGzY9KiN9IVcvn7JmvivTFH388UD1c9Ike++UyWxJjLiilXiU4bJCysNV9yUXctQBZBRny8QUHbdeEYVrdt88bmC4bO/Oi4SEJNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436230; c=relaxed/simple;
	bh=eE5MKSFzdzy0h78twT1uh/Vtw+g5igigaFgzJ8JSISY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIzD6sXyU2DWUVM7c2DOLRAO/LpY8+FFinOoF8qOZOnCynamdgSMPhKw4KeljZCs10PoQrEUlypPX5EqkrDS6MFpxfAug1wBV/Nawr/1Pm05wFJoPIQn014fhL171FZnf7VsZtX2EkrB+qku9tkFj/+QBDmprv4HWOzlJB8xmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmHfvy1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B43C16AAE;
	Mon, 26 Jan 2026 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436230;
	bh=eE5MKSFzdzy0h78twT1uh/Vtw+g5igigaFgzJ8JSISY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmHfvy1OMPWAVwaY/ityFrU/Q0sbipNeGkrWCf55wtQAyHZZZ3QEsmvSWmIZWgMp+
	 RZOrzl3kUp+iF8ubphtSUiIwRDa59qimVhYqoPHMdnAKt/BlaZNSXR4voK+57h+Dt8
	 KJWP7bshZxBWFXVnl/0vUPCHvf/qVhdb4Gqzndi08eVY3wK6TLtS51pUPUbFRJD71A
	 QIeovRnJxLFsgWQxoXbh70PkxJFfgewtrxnt54UTfoRutOYn8SL8kUrBMeoieYw1vM
	 pD57ZmTe0GCNAC/Apdah208TWZW0GlJlKb+hoGlZKdYX+4TbtX+tYXdGgeoZz5dny5
	 1uid9yEgdYdhw==
Date: Mon, 26 Jan 2026 14:03:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] extend bit width in the flow director of
 HNS3 driver
Message-ID: <aXd0QSip2AcefqT2@horms.kernel.org>
References: <20260123094756.3718516-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123094756.3718516-1-shaojijie@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253495-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 2729589524
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:47:54PM +0800, Jijie Shao wrote:
> The bit widths of HCLGE_FD_AD_QID and HCLGE_FD_AD_COUNTER_NUM are
> increased to support higher specifications.
> 
> Note: The hardware already supports the specifications.

Hi Jijie,

Are there any compatibility issues here?
E.g. new driver with old hardware or firmware?

