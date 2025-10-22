Return-Path: <netdev+bounces-231876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAF1BFE128
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2233A468D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7834C144;
	Wed, 22 Oct 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RZyJMxxH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638D2F60B4;
	Wed, 22 Oct 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162113; cv=none; b=RGHWLsxdtWojEsV3qx4o4gniXYoPpBZ5/uFRm5ANRWsZ8x16Wfry9huYbs+GNsi77C69YWmn87pdZ7ryWV3FGfNJD4ZLkJAXUvqXrMBX6VUEOJr/hvgbNXwE9v+w+TiuoAcgZWIZ0cNhxyjGan29i40hfIs3BK8M0vbxU9um9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162113; c=relaxed/simple;
	bh=J958PiBjG200PYShzC71/+JJi9SG0ZYAQy9R0y7Hqv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuz9JR/x4U2fo5Q6MgKVogITfG3hGjsna1Mgvw9yjSBqBoUg7E/keC7sDdlW7qiNew8BO1hT5MElF0m+dlUb5sDpzBKPrJGrp49dZgybqpo1fASIGpBcmKCu6vQ8V/LNyVn/3XBXj2+S3TVRfufU2mL616EPOtFDdMgRwvQ/a3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RZyJMxxH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UimyisFTul8+MR2D50IK49ml177jHy2wLXd2XtkGKxw=; b=RZyJMxxHQK/iho9i+AipZqwbvN
	9jrqQ/UWZjyPKlgZWdXRnf8Sfj3XvcJniwXjcICZ1xgTbP0cHWabmVQSh7yYuYWU1l5r9jrXcuQ9Z
	myHM7bxK/V6pGm2PQo99xebxMb+ShtjIt1WDUgaj8EnnhqppctLEQxhuMHOWRYIf4BWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBeiO-00Bo8l-GE; Wed, 22 Oct 2025 21:41:44 +0200
Date: Wed, 22 Oct 2025 21:41:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Message-ID: <8b8e75f7-8fc2-41c9-b5ec-596552b1b0d9@lunn.ch>
References: <20251022172045.57132-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022172045.57132-1-biancaa2210329@ssn.edu.in>

On Wed, Oct 22, 2025 at 10:50:45PM +0530, Biancaa Ramesh wrote:
> net/llc: add socket locking in llc_conn_state_process to fix race conditions
> 
> The llc_conn_state_process function handles LLC socket state transitions and is called from timer callbacks and network packet processing.
> 
> Currently, there is a race condition due to concurrent access to the LLC socket's state machine and connection state without proper locking. This causes use-after-free, array out-of-bounds, and general protection faults due to invalid concurrent state access.
> 
> This patch adds socket bottom-half locking (bh_lock_sock and bh_unlock_sock) around the call to llc_conn_service() in llc_conn_state_process. This serializes access to the LLC state machine and protects against races with LLC socket freeing and timer callbacks.
> 
> It complements existing fixes that lock the socket during socket freeing (llc_sk_free) and timer cancellation.
> 
> This fix prevents Kernel Address Sanitizer (KASAN) null pointer dereferences, Undefined Behavior Sanitizer (UBSAN) array index out-of-bounds, and rare kernel panics due to LLC state races.
> 
> Reported-by: syzbot

Please take a look at

https://docs.kernel.org/process/submitting-patches.html

> ::DISCLAIMER::
> 
> ---------------------------------------------------------------------
> The 
> contents of this e-mail and any attachment(s) are confidential and
> intended 
> for the named recipient(s) only. Views or opinions, if any,
> presented in 
> this email are solely those of the author and may not
> necessarily reflect 
> the views or opinions of SSN Institutions (SSN) or its
> affiliates. Any form 
> of reproduction, dissemination, copying, disclosure,
> modification, 
> distribution and / or publication of this message without the
> prior written 
> consent of authorized representative of SSN is strictly
> prohibited.

FYI, this email will be archived, and be publically available for
approximately forever, which probably goes against this policy.  Your
best bet is to remove the disclaimer, if you want anybody to actually
look at your patches.

	Andrew

