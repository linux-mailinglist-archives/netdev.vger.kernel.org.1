Return-Path: <netdev+bounces-219010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A063B3F600
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D90C1A84421
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F42E54A8;
	Tue,  2 Sep 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e6dpTEQn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283F2DEA94;
	Tue,  2 Sep 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796101; cv=none; b=JplY5GLvgtvaKEnHfthwoakrdDRhh35/lZTm+7emzAONBnRnCuRRHXelT764QAKcamXwKPAn8dCeEHO0sBC9a1Hc/OcHTzeisAgfqY6LrdUBxI/UM6PxbPeev2nQozATBDCJE3/Hnql3anhJed6CXqSy4MjtA0+bgLGr2c5Df7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796101; c=relaxed/simple;
	bh=CsC+1NseFGXr+HNNYQlwT7VdG2zs1pDwSBXDb2b5wt0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvxS5raKm2M5b973Qj2g2ls/HtTUNm77qytfJM54smgz/JIxFte3luDfhu8kNmrRpCKOTYs2In7Tflna4j9PnFpnJaaZAEon4KEmF5fNNbkbkMmZOn/QNV34oqT49sHk2NlgCy/h3lgPQjOXGVE3ltc9MKjHHzZA6qcaqsIHTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e6dpTEQn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756796101; x=1788332101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsC+1NseFGXr+HNNYQlwT7VdG2zs1pDwSBXDb2b5wt0=;
  b=e6dpTEQn1VIt7vMsfHviLAvFOqrE008IkP2XKj9Y3If+HfpYrCC8cEYN
   Nygb/IHxOcL8RhqBanZGW0/9oTRSAGDvd+UW8vz5pBCaR9Zubd8f6CQxa
   eXa3MjVzcncPXIgfveea6NHyRj31oVeBmSNPX3OgU4pFStRrVwIYKCEZo
   8BgXMZgNym0z7c1+0hylVBn+Tuy9phcHEYMyOfgCm9SE26TyjslMv/Ql/
   TEmcbgWxSXPAjn89woh6hLMjjpEdxfGKCnaXrbZm1lauNuYouAtiKXiX7
   HmPlWEpp+jQ3F4En+w3F8yJs7Ls3X3wwKKYe43Aat7e8E/Xh2zxZa5pG1
   Q==;
X-CSE-ConnectionGUID: XpzdIPkfRDuYgIDUOjABFg==
X-CSE-MsgGUID: GRlAvooiQ9+ZJjI9J61fLg==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="277307066"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 23:54:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 23:54:26 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 23:54:26 -0700
Date: Tue, 2 Sep 2025 08:50:47 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<viro@zeniv.linux.org.uk>, <atenart@kernel.org>,
	<quentin.schulz@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Stop taking ts_lock for tx_queue and
 use its own lock
Message-ID: <20250902065047.shz6bkyfewleluzp@DEN-DL-M31836.microchip.com>
References: <20250901092304.1312787-1-horatiu.vultur@microchip.com>
 <dbc50956-4aa6-4484-be32-0b091d494bc1@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <dbc50956-4aa6-4484-be32-0b091d494bc1@linux.dev>

The 09/01/2025 11:19, Vadim Fedorenko wrote:

Hi Vadim,

> 
> On 01/09/2025 10:23, Horatiu Vultur wrote:
> > When transmitting a PTP frame which is timestamp using 2 step, the
> > following warning appears if CONFIG_PROVE_LOCKING is enabled:
> > =============================
> > [ BUG: Invalid wait context ]
> > 6.17.0-rc1-00326-ge6160462704e #427 Not tainted
> > -----------------------------
> > ptp4l/119 is trying to lock:
> > c2a44ed4 (&vsc8531->ts_lock){+.+.}-{3:3}, at: vsc85xx_txtstamp+0x50/0xac
> > other info that might help us debug this:
> > context-{4:4}
> > 4 locks held by ptp4l/119:
> >   #0: c145f068 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x58/0x1440
> >   #1: c29df974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x5c4/0x1440
> >   #2: c2aaaad0 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x108/0x350
> >   #3: c2aac170 (&lan966x->tx_lock){+.-.}-{2:2}, at: lan966x_port_xmit+0xd0/0x350
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 119 Comm: ptp4l Not tainted 6.17.0-rc1-00326-ge6160462704e #427 NONE
> > Hardware name: Generic DT based system
> > Call trace:
> >   unwind_backtrace from show_stack+0x10/0x14
> >   show_stack from dump_stack_lvl+0x7c/0xac
> >   dump_stack_lvl from __lock_acquire+0x8e8/0x29dc
> >   __lock_acquire from lock_acquire+0x108/0x38c
> >   lock_acquire from __mutex_lock+0xb0/0xe78
> >   __mutex_lock from mutex_lock_nested+0x1c/0x24
> >   mutex_lock_nested from vsc85xx_txtstamp+0x50/0xac
> >   vsc85xx_txtstamp from lan966x_fdma_xmit+0xd8/0x3a8
> >   lan966x_fdma_xmit from lan966x_port_xmit+0x1bc/0x350
> >   lan966x_port_xmit from dev_hard_start_xmit+0xc8/0x2c0
> >   dev_hard_start_xmit from sch_direct_xmit+0x8c/0x350
> >   sch_direct_xmit from __dev_queue_xmit+0x680/0x1440
> >   __dev_queue_xmit from packet_sendmsg+0xfa4/0x1568
> >   packet_sendmsg from __sys_sendto+0x110/0x19c
> >   __sys_sendto from sys_send+0x18/0x20
> >   sys_send from ret_fast_syscall+0x0/0x1c
> > Exception stack(0xf0b05fa8 to 0xf0b05ff0)
> > 5fa0:                   00000001 0000000e 0000000e 0004b47a 0000003a 00000000
> > 5fc0: 00000001 0000000e 00000000 00000121 0004af58 00044874 00000000 00000000
> > 5fe0: 00000001 bee9d420 00025a10 b6e75c7c
> > 
> > So, instead of using the ts_lock for tx_queue, use the spinlock that
> > skb_buff_head has.
> > 
> > Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > 
> > ---
> > v1->v2:
> > - initialize tx_queue in ptp_probe
> > - purge the tx_queue when the driver is removed or when TX timestamping
> >    is OFF
> > ---
> >   drivers/net/phy/mscc/mscc_ptp.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> > index 72847320cb652..e866a1d865f8b 100644
> > --- a/drivers/net/phy/mscc/mscc_ptp.c
> > +++ b/drivers/net/phy/mscc/mscc_ptp.c
> > @@ -461,7 +461,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
> >               return;
> > 
> >       while (len--) {
> > -             skb = __skb_dequeue(&ptp->tx_queue);
> > +             skb = skb_dequeue(&ptp->tx_queue);
> 
> Now as you switched to use spinlock of tx_queue, it is technically
> correct to change skb_queue_len(&ptp->tx_queue) to
> skb_queue_len_lockless(&ptp->tx_queue) a couple of lines above this
> chunk.

I will update this in the next version.
Thanks!

> 
> Otherwise LGTM, once skb_queue_len fixed you can add
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> 
> Thanks!
> 
> >               if (!skb)
> >                       return;
> > 
> > @@ -486,7 +486,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
> >                * packet in the FIFO right now, reschedule it for later
> >                * packets.
> >                */
> > -             __skb_queue_tail(&ptp->tx_queue, skb);
> > +             skb_queue_tail(&ptp->tx_queue, skb);
> 

-- 
/Horatiu

