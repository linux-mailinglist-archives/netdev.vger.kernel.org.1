Return-Path: <netdev+bounces-282889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAt1GWVs82lf2gEAu9opvQ
	(envelope-from <netdev+bounces-282889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 083094A442E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7438D300DE2A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B634E746;
	Thu, 30 Apr 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX/WfblH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1028640B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560532; cv=none; b=gQ0d+zv0Ibv/PJsa2RhydyXnh0kMITeZUOxkePmLyPLIFDXTHrCH7q3cvY0FE0ilgUvlTrJwm94H+mh9xTMsFObXQDV2izd0BaZOsg+omQyPQ1Xoq3RRVANK+nJUB0vM5aNDE4gw1K+tgyA+5Qc9NcRc49790O+dO5PLP9IcAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560532; c=relaxed/simple;
	bh=y8zJk9caf7v4JlJgjE0gjutEn8ottL/lwMgaKWlC90M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLd47Ump1+VQkMAgNXaH/UgpJbn4PDG1OR9kbdqETO9FX1RP+kUecjcbCAtQ0tjF/tQ7ku7PTFmBt14+OYJVyKuTnanCxT4OHuApX2LqvFaGM7I/haRqqZnypZ0Vz00/Bj8CuYeOUAVlWL3568FKxUtfhGkE/TYPxdn0Ta1q8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX/WfblH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED97C2BCB3;
	Thu, 30 Apr 2026 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560532;
	bh=y8zJk9caf7v4JlJgjE0gjutEn8ottL/lwMgaKWlC90M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JX/WfblH6PuwC/gGATZ14PS7j4Py7vglrSpWgh2wP6/Y7DQ44WO+hdIcB1A2TBf8z
	 DHR+atbgR7pWusLzL6DqEnmXEDS7Lond3ywE1C7nZl+4N5kMNQFnNC8ScRisgkstkC
	 DiYKyY5buUrQ7/w2EPbaDOaHM0SkKGrGkUBqkHbHBusoXnJ4sSzdlU/NrcGXLPhfOD
	 NEpA78Qx6jh0JyJNzKUxs2uvCkwiPlJiCY5SUPsDZ90ZY3/ov+gQkjyn6zXxs5Z4hU
	 OX9dyyMGPjsyOP1ffE/TPfZbJzAnvWDNVyzz/t/a+PiEAwzJFN+uVOCBCnfwFyefO1
	 xvYG3xnKkkfjw==
Date: Thu, 30 Apr 2026 07:48:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 0/5] ice: five small fixes and cleanups
Message-ID: <20260430074850.78ed5bdf@kernel.org>
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 083094A442E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282889-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 14:25:57 +0200 Aleksandr Loktionov wrote:
> Subject: [PATCH 0/5] ice: five small fixes and cleanups

Please tag your submissions with iwl-* if you are cross posting.
-- 
pw-bot: au

