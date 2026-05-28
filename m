Return-Path: <netdev+bounces-292479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAOUEqiGF2quIAgAu9opvQ
	(envelope-from <netdev+bounces-292479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:04:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91A5EB1DF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9FB0303AC22
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D41343887;
	Thu, 28 May 2026 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9ws8vPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9464;
	Thu, 28 May 2026 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926690; cv=none; b=Va97kZLACJJRhtsTB3ApnDHjuKHTzpXxnOVMW5mdc5ZbAnh+sk0QE8SHATBhlc8eQS9vHQndZtRat1A2Kgci+Wv2KEYu2IGPZdQRg/snykRL28MQCZ/2CRMneTdH5AJj2i8fTE2k+9oyhuDOQgg528o0qZQBNlOEqbmjMBABjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926690; c=relaxed/simple;
	bh=Y8dPkvHH0k3eqI68OzvyDzuVRrQ/6R6WKZwxFloxU7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs+GFjrLhXo/8yZTm9GOhPXKvgpK6tKDi6uPSUkePvR+RC1vYvWuDetNfg360CCLj2lFOxgIMbrIKwFanzabRl2I63vhWY1jpwSxXkd6sV7iDRlWrULwMd2+LW0JFVckIZ5NG4nFrxmd1AfR7xYHPw5EPy5Ba524rAqg+z3l9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9ws8vPx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCB41F000E9;
	Thu, 28 May 2026 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779926689;
	bh=KpNzEK8ilcsreYFLZ0HInY53a42KARK8PPrBKd+7WlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i9ws8vPxNZsQMuIdLNwEsw17ATOgrueS1Xbd6EVtg64N3IohZUl4ACh6twy70BLcw
	 4IzWyVABbVvjBHOndjUiimveo2vIb4L+JJaOzYj/Er0s40OkX/6JfF5EpAtILqbOCF
	 5n0JN0LlG74Xo5cRQ/TQhOn40IUNmkOTvjr59BjXhXGbSML/5yNos+mPuiaHfIDCQO
	 T/+dW713J9w84aZRltnp+LGyjfY8cgWJpLFSUWo+Gt8RPY2fhh/IGGuDcJMwHmc3Yd
	 sl+GYiLXKz0WGQx7f6rKzrweH+xbAw2+VvUA9u40bGr+BaclHXz+n1LyWICr9BCI+L
	 USvlJIXrTuiAg==
Date: Wed, 27 May 2026 17:04:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: rmnet: clarify MAP command ACK behavior
Message-ID: <20260527170448.350f1c2d@kernel.org>
In-Reply-To: <20260523110346.1672-1-dennylin0707@gmail.com>
References: <20260523110346.1672-1-dennylin0707@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292479-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ED91A5EB1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 11:03:46 +0000 Hungyu Lin wrote:
> rmnet_map_command() only sends ACK responses for supported
> commands. Unsupported commands are dropped without sending
> a response.

To me the words "as appropriate" express the fact that the ack
is not always sent sufficiently. This seems like pointless churn.
-- 
pw-bot: reject

