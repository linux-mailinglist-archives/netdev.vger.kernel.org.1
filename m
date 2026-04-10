Return-Path: <netdev+bounces-277481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPr5C7wj2WlrmggAu9opvQ
	(envelope-from <netdev+bounces-277481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:22:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404F3DA559
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D553021E56
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4643203B6;
	Fri, 10 Apr 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Y3h+jL+I"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657482DD60E
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837491; cv=none; b=NWkrU1ISGoixndC7rTmfxedqWWr4PTbEuUxSPSdCR6RfRcqtLRJg6JJkBO5ikro+cBMmSRkBH7LILrfLu7+sQQ7mfibH0AR5qGBmWISoFeaKmR7WetIp6H+1aMyMZ21TEfC2xfyF+Ptnnn9dKOLg/NphT7bVN+FGXZe+2diNOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837491; c=relaxed/simple;
	bh=HgXVDKCJ/yWhV5stgxUQVBx/2YLUAoG2ZWj1hbPJz4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndzyXYxQ/lyjQZ8KJAvIB1EakPYB4aROAO0ieMcnr2dTUfSABrlSTGpiXFdPuEC/Aiha5GiB5G/9ZKcB0LCUyPO3X9pg5mlhyFOiDCwfIqDl4Srg78hqyzDV8miQdxushDY5Ac42933WfoW9hHOsg19HIoDg/8Gqzw2T4JojYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Y3h+jL+I; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vWauY4MEDbOLUfnSq2co2FK59b47gPquA5iKla0DmsM=; b=Y3h+jL+It72UybWfx8Qm1H+R7s
	CbTewanehdekD+Wdjo5ThMa/koI8suefU9I1NG6KG1ShXCJkGVobb7wupKoXO4rL7DIlDPaxhl5E+
	OBOUqmXDRvdAiQKKqDSQ6MK/MhhrDLVAwXZDfffPflv32kBZ/isbsXiHNXXz1RHYI67oYNGMeVmBF
	o6qLZARPrKd6yJa6SHRdrN1c8fm2BdgP3Uy9FxI9lEUXXp97Y1NV+/YBFdE72jnJFnaqylFav7ewq
	taHjGL8NaGyvDv/ForL6Vuw8CWNdUsKUDsjJmMf060IttE0STmZh5Qo+3LdGfquLrHcNmx2Ok8mOx
	56xxX10w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wBES6-00A635-13;
	Fri, 10 Apr 2026 16:11:26 +0000
Date: Fri, 10 Apr 2026 09:11:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 10/14] netdevsim: convert to
 ndo_set_rx_mode_async
Message-ID: <adkhGw-V9-e7F4-S@gmail.com>
References: <20260407153101.3694714-1-sdf@fomichev.me>
 <20260407153101.3694714-11-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407153101.3694714-11-sdf@fomichev.me>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277481-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 7404F3DA559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:30:57AM -0700, Stanislav Fomichev wrote:
> Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
> The callback is a no-op stub so just update the signature and
> ops struct wiring.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Breno Leitao <leitao@debian.org>

