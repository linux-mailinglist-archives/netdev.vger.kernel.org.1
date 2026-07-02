Return-Path: <netdev+bounces-304073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfLMHOM0RmocLwsAu9opvQ
	(envelope-from <netdev+bounces-304073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D26F5888
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=t6NWmPxC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304073-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59C4B31B5F76
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00B48C8B2;
	Thu,  2 Jul 2026 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0147ECF1
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985038; cv=none; b=S9Frrn00UnC7TagGV46GvcC2CoV9+pP1Z+RK1JFwLk/BOiLWUS4gb9BYnpKq151aKtIudGQypY2JsOk9VCYxBLGIMjFdxzNX/haTb9B7UdnqtOYHuabjIKREtO9bbVFNdl4Z3fVcsLS+JQLufSAuu+wboWv6YMExOOdz/ICTAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985038; c=relaxed/simple;
	bh=3wUEU9rIx91HtytBtj0pECdrw8Ab1A1Bresw6piV7bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNzRvDjEPc84mYLqRL54MZXeB8eSlNgJx+IGgzULP6zzwzSWLZPixv+XA+DHp93IGAicZ8IGmza31uvKqxo0agNADcsa9vu9TVGUidBkvC5btbyt4uo270vApItnQkOll+CZ0imbP0wnwmy8ZWZQeLcUItFaEl1s5AD3vO0RWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=t6NWmPxC; arc=none smtp.client-ip=212.77.101.9
Received: (wp-smtpd smtp.wp.pl 44199 invoked from network); 2 Jul 2026 11:37:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782985027; bh=zkwar8iwJsP1r3aAhyZaEddZf6ajbV8tsabdNEJcjUw=;
          h=From:To:Cc:Subject;
          b=t6NWmPxCLKfqGe8mUnAAnf74IKaVhMS7zyWUSnn6xfLbiaV3mSEYhC4u0sAO47CE6
           S8OfRrLyaYmoY+Eyp0VfYV6tYMyO9/6BQ5qOyHywogG33bnnkcjIg37NPuZKAxp9e+
           OEhWNLnGZoWurjGInC4D7zqRapR03wQnj1P6/nWN2QziBQFTRccoEmZP3r06IzGKMn
           VJ3Hg6CuEYZrE/hjDTnQaAgWBxf9i4jNi9l/Rj6nS4dT9EZRJtg9llrmHYwM7Buex/
           +jyD5M8nJv0k3hMTcoZqme6wbVaKVbcJwamBo9JtJ9DYAsDWvkMheBgw9vphHB7RKw
           Glhkm/R0eCnSA==
Received: from 77-236-11-179.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.179])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <kartikey406@gmail.com>; 2 Jul 2026 11:37:07 +0200
Date: Thu, 2 Jul 2026 11:37:07 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: castet.matthieu@free.fr, 3chas3@gmail.com, gregkh@linuxfoundation.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com,
	Mauricio Faria de Oliveira <mfo@igalia.com>
Subject: Re: [PATCH] usb: atm: ueagle: fix use-after-free in
 uea_upload_pre_firmware()
Message-ID: <20260702093707.GA6804@wp.pl>
References: <20260630041716.97102-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630041716.97102-1-kartikey406@gmail.com>
X-WP-MailID: 83ee2a829d4fe14e834cedbb5bc320e2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [seOh]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304073-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[stf_xl@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kartikey406@gmail.com,m:castet.matthieu@free.fr,m:3chas3@gmail.com,m:gregkh@linuxfoundation.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com,m:mfo@igalia.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[free.fr,gmail.com,linuxfoundation.org,lists.sourceforge.net,vger.kernel.org,syzkaller.appspotmail.com,igalia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,3d45d763d18796f97412];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,wp.pl:dkim,wp.pl:mid,wp.pl:from_mime,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9D26F5888

Hi, thanks for working at this,

On Tue, Jun 30, 2026 at 09:47:16AM +0530, Deepanshu Kartikey wrote:
> uea_load_firmware() calls request_firmware_nowait() passing a raw
> struct usb_device pointer as context, without holding a reference
> to it.
> 
> If the USB device is disconnected before the firmware workqueue
> fires, the usb_device and its usb_interface objects are freed while
> uea_upload_pre_firmware() is still pending on the workqueue. When
> the callback eventually runs, it accesses the freed memory causing
> a slab-use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in __intf_to_usbdev
>   include/linux/usb.h:752 [inline]
>   BUG: KASAN: slab-use-after-free in uea_upload_pre_firmware+0x8d/0x640
>   drivers/usb/atm/ueagle-atm.c:598
>   Read of size 8 at addr ffff88802b0710b8 by task kworker/0:2/1664
> 
> Fix by calling usb_get_dev() before queuing the firmware request to
> pin the usb_device in memory for the lifetime of the async operation,
> and usb_put_dev() in the callback once it is finished with the
> pointer. On the error path where request_firmware_nowait() itself
> fails, drop the reference immediately since the callback will never
> fire.
> Reported-by: syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3d45d763d18796f97412

I think the problem is not lack of usb device reference.
request_firmware_nowait() does get_device() and after fw work 
finish - put_device().

I suspect the issue is that syskaller corrupt descriptor such
the below condition:

 else if (usb->config->desc.bNumInterfaces == 1) 

is not met for pre-firmware device.

Adding Mauricio, who has setup for reproducing syskaller bugs on ueagle.
Hopefully he can confirm the diagnostic. If it's correct, we could
either save flag to recognize pre-firmware device, or separate driver
probe/disconnect for pre-firmware and post-firmware, to fix the issue.

Regards
Stanislaw

> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/usb/atm/ueagle-atm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
> index d610cdcef7d0..686cc58fb89f 100644
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -663,6 +663,7 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
>  	uea_err(usb, "firmware is corrupted\n");
>  err:
>  	release_firmware(fw_entry);
> +	usb_put_dev(usb);
>  }
>  
>  /*
> @@ -693,12 +694,14 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
>  		break;
>  	}
>  
> +	usb_get_dev(usb);
>  	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
>  					GFP_KERNEL, usb,
>  					uea_upload_pre_firmware);
> -	if (ret)
> +	if (ret) {
>  		uea_err(usb, "firmware %s is not available\n", fw_name);
> -	else
> +		usb_put_dev(usb);
> +	} else
>  		uea_info(usb, "loading firmware %s\n", fw_name);
>  
>  	return ret;
> -- 
> 2.43.0
> 

