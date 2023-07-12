Return-Path: <netdev+bounces-17078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B59750246
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F8D2816A4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6943C100B2;
	Wed, 12 Jul 2023 09:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C81116
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:01:26 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749310CF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 02:01:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 451635C00BD;
	Wed, 12 Jul 2023 05:01:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jul 2023 05:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1689152484; x=1689238884; bh=xmp0kiDiHuCYb
	FACY9UK1mmkzYRL6jMu4jfjvJVgrY0=; b=FnaaxwQ0un1Djy+1JtlBJWorL+uGD
	s9NTx1bzRrsXqM+a/cDd14V+xKZ8/+mZ5RXVYh4mxcniEQkXgY/Bc1Nmhc1hISaD
	nobnHPnffsbQ6qzzFXDV/vLl9IQkjvWsaKPPGgOX+0/jA5RIF6ifDVM8BLzHKJ0E
	J1/9AiSj1GLYQiujjpYk1rmYhHmHIXUZXXuSEyIaqZSb+hMZmLhEIHh6+MTGuiQB
	Rz/hQAviLwXWQ2l2y1HrCjvmJh8RA50ieXb2LPcTNaNyE/pOuUfrWkJV5shSiIr5
	qBbgoYv1rWOghpmKODnNJVi/YBHC1shjtOWek1q9RaEv1hgHuedH7RkMQ==
X-ME-Sender: <xms:42uuZEfQL5-w1EIAvTuR1sxYt1hi8SoVmInhZpUMtiPJsD52SnaX_Q>
    <xme:42uuZGOU5ZdNFf1KLSTfropbP6r9LODRzgj2rh5p-WDg6LVRb8IJfte6gg7hSViRR
    wdA9xIyJ5UqBcY>
X-ME-Received: <xmr:42uuZFh4tYwZIJYNF88KxmvcrnO4W8PjdXBSCF8fLPTWcDp5L2GpiZrxTjrhUdKQHCUpagLXmu6EKUk_rwY8EaY2LAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:42uuZJ-5ZnmhZ9xSUaSbuROXP4KbNBPEsAijKk3W5oI63mw8SFp29g>
    <xmx:42uuZAunWTgPsjjligJ-dJtDR08ccYrXbGQkYCJqLkyZ-Akw8ih4qQ>
    <xmx:42uuZAGeSpPidbKxM9gn8HT3CAvQIAplm9cOQKJ77SwP2ZbC4Hsu8A>
    <xmx:5GuuZMJijq_Kc0gBEmy2581CX30_LX2cHXsVKy5fI6ENkBNtilWhsg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 05:01:23 -0400 (EDT)
Date: Wed, 12 Jul 2023 12:01:19 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net-next 5/5] ionic: add FLR recovery support
Message-ID: <ZK5r307SRIBUfpgF@shredder>
References: <20230712002025.24444-1-shannon.nelson@amd.com>
 <20230712002025.24444-6-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712002025.24444-6-shannon.nelson@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 05:20:25PM -0700, Shannon Nelson wrote:
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index b141a29177df..8679d463e98a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -320,6 +320,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (err)
>  		goto err_out;
>  
> +	pci_save_state(pdev);

Can you please explain why this is needed? See more below.

> +
>  	/* Allocate and init the LIF */
>  	err = ionic_lif_size(ionic);
>  	if (err) {
> @@ -408,12 +410,68 @@ static void ionic_remove(struct pci_dev *pdev)
>  	ionic_devlink_free(ionic);
>  }
>  
> +static void ionic_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct ionic *ionic = pci_get_drvdata(pdev);
> +	struct ionic_lif *lif = ionic->lif;
> +
> +	dev_dbg(ionic->dev, "%s: device stopping\n", __func__);

Nit: You can use pci_dbg(pdev, ...);

> +
> +	del_timer_sync(&ionic->watchdog_timer);
> +	cancel_work_sync(&lif->deferred.work);
> +
> +	mutex_lock(&lif->queue_lock);
> +	ionic_stop_queues_reconfig(lif);
> +	ionic_txrx_free(lif);
> +	ionic_lif_deinit(lif);
> +	ionic_qcqs_free(lif);
> +	mutex_unlock(&lif->queue_lock);
> +
> +	ionic_dev_teardown(ionic);
> +	ionic_clear_pci(ionic);
> +	ionic_debugfs_del_dev(ionic);
> +}
> +
> +static void ionic_reset_done(struct pci_dev *pdev)
> +{
> +	struct ionic *ionic = pci_get_drvdata(pdev);
> +	struct ionic_lif *lif = ionic->lif;
> +	int err;
> +
> +	err = ionic_setup_one(ionic);
> +	if (err)
> +		goto err_out;
> +
> +	pci_restore_state(pdev);
> +	pci_save_state(pdev);

It's not clear to me why this is needed. Before issuing the reset, PCI
core calls pci_dev_save_and_disable() which saves the configuration
space of the device. After the reset, but before invoking the
reset_done() handler, PCI core restores the configuration space of the
device by calling pci_restore_state(). IOW, these calls seem to be
redundant.

I'm asking because I have patches that implement these handlers as well,
but I'm not calling pci_save_state() / pci_restore_state() in this flow
and it seems to work fine.

> +
> +	ionic_debugfs_add_sizes(ionic);
> +	ionic_debugfs_add_lif(ionic->lif);
> +
> +	err = ionic_restart_lif(lif);
> +	if (err)
> +		goto err_out;
> +
> +	mod_timer(&ionic->watchdog_timer, jiffies + 1);
> +
> +err_out:
> +	dev_dbg(ionic->dev, "%s: device recovery %s\n",
> +		__func__, err ? "failed" : "done");
> +}
> +
> +static const struct pci_error_handlers ionic_err_handler = {
> +	/* FLR handling */
> +	.reset_prepare      = ionic_reset_prepare,
> +	.reset_done         = ionic_reset_done,
> +};

