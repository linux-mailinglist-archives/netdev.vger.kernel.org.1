Return-Path: <netdev+bounces-266380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF/KD8SysGkHmQIAu9opvQ
	(envelope-from <netdev+bounces-266380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:09:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA4259816
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42C7A30066A3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6201CF8B;
	Wed, 11 Mar 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxUBogDE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA9A95E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187778; cv=none; b=h5Q6XalxjKDT5Aqkzj8irWJaO0Rpi/WTt9eWRO3/z5K754AiH6eKkPt2Fjez9mhBnBpDDDB4kqq7vicg5jmokprbmhWQMGxowQSbeYWKMjO60FiAz/mSD7qcHf8ol3ePRqwAGhPrwoj5Vs5+N4aOgh4j1dMsrfJl1vedj/dRTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187778; c=relaxed/simple;
	bh=G+EASqo5sUpecmd/NHO5XZFZ8PZbl576yUz1wTKeVIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtyrN6DrBTRPgUagDC4zBHDpfGdkQvretvYoN+JEhWKtkvCNei2JQysaDM/JLFP63FtZIwbO6Iu3FjKFwt1jp4n59cPSZaXV45273GSZT9mCuPpK6yKGZ3rE7qNma8g02xmUwhO5p6A/1bsutgwdYcrtsSrQopXb6cTr812KaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxUBogDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29183C19423;
	Wed, 11 Mar 2026 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773187777;
	bh=G+EASqo5sUpecmd/NHO5XZFZ8PZbl576yUz1wTKeVIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxUBogDEud91vrfh78nE6b4Psf0sX8c+IxSKV5cvZjPiQq+lV7C8uTr3X4/SPlL/r
	 AstzdooFZue0vECnrRMKFBC+owKjeOlmDTGjZYeBz33tkCK4RF6okZlwT727EN2nKe
	 PKqDT7Kq5K9MZE159ubgG4Vl0jYdSZhk7TbNb9xw+QV/iHOkJV3/pVGSgOeh8lQo/i
	 B6OI2e6azFmokt22bveYZbK3BtOZM58l4PHgI2uyFaOZkW7nd7lvOoaSwy/ogUdpbE
	 Lt27el5LLlGc3PHmsdal92LE0/tcdoPL7Z5wGE5OrQ5/7u6diSOs49Mq47xFCMDLhv
	 6qLwGYh/+Dqhg==
Date: Tue, 10 Mar 2026 17:09:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Ramaseuski <jramaseu@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 przemyslaw.korba@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
Message-ID: <20260310170936.07d429b1@kernel.org>
In-Reply-To: <20260310115556.1004263-1-jramaseu@redhat.com>
References: <20260310115556.1004263-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D0FA4259816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266380-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 12:55:56 +0100 Jakub Ramaseuski wrote:
> IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
> while IPv6 over IPv6 GRE falls back to software segmentation.
> This happens because the kernel's GSO engine requires the generic HW_CSUM
> flag to trust the hardware with complex encapsulation offloads.
> 
> Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
> stack and unlock full hardware segmentation for GRE tunnels.
> To prevent checksum corruption on standard traffic, evaluate the packet
> in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
> if it is not a GSO frame. This forces the driver to fall back to safe,
> protocol-specific checksum features for non-GSO packets
> while preserving the generic offload for tunnels.

If you're CCing netdev on iwl submissions you have to follow the 24h
min reposting period.
-- 
pv-bot: 24h

