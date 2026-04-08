Return-Path: <netdev+bounces-276410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLuZMzgl1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9613BA246
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09324301E20A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD03B2FEE;
	Wed,  8 Apr 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2eHSP7u5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D983AE713
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641909; cv=none; b=Xb3FM+TzM1YYhyFn13n478qETGAYyuvUfOzUGvlOYneNf19i/ciaGJPUyyZwSjGz2iBKAfwLhClMS+jqEF4iWR+50hCojOwX6oSwqWPYLababa1sbwGLTHWDqJMmo3Nt27wNi3REjGZQyCtuXAo37JGAA/d0ZQIWgycSL1CsZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641909; c=relaxed/simple;
	bh=sIl9ADyswSdUdacRGGk2RRCj/IYAwfc16ampEM29o2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTvIpjvM3dqrCc8jAjMbhN15MnyilllxK4O1NnmYrGGRNOaN1JnR8K4ku5JI6kFHnoYsDkGSO1+fuNPhvDUaRPjzWFb6uM4qrR4cB2c5q5x/hz7B4fcvDCYTiTssAjGsUXaqUSjXw7pQ1yP1Q+iI1jdcWbM1RjMRCkuq3Jj9MQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2eHSP7u5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A191DC5B1AF;
	Wed,  8 Apr 2026 09:52:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68095603CB;
	Wed,  8 Apr 2026 09:51:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3715210450D76;
	Wed,  8 Apr 2026 11:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775641895; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AmTCxSUmYlr6lmCkhB/kE8XBo7O2sT9ZgNN/59oCM+0=;
	b=2eHSP7u5yZSMunGqu1M9US2MEreqoTTZQnCKN2nSTw6tao6hEAuTzoV1MgTZIQfEevJlWL
	bftxbi/JNX9X0KFjGMAk/qN2m8iN3UL+uErPLJQjCX9mT+o29aAeDhp9z2yV08WJkENtwv
	IO/tQUDTic/6NurEgjP4aQOA5RSRQ/X0/N3dp1zks4BpGtSBmP+ZOO72UaSYV9m9OeWLbM
	rYqxEMLLMTtCFvOlR2RLk5KcjLJ9hrr9u+SGBbxvzD8fNZ1+TuyUAg/A1/rsyn865Tt1B4
	47HtusqBF4jxOZc8mnU7GZL1WU37lshuMd2GfRFmPFlpIiHemNOW+U6c5tcRBw==
Date: Wed, 8 Apr 2026 11:51:26 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260408115126.5529c823@bootlin.com>
In-Reply-To: <20260407132016.4cfivs24ljqneyu7@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
	<20260323155204.0321db13@bootlin.com>
	<20260323172640.2669232d@bootlin.com>
	<20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
	<20260324090752.0799acb1@bootlin.com>
	<20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
	<20260327113337.0368eea3@bootlin.com>
	<20260407132016.4cfivs24ljqneyu7@DEN-DL-M70577>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276410-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C9613BA246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On Tue, 7 Apr 2026 15:20:16 +0200
Daniel Machon <daniel.machon@microchip.com> wrote:

