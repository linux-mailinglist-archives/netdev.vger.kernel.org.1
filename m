Return-Path: <netdev+bounces-272271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFS+Ohy2xWnxAwUAu9opvQ
	(envelope-from <netdev+bounces-272271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:41:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FFF33CA90
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0583197E1B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A033D4F2;
	Thu, 26 Mar 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+e1mTyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7C33BBD1;
	Thu, 26 Mar 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564178; cv=none; b=Hdy/09pa/IBTB7oytXSg0vDwYGc8Flke2T5VCILUtMGS7nK4iP7yd60zGPwLHHRNqLQjC+icTUEo7kRTdVkjbm/lutO7uW8lx1cD3tPlbDK1OBCS7V6/Toq8oyOABn5RwDBc67rHUmYQicuDCG9Kd4EQe0Gqu5j7VanDfYf381s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564178; c=relaxed/simple;
	bh=CArnRfnVPCa8bbY0l8IMw0xFFHvphDDOuJvw/NxmZZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iutNlZbBXJiYBFe4OOMItbIRFsXmYjXOiDJKHhaRwnD9JDByghX09206PdSXepbSsdeRA6WEEycQSko/8ue94EYNB6gyUV/PxN1eHrlPD1mVXoOo4n+lU2LQ1qURnJjP8soQFNHN9wYOirelbnNzTBfGpFVZ4rjkCydbzA6YshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+e1mTyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0040FC116C6;
	Thu, 26 Mar 2026 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564178;
	bh=CArnRfnVPCa8bbY0l8IMw0xFFHvphDDOuJvw/NxmZZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+e1mTywNu63ZjBEK5m2QuQ0qlmcEhYgMBapC7QHkV7zT9BeAMYXkKfRFDdwVad3b
	 B1fv96z8jeTUZ790XcdOTX70VCwAlxYQd43YIYoAx7K44mjLi+1IWXjCFjGHKW0OhL
	 GlO777tTbGVWe6846qKp40vpp1EUJ3IN/2rwqW5DQc+3fAJ/6LZglnqGqnTeN/8EVm
	 SNzUH8AnXjN84kUbiM6htJXDoGuSK6hc3q6Vt1u7AnbM18iak0lSCEZkQM6I9Rhcy6
	 +pZsnXnbm4oxGUT3eezX9muf1CXR00vjy0JL+3XOTjRLEfn86Iy1RefU3fcFd060lL
	 7ClbcRWezzukQ==
Date: Thu, 26 Mar 2026 15:29:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <20260326152937.7196847d@kernel.org>
In-Reply-To: <20260325194256.988853-1-admiyo@os.amperecomputing.com>
References: <20260325194256.988853-1-admiyo@os.amperecomputing.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
X-Rspamd-Queue-Id: 75FFF33CA90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 15:42:54 -0400 Adam Young wrote:
> Implementation of network driver for
> Management Component Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)

reminder: at most 1 version within 24h on netdev, please
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h

