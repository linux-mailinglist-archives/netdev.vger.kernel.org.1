Return-Path: <netdev+bounces-278373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB4fNoAM3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:44:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D563F81CF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E53E30067B6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E33C3452;
	Tue, 14 Apr 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPL+iy91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EA3C1414
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159560; cv=none; b=Zs5YYFmHdA5cdmX837V4EzYd+vTX6UHP7Lzj82U1ZNb8uApk7waMlWk06WZqYOLkk9LT4ogslzEul0nfob7DCpoBoITniisoDCLRMcP/G6h7Bwvd6sKyjA6qNMc2SFJrBcsVnBHOF6gqxAPKQip2HljkD5Ri4sAxdzxUHaPPWIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159560; c=relaxed/simple;
	bh=aRRkx0oARVYmRtTLmp4iTQ4iYhOU1FS1vixYruiSzXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmIeV++OxGMyH3N4xr4YeHs6fC3AGwhVrJu/hZ0D+a05fMAlda6bsZO0VVYXhWRAbRL6x2yJFCgBPytPekZWV/nOBsYY4bAQ6oZ/9C5Iyz806ZdVhu/PjTXKUT62ggitjYS/xuLh0gmjZRRPydRyr1tR9HQksnawzhNvz+wKfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPL+iy91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7AFC19425;
	Tue, 14 Apr 2026 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159560;
	bh=aRRkx0oARVYmRtTLmp4iTQ4iYhOU1FS1vixYruiSzXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPL+iy91P84aOq8oVXrZS+OCE26GzRiphmhPKnGfJDaCiA8itZ+ds0x62sRuq9hQ7
	 MpDKW0DicvbqfLUOAxPVYtIYRtsX/eWiUZqCkqRQIzBExHxA9ZDAGF71HSmSC61uFI
	 rLcA1qM8Yrqimid6cxDml4ELjo8+Qq/Y8DmnFZlfUxzea/p02kiGpDf9dVCJZdl9zc
	 gUGdJeqI6YP4Ijx6JEpKKSTTJU5yQRoBxMv9iZmZueminiZ32f7eYCn5vhF+Hzfn7h
	 DH/bmMqQilooM+O2Mp/idGYoAXOZuE760aG5NVYzKNu+fHpJJtomuPqzOQQ7SgQt3U
	 TT/pSSUdJqRvw==
Date: Tue, 14 Apr 2026 10:39:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 10/10] ice: promote Tx FIFO drain timeout
 message from dev_dbg to dev_warn
Message-ID: <20260414093916.GC469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-11-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-11-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278373-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77D563F81CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:21AM +0200, Aleksandr Loktionov wrote:
> The message emitted when the Tx FIFO fails to drain within the
> timeout period is currently at dev_dbg level, making it invisible
> unless debug logging is enabled. Promote it to dev_warn so that
> users and administrators can detect Tx timestamp path issues
> without enabling extra logging.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


