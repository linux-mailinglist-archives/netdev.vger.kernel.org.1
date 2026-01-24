Return-Path: <netdev+bounces-253115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI1cEN9HdWlxDQEAu9opvQ
	(envelope-from <netdev+bounces-253115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 23:29:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20117F212
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4EC300AB38
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF727BF6C;
	Sat, 24 Jan 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wl7iN1ws"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A65269D18
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769293789; cv=none; b=H5ZNFlBljqnF3xB2dyYHFfYHjsAeAejYvo9O/3f16g0zquXdZgOkVgIhyo9om/yVmZ8UqDwGa14v/ohLej+qog1iELOCtj1BVd6trOZlyMJVN1pJqTLUbO2YX/OSDT9+peOMKL8L+rCeHYmuFud9G7is1956iQLMGpgyhmJNOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769293789; c=relaxed/simple;
	bh=XfaVZ48abcKeHowHpxnfgSkhDMjuh42CR8Z+C+skJz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbXc3/SGuGID1i7wAmXXasJJr+2+Iz9nH3anp2oDyQy1ZjblbarpSQm3gIhF499ihS5Ty9rri2BHB7gage1upQMmpBQutJ/ACuR67Ejn2lcEgeRNENABIGZNXL9y6PzNxZbtggKZRqXf4VjCww63d4677gcoYtHB71H0VKSGqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wl7iN1ws; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8m/16O9alt9lb9iU+TEcXPNlhl6+Rv0dYcZdwaV48nU=; b=wl7iN1wsEezk80pPogDiUjSTX6
	Ae6ANulULpEUFWhv2VO1obN7WUC8LUQV+Wb+hOvJyCCnFg11cXwN/XERPXhynh97n+LAEEXQh6TcQ
	lAZYrOv2+KoYEMSc7q3FVVJ4K/J00ioWQpGJG77xp6tJmnOPd45cU97FqJmcodaYdrDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjm8X-004WHh-Jc; Sat, 24 Jan 2026 23:29:45 +0100
Date: Sat, 24 Jan 2026 23:29:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] doc: add AGENTS.md for AI coding assistants
Message-ID: <6f5f0afd-ded9-4438-9dc1-82483581489f@lunn.ch>
References: <20260124221439.234122-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124221439.234122-1-stephen@networkplumber.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253115-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C20117F212
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 02:14:27PM -0800, Stephen Hemminger wrote:
> I (and probably others) are experimenting with AI code review
> and dumentation tools. It is worthwhile to have a baseline

dumentation tools? I know we say code should be KISS when possible,
but i did not know there were tools to help make our code dumb.

     Andrew

