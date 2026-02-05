Return-Path: <netdev+bounces-256912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EW8FIb9g2kXwgMAu9opvQ
	(envelope-from <netdev+bounces-256912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B99CAEDEA7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CF8A3002F46
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58DF1A23B6;
	Thu,  5 Feb 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUEBZuFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212B125D0;
	Thu,  5 Feb 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257793; cv=none; b=PqYrmZOtP2JifhTs+Y7FEn/enzv0n6jQtI63Yjg1yU1db2IswpHgL/s58ccc8vXVn4oa7+BIZR7TtcMZ0VYOGRBVavrfxHlRIa1ZK8fxVePIjlF+er4htKMIsgD56cNxDpjOnlwfmxyDLYjy+1Tgd9YX2pEQZFxwmbn+siV7pJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257793; c=relaxed/simple;
	bh=iu/nBZW03fVjULq+MrxpfMr1b9V943jAhl3OQAJBrLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfQnvjuD6Xcx5CK9d4g7k52TAEsDxDGlkAxrCIpavKx43ByLhefeFJEIWCglBNxOn1AuoTfLLlzaJp6+kNn8i4QahqTgKv7pBZpdE8R5DGUWFJAdQtuipvc8eaeNa3v7XMz3p1f4k7RIIBr5IiT3Rs3ZJmFDbS3yXHmQsyhVEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUEBZuFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415B5C4CEF7;
	Thu,  5 Feb 2026 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770257793;
	bh=iu/nBZW03fVjULq+MrxpfMr1b9V943jAhl3OQAJBrLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUEBZuFlXBec0mbp0VKtfBm8KPqkesLGd6gBeEqxq+w4e6HD5Gw7VY1khBdw7fQ9h
	 vdnEGy8WOYp2mgPmhug6s0IhkuQ58+qzpNaOv4CjTJZeFeQlHIrjzwIq/r18gFAsYE
	 61F+GxxZMo63VBjpHMsR6bMKc1Ud//vOucuyNbNoWTa1vsgvNkyad4FyMjfGehzpyN
	 yhqUU7q+KrTirs5B46O1KZycQysvpohEEg9OYVAWn1jPr6cMz/ZcPA4wwLjomagjaq
	 20YXN9zXJdbistPoFblcKz6ByfaO1RJdI6Qgm1LpEgbaEvDAWLds+Z4RZYvBl9ZYtF
	 T3c8Xd1fHxoCg==
Date: Wed, 4 Feb 2026 18:16:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 danishanwar@ti.com, rogerq@kernel.org, pmohan@couthit.com,
 basharath@couthit.com, afd@ti.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alok.a.tiwari@oracle.com, pratheesh@ti.com, j-rameshbabu@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v13 0/3] STP/RSTP SWITCH support for PRU-ICSSM
 Ethernet driver
Message-ID: <20260204181631.3a6f7392@kernel.org>
In-Reply-To: <aYN0xmOIaHeAvWNI@horms.kernel.org>
References: <20260130124559.1182780-1-parvathi@couthit.com>
	<aYN0xmOIaHeAvWNI@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B99CAEDEA7
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 16:33:10 +0000 Simon Horman wrote:
> I notice that this series has been marked as Changes Requested in
> Patchwork. But overall it looks good to me.

Unclear who did this. So I've applied the series..

