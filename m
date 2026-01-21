Return-Path: <netdev+bounces-251873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ6lExzTcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:22:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F757781
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40F3C66A72E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFA36405C;
	Wed, 21 Jan 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g4QLjE3L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6924E4A1;
	Wed, 21 Jan 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000904; cv=none; b=saeCNllUydL5KyAAxeVdAyFCijHqiX+shN37/FaN9XOeb1vZv1z5NO7SrbMjk4Q2POmDG6Kovf9ADQ7T+hRCFmpu+7iAolixeBhOu3Vl8cvkv6MiZ6QTjNOl+KhVuD6IbFlkKKuk3pgZmq+sYglqGKAq4N3UbK5DAqGB2VBv8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000904; c=relaxed/simple;
	bh=NrXdFStxEa2mOJ95/o5EvA1LtOMRovnSBIfwW+kqwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCkJhN+fdeCMqw6g9zmApZyQgDm2lCJ+BNyU/zSwrmeyj06Sw6Lynic69pPpIpEBxWbY4oTSSSm1IdSBfweKEPkY/x9aT5rOxrit8GFoyKsyWYIbuUSlLhEHVQMTgND1Zj3nRr8szkoHbnvFZNvIwnDvZYCpGv9MgImtlIUF6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g4QLjE3L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DjtY3Y+EVEI/+uy6UNTO/Ue3hBblWM6Fgy18ZlQf6Fc=; b=g4QLjE3LFY2vITAsFa3+w6Z7FN
	4WywkWxyuzChy2NhrO6DDYvKhcVfQPUVMOVRaqOy1MEEcFiI6caLcZB2jn6wWk6j1umb/iEKGY95a
	tZZhZGK/b6Wr0rFlHZ8N0PBeDBQ4h/PXVH4uy98J6TJucwZRl73J6q0svGBiRRLG1LmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viXwV-003ou5-QL; Wed, 21 Jan 2026 14:08:15 +0100
Date: Wed, 21 Jan 2026 14:08:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Message-ID: <388baa3c-c959-49f7-ac0b-99c2ea266690@lunn.ch>
References: <20260121130704.2236452-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121130704.2236452-1-weibu@redadmin.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,redadmin.org:email]
X-Rspamd-Queue-Id: EC8F757781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:07:04PM +0900, Akiyoshi Kurita wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

