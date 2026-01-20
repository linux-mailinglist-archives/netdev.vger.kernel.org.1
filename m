Return-Path: <netdev+bounces-251663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKo9GhUYcGkEVwAAu9opvQ
	(envelope-from <netdev+bounces-251663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:04:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD14E448
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ADDFB689C5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55923A9DB5;
	Tue, 20 Jan 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNIeyN+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901139A7F4;
	Tue, 20 Jan 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952881; cv=none; b=hudBpFCGLhEkfmqPStg1/RqdBzxqqNVbgOkDUO2ROiWeqdaNFkx4mgH/HfnWewBd/c7RiahIK5rdU7R1iqPQ5sZTA3/Q0ecRAvDC0YEIAh5UIOpViQndK+whtRbJ6Y3N/cIjrTtLCH0E+OfLE4ZOhMSo7c0CVyODyNYP1xKs0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952881; c=relaxed/simple;
	bh=48E4DT0TvVY6z+infj8rNRT8NU9o/Y6Hu2IK7WPs1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEwmb+TTAqEm1USQajfcvbXqq56vhhusMjS1kPkljzmq8mFjyzfKwEPeyTMeiyu5EOyGRhp4Kj22ffTsZe3kaiQJdyvpuUdw9A3OUBfDCQ3bBRMVhBxmmPwa8wNJ63XISkKioNeMEqqlym+TSZOz7yP2JcbGrNLHWbRAVAK6hMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNIeyN+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988AFC16AAE;
	Tue, 20 Jan 2026 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768952881;
	bh=48E4DT0TvVY6z+infj8rNRT8NU9o/Y6Hu2IK7WPs1VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NNIeyN+RP56ykcyAuEWsOR2kao1VmluBm6sGelI24WlfBVV2NDL6qDbEJ3hJP7qgC
	 kc77XdxtVp9z35Z+jELJqsK3JSmJ6K8u+VxucB6cOpePrJkhFNYJxY7FFvu49KRwm3
	 Cd/6h1Vw/7elpWOQ+ci6j83ADihGEibH+PfKhHHfWzD5GJ+Vl1CMCkDvszJ6Vs1I2v
	 MR+WV5n2F/oqIkp0uoBOKjv2w9V3NiqNeNZmJr5ykogMiaFTQYNA5ts0Z5HmZ6/Njd
	 MGirxfeJPyvAsniUoQsQOnB1Po0gmXauWvevvkZSpZ8i+8cSIKzKT0brbKfOcxW4eO
	 F4JSqVVNvxTkA==
Date: Tue, 20 Jan 2026 15:47:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>
Subject: Re: [PATCH net v01 0/5] net: hinic3: Fix netif_queue_set_napi input
 parameters and code styles
Message-ID: <20260120154759.5a2c04c5@kernel.org>
In-Reply-To: <cover.1768911232.git.zhuyikai1@h-partners.com>
References: <cover.1768911232.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 07AD14E448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 20:38:38 +0800 Fan Gong wrote:
> This patchset provides netif_queue_set_napi bug fix and serveral code styles
> fixes to :
> 
> Fix netif_queue_set_napi queue_index parameter passing error.
> Remove empty lines between error handling.
> Remove redundant defensive code.
> Use array_size instead of multiplying.
> Sq use SQ_CTXT_PREF_CI_HI to improve readability.

no reposts within 24h please
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

