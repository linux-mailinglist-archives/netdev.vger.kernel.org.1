Return-Path: <netdev+bounces-280282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIPJKB4n6Gl0GAIAu9opvQ
	(envelope-from <netdev+bounces-280282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A484411DC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B743018765
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412829A31C;
	Wed, 22 Apr 2026 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaJAPuDv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7761A683E;
	Wed, 22 Apr 2026 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821959; cv=none; b=fd6fm5lLRqTLwIaIFfJJGMKrkNVFKy575EG9Fk7FMAKklV85eO1ANSti3/ODuOwz/GuO4P/NavNO3xCOb6RDjByJpSsbbWoq54l33OQtOzwpDXsyLnSSf7pc0bclCcpo/DHgTbLr7pPA20UBDOUnN2GVmNyUL2wz5Vz7F+sJpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821959; c=relaxed/simple;
	bh=kXDdz6fh1tHiWWOVkx/MOqXVrqSnDJZ0bxKziJBaOyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STUy8eCMoVY9gauG1hYXHiBd86c0QR3EGsIC9U3IXx3WJr9k0a1/W82UTge/Mp7ies0Q9BacYD8h2oPdAtOhdck6KcDxMrW3DCwHlaYJKPkrGPvN5IebmooFf1L7WqfdC5wwDUXb7qoqZhH/aLSnFxEjXVMRVBdQ+HELuR6We2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaJAPuDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0CCC2BCB0;
	Wed, 22 Apr 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776821958;
	bh=kXDdz6fh1tHiWWOVkx/MOqXVrqSnDJZ0bxKziJBaOyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JaJAPuDvw0JuXVFO9/L1rWLgI1PpSEKd+0nGXW1+43e2VVxkSOfOU80a66n2GQbwW
	 KvyIvjWrVT1IKDJu6oM8VXZyhbC5vUpcnT58TE/Tn9jm2sALkpQRo4ApJ7TuTRAC67
	 mOSAUBX6nFzq+UtkRDipeJbIvdUtXoRNA+K/crhFrqEdTTmq8zPb1zJaHk15KSgwFi
	 9txjI7lLxzfAOUL51/Kp9I4WBcce9DwhECeSojMTuK6MZ414gCaDwK5nGd5gbgB0TY
	 5Cki5he9gFpwWQImTTFLmPF5egpHagzNKPG4ZJhHO1TZjUhNaB2XgPUuQEh7TEgsZ7
	 QyonEZkth7kbA==
Date: Tue, 21 Apr 2026 18:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <20260421183917.0dc30ff8@kernel.org>
In-Reply-To: <87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
	<87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 13A484411DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 21:53:38 +0200 Andrew Lunn wrote:
> There should be 18 patches in this series, but it seems like b4 send
> and exim are not working together too tell and have truncated it to 10
> :-(

Looks like they ended up coming thru and got nom-nomed by the AIs,
which flagged some omissions (in docs mostly). So I'll keep the series
as "changes requested".

Please feel free to ignore the 24h limit for this. We need the
deletions shipped to Linus by Thu.

