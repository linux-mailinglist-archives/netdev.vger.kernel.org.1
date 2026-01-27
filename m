Return-Path: <netdev+bounces-253969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIKYGG7+eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:05:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A798C4E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D0930490FF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1A3242D4;
	Tue, 27 Jan 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhizygvn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FF221540;
	Tue, 27 Jan 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537071; cv=none; b=CphxNuxYoDS8HWRsus/74PAVoKd4HsHY9fcoqvUpKyJg5FXqRheO41gthTAxS2HlJhDxu+Lsat77QI7MKpngbMqetybxMY5Vly6I1/pouJVSaL4z09Erh0Qt76CPxuv8qW8TJWe6sd7gfsNSV6LGMCl/hyTFB65km4P655wBuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537071; c=relaxed/simple;
	bh=MjZ7v+ghGJIE+6DAOfJ2Xh+QBFgqEghaeM968xEKkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5PVlngj4j6kRvxTEWSz/w6vJgdh41/Z4TT66r9+SeYzJtNLkPzj79YgEVNfUVJJJwPn5NyAx9s7obdansD/P8yK2yPrd4ALtUtTmp/qSARN/ERLOQc8R/pQQMgyIki4iQnMdKmM1YqpfmvZCuzAkP5KPOKL/sotPxvLiFEAS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhizygvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014DBC116C6;
	Tue, 27 Jan 2026 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769537070;
	bh=MjZ7v+ghGJIE+6DAOfJ2Xh+QBFgqEghaeM968xEKkoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhizygvnrEDcXmR4MBa0odXor4bpnwYs8cYaCUTPOOsBQOsxyzFTU95yzPgxqSPaF
	 AqDMiz3z4nOBZEjqPI9/qjeZXCoSr+QsTPM5EbU4lUxVWleI15GVH3QsAgRGfP7kb2
	 g6zXnMj8VXOeA9ojjBj2LsRmPydhF9L+EjBsOqzUkWwQrCbUrpY23BgxHW85pRnzV8
	 b5ewdbTx6MJQKGRk5rLg7xkKUWGFBvl934mMOaxc1T0RxpF2pGa5DG2t6EEkzbX8Bl
	 1VezBaP1qw5y8YqezuE7jxH9vdfLH5DBNPZZKbfPwsJi1AIhCnuv7PS3AMjAvlqeZ5
	 AlqSoJ/ecLLSA==
Date: Tue, 27 Jan 2026 10:04:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next v2] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260127100429.26dc5258@kernel.org>
In-Reply-To: <rsngz5ql5s54luv4mnjs733uogjjdxiylbbm4w4pcaefow45rm@memr4a27ycc2>
References: <20260126023946.906893-1-rkannoth@marvell.com>
	<20260126171859.5097dfb5@kernel.org>
	<rsngz5ql5s54luv4mnjs733uogjjdxiylbbm4w4pcaefow45rm@memr4a27ycc2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-253969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D56A798C4E
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 10:51:10 +0100 Jiri Pirko wrote:
> Tue, Jan 27, 2026 at 02:18:59AM +0100, kuba@kernel.org wrote:
> >On Mon, 26 Jan 2026 08:09:44 +0530 Ratheesh Kannoth wrote:  
> >> Devlink param value attribute is not defined since devlink is handling
> >> the value validating and parsing internally, this allows us to implement
> >> multi attribute values without breaking any policies.
> >> 
> >> Devlink param multi-attribute values are considered to be dynamically
> >> sized arrays of u32 values, by introducing a new devlink param type
> >> DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
> >> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> >> 
> >> Implement get/set parsing and add to the internal value structure passed
> >> to drivers.
> >> 
> >> This is useful for devices that need to configure a list of values for
> >> a specific configuration.  
> >
> >Could you respin this as a series with the first driver implementing
> >a param of this type?  We can't merge an API without a user.  
> 
> I may be missed it, are you okay with cleanup helpers now (__free(kfree)
> used here), or not yet? :)

Of course not, I haven't looked at the patch at all.

