Return-Path: <netdev+bounces-273417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAiTJekby2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56398362EA8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04240305EB82
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B892FE56A;
	Tue, 31 Mar 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6FcsSwd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60F2F0C45
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918537; cv=none; b=fVyveIrI2/V+ADbhCeWyJ9hG29SV52sGZ8a1Xj3CH58Po8elbzW93yGA+HCfzZqyvs8Xwp9MKOqb1wL9tjfrY0GaeyW7DP2SgjWg3bafM7an3443CQABRLCak7zS2fzEC4rticNlDh85jBBmn9J20kPpOxc6ZndALMdIFY0X4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918537; c=relaxed/simple;
	bh=Nd1dg9v5tyXrIZZZqqCDOe3BHEUvs19RqTjexVkGAc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ykc0w50bSVIXr3FuoeLmi7FvdwoZ8GCwC9yhngUS140a6iQH9HKVJbAN01do/bneAg16bNliedDn4yA3UeF1IDcsfqjnXzVRFIEr5ONE6hXeOXJjEw3mA8zpx9QLYJu9NIx+DmqxZ3IUShyFXme43vdKKj8bjOlXtUcWGCZ3MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6FcsSwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B7C4CEF7;
	Tue, 31 Mar 2026 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918537;
	bh=Nd1dg9v5tyXrIZZZqqCDOe3BHEUvs19RqTjexVkGAc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6FcsSwd4RLZVyzxQwdHBxUtI2bhumH7Ibg8FBGh/IqGuayJ0KV5N9H10agAdHjhV
	 nNWd4YtEW+FSBzKrCOjDgrLAdKHjAz7bxGoij8FBCsHeRJK8TgVcL7yMTVHvgHvQVP
	 SUriPfqqMVAivya0FfFWsM3gBTiR+OnibQhJXlrMP+OWwRbXNi6GWsyjRAnZEq/Dkd
	 NRP2dw2hApX4ao+OQ7pmTmNLCux7DJNErBqZzxHKi4EjE6y8kPo4S8xwB3cMIXy3Dv
	 2a6b5K8vCCXvsJxuP+IY/XhNaOnjMjwNkfpvxmqXHGcWgF1BxW7gxV4nUoEwtpSbR4
	 vRa5a8XgNKa2w==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	joe@dama.to,
	larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com,
	leitao@debian.org
Subject: Re: [PATCH net-next v6 05/11] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Mon, 30 Mar 2026 17:55:34 -0700
Message-ID: <20260331005534.3459587-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-6-jiawenwu@trustnetic.com>
References: <20260326021406.30444-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273417-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56398362EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: move reusable PCI driver ops functions into libwx

This commit adds a function pointer for close_suspend and adjusts do_reset.
These changes allow PCI driver operations such as shutdown to be called
directly from the common libwx library.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 746623fa59b40..c65240ca3c283 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> @@ -3342,5 +3342,90 @@ void wx_service_timer(struct timer_list *t)
>  }
>  EXPORT_SYMBOL(wx_service_timer);
>  
> +static void wx_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	u32 wufc = wx->wol;
> +
> +	netdev = wx->netdev;
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev))
> +		wx->close_suspend(wx);
> +
> +	wx_clear_interrupt_scheme(wx);
> +	rtnl_unlock();
> +
> +	if (wufc) {
> +		wx_set_rx_mode(netdev);
> +		wx_configure_rx(wx);

Does this sequence result in a use-after-free of the DMA rings?

When the interface is running, wx->close_suspend() is called, which frees
all receive and transmit descriptor rings via dma_free_coherent() in
wx_free_resources().

If Wake-on-LAN is enabled (wufc != 0), the code then calls
wx_configure_rx(). This programs the freed DMA physical addresses from
ring->dma (which is not cleared upon free) into the MACs Receive Descriptor
Base Address registers.

If the MAC fetches from these freed pages, could it interpret garbage data as
buffer addresses and DMA incoming network packets into random physical memory?

> +		wr32(wx, WX_PSR_WKUP_CTL, wufc);
> +	} else {
> +		wr32(wx, WX_PSR_WKUP_CTL, 0);
> +	}
> +	pci_wake_from_d3(pdev, !!wufc);
> +	*enable_wake = !!wufc;
> +	wx_control_hw(wx, false);
> +
> +	pci_disable_device(pdev);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 50a13dcf4b3c8..baffcadb22690 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> @@ -604,11 +570,11 @@ static void ngbe_reinit_locked(struct wx *wx)
>  	clear_bit(WX_STATE_RESETTING, wx->state);
>  }
>  
> -void ngbe_do_reset(struct net_device *netdev)
> +void ngbe_do_reset(struct net_device *netdev, bool reinit)
>  {
>  	struct wx *wx = netdev_priv(netdev);
>  
> -	if (netif_running(netdev))
> +	if (netif_running(netdev) && reinit)
>  		ngbe_reinit_locked(wx);
>  }

Is it intentional that ngbe_do_reset() does nothing when reinit is false?

Before this patch, ngbe_resume() explicitly called ngbe_reset_hw().
Now that it uses the shared wx_resume(), it calls wx->do_reset(netdev, false).

Since ngbe_do_reset() lacks an else branch for when reinit is false
(unlike txgbe_do_reset()), the hardware reset is skipped entirely during
resume. Will this leave the MAC/PHY uninitialized and break the interface
after a suspend/resume cycle?

