Return-Path: <netdev+bounces-264977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LSZNqpwq2midAEAu9opvQ
	(envelope-from <netdev+bounces-264977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43439228F90
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A413026152
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602B26560B;
	Sat,  7 Mar 2026 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4seNwR6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAA14E2F2;
	Sat,  7 Mar 2026 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843175; cv=none; b=UWFjEz1knYB5z1PXry56UfZYKfAiNfLEulmFERZgmHIb9prCeDqx00kwdVhROkcuaoiyGQMMmUOjCADmRhoTV421/TyaB4nf2qIbzqsGLc/VZACRlMxNV6O5dwYgsmFZx+hUXyA8MWz+soUMTfHLBwer2hB9hPvSHPENYe/7Nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843175; c=relaxed/simple;
	bh=c9jGF2crzNHwAfzX8DOWqfH6LyBAuBx+7b4tN21jMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDu1aTHh5eKvPcZ9KRBhNbqN1FEQV71UjDzHCsW75APWvd3K/7t//LRSQRI1SpgGn1sQcLaSlhAl9tPgzJ7Z1toV3+F3p15prFjesgxwpOylziZL99uEjrUnetYHvNTmL38/brW7ijS/0FxtSF/lI4PamnkZftF3x581NCILggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4seNwR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED6C4CEF7;
	Sat,  7 Mar 2026 00:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843175;
	bh=c9jGF2crzNHwAfzX8DOWqfH6LyBAuBx+7b4tN21jMRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S4seNwR6sp9EXPdroqJsVf7G8RMEujINWTt7qW2TGE76lFuXRudzl8xPedcg7IOav
	 MUDktXQLlvKv8cum5zeyGjUB//eQbkqlZYAZtICBbOscrEvhRqqjKEX9992h7iT5bl
	 XuEkgxRcQy/PWRXRRWrbX3UHIN0QRPcoHPufPpMWbICibGIWda7KcMVHqjjZSaM/RZ
	 5pULNB/MzTZdG0SS9qfPtc1OW+GmnGuTyCoForFmYOoCN2BheBCodG4ZI6V+GwNZK+
	 rQexUd6TR1PZxiHaK9uSbJDsDs+N/zpCEo5qLTXdQ1dmHoZoi01uW+OccMBR9cT/xU
	 fCB/hbyLszV3Q==
Date: Fri, 6 Mar 2026 16:26:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tonghao Zhang
 <tonghao@bamaicloud.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jay Vosburgh
 <jay.vosburgh@canonical.com>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net 0/2] bond: fix 2 link state issues
Message-ID: <20260306162613.05a8ca6e@kernel.org>
In-Reply-To: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
References: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 43439228F90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264977-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026 15:13:52 +0800 Hangbin Liu wrote:
> Here is the reproducer:
> 
> ```
> ip netns add ns
> ip -n ns link add bond0 type bond mode 3 miimon 100 updelay 200 downdelay 200
> ip -n ns link add type veth
> ip -n ns link add type veth
> ip -n ns link set veth1 up
> ip -n ns link set veth3 up
> ip -n ns link set veth0 master bond0
> ip -n ns link set veth2 master bond0
> ip -n ns link set bond0 up
> sleep 1
> ip -n ns link set veth3 down
> sleep 1
> ip -n ns link set veth3 up
> sleep 1
> dmesg | tail

Are you planning to add a regression test? Or you think this is too
much of a one-off regression? Just curious.. 

