Return-Path: <netdev+bounces-299966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahlCMYfFMWrKpwUAu9opvQ
	(envelope-from <netdev+bounces-299966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 945486957C3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=BkQPM8Ff;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299966-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299966-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A54DB300A5B8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A838F941;
	Tue, 16 Jun 2026 21:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB0331EA5
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:51:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646722; cv=none; b=g0VsddeFIXmMJmqtGAITVpFvQVRwOZLpkUAu6vxXji7b9i3719cIs6XN4urfmJ61AagTRmUN2+A6wwqF10dA8VybIDJVBDa6dNn2bWovHFEjyMVE7WSa7hXL4m7g22IsAYOOntX4sHWb9gxkZaUl/E1rJ39XOl3H9oXOz4GeJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646722; c=relaxed/simple;
	bh=obOzldN+LQsjeklG6LrCuEPhtTiDzSyhkMGybJq7nzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT51LIM4o8VntyPbJZO+BtVwlMTm/C3iFwbo1Z1lCgV2mozlfCahVfNmN81wZYf9RCKrAx6gjzCFL+tM100NC9bbHd1WcxALuaI/XGFKqphjqBPcR6Or6NdoDoG4CF3Pc27ihiuYnbo9RmnoZrE2GoAVjth29POAn7QrpqfyxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BkQPM8Ff; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JMh2DGgeekcuM7pXyDPRogcytRWKrPwaCauLBLQ4ra0=; b=BkQPM8FfBpHKaPv9mpBJm6UYVk
	M6dcnNLuYqKsNMR1SvbB0GNQOute76XtHniy0LzLuLB/ENTTmetjDRm3AHEB7Iti0Pn1RgL3mFess
	xkJsf6bq/G/I+WTFrd/yVNeBRBqNlOpR1ku2vkAk7OrDcIPNvLQ467f1B1cION23Np5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZbhC-008277-KT; Tue, 16 Jun 2026 23:51:46 +0200
Date: Tue, 16 Jun 2026 23:51:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] e1000: Remove redundant else after return
Message-ID: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
References: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299966-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lovekeshsolanki00@gmail.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 945486957C3

On Wed, Jun 17, 2026 at 02:30:08AM +0530, Lovekesh Solanki wrote:
> The else branch is needless because the preceding branch
> unconditionally returns -ENOMEM
> 
> Reduce nesting by removing unnecessary else
> 
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 9b09eb144b81..3d97e952c916 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1546,11 +1546,10 @@ static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
>  			      "for the transmit descriptor ring\n");
>  			vfree(txdr->buffer_info);
>  			return -ENOMEM;
> -		} else {
> +		}
>  			/* Free old allocation, new allocation was successful */
>  			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
>  					  olddma);
> -		}

Hi Lovekesh

Please review this patch yourself and tell us what is wrong with it.

Also, please read

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

