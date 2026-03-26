Return-Path: <netdev+bounces-272215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD5hBSeMxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:42:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1D33B0D1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B21B301F9B7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857343A4F3D;
	Thu, 26 Mar 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3I01V1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D93A3E8C;
	Thu, 26 Mar 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553373; cv=none; b=FjKjl83RZRnwrmSsa9ZcCUbXOQ6d2vYbemoxxxeFIuuL04WaM1IlhIiCwRrE+PicFpV+lo6WrPdGTqZrz/AuAJ12waV63xIfB7kvjJNmguT5nGzsDMop7OWx500A8hDUL8Z/vmgAaajSthRl6WmPkn+CmbE1809/jMy9RTi86lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553373; c=relaxed/simple;
	bh=lQSO28sYXd8Q/b8mWBEsP49f7NhHn4D9RJdcn9c8DdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWuWqSrDwn+6ot2l+tiB22K1aLJALyZsEkcatFggVhlaDH1pQ6JyCUmiLJmPFPbT7YaYjDrpMpHD3hn3NOzOkMgHQlr2VgFrF1b4h5o7nRrqAbPm07jDgtjXL2WZN33be/4isyYO3K7mSqcg12KqHZL2Gvzvh6UNkA5uqfGJV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3I01V1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B25C116C6;
	Thu, 26 Mar 2026 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774553372;
	bh=lQSO28sYXd8Q/b8mWBEsP49f7NhHn4D9RJdcn9c8DdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l3I01V1DpAwrp5v/EN3CIk2uiLNUcAdRSPOxIBee2Gf6HNubRWYR52AzJGTq1vb4n
	 C6cb/ZBLVL+rjZ3ip3UHt+GPOuw2Sx9eAFf6aiW1jILT9bnH75dOHS5xI5HW/+Blau
	 9/VSdKD1cV2y+32PjaVrm+tMDcBebOqjZk3oJCmB8p3m8LmvhJVpfBejScI09+/ls8
	 ZWK/U+latACrmHZEE8XMvFInOqpdqNXEPfN6svV7RvSZ2N9ny33TLZnKA5iWCJL66v
	 5tN4Atgbeom5Jild5ktzaIKrgjY9vGv/A372vh9Deg/57DUbqplcHYDTffpkD8Oz0U
	 ZmmjzNf4CZx5Q==
Date: Thu, 26 Mar 2026 12:29:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] bnxt_en: validate firmware backing store types
Message-ID: <20260326122931.1e7e2849@kernel.org>
In-Reply-To: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
References: <20260323080336.36905-1-pengpeng@iscas.ac.cn>
	<20260326142033.82313-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272215-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A9F1D33B0D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 22:20:33 +0800 Pengpeng Hou wrote:
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[] without a local range check.

please don't post the next version in reply to the old one.
Add a lore.kernel.org link to the previous posting in the change log
instead.

