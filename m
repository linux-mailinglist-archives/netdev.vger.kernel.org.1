Return-Path: <netdev+bounces-280575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJQvNyOC6WlbbwIAu9opvQ
	(envelope-from <netdev+bounces-280575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13C44C417
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAB143006689
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C312C1788;
	Thu, 23 Apr 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdY+Yg54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAA29E113;
	Thu, 23 Apr 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910879; cv=none; b=Yp3SM2FLP2PGgu2FSF5A1RdAzVIoUcTr9rERwteBmPMgO0GBhrMFYnpdOcsQxAsx58cVTm8PH3wP/d/r7svNiR36qca7grZYsHEAT/haUgvXfehyCT6HQcuwS8/cG2OeuvkD7YThIbN9y1G+r7QZAkRNl50XjRYzvzzX9ANSADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910879; c=relaxed/simple;
	bh=7jFhU3TCx4qkATYUj58D0VI+IAvlmWX5mDxt6ZYhrHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZm3dT05G9lACvlaJXSGvkdiwb+DjYFmkBOGkgQXcmdCaWOu4l2uHPV3Z1qaqqmexYXx+yX1h2O4SQht+pefjI9ZinkV53n+qJpDY4mkCxKi0yGXWZPJ2LOsQ3fX/loR6DqFdvfWFr8mSXtP0rWT+jplzQBf7PyephbRllN2Jao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdY+Yg54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EFFC19425;
	Thu, 23 Apr 2026 02:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776910879;
	bh=7jFhU3TCx4qkATYUj58D0VI+IAvlmWX5mDxt6ZYhrHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OdY+Yg546AUQpX8jmcbtOPDUOpI4l253B0KYwuaiFkh3uAbsXkLn01eRjFEefC+Mx
	 AEc86SkbTOwd6mPUE4gL1X8tif3REsMjjZ2vm7dB+ivtsg13a/mp1fbb2ej8wOlIbA
	 0k77CBq6b+wLcmmQHTKpwNprTSecg3qYSMIXLKFTKkT7f+5510M+AA1r/lUfh9aO1L
	 FPPNAETEDMB6Dkvw94Gi0LX9ydagDVDZVlS9v/yBrD0US1TKkck2oS1TLYV3Q1QOVM
	 LeJBnS3E2IvXvk8buXddFLsgwSY+vIqGy6Z/rZHD6awWH1WLgIIHQZXZrMoOJNPzV8
	 OCIl+XKZIXwAA==
Date: Wed, 22 Apr 2026 19:21:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michael Fritscher
 <michael@fritscher.net>, Byron Stanoszek <gandalf@winds.org>, Daniel Palmer
 <daniel@0x0f.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH net v2 03/15] drivers: net: 3com: 3c574: Remove this
 driver
Message-ID: <20260422192117.2d94acb2@kernel.org>
In-Reply-To: <AM8PR04MB7284CF79628FB99F7A7F20D5882A2@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
	<20260422-v7-0-0-net-next-driver-removal-v1-v2-3-08a5b59784d5@lunn.ch>
	<AM8PR04MB7284CF79628FB99F7A7F20D5882A2@AM8PR04MB7284.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280575-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C13C44C417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 02:14:22 +0000 Wei Fang wrote:
> > The 3c574 was written by Donald Becker between 19973-1998. It is an  
> 
> Nit: 19973 --> 1993

Will fix when applying FWIW

