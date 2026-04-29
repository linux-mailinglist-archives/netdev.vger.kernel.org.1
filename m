Return-Path: <netdev+bounces-282191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHIZD4tk8Wk8ggEAu9opvQ
	(envelope-from <netdev+bounces-282191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D048E20B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74682301E584
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E75359A68;
	Wed, 29 Apr 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tmUixQaj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735234AB06;
	Wed, 29 Apr 2026 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427587; cv=none; b=H5YfkxCRIdTxZ4SoGK8E5jsp/B02aknkznT1oopYBTN+uo6Kw6WQOloVqCikZtcp3G0k6ip5YFjggW93WWA9wz/I1+PCDHwwABWbRXum9IDec9rWUKvYOExRImRgLzsaRQuINZ+4oPbjSKOE79K0vq/AJAE/XuygUGSsyH1nXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427587; c=relaxed/simple;
	bh=5aXFuNsbs4JbrpQO6xbeh6efmIxB4/L1r+seliHUaIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N17RiFX3i+5HJzMdrAtFhwAmY1xNK+4+vEnZLrNh9rjK3h9CJwe1a5pqLZFYwpTTRFUldbgkTsnw2ivVPNE7Nb6h0WA35fsKSVM84KthLrY2TwhMfpStKYWmM6qSqRVG8yP8luiLJ24ZxWl8C1z6C0Ig5/fIYocxJeq+X7vNH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tmUixQaj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z0cX/ojT+0Guv16ohll90IHcdqreDWnQJf999+c3H6c=; b=tmUixQajy0qwThmRHc7SRL0MB6
	WXvKZdhrXjwVhNceBPzWJofTEY8YWESJvWo3wUtezUM0AgFDhyCMCn9bn8mfuOwJI1XZwIUob95Yg
	KYN7ZvJ6xfY5/sD4HOhGnlQ6Xm5162g9lpHTdWHJGX7u7jTxrz++qbsQuSsZdCp2TFbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHu6k-000Rn6-1B; Wed, 29 Apr 2026 03:52:58 +0200
Date: Wed, 29 Apr 2026 03:52:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 2/4] r8152: Add support for the RTL8159 chip
Message-ID: <3e04d913-693c-44a9-a685-df9d0c9bd95f@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-2-52d03927b46f@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-rtl8159_net_next-v1-2-52d03927b46f@birger-koblitz.de>
X-Rspamd-Queue-Id: BA0D048E20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282191-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> @@ -3431,6 +3432,7 @@ static void rtl8152_nic_reset(struct r8152 *tp)
>  		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, CDC_ECM_EN);
>  		break;
>  
> +	case RTL_VER_17:
>  	case RTL_VER_16:
>  		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);

nitpick. The other switch statements seem to be sorted. So 17 should
be after 16.

> +		/* Power level tuning */
> +		// test mode power level
> +		sram_write_w0w1(tp, 0x8415, 0xff00, 0x9300);
> +		// normal link power level 10G, 5G, 2.5G
> +		sram_write_w0w1(tp, 0x81a3, 0xff00, 0x0f00);
> +		sram_write_w0w1(tp, 0x81ae, 0xff00, 0x0f00);
> +		sram_write_w0w1(tp, 0x81b9, 0xff00, 0xb900);
> +		//nomal link TX filter

normal? Please also add a space after the //. netdev also prefers /*
*/.

> +		/* XG INRX parameters */
> +		// RC coefficients
> +		sram2_write(tp, 0x84ac, 0x0000);
> +		sram2_write(tp, 0x84ae, 0x0000);
> +		sram2_write(tp, 0x84b0, 0xf818);
> +		sram2_write_w0w1(tp, 0x84b2, 0xff00, 0x6000);
> +		//Training AAGC PAR (with uc2 patch)

space

> +static int r8159_wait_backup_restore(struct r8152 *tp)
> +{
> +	u32 ocp_data;
> +
> +	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> +	if (!(ocp_data & PCUT_STATUS))
> +		return 0;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> +			       ocp_data & BACKUP_RESTRORE, 200, 2000, false);
> +}
> +
>  static void r8156_init(struct r8152 *tp)
> @@ -8221,6 +8421,9 @@ static void r8156_init(struct r8152 *tp)
>  			return;
>  	}
>  
> +	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp))
> +		return;

You should probably do something with the return value from
r8159_wait_backup_restore(). At minimum a dev_err().

    Andrew

---
pw-bot: cr
	

