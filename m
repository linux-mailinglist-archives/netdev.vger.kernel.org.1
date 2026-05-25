Return-Path: <netdev+bounces-291360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPeYD/FrFGoTNQcAu9opvQ
	(envelope-from <netdev+bounces-291360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 408EF5CC552
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3725A3003832
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2CC29BD8C;
	Mon, 25 May 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Zde2rW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2021CA03;
	Mon, 25 May 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723244; cv=none; b=u1sp6qJRrzX5Ni+CPvEP86cY2N/eqLCEsu2EED9uGDXb/bfCrseHNykLKhtc/UT7W2g5ksYYbH4HgaVrXn1GPQf4hrihrnJFytiDXBFiTtma8Dy3Ioj0W1jDIsxDU4sUJxSlBL7Do81NjE38P6O/v/OyomsX3SjuSv2woFV3FgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723244; c=relaxed/simple;
	bh=x8uJeJQCOHo2oeYel8I5Mw+AW5j9oNrB2LOkztpnBjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef01V23YjUq4L0iZr3WubRQkrGDDvLBstjiFAT3hJ6TicQgh0kawm8x3Ahgo2+Ashsq209/PqCYS+VhEjGBQs9m6l4REtRNdD983UFuJtwx2a5FrtMuv/jGoksl5f9i8f809Gttx2TbOi2hsiQuWbz7ABNY+S9RQhRIxCyfhKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Zde2rW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437511F000E9;
	Mon, 25 May 2026 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723242;
	bh=WlsZXpJt4K24hjMSYoSjU2iL3sBxP5CwjJ+Nd/gbYhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d0Zde2rWYN46IQyAFXPz8SyIprd2PLTUcbft1e+INH+96h7u4DT+umwzDDKxvd8tv
	 VALnTMnSN9+vwRfraCVQebgcVxHY8LhlMD0tHOWCihBVbVGjcU/jZpsT+STm+eL07H
	 /9Y31FLGyv2sjfigTQp74xtJZT95ZyfQ/qFmRQNzRbU+wKooqKAuxGK97N0vIgVJMY
	 Ud4Ud92JklyasfZHxwLpd0FKvlpLpvfahmmk6uqGpoAj0AnHXVSLXs3uwOxUcwiut0
	 ehPLpm+LQVFK/G4qFQWemP/t4OR/a8cPKZen3uNdjrJCIe/6UNSW5doNniVKF7MBWq
	 NAwkAMaJfiYKw==
Date: Mon, 25 May 2026 08:34:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>, Prathamesh Deshpande
 <prathameshdeshpande7@gmail.com>, Simon Horman <horms@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Moshe
 Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header
 action
Message-ID: <20260525083401.38a7c15d@kernel.org>
In-Reply-To: <433cd37c-bdf8-4739-a85d-7f47e36a9d0d@nvidia.com>
References: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
	<20260509132508.GR15617@horms.kernel.org>
	<744adbc1-ba3d-47c6-9129-439a59636f14@nvidia.com>
	<433cd37c-bdf8-4739-a85d-7f47e36a9d0d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291360-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 408EF5CC552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 13:34:32 +0300 Tariq Toukan wrote:
> On 10/05/2026 11:10, Yevgeny Kliteynik wrote:
> > On 09-May-26 16:25, Simon Horman wrote:  
> >> On Wed, May 06, 2026 at 01:00:31AM +0100, Prathamesh Deshpande wrote:  
> >> Reviewed-by: Simon Horman <horms@kernel.org>  
> > 
> > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> I guess this is still pending my ack after Yevgeny's review?
> 
> Here:
> Acked-by: Tariq Toukan <tariqt@nvidia.com>

Yes, for us to apply directly we need an ack from the person who sends
us the company PR. Too many false positive otherwise. Even people
listed in MAINTAINERS are not considered sufficient by other companies
so we play it safe :|

