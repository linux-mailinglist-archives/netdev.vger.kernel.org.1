Return-Path: <netdev+bounces-270043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMlnL3qevWmW/gIAu9opvQ
	(envelope-from <netdev+bounces-270043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:22:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C14272DFDB2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1465F3007B1A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6B34B425;
	Fri, 20 Mar 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haDJhrWx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14904344DB4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034548; cv=none; b=eeRUy8458XHtQ0OwxIvcDpHFHZzJwINyAc4FdJSjgcjBT60AhFpABsuYN7ZXhIjIPjRu8LtytT3woljYBQCJvpCptDQ6vsbuGekqLmeF/odJN5fKWfpE1LnMEwpPwgcnGbWUhWf3qB1Sl2zuc71wqC85NIaLqjNcFEBp2ujNHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034548; c=relaxed/simple;
	bh=TggM05cJ/nNvU3rSwbGrgvekmiHgnNF4O6+tt/fSZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTkft4K7R0Zyj7ICIGnbx3NkKIYrFeVEKHNPMyjn77X3bY8ih5jojZ0wbMNdBoXpi3nDcKBoE+kkw+aiuh8mlyay5Lv4fIVaAWuES3byVvpfFtRxodn2w098IkNANvEkPjP0guetqJsp/WMFSCS2vvPeQwYQ/QHVkQXIcd27ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haDJhrWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F2C4CEF7;
	Fri, 20 Mar 2026 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034547;
	bh=TggM05cJ/nNvU3rSwbGrgvekmiHgnNF4O6+tt/fSZ5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haDJhrWxjcGLKvlrrefGIqiIYgSk7UEAILzIfevI3Fed9774J0boBznB/XgeQQfb2
	 Ka3Xl8Is5S/sNSjsIA8hX5ikL1cspdn1LjaeIbxxgPJ2Xrm5d/lIecSXhp7UgVoKvo
	 f4Ocy+7OFyFfwNsYO/lYm1FXkiaLOZXpVC8rSc2vdykHtaBrbQb+0I9HK73kFQ/GKt
	 9vcgtgnTFT8l02AksNupSeogtPAbZFi/4SmJJHM5PNYQceTl1WS2sB8yNrHRjjDDa7
	 8EpOYFDd3dU6MNycIGo98a4XuiWHARCk1tUKUUCHWSu+N83A+pKcPPuk6YgzK8BP4r
	 vIdp+tkE09G5Q==
Date: Fri, 20 Mar 2026 19:22:24 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH] ice: fix ICE_AQ_LINK_SPEED_M for 200G
Message-ID: <20260320192224.GA164092@horms.kernel.org>
References: <20260320050537.422528-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050537.422528-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270043-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C14272DFDB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:37AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> When setting PHY configuration during driver initialization, 200G link
> speed is not being advertised even when the PHY is capable. This is
> because the get PHY capabilities link speed response is being masked by
> ICE_AQ_LINK_SPEED_M, which does not include the 200G link speed bit.
> 
> ICE_AQ_LINK_SPEED_200GB is defined as BIT(11), but the mask 0x7FF only
> covers bits 0-10. Fix ICE_AQ_LINK_SPEED_M to use GENMASK(11, 0) so
> that it covers all defined link speed bits including 200G.
> 
> Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


