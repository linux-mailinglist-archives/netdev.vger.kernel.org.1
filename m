Return-Path: <netdev+bounces-278362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA5YHKMG3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:19:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE943F7CCE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B7CC3032378
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D13BE16C;
	Tue, 14 Apr 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwGVb1Pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5D3B38BD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158191; cv=none; b=NkPIkt4/5i8YFYFPNHBjgPufYTlUUkaF0y4ALOsNSejCklFEvGKkWxxyzBDwcsnJKhQcvYe77qNi5a+A4wvifzHik90kA17AL48xnxFMZX86u9d575WQ5gN68w7/lwEdkLHhVZrWoEB0Ybzb0I7EJ9m56vXrtwQiA/QkhKwG6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158191; c=relaxed/simple;
	bh=XdU3+uXpTQHIkDhg40fCylMNlGQWcd1ytCGfIDJGre4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBjybuLQ1jxI4lRYQtBW7+F1hgogYTmiwgHqTt0nwidecFCd9nR3glPT4Ij3N8efHFWYN3bsquh3A22nBZlqCJqDWOHpTz+S9dsWuA7Jsvxrvm1k3x2z9RjRRyaEkow/ChzN20EClQBcvR/sC7azlm6+0ctvNxG6lMAOlRuEv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwGVb1Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78DC2BCB5;
	Tue, 14 Apr 2026 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158190;
	bh=XdU3+uXpTQHIkDhg40fCylMNlGQWcd1ytCGfIDJGre4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwGVb1PjURl89jj6D0za1hOgBuYJOHOhbHYJAVHRMEPiRxT7rNp/VoQL2DttNvyVV
	 AzP1cQje3+dbP1GSuMYiT/qXdkSiHReAtUWQzwSz9biONaTrzE8e2VoWalqKGtfHuQ
	 dlcS9GVEF4e5kSSiS9U0JZAUlz5EYr5U/8A2mmDf3CGN+yLvDj+8xi0yfQ8mzyiyMH
	 J05Iy1sPTEcHKdB9MAYsIFEEsHdDryjrfntuB8YYXZaJx8awahZlsQUX/U8GvGs4lK
	 1/FybHYNiGtX+zI0WbFdwICFc1lZj0OVmPrCH+lNGvZxV335gOXO0jGW9usRS1dxXz
	 /6qXrLknPeprw==
Date: Tue, 14 Apr 2026 10:16:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 4/10] ice: reorder ice_flash_info fields to
 eliminate padding
Message-ID: <20260414091627.GX469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AE943F7CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:15AM +0200, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_flash_info structure has a u16 sr_words field before a u32
> flash_size value. This creates a 2-byte hole as well as 3 bytes of
> padding at the end of the structure due to the blank_nvm_mode bitfield.
> 
> Re-order the structure to place flash_size first, which gives a better
> layout and reduces padding.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

