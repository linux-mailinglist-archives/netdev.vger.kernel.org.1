Return-Path: <netdev+bounces-253547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLNkApmcd2n0iwEAu9opvQ
	(envelope-from <netdev+bounces-253547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:55:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C930A8B0EB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC60304A54A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50B3491F1;
	Mon, 26 Jan 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvH/ojhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57E347FEA
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446420; cv=none; b=kMIpzBsOCvoDxi2Y08ULJTRWDIFEqG2d92DqIIy1giWNeTWR9Ln8ir7vViiB9dRX6KZovjEijSEh4w9D5I2aukxRiaIu+Z1ZnajGYQkjiIm3O9ZGslRVGTyidzzLIX/csK0c4bhMURBS5mEDn+57H6jSLGU1WaCugel3xjEnQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446420; c=relaxed/simple;
	bh=nJk6+hl07VRbjSmWfIoluy2CoiiL2JE+kR7eqf27Uqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAogJ/41ELTk1+XVDWDFen3Vq+MqU9NxAV/aVH2lHg+OFdEdC36SE0yNZbWza/Pq5Xg3RUf2hLWPupwriqgwSAoFd5ClEmUb5N/oj1RqpKfl0I+glRXflUs1VUcQ+0fUkjjT3WssQyLxLiuxi7fBM8c6KzJ3l0oMH4Dea8s5TPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvH/ojhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F34C116C6;
	Mon, 26 Jan 2026 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769446420;
	bh=nJk6+hl07VRbjSmWfIoluy2CoiiL2JE+kR7eqf27Uqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvH/ojhVILRdym2IDtjxZb9rtATkVLzte+ig395AtxgYHId2nRPKlkMNwq+7Ovwp9
	 Kf809aPqe0KFh1SCTVeInzVQlede7++K90h8s/Srn0AmuR1HAXXN1OkHjyf1Tif45m
	 deLq2p+VxHu2fxwHP7I+3sJF3JBG2DiM92cgBgzpxpu5u3DrzwcognOuHuq0M5Z3Z2
	 5GqobmfI2+YLDf2y2AK5dxG74io13Py/5XyyC1ByuiBLmzO/h1V3ENwTz8Bhhi1TmW
	 53EFkHMoKZoUjXPY9IkdhjY5QIXOfpEQHxSRrN7PXLzU3885SFZ/tyXJzRIS35oiWj
	 ITZqX6ec8hH4Q==
Date: Mon, 26 Jan 2026 16:53:37 +0000
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ss: fix grammar, articles, and phrasing in
 man page
Message-ID: <aXecEWx08vg4MQiT@horms.kernel.org>
References: <20260124200107.222116-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124200107.222116-1-stephen@networkplumber.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253547-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C930A8B0EB
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 12:00:41PM -0800, Stephen Hemminger wrote:
> This patch addresses grammatical errors, awkward phrasing, missing
> articles, and singular/plural agreement issues throughout the ss
> man page documentation.

Reviewed-by: Simon Horman <horms@kernel.org>


