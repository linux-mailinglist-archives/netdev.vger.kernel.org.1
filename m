Return-Path: <netdev+bounces-285077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAyOMtHL+2lsEwAAu9opvQ
	(envelope-from <netdev+bounces-285077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393F4E179D
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8834D301AA64
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260672E06ED;
	Wed,  6 May 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw/IU/A2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374E175A85
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109391; cv=none; b=D9VbAMcAyBBhy51rOnq06eJsn1s6BK3cs/oIPREf9D0l+BRY6KKHjPY7SsPj+tSx39CVB7dRu8JGjWWBtANptReVIv3Ny1obvUmquQd31Ai+yw+LjqCjwsVQpu5iVFq1ErJFvunLqsepkFuCu3bcRGWylbYmyGl0hEahqlRDSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109391; c=relaxed/simple;
	bh=ZeQsG/N9Ska5pWnZzaJsL52vXjyhYhU7cDQ4rObifgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA2LP4cdfxgRRFSZZPZ0oxf71c02TKIp3UBry6PUE1i1YQ3iXrYtMqm4uw5PnknKcM0OZTCVny3QhXhAKwzBo6bavp39Mr2KC8kdYq0z+Iy7VzQQENWVkyklpW6IwhYJoSRqzwfXrNkI97fZE6EydtN5W7UWwecSBWHeMwIU+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw/IU/A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB54C2BCB0;
	Wed,  6 May 2026 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109390;
	bh=ZeQsG/N9Ska5pWnZzaJsL52vXjyhYhU7cDQ4rObifgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hw/IU/A2r4V8y7O6kkV3ePUos8hJlaVcXoR/jiizehDw+u3YVqr9YI78M+6ZcRL5F
	 yA7+iqvXCGAExh1HR+D+I1zzA4cxhIGlYK7KThCpzjSJEw8x2kRcLCF2fUq6ozms5S
	 t8JWyAeoSf1b+um5lyS7G36tLangQZaApZV2havmHEwmbK8Aju/ZE/A4NSHb+Pj9A8
	 AtNGL38evyydlQh6hy+J7KJ94JqzY7+7YVv54Yg6ad593d42wWNpkAGsrjR4WF/fxQ
	 vKXKAmfKPFhkrVwvHyechOoK1IY4EzDaBFN8s16OmoM/5S1pWbB/kUDXtaa4a81i8q
	 PimvG9DWf+GCA==
Date: Wed, 6 May 2026 16:16:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org
Subject: Re: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260506161629.5488a643@kernel.org>
In-Reply-To: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5393F4E179D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:
> When the device is removed all allocated resources should be freed.
> In uhdlc_memclean the netdev transmit queue was already stopped. But at
> this point we may have pending skb in the transmit queue which must be
> freed. Therefore iterate over the tx_skbuff pointers and free all
> pending skb. The issue was discovered by sashiko.

And you tested this how? 

Given the questionable v1 I'm highly hesitant to accept patches
from you if you can't test them.

