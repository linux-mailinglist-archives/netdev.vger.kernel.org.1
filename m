Return-Path: <netdev+bounces-299946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vVVK3GmMWo5owUAu9opvQ
	(envelope-from <netdev+bounces-299946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260B694FD6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:39:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=v8atiQAm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299946-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299946-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5113014BFD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421943CF943;
	Tue, 16 Jun 2026 19:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B923AB88;
	Tue, 16 Jun 2026 19:39:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638767; cv=none; b=GvYvtJwQJcp7XHyakPgftw3hD6VBNjxMsJhehC/m5cdrfiIVK+adBMHuAetFbUlGVvpArZIcCC2Cmw9mzdbfk3zRLzMRxW1WDIYbLUqV5wy7Z8XbWy1iaroBLqMiF2euqPGXRpA0T5Y0i4Q8iHQkpx0U5LFaonOjLyw2Cn9i14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638767; c=relaxed/simple;
	bh=MJhp1IRR0FbFmfsL0S1GqLz1h1QFMhqJUYwuO8eBnZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai4uYsYxJdcUjJ9edrkKuL2LUjiOLRzVpRL21TlWW7LZVSn3DOO3aEi/2COFwUzOIzfLcKXwWAPoSukETxGqh/rym5MMzWA36LLDN3FZYYtezM8LbV+Bvu7yDn/V+MvsWOjjDKjNlM9ZQW84vxB5yqDtfRT+qZs5/69nMPpLzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v8atiQAm; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jmJ3865OUTvY13XqaIlNu/kLAlTETRik+w6P+e58M/o=; b=v8atiQAmAJ5deTFtTfcyrOM3nc
	lnLDJn9qKKJdVU6JAaKzH0xCO3a1F/mGueyADWUYdZ2PjRY4JejBzZQgAgtuEnN4SOtRw0IbO7/HK
	mTKWw4AO/kkeGmcFCZs/f+LtaUkmdIo7TINXzVb7ThMasqMHgHyoQ38Wgkbqfa05i5X0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZZcv-0081Xm-Tg; Tue, 16 Jun 2026 21:39:13 +0200
Date: Tue, 16 Jun 2026 21:39:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v6 1/2] dinghai: add ZTE network driver support
Message-ID: <920cc3b1-af5e-4ce8-bfa2-520c1ba53904@lunn.ch>
References: <20260616212106742_trNLb7r-FL04eDlJO8tT@zte.com.cn>
 <20260616213057452I2KLm3mVgWYl_SUTy_YYS@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616213057452I2KLm3mVgWYl_SUTy_YYS@zte.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0260B694FD6

> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
> +static inline void *dh_core_alloc_priv(struct dh_core_dev *dh_dev,
> +				       size_t size)
> +{
> +	void *priv = kzalloc(size, GFP_KERNEL);
> +
> +	if (priv)
> +		dh_dev->priv = priv;
> +	return priv;
> +}
> +
> +static inline void dh_core_free_priv(struct dh_core_dev *dh_dev)
> +{
> +	kfree(dh_dev->priv);
> +}

It is unusual for these to be inline functions in a header. Why is
this?

	Andrew

