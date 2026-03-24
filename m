Return-Path: <netdev+bounces-271224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLdGBxrWwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:21:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8831AB3A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB0630AD4BE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F537A498;
	Tue, 24 Mar 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJB3bye2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6D1E5B88
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376176; cv=none; b=s3V/AXKqUGEP/VD4SBmIVJNVXkTWFJaWd4dWr/fpBneqFkTTaFJ+af8obZ9DgdOrlPm0Os8/x2snd9ILKFAn+3HfyyUjsG79G9qKFAmQhJkrsaunLVTVHcSXRxneNmYLVbyxCDLxp6JDCsVY3eDCl7GeQcTxgXR352eNHt2hom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376176; c=relaxed/simple;
	bh=N4wYF65jbJz3YOdMBQKu7J7Y5hKyKxHEkJXVzXlvoVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXT5mJMP6eP0r3nRkEMq+neUlnpX1vk+7azuJQO1DqA9R+xO9/zKSUPjjoRyKs5f656W3kb8ud9h5B+5Ho0BELC9VBr/O1WWCqpd+yDUiCWpFz5zqZ/FggsJ2flrajua2ThOI6aXDiIMhHA+BGXLc3lMDBxJSPGOyOt4tzxiLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJB3bye2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D2AC19424;
	Tue, 24 Mar 2026 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774376176;
	bh=N4wYF65jbJz3YOdMBQKu7J7Y5hKyKxHEkJXVzXlvoVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJB3bye2h3s1vjT2Zi3+vlWVS2Cq/y2fhHhZK/FOwozhQLzhyQWhB0tQ4cmNYQno3
	 olyxRlc2jKM0YFQ8OadKmrx8XKgMXqWCQd3wrXOxA7Cv34/CvInMKgaFkyYnc5JFSU
	 5btIx/QlxX3nF2PRAhR0+52iIVZKdfKq/ASu1MMuzoVA/3xmoJZoRTPMyOsvorVMLL
	 TDvvcFvbd8ntCCXz8mIoZsZ0bADqEjhjDg3Vdn6dQkdOhVbyahdz27okT0VuOjQmcn
	 BBXj/rQRhiMMgmzfoiW5RX30pHpkuGL1WMF1eo889MMhrdpHZme41N4DIKZJD2RDV/
	 7JZ3HDia1kkNA==
Date: Tue, 24 Mar 2026 18:16:12 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: update ice_link_mode_str_high() with
 200G
Message-ID: <20260324181612.GE111839@horms.kernel.org>
References: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 76F8831AB3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:58:40AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Update ice_link_mode_str_high() with strings for 200G PHY types.
> Without these entries the ice_dump_phy_type() debug helper prints
> nothing for phy_type_high bits [5..15], covering all 200G and
> 400GBASE-FR8 PHY types supported by E825C hardware.
> 
> Also add the corresponding ICE_PHY_TYPE_HIGH_* bit definitions for
> indices 13-15 (200G_AUI8_AOC_ACC, 200G_AUI8, 400GBASE_FR8) that were
> missing from ice_adminq_cmd.h, and update ICE_PHY_TYPE_HIGH_MAX_INDEX
> from 12 to 15.  Without these definitions ice_get_phy_type_high() would
> stop iterating at index 12, leaving the new PHY types invisible to all
> code that bounds-checks against MAX_INDEX.
> 
> Fixes: none (new hardware support)

AFAIK this is not a valid Fixes tag.
If it's not a fix, please simply omit the tag.
If you want to say something about why then use free form text.

> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 update ICE_PHY_TYPE_HIGH_MAX_INDEX 

...

