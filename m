Return-Path: <netdev+bounces-266276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBF1JGldsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:05:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777D256201
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEFB5305C335
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F373D092B;
	Tue, 10 Mar 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHHEkKZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F13C660E;
	Tue, 10 Mar 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165638; cv=none; b=DlKNbZwU1mhhd1kbCKmzBVctoUf295C3ExkxgXuy66WTtnxzxLnP/E3NcyA0FLY7IdPynYZGsKeoR7v+hsGeWzLebhRqDiG4YREkDsJi9Z2hVLUpn5QdSDG9snaLd0CNdvmvyHTuaHuXxu25XjAeMVfgeMWBnTAEhZD50gCq9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165638; c=relaxed/simple;
	bh=CKsWR505Y3AwkREW3d1S4iMAo8jk+VO48RpIMHV3zBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCA+7cdZlsoAiEGqs7XuJzdi0HJRWjPkXhkLGGPitsiUS5tZdt+lRLL1VxFxWxRmX9nKhTeNBObfyRpfT2YoiB/witQE7cMVksBukcAwjxQqkrRRZCvv2SwY787yi4Ktp88jMDkDmykzrKlJzV348seWX9gdtVd54OuzaLv3fzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHHEkKZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DFC2BC87;
	Tue, 10 Mar 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165638;
	bh=CKsWR505Y3AwkREW3d1S4iMAo8jk+VO48RpIMHV3zBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHHEkKZhdbQRj+09/p+Oc6gWjm5BCamjSM9e2h7G3u4HOsUj9rLyo/rAxWFjW88ka
	 xdegOdZWy9MwuivJFGBrqy6PBqrcSUpP2HsJNvp5Rr/ZCjY93cHkpRtTw6QMHgZVUC
	 nlf+QsRIIblU/4gIDf1hvcPOw5iv3qDq3nrL8vKLv8l4/JenhDMVCOBlBJtgCTKx1G
	 DJcDPst8vndmxP4w2hS9RT/2QPLiIj5fk7XFJ28JL7tu4L7/7F1UlWosKNYr0bnZns
	 PMwQm+pgYU//tsvi4doXgNb2YPTJFFikq9CZ6vIl19i80N5K9EWNOz49zMLV80km20
	 VPoUZTTO5rqtg==
Date: Tue, 10 Mar 2026 18:00:34 +0000
From: Simon Horman <horms@kernel.org>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/2] dpaa2: fix config relation with
 FSL_DPAA2_SWITCH
Message-ID: <20260310180034.GP461701@kernel.org>
References: <20260309125018.420275-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309125018.420275-1-caixinchen1@huawei.com>
X-Rspamd-Queue-Id: 0777D256201
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
	TAGGED_FROM(0.00)[bounces-266276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 12:50:16PM +0000, Cai Xinchen wrote:
> When compile FSL_DPAA2_SWITCH, it needs to set CONFIG_FSL_DPAA2_ETH=y,
> otherwise it cannot be compiled.
> And as Ioana Ciornei sugggested, FSL_DPAA2_SWITCH included dpaa2-mac.o in
> the driver, but it does not select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO
> 
> v1->v2
> There is no code dependency between the dpaa2-switch driver and the
> dpaa2-eth, so use Makefile to control dpaa2-eth instead of using depending
> on in Kconfig.
> And add select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO for FSL_DPAA2_SWITCH.

Thanks.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


