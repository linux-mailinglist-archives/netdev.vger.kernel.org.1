Return-Path: <netdev+bounces-277807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEOJD0Kw22lkFAkAu9opvQ
	(envelope-from <netdev+bounces-277807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0A3E45C5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E51300F13D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B6036A035;
	Sun, 12 Apr 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUUNKd8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46384503B;
	Sun, 12 Apr 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004915; cv=none; b=X3PnoJBzIF/HeJNCmk/0alPxphSgLgzLO6+CUlTVCFCfR8rO6NSciPZ9iCDYiKvFgMwatrJ/op7/xfImgzLfYY0J1xf4P8c6uFIgzrBhTxDGmyBts7pTlIADX67NHDFJLHsUtRafzITJjEBbm2MzNdvsWKnQmPylZksz2UCoibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004915; c=relaxed/simple;
	bh=vU8qocTBhF2Eu+LHdZXNCVDARpzm7EZ8Y8vqQGXu39M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzAjroEiBLnj1a8233sh3haDn4vrk0O8HoAfiYtVAGwB3gWYUvK4lYayEaqTfyxPNDPlVhWFINqdB24z4GKBiBbc2lRdIh1Gf0oFgDUUtaeRY9rtFFRpVi2/iw+VSCk6KRNjd4sshjwnpbY7siNFl0xKjgpMXeRh7aOCcoFGrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUUNKd8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD503C19424;
	Sun, 12 Apr 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776004914;
	bh=vU8qocTBhF2Eu+LHdZXNCVDARpzm7EZ8Y8vqQGXu39M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUUNKd8Imz8oj+3j+KPEIjO9PzKntTuzwp7tZGykge2m9Ieriht60B5WH44PdSr7D
	 W2CpGSWZ09SokZlQu4jV/pRv5Bm2Yklmod1IhL0fYUxBwVHxBdx4WZT6Q4cTLGBCzd
	 OAJdjw8w50xurMGemJdg9oUCLJbJQj7QHLScJeGF4yZy8JVvlo4wG4Uwb9zFAxV362
	 TqeHaKFV+NYZK4/MfsdjTVOi93LQQPhSJ167b6UfTH8LRj9xNTIK5+mc1mhYJqPtKT
	 KVdpts6xKTnrv412ShvaBIibc8crLukjkucPSXGvckQpAth3/Qq8w0ulMwl5RNjhBT
	 Jf4BgBU5ZQuuQ==
Date: Sun, 12 Apr 2026 07:41:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Craig <edfardos@gmail.com>
Cc: hugh@blemings.id.au, Kuniyuki Iwashima <kuniyu@google.com>,
 davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260412074153.07636ebf@kernel.org>
In-Reply-To: <761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
References: <20260410145448.38253e3c@kernel.org>
	<20260410221220.1708137-1-kuniyu@google.com>
	<4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
	<761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277807-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: B1D0A3E45C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 15:51:39 -0700 Craig wrote:
> If you're sure the Internet will never fail, I guess it makes 
> sense removing all of this since it's inconvenient to maintain.

I did a sweep thru the fixes on Friday, there are 4 more patches
for ham radio pending review. Go ahead and review those.

