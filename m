Return-Path: <netdev+bounces-253630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBAXAg4EeGlvnQEAu9opvQ
	(envelope-from <netdev+bounces-253630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:17:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162C8E6DE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CABC0301BF67
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245216EB42;
	Tue, 27 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt+E/Psq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38E78F3E;
	Tue, 27 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473033; cv=none; b=KXtMo4+hgDNXJInV1MQNVrbFD12rf4vUsRcguPtj4vMHnL0G2LinqcxlroxR09A7mY0XgIRXU33tro1HFDarhMU4/GUNLax75FVx6ox/extAfwY77zttbxOanuJR3z71lJ++alnerzE+XD55ryBy6Z0U6LOiDbr8yJwZgutEQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473033; c=relaxed/simple;
	bh=KkOYQevkpGOrnDIoJPRQGxUkPN409sQyfY4sFH+8OzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H47fylQOiUJRn1oTZIK6yaK6ArTnXyuMdAx2RQhsUq4gcfR0RV9ESZEkaQ54YhzPZKgH7ma5WjERu8OrJYeJEyKOeUmxdO9ygNruNeQIwNoic7D3dHYSRTD9SdVIsXpsOw0SbqpAlih0hCr+xhSzMmA9UMbiLTZo2zlzATuP94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt+E/Psq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B83C116C6;
	Tue, 27 Jan 2026 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769473033;
	bh=KkOYQevkpGOrnDIoJPRQGxUkPN409sQyfY4sFH+8OzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mt+E/PsqP0byrVFgyagQnoUX1xKvoR618QUcQ9TXglRCWaMri7VLyQVNwFPZCEboz
	 I6jZSPuZKykSZYDXibh/f9dpz+fN6bayGcTqkdjQDJy/n52LormX9deMT44XWtAq+E
	 R2XAenRVgsdA7JWrsZYnE/o66SlLfvTLeLQFjpzn8k/JfcKXN4QOblLlm0DF6BvPm4
	 zY514/2/v1oud4d45dejbl700KofsgzFRgaHcLQPMIJ7xj35q1F9WNjlls/n9/NopU
	 0C1yr09TVCdkol7D2HyyWWk1st51X1uN8hy0ZtZmkMDbDZsUCXEar+hQyxRMlA/dWQ
	 3CxQdYtyhaDOQ==
Date: Mon, 26 Jan 2026 16:17:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
 <shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 "ast@kernel.org" <ast@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [v4,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Message-ID: <20260126161711.2ee02510@kernel.org>
In-Reply-To: <PAXPR04MB8510775746A1CAF835E365718893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-7-wei.fang@nxp.com>
	<20260125214446.3383999-1-kuba@kernel.org>
	<PAXPR04MB8510775746A1CAF835E365718893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,iogearbox.net,kernel.org,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-253630-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5162C8E6DE
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 02:09:13 +0000 Wei Fang wrote:
> Therefore, xdp program will not be installed for those platforms which
> need swap_buffer(). Because the XDP path and the traditional protocol
> stack path were previously mixed in fec_enet_rx_queue(), the logic was
> confused, which led to the AI =E2=80=8B=E2=80=8Bmaking a misjudgment.

Understood, could you add a note to this effect in the commit message
to try to steer the AI away?

