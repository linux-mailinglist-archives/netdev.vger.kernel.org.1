Return-Path: <netdev+bounces-292221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EBUMN2/FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:56:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E05E23E0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2C23301A2C7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FDB3C2BB4;
	Wed, 27 May 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ44YiOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE053446C0;
	Wed, 27 May 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875232; cv=none; b=NA8IyQFzQDxkQMZp3T9GSaK5qLTxhQjzRLwdM8dyv4NmMJN1vFf425kX+FiyyGiP5y60xV4fpHWqQGTD84f6Os5TE8atTOn6gVCplFk7ykT33DErjac/xS9Piejn4wv+9mEy59uoV3l5IPfZ5/7rI/LxLg+lsu+XOLKahyToymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875232; c=relaxed/simple;
	bh=cZBXF5n5heiU0yfVcoVzX5Frlr3jbzLETtopgWuSThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmvVnZRIC8kjUoiN9Uum7K1LA6HM71OVmx1lM6nciTKJzrbBKurtuBHSK6Wd4xxfQAUJpA0IRwN1wUQf46e6Pbq+LOwHuARFycTVwFlb4Rf9oDLhSzKNw4eCx7ZlgjfjL3vNNfcknyPMHWZtpbYQKBnZf86pqOeyR3DS3i4yZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ44YiOq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C0D1F000E9;
	Wed, 27 May 2026 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779875230;
	bh=4sLLUrxeCfKW1kigyrAIONtlCWQo1qmLOvFucC+MnWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQ44YiOqzM7JkO+eJEfZnElCctwSjhbWfLlwXRyjk9CWri8a5Hx/qCK90jnFCQPZe
	 heTNDy4sDMNw7JDPLnkuAfmyeDOq3kMdPFxXNHa+f6I8ArTNKs+OfGDlNT1ws4B6FD
	 Pij4rpYg8doGUsGZxjj0E9P1wDlNrufKP3ueivTc+FfDz5gXQKNNMsHdp3RU1qN5pl
	 t2yXsBq5lOtVbhmkLQxEXxLB+FMXit+SQ41me+wuKYR/Ouzk72wm5ERDaSCVzZMX5z
	 7oqFcJ/inNad7/4an01D37Zl77Lvb6TGjuRY5QBd1Qyp7o6LUYppLNJemAngIqBL+8
	 AgrHXzc9L3O/w==
Date: Wed, 27 May 2026 10:47:06 +0100
From: Simon Horman <horms@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: rmnet: clarify MAP command ACK behavior
Message-ID: <20260527094706.GH2256768@horms.kernel.org>
References: <20260523110346.1672-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523110346.1672-1-dennylin0707@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF1E05E23E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 11:03:46AM +0000, Hungyu Lin wrote:
> rmnet_map_command() only sends ACK responses for supported
> commands. Unsupported commands are dropped without sending
> a response.
> 
> Update the comment to reflect the current behavior.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> index add0f5ade2e6..c1c3d4fc7a99 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> @@ -69,8 +69,8 @@ static void rmnet_map_send_ack(struct sk_buff *skb,
>  	netif_tx_unlock(dev);
>  }
>  
> -/* Process MAP command frame and send N/ACK message as appropriate. Message cmd
> - * name is decoded here and appropriate handler is called.
> +/* Process MAP command frame and send ACK message for supported commands.
> + * Message cmd name is decoded here and the appropriate handler is called.
>   */
>  void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port)
>  {

There is an AI generated review of this patch available at
https://netdev-ai.bots.linux.dev/sashiko/

In brief, it suggests that the wording above may still be too broad
as the ACk is only sent when supported commands are successfully processed.
But I regard this as a nit-pick and I think the current wording is fine.


There is another AI generated review of this patch available
at https://sashiko.dev

In this case the review flags possible pre-existing issues in the code.
And I don't believe they effect this documentation change.


In summary, I think this patch is good in it's current form.
And that it's progress should not be effected by the AI-generated
reviews cited above.

Reviewed-by: Simon Horman <horms@kernel.org>

