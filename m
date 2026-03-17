Return-Path: <netdev+bounces-268763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAt2DdHZuWlHOgIAu9opvQ
	(envelope-from <netdev+bounces-268763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:46:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36A2B32C0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39E6B306D8EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F934C83D;
	Tue, 17 Mar 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBl0Bby3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB81DF73A;
	Tue, 17 Mar 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787598; cv=none; b=sxQ2PzKn/Yfb3GaTFPV1zaWhQVeGgNo0TTNWPTOaSxTJaU3O/A0RlT2id+I98/RQKqMRzkIp8+4qoyi1TFIGWyy9521X+iZhat9zGV38+TqgVImp2v65jP9JkoVtm9/Dqi/IPFVhnoJ7Jwz9PSM5ZsvXa6sPs8BFbPi0jI/FYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787598; c=relaxed/simple;
	bh=CToKfNZF/bsROvo5x9jpRvs0zl/v6VkBXXPS+WImD6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4yKSewxEPo/rr3qCHLBM3VSPLM4m/VI/wq1g2SkWO9EoBuDFbUELr3fk3ZzNAJWFdOUMyzvUfxmj8hODw1C+0E+uroLpDDHhkdDFqat7diUwVH3RP+aJ60xyWGQ0oaaLd0ZmMidP4Y+Ire467434PTUekfE32jIxiFaiNeo7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBl0Bby3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E591C4CEF7;
	Tue, 17 Mar 2026 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773787598;
	bh=CToKfNZF/bsROvo5x9jpRvs0zl/v6VkBXXPS+WImD6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lBl0Bby3MaA911f18pAW6N4oZhbckGeo0yvpZJH5+tGL9j3u1C7I7XPpFy57SRJlD
	 sLbyphK6/YESeR0C4+i8nf9CcxeDHcTKytoyS7qcpKOOdCgfbcEZiurRdWZF36ZFQB
	 IoHpeYL9OmGG/sWSK8J8z9S1MYhUM/OOZdMhU1q0audqYuT5deDh8ia6LBnDHEVjrd
	 kCWfCwAOvvbUU+BvHqoB5j/kmmTzZmAxXHirrrg7nP3xhQ1B7bk3NHRv4rGE+g8vSc
	 BFhshkU3ZA7JNumNjiUu7xNM1uq83a58ExrEr6ho0ZhLGFbafFyZ4XnipFQ4SnjNyz
	 Vgmd4NkHOC7VA==
Date: Tue, 17 Mar 2026 15:46:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v5 1/3] ethtool: Add RSS indirection table
 resize helpers
Message-ID: <20260317154636.78964316@kernel.org>
In-Reply-To: <20260317083339.2811865-2-bjorn@kernel.org>
References: <20260317083339.2811865-1-bjorn@kernel.org>
	<20260317083339.2811865-2-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B36A2B32C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 09:33:34 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>  static int
>  rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
>  		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
> -		   bool *reset, bool *mod)
> +		   bool *reset, bool *mod, u32 *user_sizep)
>  {
>  	struct netlink_ext_ack *extack =3D info->extack;
>  	struct nlattr **tb =3D info->attrs;
> @@ -685,6 +685,7 @@ rss_set_prep_indir(struct net_device *dev, struct gen=
l_info *info,
>  	}
> =20
>  	*mod |=3D memcmp(rxfh->indir, data->indir_table, data->indir_size);
> +	*user_sizep =3D user_size;
> =20
>  	return 0;

Weak preference for return user_size; instead of output arg, 7th, "p"?

