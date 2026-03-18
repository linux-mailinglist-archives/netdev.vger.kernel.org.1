Return-Path: <netdev+bounces-268850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIS2HkYFumlcQgIAu9opvQ
	(envelope-from <netdev+bounces-268850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:52:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB072B50A6
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A4B43005EB8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D91F5858;
	Wed, 18 Mar 2026 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bViFVAJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C726AF4;
	Wed, 18 Mar 2026 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798723; cv=none; b=XXzI9qiD4n4zrVXK0+XMc+t+++DxAk7Wz4DxxgBkUJqnfG30wWa9g8wn+i7gnG7hJD8/HkduMnAV9u9RklDDVWKIogRyr6UzUVcwcJxyQ2oHt/JBFjV4+t+Qn3XcwUvgLzDP3Uc7uJwDrP+pG+6XbEL7BI0L7LZiB50fRfwuMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798723; c=relaxed/simple;
	bh=J4/FZpxdsxGLgWctP7/JS4Mcu4RszMThWMIJvsQo1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtMwn6o1u9lBY0rqMHNzyseuKrTTA1i1kHHUnz7LNczHJ1yuLLBIMiWG1fNFlQ1Ag06F0D2OEtWFGps7kY5sVi2akxZFLwPPCFyKD9mkTMTiHA88jY8DxKMmqo7O/VFqgIFU0ku2qyy0py6RAOU0lTNYyOBQRoeTnOJHgU08s/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bViFVAJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9EAC4CEF7;
	Wed, 18 Mar 2026 01:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773798723;
	bh=J4/FZpxdsxGLgWctP7/JS4Mcu4RszMThWMIJvsQo1rM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bViFVAJ/gYQhaFmfJwm5GMWHSuuOq1nCPPjp6/q/zNveCp5NDDyBUX/xLBZeFyDSU
	 CyDTL8gyGrBKr1vi4dFmWQjCd9mpFjVMwZhNIj7yjKmPjNbCSg4ClH342v1+YVvwQf
	 Qo6agY2S73lWaFYD+erg+t7qteAoeyVze01rfy8WTGCoE5wchmf1JwHaF0etTFDIOw
	 MLv9riNNFPPzvtcD+n1tbxDVN9nq1MN3zFy9DekXD/3y6tuUbZX4IaZpCUj5Cgyv+K
	 z+uWyGHb0+uNrn4oUhxxWL23nKVecvbuRGATpme1njF0t06PsrikFaZ9S+tU+D09R8
	 aOU46ly5xNceQ==
Date: Tue, 17 Mar 2026 18:52:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <20260317185201.40585c7b@kernel.org>
In-Reply-To: <CAADnVQKYW3cmJoPJyDowXvg92crKcc0be=+3pR=DfPWLdCxaSQ@mail.gmail.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
	<20260316171200.4b8a96a0@kernel.org>
	<CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
	<20260317152045.58c719a7@kernel.org>
	<CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
	<20260317182920.3f4fd8eb@kernel.org>
	<CAADnVQKYW3cmJoPJyDowXvg92crKcc0be=+3pR=DfPWLdCxaSQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268850-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,vger.kernel.org,gmail.com,redhat.com,kernel.org,iogearbox.net];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDB072B50A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 18:43:18 -0700 Alexei Starovoitov wrote:
> > > I wasn't paying attention. We can revert it in bpf-next and reapply
> > > in net-next and probably route all future xsk patches to net/net-next ?
> > > since it doesn't have much to do with bpf anymore.  
> >
> > Maybe we should defer until the merge window and let it sit in Maciej's
> > local tree for now. It's a tiny optimization, Maciej can resend in the
> > next cycle.  
> 
> or I can apply it to bpf-next/master and we start taking xsk via net-next
> after merge window?

SGTM

