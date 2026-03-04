Return-Path: <netdev+bounces-263957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODjZBkFwqGkkugAAu9opvQ
	(envelope-from <netdev+bounces-263957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:47:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF930205672
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979483012EA4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763703C6A5A;
	Wed,  4 Mar 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBoxsvVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415037AA6F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646299; cv=none; b=nFJvB7T8lmAIKYV9ph9HPhDPnUNaSUelqLNTgP5LerBrIccgGc/ERESLuRf4F2PKAd8fEZoObETh7N1XFx4WIKkNEgBh11t69oppqqLNfzDlk1ByQCAvbiWbqAtS4VfEzbluYgbdKTjwFLCZwXv2hhPwMeS5o6N797cXLkVfbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646299; c=relaxed/simple;
	bh=fgYWH7HBwrxdOodX6x0w7u6A8Og//sc/xt2xpeduTpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f60o5G+nwglYIjv3mjPweZWiB7D4q6Qii/BaMBy3UedLzo3u2/pYiKmJmbKm6ql0JR/lI7WV3rDNDCUWn/THvWqK+VlpGY97Ow4X8ubcJ/3/H9uY2ARLGTMEZagkZWAg0UF3ympEwkyGxQhnU3jBw54/uOTkgBnDg9qrJbxlaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBoxsvVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF2AC2BC86;
	Wed,  4 Mar 2026 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646299;
	bh=fgYWH7HBwrxdOodX6x0w7u6A8Og//sc/xt2xpeduTpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VBoxsvVGTKJWLtQ9whxELu9fzmZjGi1uLxBDS+33+sHTQXOHkRQlCt1fCygQYI2IA
	 Mh4DYKZgaahlQabFDLdYiLx9E9dNbLmNr8YzySJ1afeGfBwU2Rb4cWrLvbyL7GiCRW
	 N3lnJ9talnc62ph2xBfz1tPJaDUFRnwcySpIkGfWeK9xunc7oMZfiCVp6Fw/7emNsW
	 3Hv0E9UFe318kPIwmL2i3Sbkk5R0TBMZhpNpcmFHrHyGmMDNzZZYfdQmD5Ut+KUzQf
	 4XTbt9K/iXJVBe+mA2PP+kGKm84GTnBCpMTfBr2jWKUeq/VEgsQCe6KjK92V2bxLcU
	 L3PHfxdDtIb4w==
Date: Wed, 4 Mar 2026 09:44:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <shenjian15@huawei.com>, <salil.mehta@huawei.com>
Subject: Re: [PATCH net 04/11] MAINTAINERS: remove Salil Mehta from
 HiSilicon network drivers
Message-ID: <20260304094457.79b783c0@kernel.org>
In-Reply-To: <259cd032-2ccb-452b-8524-75bc7162e138@huawei.com>
References: <20260303215339.2333548-1-kuba@kernel.org>
	<20260303215339.2333548-5-kuba@kernel.org>
	<259cd032-2ccb-452b-8524-75bc7162e138@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF930205672
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
	TAGGED_FROM(0.00)[bounces-263957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 20:17:36 +0800 Jijie Shao wrote:
> We expect him to return to full capacity in mid-March

Got it! Everything else you wrote is besides the point (point being 
the dereliction of upstream responsibilities). But if the situation 
was temporary I'll drop the patch.

Thanks!

