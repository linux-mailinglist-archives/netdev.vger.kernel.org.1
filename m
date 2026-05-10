Return-Path: <netdev+bounces-286368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHo+IlnRAGoMNAEAu9opvQ
	(envelope-from <netdev+bounces-286368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:41:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26039505BF2
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 863B1300233A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2A302165;
	Sun, 10 May 2026 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxoGcBYu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4514A4F0;
	Sun, 10 May 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438487; cv=none; b=AL4yaCMEZvizxUCzDAqd2UvUC3yYCU4oueZwiDRwQbJ7ONxq3ItJXZ2AXeAp8TLz1pr8l3O19Jeo8f7GrLecwQb2YgMOl1BewOWm4PjaGmwvWqKjGnRXvgkqL2Abu/H5tXMFKLPR4GKYFs72mYG2Fw6Do72vF42kDskUNgoTEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438487; c=relaxed/simple;
	bh=FGAetDrPER/USpU+imGT7Qc9WeizJpAF78sFxLjUXzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7ezWHtDLJ+ZzzirpL/2ejpnXpMuDz8APA5NNuHEokQtcceCEU58jZxyCYMPOYUexT/O+MumDvspRk2UcZBe5cdkRX/ddLlAz2McsE/IYwmIV/MY5XtDTsVIWV2PwDqPDSTyvisyOFRPVjzp/KYyvZdwO1M8pEhLt9kooLMkJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxoGcBYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CA4C2BCB8;
	Sun, 10 May 2026 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438486;
	bh=FGAetDrPER/USpU+imGT7Qc9WeizJpAF78sFxLjUXzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxoGcBYu+ryyGsFAQpgSuNmzWO3PaasWIbaMCXnbwaUNViwx3mFysOc8G2/IDRbh3
	 oDF1TcyNcxzzhVy/0riMjrn0b+8zPv50LsysbFeEOafnemNqWWZ/JRuYJqGZJ1UhTU
	 Jcpit+zPYXsrak2n1AfXuV+0TNPCC/r0hMbFStQ0S9K4e+B++kNkTpPkGEgkFxA2aJ
	 jKLEDhafay35PKeRk/4HpQNurA4IX4IymrC2QjM6wwRif1begMm5ml2XdMqkeOc+jR
	 UUUiZGu7MhTxUGacxRF+Ox7+3zMbQDBcB2UgMINkzf4ITKnc4YTU0PARXjuPqjU8ac
	 tLh1UCp9nVhEQ==
Date: Sun, 10 May 2026 19:41:22 +0100
From: Simon Horman <horms@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] net: xgene: fix mdio_np leak in
 xgene_mdiobus_register()
Message-ID: <20260510184122.GV15617@horms.kernel.org>
References: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Rspamd-Queue-Id: 26039505BF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286368-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid,cambiumnetworks.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:50:24PM +0530, Shitalkumar Gandhi wrote:
> The for_each_child_of_node() loop captures mdio_np via break,
> holding the refcount. of_mdiobus_register() does not consume the
> reference, so it leaks on success.
> 
> Put it after registration.
> 
> Fixes: e6ad767305eb ("drivers: net: Add APM X-Gene SoC ethernet driver support.")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: There is an AI-generated review of this patch which you may
     want to look at for possible follow-up. I do not believe it
     should block progress of this patch.

