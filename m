Return-Path: <netdev+bounces-281526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Boq2BLvn72l7HgEAu9opvQ
	(envelope-from <netdev+bounces-281526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:48:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D247B9CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33499301738E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A53AE196;
	Mon, 27 Apr 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7CCmy2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B383AE184;
	Mon, 27 Apr 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330104; cv=none; b=UG9IFDOpUrvZ2okk598v28CSNwXB0UjpNuZASQydk8YJzmaAqoH4vOKQtOaUTX8NaajuqN1f2QxTXkSWNCagTfhCBdWyGa6V7j5tj9XiI98kkoxOC2eLzLS2lmX6efIypmri1heEEW73H5dLn6X/DmuZVDxyrgRXp6lFd2Oy8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330104; c=relaxed/simple;
	bh=DUljwczvOM2bJ4zPZp+j5VqZGdEeJyU1nWeBuQT3kJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHJVPOAhPWKLWKZwAuIXbBe9ZvpL1dCY7gcQq3/OsV7yylzx3C99igVPvFzCGEPsaGJ6yw2Wpbda3ssn/maxBq46zZVdWQibVGbrpeeSw+pvVzWGWvhpsbHyR+Lr7NRztR2iLDidPI1zhRFhvhdBrauA6azRluApovc7X+0e89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7CCmy2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA480C19425;
	Mon, 27 Apr 2026 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330104;
	bh=DUljwczvOM2bJ4zPZp+j5VqZGdEeJyU1nWeBuQT3kJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7CCmy2VmoqP/jHoI4WSezsrZde6TgpLvod+ir78x2MFt+z1nMDfacy7wuQRw84XR
	 IHqAm0EyHxmfwfW63L8fLfbyxGevDScyMglljPS5UFAC8DgU7BVakbDrUbSR1Gh4SG
	 3mY9dsvUHbGrFOm25RZmzgYH6akGXaZGVAFT5gdz1U6HS6VTwxJ8m80cXy8UJWqsQQ
	 lm5bznaZ7iPdz0zNcJ+tUvPcK3HROIyXV9XNBaN1NMYVCTfHH5LiiPb8uigyoyGi4L
	 YInyLnIbk5o3z/RIhOqkJy1IFfqTfNxscXk8qtlyULsWKxIZRpcxBehk79+liPpupJ
	 vzD1lB1VcEdXg==
Date: Mon, 27 Apr 2026 15:48:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v5 0/3] selftests: drv-net: convert so_txtime
 to drv-net
Message-ID: <20260427154822.6866e056@kernel.org>
In-Reply-To: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
References: <20260427201640.294694-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D8D247B9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 16:14:32 -0400 Willem de Bruijn wrote:
> Subject: [PATCH net-next v5 0/3] selftests: drv-net: convert so_txtime to drv-net

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer

