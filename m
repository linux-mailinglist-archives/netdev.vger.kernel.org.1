Return-Path: <netdev+bounces-277714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC4qFXKT2mkS4AgAu9opvQ
	(envelope-from <netdev+bounces-277714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE03E151D
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 406B93008D20
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECF2F5A06;
	Sat, 11 Apr 2026 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGb+c+A0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BD5C9E;
	Sat, 11 Apr 2026 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932252; cv=none; b=LVywqo7dOFbKtCf5MXEKBZIQSbK0QPf69p7I+E600rUcyQNaZx/knluMnpDG9zbO1iYqQLadVgDURzNeElhSv8eaM53Ip74pUeGudAkxuA9CCPD70t4J3WKAtur+E5AahuhNXp+iwsoGwbcm9tcTk0zDkpmAL3yKomQb/NrKTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932252; c=relaxed/simple;
	bh=bgD/DoFlxzGZ6ms6SH9DxZFsWvt9FzTAhKFBqEUeTDc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uy3fcuH/Bg5kXbDYvfvDiWJq4fJeOmX68JuzrAwHiACYIDCYtB0TP4us4D9/qNZ/ZGPQ7httpVlCbqte1nOTWdIMUFj0eenth98jw7jAMBIYv3Rb8hy/A11KK4uyceKsyo8SAfFYBBauSGQdS4rRJNxXgs5Q0p7uNq9czy47Xrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGb+c+A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE51C2BCAF;
	Sat, 11 Apr 2026 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775932252;
	bh=bgD/DoFlxzGZ6ms6SH9DxZFsWvt9FzTAhKFBqEUeTDc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tGb+c+A030OY8cewOBFStj2/ij7jegwpdqnOnVN8zXyd4cPjTgauGS3lprnULbOeu
	 tLrvZvEhynrndgz3qHOsoYCL3ZBez2jxaJO2deCwcR6xHVA4y7Ck0wd9thqpQEsgBc
	 HvoCCQeL8adSElMScc0jPKpXIKGXcd/AebEe2rFRbDZBu+TPCrIJGh6VOumSEzrni6
	 9X+8NoiqTZTS2bOFYBdqxFD2IkBxdaVxTBsI8wG1jS1fMfQmAt3HpF75uDFEjIvTdW
	 1leGfVFGmTLpnIX3B+GHV8ZEIBHaUkMjOE0kWqx9RmDhF1pSjm1Cu/IU8wYkd/9PTl
	 UT70P8sBDWc9A==
Content-Type: multipart/mixed; boundary="===============3109053111654324821=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c29b58af9328ba78ba275216c586b1e82c2845f0725fce7c3e6baef801a6b22c@mail.kernel.org>
In-Reply-To: <20260411175134.771552-1-azpijr@gmail.com>
References: <20260411175134.771552-1-azpijr@gmail.com>
Subject: Re: [RFC PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
From: bot+bpf-ci@kernel.org
To: azpijr@gmail.com,bpf@vger.kernel.org
Cc: madalin.bucur@nxp.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,horms@kernel.org,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 18:30:49 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277714-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 52CE03E151D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3109053111654324821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -297,10 +297,11 @@ struct xdp_frame {
>  	u32 headroom;
>  	u32 metasize; /* uses lower 8-bits */
>  	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> -	 * while mem_type is valid on remote CPU.
> +	 * while mem_type and queue_index are valid on remote CPU.
>  	 */
>  	enum xdp_mem_type mem_type:32;
>  	struct net_device *dev_rx; /* used by cpumap */
> +	u32 queue_index; /* used by cpumap */
>  	u32 frame_sz;
>  	u32 flags; /* supported values defined in xdp_buff_flags */
>  };

Is the updated comment accurate for all paths?

xdp_convert_buff_to_frame() has an early return for the zero-copy
path:

    if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
        return xdp_convert_zc_to_xdp_frame(xdp);

xdp_convert_zc_to_xdp_frame() zeroes the frame with memset and
explicitly sets mem_type but never sets queue_index:

net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
    ...
    memset(xdpf, 0, sizeof(*xdpf));
    ...
    xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
    /* queue_index is not set -- remains 0 from memset */
    ...
}

The comment says queue_index is "valid on remote CPU" but for
zero-copy converted frames it will always be 0 regardless of which
hardware queue originated the packet.

> @@ -441,6 +442,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
>
>  	/* rxq only valid until napi_schedule ends, convert to xdp_mem_type */
>  	xdp_frame->mem_type = xdp->rxq->mem.type;
> +	xdp_frame->queue_index = xdp->rxq->queue_index;
>
>  	return xdp_frame;

This assignment is only reached for the non-ZC path.  Should
xdp_convert_zc_to_xdp_frame() also set queue_index from
xdp->rxq->queue_index to match?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24288456014
--===============3109053111654324821==--

