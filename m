Return-Path: <netdev+bounces-264980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdSHuh0q2lCdQEAu9opvQ
	(envelope-from <netdev+bounces-264980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:44:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6D229164
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47763068F26
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43526CE3B;
	Sat,  7 Mar 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtHx9Iag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3811D63F0;
	Sat,  7 Mar 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844233; cv=none; b=WHfV+Me4tpAKsMr10L14/rfnqa2QSdmpd1g+rAh8WXbXXNn6hddoxrJXrO3oI5Z/PpACXTFwaAZdtzoudV4zf+Kkc0u/1ufrecLi5DRFHPbQq1aiN7IpehBVZCHtnLOcqgX9nHwdy3gtgm9Ayy+bJ0eyTCU6VK7svFYpG5zqoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844233; c=relaxed/simple;
	bh=y8TfDk5UbuhG507qxGMQmaX1GzUyZXxTcvDHQ3NDylI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ltpe0ZU9+t5gaHP+Xqrz8hJwQ2hZwn5gRqjU7ZTKY873pu9X9JFtCcoIA5uB0WVWtLpMcWN8D6NX1+TKC4QVmVsiM3BOVwcfxo6ZElRGPNmC5kG8IX8pxknSDStUStmd0dYTGLYT+4jJoU6wQg2pdonHwb1M09b++fnkfVrjqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtHx9Iag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6926EC4CEF7;
	Sat,  7 Mar 2026 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772844233;
	bh=y8TfDk5UbuhG507qxGMQmaX1GzUyZXxTcvDHQ3NDylI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OtHx9IagDNULDihLQBkfMIXf0PZOO3sOhjg/23kct7+HXV18IKOncZzRI4frhpNOq
	 2nN4qXbwxmpi1vDJfVmYEmcCbvH7QeulX+YHOptzo37Pf76fCoJ5GkWfo8IBJ9zsb5
	 dFechInm2UWndMTEe3FcbSEF48hWhJvIctaGL+a+aEyveR9V+3/ZFd9+b40FP5PNhl
	 52L9gKp2D+l+6WeXMhSQzHDTGf4qeQ0e7SLbskY/JeJfdVw52e2RNd5EgUdGPEjqg3
	 iH+b5HEbXjxN1cjT97HWLvDN3QoHHvL7C0OO72dgN0oHlZmhtaVShSd3wPC3xLaTbK
	 YgKRMVA6MeghA==
Date: Fri, 6 Mar 2026 16:43:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, Dmitry Bezrukov
 <dbezrukov@marvell.com>, Igor Russkikh <irusskikh@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, enelsonmoore@gmail.com, kees@kernel.org,
 oneukum@suse.com, n.zhandarovich@fintech.ru, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: usb: aqc111: Do not perform PM inside runtime
 suspend callback
Message-ID: <20260306164351.503e8540@kernel.org>
In-Reply-To: <20260304155734.110734-1-zlatistiv@gmail.com>
References: <20260304155734.110734-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CED6D229164
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264980-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,suse.com,fintech.ru,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,48dc1e8dfc92faf1124c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On Wed,  4 Mar 2026 17:57:34 +0200 Nikola Z. Ivanov wrote:
> syzbot reports "task hung in rpm_resume"
> 
> This is caused by aqc111_suspend calling
> the PM variant of its write_cmd routine.
> 
> The simplified call trace looks like this:
> 
> rpm_suspend()
>   usb_suspend_both() - here udev->dev.power.runtime_status == RPM_SUSPENDING
>     aqc111_suspend() - called for the usb device interface
>       aqc111_write32_cmd()
>         usb_autopm_get_interface()
>           pm_runtime_resume_and_get()
>             rpm_resume() - here we call rpm_resume() on our parent
>               rpm_resume() - Here we wait for a status change that will never happen.
> 
> At this point we block another task which holds
> rtnl_lock and locks up the whole networking stack.
> 
> Fix this by replacing the write_cmd calls with their _nopm variants
> in the case where we are inside a runtime suspend call.
> 
> Reported-by: syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=48dc1e8dfc92faf1124c
> Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
> This patch is untested!
> I do not have access to a real device to test it,
> testing on real hardware would be appreciated,
> if anyone has a device laying around.
> 
> I have found no reason for the PM variants to be
> used in the ->suspend callback when it comes
> to the device driver.
> 
> The PM docs suggest that PM should not be done
> during runtime suspend, but I cannot find a
> definitive answer for system suspend, hence the
> conditional if(PMSG_IS_AUTO(message))

Dmitiry, Igor, could you possibly shed some light?
Can we simply switch to the _nopm() helpers instead?

> diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
> index cbffa9ae1bb6..2f0d66c7ade0 100644
> --- a/drivers/net/usb/aqc111.c
> +++ b/drivers/net/usb/aqc111.c
> @@ -1395,14 +1395,27 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
>  		aqc111_write16_cmd_nopm(dev, AQ_ACCESS_MAC,
>  					SFR_MEDIUM_STATUS_MODE, 2, &reg16);
>  
> -		aqc111_write_cmd(dev, AQ_WOL_CFG, 0, 0,
> -				 WOL_CFG_SIZE, &wol_cfg);
> -		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
> -				   &aqc111_data->phy_cfg);
> +		if (PMSG_IS_AUTO(message)) {
> +			aqc111_write_cmd_nopm(dev, AQ_WOL_CFG, 0, 0,
> +					      WOL_CFG_SIZE, &wol_cfg);
> +			aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
> +						&aqc111_data->phy_cfg);
> +		} else {
> +			aqc111_write_cmd(dev, AQ_WOL_CFG, 0, 0,
> +					 WOL_CFG_SIZE, &wol_cfg);
> +			aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
> +					   &aqc111_data->phy_cfg);
> +		}
>  	} else {
>  		aqc111_data->phy_cfg |= AQ_LOW_POWER;
> -		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
> -				   &aqc111_data->phy_cfg);
> +
> +		if (PMSG_IS_AUTO(message)) {
> +			aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
> +						&aqc111_data->phy_cfg);
> +		} else {
> +			aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
> +					   &aqc111_data->phy_cfg);
> +		}
>  
>  		/* Disable RX path */
>  		aqc111_read16_cmd_nopm(dev, AQ_ACCESS_MAC,


