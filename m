Return-Path: <netdev+bounces-299057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T+aIIkvPLWqJkQQAu9opvQ
	(envelope-from <netdev+bounces-299057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25767FCED
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hwel8ahi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A733011F2D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673330ACE6;
	Sat, 13 Jun 2026 21:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0B70830;
	Sat, 13 Jun 2026 21:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387081; cv=none; b=uuA2SE9KY3OYvisgZtGLg2424VQwP9hYLQXC//D5RGwa/1vcloFlvZzzhJ8MlJRxOwb6E5Jmpe+l4bP9oXCJgJhsoySGdhLTqKIl60MQJ9FtYZXvUdY8i+2ZZnZep842y4q6CL7a3x0CuDY/vCgzW7R3WTPVzyNEUk7Q0KrMeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387081; c=relaxed/simple;
	bh=qm0c/7OqOrnZF819uwAs5sHM0Jrpdt9zlsXwPCKTmpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la2q0Cnei0vEnsppsspSH6Tu47YQBV1Fb1SkbF7HDDPGDNrZ8FiqJRo/q+CefjfiASGn6tZQDAnoF7V32wlsOFgPji7JoVHmPviV1vqwzdGsmkyHWnXfNUDMhyxuHvscSkYgU9H5UJG9nSdjq/3Hig9BGOc1gBlYTHyDnjz/zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwel8ahi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7DB1F000E9;
	Sat, 13 Jun 2026 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387080;
	bh=VTV3hvkfnFtSxcZwKkRw+CPpLJ0bwEj286O8Akrc30o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hwel8ahiwoji/cs9e+YwduWGKtvE43RoGsDZ+zTq7dPRUrHm9Neb0FkZ+ldR2iI4r
	 bRygPatiiWFRB0n/d9etgCmr6aeYh475zpTMC3gziAzuDoPE3b3VIoGiWW5XX2iALa
	 hQF8BPmtgOrjuuHhAeL2zU5m6ZW3ZtGCGfr5LbOijd0ig//fHV+jCwvF8brBap9iq+
	 uL2+wiM3tWAzZVWfTeNbkhl8xGMwSmUuy/iiiHrmDdpl1lBglhzVAgCI3w3GeFSUBs
	 nNYY7aSBFuuXMaWk25Llhli49eylbAetSE1L1GMYkXdxdcg+rchxgN24eHX56eCyb+
	 yGVxEmLXj8g6A==
Date: Sat, 13 Jun 2026 14:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Message-ID: <20260613144438.767f8069@kernel.org>
In-Reply-To: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299057-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E25767FCED

On Wed, 10 Jun 2026 16:16:48 +0800 Menglong Dong wrote:
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */

TBH all the comments you're adding are harder to understand than the
code itself ;( Please try to phrase them better or just remove them.

