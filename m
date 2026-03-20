Return-Path: <netdev+bounces-270047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCLJAhujvWl8/wIAu9opvQ
	(envelope-from <netdev+bounces-270047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA892E03E5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD88030BDD86
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C53C6606;
	Fri, 20 Mar 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdTVLv3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166A3446C8
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035094; cv=none; b=f63kSx7e6zNjKWOI+M98RcjcvZ0wTN0hngIqGmQjAy85MnVkaqBfFB5+joh7FLgTeMDpZ1hp/D9bgDEPNsu2Q3tPIkqvekWbMJZ2Tb56Ecf6RNNlU8qwagRULeIi/9V8jVGrLED5GYLOKVA/UDd+nW3eN8sdXaubE/YXOfGouUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035094; c=relaxed/simple;
	bh=QA/w4+khlPRy4EweZlpjnLRnmAwb/BV3yY+xixVCdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhfDj3XjUkeKTyqxs5z4eQk4n9d2smgHPnqCVZWh/XQqnE5BQIxaQNLnJoYD72lYsNwYuxtdrQ+RtZ8c3mbOK+tbf+Sdt+L/c5YQC7K7npe6DebHVqAmflqvFKU/MNSW+IaX4SpaKYD8xTP5B6xzexLVH9OXm2pWtUxzOhuvhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdTVLv3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947AC2BCB7;
	Fri, 20 Mar 2026 19:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035094;
	bh=QA/w4+khlPRy4EweZlpjnLRnmAwb/BV3yY+xixVCdvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdTVLv3lqiLj4KBIGwwtH1e33UD9cqU/ctYm9abicNjWz/jeJ1zynPj2hVxUIYRaU
	 686SDBRQELplSM31QlCSueorVWpcacibMWHmPIMchm0g64v5lDosphVIOrnDFt7mgn
	 wkry0qBN0/l7Q+M9vC0IyK27TPS5PbB+VkB+IwL8oIWmPeRESU2GdmrgB/mBN7BVxd
	 2ltSzoRavGsXeQVqbvVhJXvsVIfeJgygM5cgNlGo9FtmEmiBmLzPj33uhgWmyMXM59
	 Si4VCi3Sa99zZ2QMtV5cq5CnZs2XwmKH4ysxCao958g8wMXByHXuv5IxoOnXSawA5E
	 2tyZm3z82GV/A==
Date: Fri, 20 Mar 2026 19:31:30 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iwl-next] ice: init desired_dcbx_cfg in default DCB config
Message-ID: <20260320193130.GH74886@horms.kernel.org>
References: <20260320050541.422592-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050541.422592-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 8DA892E03E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:41AM +0100, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> When DCBX is disabled in firmware the driver falls back to software LLDP
> mode and applies a default DCB configuration via ice_dcb_sw_dflt_cfg().
> This function properly initializes local_dcbx_cfg with valid parameters
> including etscfg.maxtcs from hardware capabilities. However,
> desired_dcbx_cfg was never initialized in this path.
> 
> All DCB netlink functions (ice_dcbnl_setpfc, ice_dcbnl_setets, etc.)
> use desired_dcbx_cfg as the base configuration for user-requested changes.
> When desired_dcbx_cfg remains uninitialized with etscfg.maxtcs=0, the
> firmware rejects the configuration for 4+ port NICs, causing DCB
> configuration commands to fail.
> 
> It is not a problem for 1 or 2 port NICs where we support 8 TCs - in
> that case FW accepts maxtc=0, treating it as 8.
> 
> Fix it by copying local_dcbx_cfg (which was freshly initialized) into
> desired_dcbx_cfg after the default config is applied.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


