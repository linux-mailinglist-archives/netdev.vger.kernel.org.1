Return-Path: <netdev+bounces-270006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD/+DK2HvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3496D2DEDDA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A080300348D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC63D666F;
	Fri, 20 Mar 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFhELuc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F53B19C0;
	Fri, 20 Mar 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028690; cv=none; b=VLOsd+SDE8SvCBU6yEs+77nPCeA2YAY9QDdWrAwGceK3rCDM6o3WjD4EBtYT4f0Bg61WKb4I3cszIlJVcagzSozO3TxLj89V9jemNjL/tULDWWDDUNR0c4p8TKNOieyUQu2OGp9bcy4jU6L9FamXL/+LblHegkm7/fxo92rb6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028690; c=relaxed/simple;
	bh=XxiZwm/TFIYNgDW+Y1dURY6wVeoypsqYZQcwhGZGH5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJdU4OGcvZ3nFBd34AyuuogfsR1PLKbMwarOHIK2JVivgJYAU7Lj76cZ8K4IrsS1MARTr2E/nWy4FV94iItRULk+sKkSvI0jV2qzHB+HZoEQ+3s6HPsmnj4XKyCaHMAMu/ppzn6+NnDjX1rwLwISb38d+1n+DLsU5BlI9OrCFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFhELuc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1970EC19425;
	Fri, 20 Mar 2026 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774028690;
	bh=XxiZwm/TFIYNgDW+Y1dURY6wVeoypsqYZQcwhGZGH5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFhELuc9ptp/tfiGUeWB6IpIvB2CclNpsrcYG5Jd6RCH9+YxhvpMoiu+hW/QwVkqM
	 WaOt7W4WZ9f7YfdzbnHqBEVpkbbGmR2Rx9LTgV14zJLYlsmvXFnFrj/QwbgdgMrkUf
	 rql+xKm9WEAOW4BpZmpChMzU4iWBRauphaOB3HFVAKVwFz6Y6vdAHNBPLDxEeYrlCH
	 yKv6BzAFaariZVvsyojoYj9bT9YSMWXMShRcTqoseKWI+xd4EfK0f7kWduG07Vt+vE
	 nZZSME1iivJjvz4A6e11jXkml66qwlRntV3nbqQ1K01oJkJWtGW3wYq2jJvKgHDYL0
	 MljJL8ta8uADg==
Date: Fri, 20 Mar 2026 17:44:44 +0000
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 0/2] net: cleanup bitmaps printing
Message-ID: <20260320174444.GG74886@horms.kernel.org>
References: <20260319201713.941956-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319201713.941956-1-ynorov@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,google.com,lunn.ch,marvell.com,fomichev.me,linux.dev,vger.kernel.org,weissschuh.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 3496D2DEDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:17:09PM -0400, Yury Norov wrote:
> Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
> print bitmap into a human readable format, making sure that the output
> string will not get big enough to cross the current page limit.
> 
> Some drivers use this function immediately before passing the result to
> scnprintf() with no modification. This is useless because scnprintf(),
> and helpers based on it like seq_pritf() and sysfs_emit(), take care of
> not overflowing the buffer by itself, and perfectly print bitmaps with
> "%*pb[l]".
> 
> v1: https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> v2:
>  - fix copy-paste error in print_npa_qsize() (Simon);
>  - fix typo in #1 subject (Jakub).

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


