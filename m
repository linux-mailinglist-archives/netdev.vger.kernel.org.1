Return-Path: <netdev+bounces-291916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPeVLSj8FWovggcAu9opvQ
	(envelope-from <netdev+bounces-291916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 170995DC2F5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53533007F77
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF02395AC3;
	Tue, 26 May 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUAlP0dm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62230C16D;
	Tue, 26 May 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825680; cv=none; b=Dx+xZthcTV3Yl9BAl3yJ9F+zL8f6F3dHLwMeatX4eaE44pFNACabhdW+S+XLuAhxdIq0wiSzwnF1lv7waHQI1cVr1QaH3JgJFdKKONzQbf2YhwhezlYV2xotMujrFSzgnTtrY7qqRIFXZFU6TgaZf9XFRVPNBW42ZYKk5ldFnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825680; c=relaxed/simple;
	bh=nd+IYyFSAp07KyOd1BzNPpyJpQXcGhkRGMogWzI40tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuogTkQHOLgJDhevMZt26WJmkBm+MjWOxblEZW3uN+x3of0zxrkH3PJWX/yqCe17DGR0hyHakGkrxXqWDurjJQZo8npiDJq+pnf7RHZr0Hyd5RdYQOf4JXRAkhZJ0Lb1TGS/YT9eS39KuCekxvCBXx1ibnXBSsr3RcTgrIn1uvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUAlP0dm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC84F1F000E9;
	Tue, 26 May 2026 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779825678;
	bh=1qxnmKQGUKtoFj3/nGD5Rn2Gfy5r6REEQNVEGh2K3ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XUAlP0dm/G60yd+smYcUeLELrUuSSrHXbnAXU/Q1+cjxZlg/jZGq5x/8aQ9k/lp2/
	 75qT1tMlIyHUDx14RtalRuKuqkKqC8XTO4xf40eSqk8kGMSRI1W/sLGMy6+tmmDErx
	 sSZAyp3JucSrQEkEjIY2KLW6wuLFNU0dXlzak8CdRg/LcUk+jdCg2btwH3M4NAXuIo
	 ta1bepz6hgmjF13VWpiqaDUZ8cnOzG8cEDiz1Iam/Pw3sN7Lep0xIjKRNYHBq9fD/G
	 Amr42UO8/ZtBc1rqraAWIzPxzn0wqy/AanF5JMxvlsm7V6WQB/s+SQ01uD/mbePgGu
	 0E+JZaGxaZsPg==
Date: Tue, 26 May 2026 21:01:14 +0100
From: Simon Horman <horms@kernel.org>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: anthonylnguyen <anthony.l.nguyen@intel.com>,
	"anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	andrewnetdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>,
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] e1000e: fix memory leak of msix_entries on
 MSI-X failure
Message-ID: <20260526200114.GD2256768@horms.kernel.org>
References: <19e537fa55c.56218d6244367.1765806925055659075@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e537fa55c.56218d6244367.1765806925055659075@zohomail.in>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,sashiko.dev:url,horms.kernel.org:mid,zohomail.in:email]
X-Rspamd-Queue-Id: 170995DC2F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 11:52:14AM +0530, Ashwin Gundarapu wrote:
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Sat, 23 May 2026 11:49:40 +0530
> Subject: [PATCH] e1000e: fix memory leak of msix_entries on MSI-X failure
> 
> When MSI-X initialization fails, the driver falls through to try
> MSI or legacy interrupts. However, the msix_entries array allocated
> earlier is not freed, causing a memory leak. Free it and set to
> NULL before falling through to the MSI fallback path.
> 
> Found by code inspection.
> 
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7ce0cc8ab8f4..1526069d7fc1 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2065,10 +2065,12 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
>  							    a->num_vectors);
>  				if (err > 0)
>  					return;
> -			}
> -			/* MSI-X failed, so fall through and try MSI */
> -			e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
> -			e1000e_reset_interrupt_capability(adapter);
> +                        }
> +                        /* MSI-X failed, so fall through and try MSI */
> +                        e_err("Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.\n");
> +                        kfree(adapter->msix_entries);
> +                        adapter->msix_entries = NULL;
> +                        e1000e_reset_interrupt_capability(adapter);

Hi Ashwin,

e1000e_reset_interrupt_capability() already handles freeing (and NULLing)
msix_entries, and it does so after calling pci_disable_msix().

This patch seems to have the effect of bypassing the call to
pci_disable_msix().

Are you sure this is fixing a memory leak as described?

Flagged by https://sashiko.dev/ and https://netdev-ai.bots.linux.dev/sashiko/

>  		}
>  		adapter->int_mode = E1000E_INT_MODE_MSI;
>  		fallthrough;
> --
> 2.43.0
> 
> 

