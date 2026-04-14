Return-Path: <netdev+bounces-278367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB35LgYL3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:38:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0F3F80B7
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68298304502A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097263C2770;
	Tue, 14 Apr 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+Tbw0Cc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6943B8D4A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159201; cv=none; b=twRTfOxgSa5TipspnMsEucm5yl3cbjIf8Vj36uURVbvK8ya7yOBjXy+RT9/6ho9hQHx07gIKpCfg75ZxU6H2gkqIFAzo2Qt+2NAVZSxy3emLmieivplzl3eUmghtDSjCuqoSIsNS/U2eh5QMLvlkykAkB2zfQ/rrxriHF4mimCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159201; c=relaxed/simple;
	bh=LsW298vC1uXD4bNamm2iAeOtiJmLtwQwZUl1bRwVznM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw/6nbxltUd4Hw11kaNgns5/GK5EyvyzI6vsaHCW1I2gIJvv96hmyNx0C1SJz2pkeaKjYGR3OEXaInyUW85e8utFQqrYUTO/s/UZUkYgiT99yPu45u2XvKV8LjaGz0+KJ0+WWcD7qOs7TudMkrJP2n5QwyjV6sHit6iB/nLWJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+Tbw0Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC5C19425;
	Tue, 14 Apr 2026 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159201;
	bh=LsW298vC1uXD4bNamm2iAeOtiJmLtwQwZUl1bRwVznM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+Tbw0CcClfF8F75vv96rwLR7UM3a7fRL/T3bZ1hNRJnlyCrlJOU2NTgGmLhNngss
	 4s+n7kvhJef/vDVcve6TDvBD3nqoMPQk075oWrebT/iPaLDoQwTBeZOpPt0e353zHg
	 B09LaAtf44/1/Ffb4GBkMdjjo+eswm/xEAXJwcBJ4JpEQA1Mwz4nVE7KIm5PdHeYBD
	 51CuH5Es5wmNcSlft0/RU9CoilQ3PdOkAUc1D2csJu+Mcxms6Vjk5Gee8J3ZQdA4Qc
	 EYiwEQh5UFVDbEGKSm1Bp/bOPeeTgkSePmZ910I6Z2fKcXAGkiAHgbrNIDPcah5ARa
	 dS9Z8eAqc5Iow==
Date: Tue, 14 Apr 2026 10:33:17 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 6/10] ice: increase OICR interrupt moderation
 rate to 20K interrupts/sec
Message-ID: <20260414093317.GY469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-7-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2DF0F3F80B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:17AM +0200, Aleksandr Loktionov wrote:
> The miscellaneous interrupt cause (OICR) is throttled to 8K
> interrupts per second (124 us minimum spacing). This interrupt
> handles VF mailbox messages and Tx timestamps, so the low rate
> imposes a minimum latency floor on both use-cases.
> 
> Raise the rate to 20K interrupts per second (50 us minimum
> spacing) to allow lower latency handling for Tx timestamp
> bursts and high VF message rates.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


