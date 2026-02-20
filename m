Return-Path: <netdev+bounces-259777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IWNCmfTmGmuNAMAu9opvQ
	(envelope-from <netdev+bounces-259777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:34:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC016B02F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCBDE301A411
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA330B517;
	Fri, 20 Feb 2026 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw9OfDBW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD323643F;
	Fri, 20 Feb 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623266; cv=none; b=GE6zSR+yxZNxt94VpCgq/AtH6JJSwBdti1LUChglQubapz55+GAv/LO3Cz1QEpuNkwekcyn8lJDhxoWFQFn49/1ljoMhXYVZiz636sQewxHvxrXh70hICcFj0/YXUvTmSLivBLsbQjMNf/vp6W1vtEYoG8+ROVl8sKmEpSMCqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623266; c=relaxed/simple;
	bh=es8vh2he9nUqYPUfvYqGL5Po9BlfB5MMfgsVFNWufMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDJsnU1qRThBJzNo0Evk9OKJOjZWTAq1g+mNLAxOVUCa/A8EqdQ9gGaM4wwqqeDsH6nI2UYATGTGQ+wqnqu+jPQEx56Dy90jQFudkP6EM0rqV+lGqw1K7wtlRKUm4YEM3dB/igoFZmZ/Od4TmPlrz2iTA/fegNAsdly1Xm9Rv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw9OfDBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A86FC116C6;
	Fri, 20 Feb 2026 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771623265;
	bh=es8vh2he9nUqYPUfvYqGL5Po9BlfB5MMfgsVFNWufMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uw9OfDBWABFgxLrv5ojCRtHeVbkYxziLnQrbDniYt0OVEs6Hk4xRnM5jIoPkRDLlo
	 7ruC9F0in6axrtbOKlWzdiwIJPG/f98NjMHZPUImnL2B2p+Z05w1dlmAX63BFmaal0
	 GaMCnDoLdR2WePsjTkY3S49fGIvY6lscs7sjdwU3EGTDjuK5y2yerM/UKkSqH6uZp0
	 hk2ObX4PnzSRJDKMIL8Fg/qdfGoaETgwUIskvwEnNSSWNM5xR4LFydplupFYhSIw/n
	 9KUhg6GLckH7yQNLcPo5hgUP+rKv8p1hv191f3AN/AU4CrzYRWL0faO4XjU050yqhe
	 PnhLBFmE2UXgA==
From: Jakub Kicinski <kuba@kernel.org>
To: ian.ray@gehealthcare.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	ryasuoka@redhat.com,
	jeremy@jcline.org,
	krzk@kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: nfc: nci: Fix zero-length proprietary OIDs
Date: Fri, 20 Feb 2026 13:34:19 -0800
Message-ID: <20260220213419.3181677-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220112536.100017-1-ian.ray@gehealthcare.com>
References: <20260220112536.100017-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259777-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94FC016B02F
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
nfc: nci: Fix zero-length proprietary OIDs

This patch allows zero-length payloads for proprietary OIDs (0x20-0x3F)
to support the NXP NCI_RF_TXLDO_ERROR_NTF notification case.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index e419e020a70a..78da0fb9ef3f 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1482,10 +1482,16 @@ static bool nci_valid_size(struct sk_buff *skb)
>  	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
>
>  	if (skb->len < hdr_size ||
> -	    !nci_plen(skb->data) ||
>  	    skb->len < hdr_size + nci_plen(skb->data)) {
>  		return false;
>  	}
> +
> +	/* Require non-zero length for standard OIDs (0x00 - 0x1F).
> +	 * But allow zero length in the proprietary range (0x20 - 0x3F). */
> +	if (!nci_plen(skb->data))
> +		if (nci_opcode_oid(nci_opcode(skb->data)) <= 0x1F)
> +			return false;

Does this validation logic create a buffer over-read vulnerability in the
Samsung s3fwrn5 driver?

The patch allows zero-length payloads for any proprietary OID (0x20-0x3F)
without distinguishing between notification (NTF) and response (RSP)
message types. The s3fwrn5 driver registers RSP handlers for proprietary
OIDs 0x22, 0x26, 0x27, and 0x28 that all unconditionally read skb->data[0]:

drivers/nfc/s3fwrn5/nci.c:s3fwrn5_nci_prop_rsp() {
    __u8 status = skb->data[0];  // No length check
    nci_req_complete(ndev, status);
    return 0;
}

If hardware sends a malformed zero-length RSP packet with one of these
proprietary OIDs, the validation would pass (since OID > 0x1F), then
nci_rsp_packet() calls skb_pull(skb, NCI_CTRL_HDR_SIZE) leaving
skb->len = 0, and s3fwrn5_nci_prop_rsp() accesses skb->data[0] on a
zero-length buffer.

The commit message justifies allowing zero-length for the NXP NTF case
(OID 0x23), which has a handler that doesn't access skb data. But the
implementation applies to ALL proprietary OIDs including RSP messages.

Would it be safer to either:
1) Restrict the zero-length exception to notification packets only
2) Check that all proprietary OID handlers can safely handle zero-length
3) Add a length check before skb->data[0] access in s3fwrn5_nci_prop_rsp()
-- 
pw-bot: cr

