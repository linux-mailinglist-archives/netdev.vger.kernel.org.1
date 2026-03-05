Return-Path: <netdev+bounces-264461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oChLGa6gqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:26:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A632147BD
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AC47300B598
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF993BED49;
	Thu,  5 Mar 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBOFcs/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D433C53A;
	Thu,  5 Mar 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724109; cv=none; b=XNWuSxO90xkkMZ26bEHrH5PLuVNazNCj3h5GWTaz2gRcxkiY99ruHQHj7HT7PSxefCNhgDKF9cKWaxv3j9C6zxyfJLuKwRM7WoG3Qt06HIrmDZzSlwvp2g5fBMnVHpXEOuS4yzQs3RrSGz9iIf8bIGkrkuh1E732lHMTGkbxD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724109; c=relaxed/simple;
	bh=Ko+d+6D5NOJWl3qoXrPZwe0PpbdIedfPT4KtLsRg8zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTeVg7Za+/J5EC+45gAClpRiPwoNMyrDgdwJMpq2IY2vAg4BS16wdW1TL5TV4cHUOSt+gUEHbmPjg1hO1pPiW3b0Sbu+cJQptfr9I5ZETS0/z8TO8oP1EFy54x0Z2H3mn5DxIDiSiOjjsqd7/HzlVrogeQ+X6yvZ/xuUtUpsIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBOFcs/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD75C19423;
	Thu,  5 Mar 2026 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724108;
	bh=Ko+d+6D5NOJWl3qoXrPZwe0PpbdIedfPT4KtLsRg8zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBOFcs/NmzcJQhsGghr+1qQQTA0L4ZZRY1JOSUzFSfmfqle457RysvyW99I0iWS0Y
	 CQWxllE/lR1tqsgI/p/bHZ4YUCeKfX3ARLd2qN2qChEfX0VIdEdIfhyqifi21Ujte1
	 dy9bxXuv9GdFjUTx4oG51rV2uf6Twkh0o7oo8gIK53l8Ai+k3HgfDfSak0haBYIlPg
	 V3rQ86sjrhOs/W+iXUPUvlxQjIUW3kNpel3oXh7zh5K46TJfJFcHYyj0AEgm7lWRCs
	 hB3iOpeb2uN7Gf93xBxsxOnSxYClx5s+dS3kZzWGMslB1RzXa3iBeJ/1WPKQY1tuFG
	 7PlJS0pQWUyBg==
Date: Thu, 5 Mar 2026 07:21:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mnhagan88@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
Message-ID: <20260305072147.102d9d43@kernel.org>
In-Reply-To: <20260305125235.51286-1-noltari@gmail.com>
References: <20260305125235.51286-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 25A632147BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264461-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 13:50:32 +0100 =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
> signal, but we also need to apply sfp_fixup_ignore_los() in order to be
> able to communicate with the module even if the fiber isn't connected for
> configuration purposes.
> This is needed for all the MA5671a firmwares, excluding the FS modded
> firmware.

Also please don't repost things more than once in a 24h period per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Andrew could have given you the same feedback on v1 :/

