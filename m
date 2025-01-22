Return-Path: <netdev+bounces-160283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42CA19212
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3FC188689E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F8211A16;
	Wed, 22 Jan 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="Gr5tEEGB"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88D1EF1D;
	Wed, 22 Jan 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551339; cv=none; b=OcpYcsCYJJbaXPPGNoyvCQRzEqJv7zPETiweUW/5yCvDPpttx/kpfw+4TuzwQ6yOQSLy2BXwdVeQ62AZvvZ6aonKX8LSFD6keVoyaJIdsMhXDCx9J6Kz+GsQiGkZu/Cd+h3LQdJ2VgHxTdQdb2xLOsxgbRd7CrKCUC42eg/FSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551339; c=relaxed/simple;
	bh=16C1NspXXzMaKdRR0Pc5ONVu540M1d+VHSAYlDjRejs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGFVO3PB4Q3g5bLMQ/drgcskjtUXkzxO9WdqtnG9YFNWNup0daj6TAgbuH/QcvNRdl6a5XGxaHv+Hutm0prBv7oglEHg/4WJLYumtI0BdHYcuWOcJlb8vaX/OjfwQeEhB9svE5wlPVknb6xrq3Up5UDUv6Fi52069VKuvAZNXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=Gr5tEEGB; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=nucleusys.com; s=xyz; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SwiT4yhva7UJxjf7ri02WQInahqjw6os6/zyDLPTRCQ=; b=Gr5tEEGBI4SqeZfRNF2HU7B3WI
	dVwDZqn3qsovi3JeaSLUTjFLg/BpOtc8OkBB3nG/LG6AkoOCdKphkRUB4/m/ZAB4xMi5j4jZXafJ4
	lzspkiFffsj6UqQ1tYS/SzOcBSJHZM4MtTAj+eh2Ln9KVEcEphqvutSaHlt2MSe1H6aA=;
Received: from [192.168.234.1] (helo=bender.k.g)
	by lan.nucleusys.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <petkan@nucleusys.com>)
	id 1taa5P-000FSM-0X;
	Wed, 22 Jan 2025 14:44:01 +0200
Date: Wed, 22 Jan 2025 14:43:59 +0200
From: Petko Manolov <petkan@nucleusys.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: usb: rtl8150: enable basic endpoint checking
Message-ID: <20250122124359.GA9183@bender.k.g>
References: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
X-Spam_score: -1.0
X-Spam_bar: -

On 25-01-22 02:42:46, Nikita Zhandarovich wrote:
> Syzkaller reports [1] encountering a common issue of utilizing a wrong usb
> endpoint type during URB submitting stage. This, in turn, triggers a warning
> shown below.

If these endpoints were of the wrong type the driver simply wouldn't work.

The proposed change in the patch doesn't do much in terms of fixing the issue
(pipe 3 != type 1) and if usb_check_bulk_endpoints() fails, the driver will just
not probe successfully.  I don't see how this is an improvement to the current
situation.

We should either spend some time fixing the "BOGUS urb xfer, pipe 3 != type 1"
for real or not touch anything.


		Petko


> For now, enable simple endpoint checking (specifically, bulk and
> interrupt eps, testing control one is not essential) to mitigate
> the issue with a view to do other related cosmetic changes later,
> if they are necessary.
> 
> [1] Syzkaller report:
> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> WARNING: CPU: 1 PID: 2586 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 driv>
> Modules linked in:
> CPU: 1 UID: 0 PID: 2586 Comm: dhcpcd Not tainted 6.11.0-rc4-syzkaller-00069-gfc88bb11617>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
> Code: 84 3c 02 00 00 e8 05 e4 fc fc 4c 89 ef e8 fd 25 d7 fe 45 89 e0 89 e9 4c 89 f2 48 8>
> RSP: 0018:ffffc9000441f740 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff888112487a00 RCX: ffffffff811a99a9
> RDX: ffff88810df6ba80 RSI: ffffffff811a99b6 RDI: 0000000000000001
> RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> R13: ffff8881023bf0a8 R14: ffff888112452a20 R15: ffff888112487a7c
> FS:  00007fc04eea5740(0000) GS:ffff8881f6300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0a1de9f870 CR3: 000000010dbd0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  rtl8150_open+0x300/0xe30 drivers/net/usb/rtl8150.c:733
>  __dev_open+0x2d4/0x4e0 net/core/dev.c:1474
>  __dev_change_flags+0x561/0x720 net/core/dev.c:8838
>  dev_change_flags+0x8f/0x160 net/core/dev.c:8910
>  devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1177
>  inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1003
>  sock_do_ioctl+0x116/0x280 net/socket.c:1222
>  sock_ioctl+0x22e/0x6c0 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc04ef73d49
> ...
> 
> This change has not been tested on real hardware.
> 
> Reported-and-tested-by: syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7e968426f644b567e31
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/net/usb/rtl8150.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 01a3b2417a54..f77af8cf543c 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -71,6 +71,14 @@
>  #define MSR_SPEED		(1<<3)
>  #define MSR_LINK		(1<<2)
>  
> +/* USB endpoints */
> +enum rtl8150_usb_ep {
> +	RTL8150_USB_EP_CONTROL = 0,
> +	RTL8150_USB_EP_BULK_IN = 1,
> +	RTL8150_USB_EP_BULK_OUT = 2,
> +	RTL8150_USB_EP_INT_IN = 3,
> +};
> +
>  /* Interrupt pipe data */
>  #define INT_TSR			0x00
>  #define INT_RSR			0x01
> @@ -880,6 +888,20 @@ static int rtl8150_probe(struct usb_interface *intf,
>  		return -ENOMEM;
>  	}
>  
> +	/* Verify that all required endpoints are present */
> +	static const u8 bulk_ep_addr[] = {
> +		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
> +		RTL8150_USB_EP_BULK_OUT | USB_DIR_OUT,
> +		0};
> +	static const u8 int_ep_addr[] = {
> +		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
> +		0};
> +	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +	    !usb_check_int_endpoints(intf, int_ep_addr)) {
> +		dev_err(&intf->dev, "couldn't find required endpoints\n");
> +		goto out;
> +	}
> +
>  	tasklet_setup(&dev->tl, rx_fixup);
>  	spin_lock_init(&dev->rx_pool_lock);
>  
> 

