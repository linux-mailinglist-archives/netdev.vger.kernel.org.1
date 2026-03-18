Return-Path: <netdev+bounces-268944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGauAkxxumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:33:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E442B919E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA2B30DCFCD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBF29C33F;
	Wed, 18 Mar 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj7OQUfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4553A8743;
	Wed, 18 Mar 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826095; cv=none; b=AlyeL0ca+bcqmm7Dhr/CydVsQrA6Ah0CTnUIITuxtrjhtWh7HUsGqsWSRDkZEWA1cWdWkELQRis/HkWsp2t95zOVms6/dspHpssI2Fwdyi0f5SUJiOyua9SuLh+RKUGQLpXLQUiPXjN1kWUnvO0jia1FCAF40QjAJ27dS9Di43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826095; c=relaxed/simple;
	bh=Pjn/dG3zw03NhBpX4qB38ysq5mqSCnSgQSEU+EapZzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FobeX56LmIQz7UWxTal4UZbh9/xaenoBsARVx5AFhwtJTc1+MILB5ozfMKN+XXeEq/be2NO43oQg8uBw+nzHGTJrBIB3nYOSsQq+W/1zNTejPW2x4RTGsZ1Wein65saYerLjeL3tDfDZa7XedvL1hBKvaojmAt80WDkYhfoRWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj7OQUfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE61C19421;
	Wed, 18 Mar 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826094;
	bh=Pjn/dG3zw03NhBpX4qB38ysq5mqSCnSgQSEU+EapZzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Nj7OQUfSDCDh0kc3LfdVqVwX588GULb7h/kOb8iY1jHkoNbjezY2wP1SLLhwiQJB2
	 VFhVUVWv8vbCTbGZUdMEZSZBR7FaKJAuoKl3DYRUT5SkEbqx8mG0spo5UiDtyVUrqA
	 dKf0lKYmte11HA0p91zduZwObGE5P8SPNSVQjhHRjistnbm42Wo9r90n5uCq7tPbHV
	 ov9ycejPs9vd4JF7ylx0DGTXZpIFafgbWOfz48ku70vOvdySjDGLEoxGHa/akkN27H
	 bv8kEazn02vG65I4r8qENiWQEblcvVExGreNKk2gu5AO+bNSkH+p2tphvIrppKFers
	 5oOmnD/RBP2MQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v5 2/3] bnxt_en: Resize RSS contexts on channel
 count change
In-Reply-To: <20260317155359.33b855b1@kernel.org>
References: <20260317083339.2811865-1-bjorn@kernel.org>
 <20260317083339.2811865-3-bjorn@kernel.org>
 <20260317155359.33b855b1@kernel.org>
Date: Wed, 18 Mar 2026 10:28:11 +0100
Message-ID: <87fr5xpjv8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268944-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[all.your.base.are.belong.to.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74E442B919E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 17 Mar 2026 09:33:35 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> +		if (netif_is_rxfh_configured(dev) &&
>> +		    !ethtool_rxfh_can_resize(bp->rss_indir_tbl,
>> +					old_tbl_size, new_tbl_size,
>> +					dev->ethtool->rss_indir_user_size)) {
>> +			netdev_warn(dev, "RSS table resize not possible\n");
>> +			return -EINVAL;
>> +		}
>
> Now that we know the size of the table that user has set=20
> we can skip the netif_is_rxfh_configured(dev) and depend fully on
> ethtool_rxfh_can_resize(... rss_indir_user_size) ?
>
> Otherwise we're not making much use of dev->ethtool->rss_indir_user_size
> (the one for the default context / context 0).
> Regardless of the table size user provided IFF_RXFH_CONFIGURED will be
> set.
>
> Which brings me to my last point - I think you can delete
> IFF_RXFH_CONFIGURED and have netif_is_rxfh_configured(dev)
> operate on ..user_size ? We should probably have a new helper
> for when driver lost control over rings and has to reset indir table
> forgetting user config (bnxt mlx5 clearing IFF_RXFH_CONFIGURED).
> Helper should clear the state and issue a Netlink notification?

All good points -- I'll try that! Thanks!