...
> 
> The following diff should fix the FDMA traffic issue, and the FDMA error splat,
> when reloading the lan966x-pci driver, by:
> 
> 1. Resetting the FDMA engine on PCI init()
> 
> 2. Clearing any rogue FDMA errors that may latch due to the soft reset by the
> reset driver.
> 
>   diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                   
>   b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                              
>   --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                          
>   +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                          
>   @@ -372,6 +372,9 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)                                            
>         if (!lan966x->fdma)                                                                                                
>                 return 0;                                                                                                  
>                                                                                                                          
>   +     lan_wr(FDMA_CTRL_NRESET_SET(0), lan966x, FDMA_CTRL);                                                               
>   +     lan_wr(FDMA_CTRL_NRESET_SET(1), lan966x, FDMA_CTRL);                                                               
>   +                                                                                                                        
>         fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);                                                  
>                                                             
>         lan966x->rx.lan966x = lan966x;                                                                                     
>   diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
>   b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                                  
>   --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                              
>   +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                              
>   @@ -1071,6 +1071,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)                                          
>                                                             
>         reset_control_reset(switch_reset);                                                                                 
>                                                                                                                            
>   +     /* When in PCI mode, the GCB soft reset issued by the reset
>   +      * controller can latch spurious bits in the FDMA error stickies.                                                  
>   +      * Clear them before request_irq hooks up the FDMA IRQ line,
>   +      * otherwise the handler fires immediately on probe.                                                               
>   +      */                                                 
>   +     lan_wr(lan_rd(lan966x, FDMA_ERRORS),   lan966x, FDMA_ERRORS);                                                      
>   +     lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);                                                    
>   +     lan_wr(lan_rd(lan966x, FDMA_INTR_DB),  lan966x, FDMA_INTR_DB);                                                     
>   +                                                                                                                        
>         /* Don't reinitialize the switch core, if it is already initialized. In                                            
>          * case it is initialized twice, some pointers inside the queue system                                             
>          * in HW will get corrupted and then after a while the queue system gets                                           
>   diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                       
>   b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                                  
>   --- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                              
>   +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                              
>   @@ -1010,6 +1010,15 @@ enum lan966x_target {                                                                             
>    #define FDMA_CH_CFG_CH_MEM_GET(x)\                                                                                      
>         FIELD_GET(FDMA_CH_CFG_CH_MEM, x)                                                                                   
>                                                             
>   +/*      FDMA:FDMA:FDMA_CTRL */                                                                                          
>   +#define FDMA_CTRL                 __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 424, 0, 1, 4)                                  
>   +                                                                                                                        
>   +#define FDMA_CTRL_NRESET                         BIT(0)                                                                 
>   +#define FDMA_CTRL_NRESET_SET(x)\                                                                                        
>   +     FIELD_PREP(FDMA_CTRL_NRESET, x)                                                                                    
>   +#define FDMA_CTRL_NRESET_GET(x)\                         
>   +     FIELD_GET(FDMA_CTRL_NRESET, x)                                                                                     
>   +                                                         
>    /*      FDMA:FDMA:FDMA_PORT_CTRL */                                                                                     
>    #define FDMA_PORT_CTRL(r)         __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 376, r, 2, 4)
> 
> Let me know if it works on your end.
> 
> (Btw. I have noticed another issue where TX stops working on lan966x-pci reload.
> It happens more rarely, but is unrelated to this patch series, as it also
> happens in register-based INJ/XTR mode. Whenever that happens, you will see
> "Flush timeout chip port" in the logs. This should also be fixed, but sent as a
> separate fix commit, I believe.)
> 

I have tested your proposed modification.

- From a cold boot, module unloading / re-loading:
  Tested Ok

- From a cold boot, module loading / no interface configuration / reboot:
  Tested Ok

- From a cold boot, module loading / interface configuration / reboot:
  Issue present.

- From a cold boot, module loading / interface configuration / module unloading / reboot:
  Tested Ok.

The interface configuration was the following command:
  ip link set eth2 up && ip addr add 192.168.32.20/16 dev eth2

With the interface configured and without unloading the lan966x_pci module
before the reboot, I have the already known FDMA error splat after the
reboot:
   [   18.908397] ------------[ cut here ]------------
   [   18.913226] Unexpected error: 64, error_type: 1073741824
   [   18.918704] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: kworker/u8:2/38
   ...

The issue is not present if I unload the lan966x_pci module before the
reboot. This let me think that something has been cleaned by the module
unloading.

On top of your proposed modification, I use the shutdown() hook in the
lan966x_driver:

    --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
    +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
    @@ -1326,9 +1326,18 @@ static void lan966x_remove(struct platform_device *pdev)
            debugfs_remove_recursive(lan966x->debugfs_root);
     }
     
    +static void lan966x_shutdown(struct platform_device *pdev)
    +{
    +       struct lan966x *lan966x = platform_get_drvdata(pdev);
    +
    +       lan966x->ops->fdma_deinit(lan966x);
    +}
    +
    static struct platform_driver lan966x_driver = {
            .probe = lan966x_probe,
            .remove = lan966x_remove,
    +       .shutdown = lan966x_shutdown,
            .driver = {
                    .name = "lan966x-switch",
                    .of_match_table = lan966x_match,

With that done, the issue is no more present.

I am not sure that this is a correct fix but it can give some clues.

Feel free to ask for more tests or more details if you need to.

Best regards,
Hervé

