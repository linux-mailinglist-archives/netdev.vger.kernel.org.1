Return-Path: <netdev+bounces-288118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FzrD3FlBmqbjQIAu9opvQ
	(envelope-from <netdev+bounces-288118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD6547ECA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BB530268AC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7415A864;
	Fri, 15 May 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrexBl54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFA70818;
	Fri, 15 May 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804077; cv=none; b=TKsgBsZZHLtBDlNegWtm4Z78uvzFvDeI41dmYacCjiy38yL/a9o7e2k/F2xe+cQyAlnDp+yaqqD5xUGMkyWtG/+5u5av5TBCGhddeJww2PnuXItZhWicOC6S7xJdSPvWnoTjzB4htdraLh4deDeLbhxfa1lGa3TKopnNRT9Kr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804077; c=relaxed/simple;
	bh=RK4Vq+dmrSCj6fWFvDRaTdOqSaIk/MDA7iUmkXXKjmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqlMyt6ndZtbSt5jfLfURCRkdwBUBNFdzNEb/HK/lToDftiTVpLEn7bBDKLwSKKGmP6DVuTHmxoXkyGopt9PRY+ktbYLMP7/8YV2GwqdKrWyGl5loPiUaC7nuOYnOwsrJmmVJKV2K6+SmzP+OknI8HaJeJfwgHIFtuU0E3wfiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrexBl54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0977C2BCB3;
	Fri, 15 May 2026 00:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804076;
	bh=RK4Vq+dmrSCj6fWFvDRaTdOqSaIk/MDA7iUmkXXKjmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrexBl54pJ8RTXsAX/Kpd+76mDt6+B3jopW9zWcqkFz8DTdjR8+zbAZMGeWI9VqBj
	 aXDZUSMRDuiVuI2XhtUrK4JuCpW+LUfdWvnA3d0P7zM3yDPkeYbxsjOBFxg0dkDw+l
	 219ACzox3oH3MyM9QL6hYQ6rfls/2BLFWarSWoJMNqLLcwr0BoK1pE+ysOfPFtXuZw
	 +KJ4+0fhGIuBvCElTFniwpKFyQL6g8wQT2eDOqPd+NRUCWChg2EBSNBdaPoDQW/yUa
	 BuC4mDooCC+f1QQR4F1NoMj+LGR4Jwct/yHB96M1FumETBknWWeIyVHcvl8HQHELkO
	 eKdW37DxcYklA==
Date: Thu, 14 May 2026 17:14:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/sun: Fix multiple typos in comments
Message-ID: <20260514171435.385932bc@kernel.org>
In-Reply-To: <20260512151931.3576906-1-j.raczynski@samsung.com>
References: <CGME20260512151955eucas1p16e090b7d76aea8c5e37d7c401a21638f@eucas1p1.samsung.com>
	<20260512151931.3576906-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8BD6547ECA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288118-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 17:19:32 +0200 Jakub Raczynski wrote:
> Also fix double spaces in lines where typos are fixed, but don't change any
> other double spaces, since it would obfuscate typo changes.

Please don't.
-- 
pw-bot: cr

