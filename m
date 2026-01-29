Return-Path: <netdev+bounces-254826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH5jDE51e2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:57:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE57B137F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 322FE300EF88
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC920E023;
	Thu, 29 Jan 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiCt9O+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661E1D6187
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698573; cv=none; b=DUqdeZeLKBXkDF1aiidAwQ+bTUG9Imrsa5O+VQHF+ouAQUiAHjb1vJ92CveuNNQoaSYmLjUgKzBMYrcuC8lfR6ukJ4AIwWzdT/NduzqCby1waiCbiMujIePjSWZSUdQO52Fc7nBhG+cRLmAcQJmrAKRKheJDMSm+nXQvRh41uTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698573; c=relaxed/simple;
	bh=Jkrg5kYBkPR/En3zoQdEOngNgOmtEethBjPLNUuWbHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvnPOSbQ3Gg5Eviti4IZ5SezykoCVcet34Yr0lMcyIKLlCNq++6xSkOElWPBi7OahqcYGm3yRI5AV+6l8YW992kcB/J+cqYMuUGpmAgtl6dq3A8BbcoN/LhQOzsMozuEnMrtgB5eCPFNiL0HtIU7TMvXZEgNT+RfW7UMa2qT6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiCt9O+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C086CC19422;
	Thu, 29 Jan 2026 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769698573;
	bh=Jkrg5kYBkPR/En3zoQdEOngNgOmtEethBjPLNUuWbHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiCt9O+DedcJps0pJ3wyhMsRY03CiVuvAmWzpu/VaTljUWRJNPZuF1XgpG5mNarPr
	 LTEmLuKb6AVkmaDdGQ4aND7CxNqcQsWggGv/gfo4ZrL21QKE9USAtNkuzVzWZ0mB4S
	 xZlBDZ8uI6+hWVIYuvQS+sYHfzVzMZyS2wq1GC/NeJbiaBFnJn/sbqvMwWCLIIwwWa
	 jg/rmGdCtW2ZKd8MY/sO4TsB9o2NhhNp09cQUexnABa2Km+0TkSBH1JrTZm1qgnf+J
	 AQSrXv6J89xLDGOxRo8DotG1TmsKap6kPmX0KfFuAxBUNobcR5GuPJJNovl3xrcym3
	 T2GFZXx8kLcKQ==
Date: Thu, 29 Jan 2026 14:56:08 +0000
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
	sgoutham@marvell.com, bbhushan2@marvell.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] octeontx2-pf: Fix header guard comment in
 otx2_devlink.h
Message-ID: <aXt1CDG_RadfQr3Y@horms.kernel.org>
References: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-254826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABE57B137F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:42:52AM -0800, Alok Tiwari wrote:
> The closing #endif comment in otx2_devlink.h refers to RVU_DEVLINK_H,
> but the actual header guard is OTX2_DEVLINK_H.
> 
> Fix the comment to match the correct header guard name.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


