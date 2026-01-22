Return-Path: <netdev+bounces-252124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB9COiN5cWkvHwAAu9opvQ
	(envelope-from <netdev+bounces-252124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:10:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367C60319
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD1D334A4DB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443133ADB3;
	Thu, 22 Jan 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYr9FmMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E022272E56;
	Thu, 22 Jan 2026 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044253; cv=none; b=FbwYfWq1q1bXyay7mOGlYtEmeD+AVYJRQPO3NvL+nZlVrOT4nxcZkHAP2ujSL6hXeyiX92X4I7jzfhIDW71gnyVVSxjNoO7BYQCl8NnkL6k8RH+XqnjKGwlhwVubjG25AQQS1+dltVmhCES7JlXAWsB1qBK9x/5UQvvkRGtlSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044253; c=relaxed/simple;
	bh=SnjxMNrpiXts4MyVSCyZNLR8uqtfwWGMPW8+wfeXfX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8vEzzND+zyr0UwT9jQKogwkzd0PTtSMBwbi5NS1JOZ6eN6JQ7Xla78dPbOAx+AKsR57Otzjbhng/+5M8FMM3OBoUV72SEnBr8NfzsaHJ/BX8aGBdd1aYviUNsxqmQXQJ4P43dQZ3vTaYntMnxxGMnAysb0exHph59zCTjJGP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYr9FmMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E97C4CEF1;
	Thu, 22 Jan 2026 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769044253;
	bh=SnjxMNrpiXts4MyVSCyZNLR8uqtfwWGMPW8+wfeXfX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYr9FmMIjBvbndlH762oetJSktbdyFN6oDz6TM1jyJeal/huS/HYmgHLG3YZiKzHA
	 RqBRpgPJcab0XmPWi10sKgdgyqCnaYyukoCXytEBq60rSYyl88oLVe5EiGidZKmw/A
	 JhR9TY/JbLAXQKeaJ/IiTEhK9cEsCY7UHMXi9wNe2bRiAKJXuvHruJOVqOxjTHP3XY
	 TBGjgwlFGHwVeqsq/gbbvRf1iNndJM3yJYqU2zm8thhXwopnkHKsbQL+P2UHcjVaQ7
	 v8Mtpebldh15OlOmJHc6L+RONuftV2pEv6mckdHYcDEcNaWXj1irHasvtnunIBXioV
	 7MxdknmchPKjg==
Date: Wed, 21 Jan 2026 17:10:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Mahesh Bandewar <maheshb@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
Message-ID: <20260121171051.039110c3@kernel.org>
In-Reply-To: <eaac2f5e-842e-4a18-a7a0-8a7ba2794ef9@redhat.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
	<20260114064921.57686-3-liuhangbin@gmail.com>
	<20260119122203.5113b16f@kernel.org>
	<71e30492-7644-4d4f-aaab-9a505f8faae3@redhat.com>
	<20260120151109.2d483bd8@kernel.org>
	<eaac2f5e-842e-4a18-a7a0-8a7ba2794ef9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-252124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9367C60319
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 08:58:13 +0100 Paolo Abeni wrote:
> >> My personal preference would be for 2/3 landing into net-next: the code
> >> looks correct to me, but refactor has IMHO still to much potential for
> >> regressions do land directly into net and the blamed commit is quite o=
ld.
> >>
> >> I suggested targeting net-next while retaining the Fixes tag as we
> >> already had complex fixes landing into net-next in the past. =20
> >=20
> > The appropriate way to delay propagation of the fix to add:
> >=20
> > Cc: <stable@vger.kernel.org> # after 4 weeks
> >=20
> > not to merge things into -next. =20
>=20
> I went over the code as carefully as I could and I don't see any obvious
> problem, so I don't have a so strong opinion vs net, but to hopefully
> clarify: my thinking is that this is net-next material because it's an
> invasive refactor with behavior change. My preference would be let the
> code be tested in next/net-next for a while before landing into mainline.

=46rom the patch description it look like user-trigger-able hang of=20
the FSM. But if this is more of a resiliency improvement than a fix
then I'm perfectly fine with net-next. But then no Fixes tag and=20
no stable at all, please.

