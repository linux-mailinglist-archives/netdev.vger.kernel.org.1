Return-Path: <netdev+bounces-253939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHuHKgfneGmHtwEAu9opvQ
	(envelope-from <netdev+bounces-253939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:25:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BC97B94
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCF63019F0A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E234BA24;
	Tue, 27 Jan 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmedgJQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2022531328C;
	Tue, 27 Jan 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531119; cv=none; b=QsNFDJPEbpv/uwQEZcB0RW8rF7jNy/RjhxmS7ZWU2ezRdGB/5fkGMHrTcD+IRVGKO1gg+2gJ79ZWQNgaFhI1lAMvqAt/iAg0VdOsaiqGvK/9qTaaK2qP1yZgcCQUv+Ga2cM/p0KKyoKPgZrv6mO1e32ABdaaXnFmbtrroby5hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531119; c=relaxed/simple;
	bh=E1NfJAp2pRZUFxTfTA8catDkh+kMmjU7cxx7FcIuLUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs98nfd+xL3zRhuGnambTAb7/lYOxaW6gtgCRe2A2i+ZeZY7sRaK8Hd0sKB5+u7fXO3pXfMuFbJph/dzlD5Us9idKhvkp6J8J0jG/02dgaWkUaQ6iul5qzG4332q0R7D4E7Syj7QvfZCIEQsBZOG2j05uG2hJlqM7UnAaxHt0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmedgJQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F90C116C6;
	Tue, 27 Jan 2026 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531118;
	bh=E1NfJAp2pRZUFxTfTA8catDkh+kMmjU7cxx7FcIuLUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmedgJQX5P3Wnvf4SB4ljWykErVE/oDxaOhwVm9GiClSgjqQVhIHGYUwiho+ilawz
	 DCXUwxNqguAvhFnW4DUMcckLZx6kQ3kGgJc0impKTjdMyf9K3DI6aRMax/oXbXQbE3
	 leu3F38rP43+rkUkG2JM8ugRXxhJJeZ8rUVUXF+cUvmJX6m+FhD+wknLAWp/dL2YJt
	 y4C7+8cA+yhLGBZ/gaPsyZVTnOmotwYfWZt+a8u8c++9u0/jjCMif01h3GcAfMXNlE
	 iCGjLZMi0kukzr7qp09OHDGpEGNDNIuGwOSLImDUqi46oQtZiEIg0/5ARIwJLOmC8D
	 Jr6RgQppoxXcg==
Date: Tue, 27 Jan 2026 16:25:13 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v02 2/4] hinic3: Remove redundant defensive code
Message-ID: <aXjm6fE7Vsv_0GTP@horms.kernel.org>
References: <cover.1769142701.git.zhuyikai1@h-partners.com>
 <5f2f3eb262f83613d276aa95a3384370a936ca90.1769142701.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2f3eb262f83613d276aa95a3384370a936ca90.1769142701.git.zhuyikai1@h-partners.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: EF1BC97B94
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:03:32AM +0800, Fan Gong wrote:
> According to comment of patch 03, check codes that were merged and
> remove redundant defensive codes.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

Hi,

I agree that defensive coding is unnecessary in Networking drivers.
But I'm unsure what "codes that were merged" and "patch 03" refers to.
Could you clarify this?

Likewise in patch 3/4 of this series.

