Return-Path: <netdev+bounces-286183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kICdLrw1/2kZ3gAAu9opvQ
	(envelope-from <netdev+bounces-286183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA04FFD9E
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03FD300CE4F
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFC7360745;
	Sat,  9 May 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXS+dTe/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE433AD85;
	Sat,  9 May 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778333113; cv=none; b=jeYQktfvYffUtLqsiTruPuq2vNSqhd5XfBRULtasIJQMK8qyjFyeWETEP/89NUuzpZ8iGRoTuOE8b+wF0hgW0UeDYevO18vpnLifC3hG8zgs3kM8iEL69NFpExgPFWMzo2WhnBsEtHEuzHHrcKTPUNtq861sfQpl96EuUuDrmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778333113; c=relaxed/simple;
	bh=MuP1e2USZig16ux2p2oo4su1xjCn4uAguNEFgBF3eng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmpPx//86HNQpQP5OnajztPsZ3Xg0atxHW/xrq3SHCQbo1znhQyWhSpAS2G4cl0va4fZQqZY5VEkAd1LQ2rfF/i1HCECV8s6/ZdoOkfWHuK6USQzNzUjyuGbCZhi9PDUEqANlu3nopIiIsSVrHWP6VXB0F/BRQ+KApPPBzENbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXS+dTe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E70DC2BCB2;
	Sat,  9 May 2026 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778333112;
	bh=MuP1e2USZig16ux2p2oo4su1xjCn4uAguNEFgBF3eng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXS+dTe/hhzRhyuclzApz0PHSgxajXC/LnjnEXuD856358btLmYuwZ1iEbUziJ27n
	 3tGXze+G2V5hvvfNxxXNvm+em7xHBp0NZa4jF2j+5RLyWlzGNP2JV8Levp9XKHXirl
	 bnFi7THSHtvVaUy0+6Y74IOKaXpQyT2ve42+XMmfxrwVa8DR5uipS015jJ2cQdBrft
	 R7csM3qqZ5nQkXUFY3GX9kTRO5rOeXReRY5aGF4QWvvmp8vmVX2tv+GeXWqTKn+Aao
	 EoTO3yU1U3w4ux5GIDU/StGZqfY8GsAjWU7STlKfe/pv3w8wcA9Awu4DQbY/Jvhn8B
	 5JXvHXERsC2/Q==
Date: Sat, 9 May 2026 14:25:08 +0100
From: Simon Horman <horms@kernel.org>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header
 action
Message-ID: <20260509132508.GR15617@horms.kernel.org>
References: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
X-Rspamd-Queue-Id: 37DA04FFD9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:00:31AM +0100, Prathamesh Deshpande wrote:
> mlx5_cmd_hws_packet_reformat_alloc() handles
> MLX5_REFORMAT_TYPE_REMOVE_HDR by looking up a matching HWS remove-header
> action.
> 
> If mlx5_fs_get_action_remove_header_vlan() returns NULL, the code only
> logs an error and continues. The function then returns success with a NULL
> HWS action stored in the packet-reformat object.
> 
> Return an error when no matching remove-header action is available.
> 
> Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


