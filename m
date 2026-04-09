Return-Path: <netdev+bounces-276981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UADEBEmd12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A11353CA7E6
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E51300C805
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242E3A2577;
	Thu,  9 Apr 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OC2TM+lf"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5861A304A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738146; cv=none; b=ZQhZb0Hq4J84pSlgbzPVAygBE00uTrYoYtbvemAadYEEaN7lmS3EQTqWw1gSmUnocyLhbhBnSegsfS1tWN1mdFjEHLwM8vpwDxtOjL9XxWXxeUG5QZrjQxT1bQOiN+Sm8Dw6tMQXZUAMw2NEsXph32Mdv7Jug+0AZpxDUW/+hOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738146; c=relaxed/simple;
	bh=jQ5ZuFFabU7W/xJ7aZFp+AMCAQXjbDGm2AAbC9r85h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfThjid8o0j3hKYGbaQqpqSzTflvUh5/TSlaVG9Mv0cznkMYMEY8JCIXQrBMGderdHlDvRyDpGp2JurKBTo/2t175KWOnhPTVpA1z3nyQlCLhsGba01C18/l/UqkxNo4trntyccO8dS5UDu9i44LFSv+MIGgVVLtkgIrGP1eIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OC2TM+lf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w706NqgBqyMKvr0nVOHn4NlIhTaCVyxRXyIz0wu2eTw=; b=OC2TM+lfxYsLQIhsCdB3HrmzIP
	054IXBC5UmIQIuU01hqYd0KX4/xz+4PAH8Kg9X5PRVH8Pddy86B4veXRGWqPjJz838D7tkhHHYJ7U
	dP0ENSI6N3dwoH+L8DqU9Ml2ob5B1rcwo9Z0P8EMb9TQQTq8bAtgaLQM3geR57eZPjcT/FR//ohZr
	XPfJql6cSUVy16+W0D0hSf/ZQnCstnMP7SCJwBYjbd193ja0sUlJOBy/7LD0m6Ez+kYqGgu55CrzZ
	/E1FXD28pda3h1/NhV1KCQkivjTdHkg2Z44tFBlXDTnraek4mzyB/y2OYno8/5mbEzMbeLwXQyMpY
	IMSr4ziQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wAobc-009CdJ-16;
	Thu, 09 Apr 2026 12:35:32 +0000
Date: Thu, 9 Apr 2026 05:35:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
Subject: Re: [PATCH net-next v2] iavf: fix kernel-doc comment style in
 iavf_ethtool.c
Message-ID: <adedA3IogGaBhXIQ@gmail.com>
References: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276981-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A11353CA7E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:30:20AM +0200, Aleksandr Loktionov wrote:
> iavf_ethtool.c contains 31 kernel-doc comment blocks using the legacy
> `**/` terminator instead of the correct single `*/`. Two function
> headers also use a colon separator (`iavf_get_channels:`,
> `iavf_set_channels:`) instead of the ` - ` dash required by kernel-doc.
> 
> Additionally several comments embed their return-value descriptions in
> the body paragraph, producing `scripts/kernel-doc -Wreturn` warnings.
> Void functions that incorrectly say "Returns ..." are also rephrased.
> 
> Fix all issues across the full file:
>  - Replace every `**/` terminator with `*/`.
>  - Change `function_name:` doc headers to `function_name -`.
>  - Move inline "Returns ..." sentences into dedicated `Return:` sections
>    for non-void functions (iavf_get_msglevel, iavf_get_rxnfc,
>    iavf_set_channels, iavf_get_rxfh_key_size, iavf_get_rxfh_indir_size,
>    iavf_get_rxfh, iavf_set_rxfh).
>  - Rephrase body descriptions in void functions that incorrectly said
>    "Returns ..." (iavf_get_drvinfo, iavf_get_ringparam, iavf_get_coalesce).
>  - Remove boilerplate body text for iavf_get_rxfh_key_size and
>    iavf_get_rxfh_indir_size; the `Return:` line now conveys the same
>    information without the vague "Returns the table size." sentence.
> 
> Suggested-by: Anthony L. Nguyen <anthony.l.nguyen@intel.com>
> Suggested-by: Leszek Pepiak <leszek.pepiak@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

