Return-Path: <netdev+bounces-307733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kCveDmJsV2oTNwEAu9opvQ
	(envelope-from <netdev+bounces-307733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:17:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD55475D7C6
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:17:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mpgEH5sG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307733-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91C0D300C82F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEE432E88;
	Wed, 15 Jul 2026 11:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA403164C5;
	Wed, 15 Jul 2026 11:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114269; cv=none; b=Hr5eT/NN3UYEPgoqD+1c5j7Kx/yQqGoM+VCrKkx92y7HtBCFD1zCl3UfHZDaWSZhDpFcOTZP0DuzXU+cZkkWzU2xCp18Km+XMmbGWf7KOiOzd73j+KfBIiabDKwC+T6jaqzNR12HpuwTPge5ALiR2ARlHQKDzcsVIu4ZZU9s5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114269; c=relaxed/simple;
	bh=qdILD0hMve2KBA9z8uUIgWV8oYkeufuvixn5/C44Md8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9TFlQLQL22mecKTdBm3VGyHxG2ICuseyBaU4/wRVE8ddLWipHKAlB58wOGX69eoptxoyn/CeDx2qM1sAevu22wuOW7wwfAA/ZRLBt9Fjo0GzgsUwySLqu/2N6NOSczHZINDjqM2aQCrIm+WKDzyXvvoZamgKt/J6B2EoLYWbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpgEH5sG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24991F000E9;
	Wed, 15 Jul 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114268;
	bh=UndDXj4FedSP9S2VvSFbatjI+UduVq6Wjqy78tw4wNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpgEH5sGSiasUkPNcmKniLxhu8l8k2RpCCWTdAXx5soZSsxzEJNS5WGVf3iSBwAe6
	 aGTi1Pxa7fULTTxTlRkWYw43XRAsU8pZTmKpxFbBbvyD3MoZDATBsfMnuQvLThmGgL
	 6BDrXEk5fEfDcwQq69aTg0C8aDcFpDoKKNnEn2eTphMB+JcB4OjXcF9nX1lQbPIML/
	 JSvJSFEh6XQvz7/QpnqifKP9nam+QwcqMuqJWmW824bFXCw4tCB+LDgTy+Bb/sJeO1
	 fVJXaoWF/OchY1jlt7ydHiMlUQ+4PrmvO2/pOlLIdLGlm0Lzf2l8rMWjvbR9RtiRWP
	 nwEgQvkgSy0Pg==
From: Simon Horman <horms@kernel.org>
To: maimon.sagi@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/1] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Wed, 15 Jul 2026 12:15:50 +0100
Message-ID: <20260715111559.1920391-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708065616.16814-1-maimon.sagi@gmail.com>
References: <20260708065616.16814-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maimon.sagi@gmail.com,m:horms@kernel.org,m:jonathan.lemon@gmail.com,m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:maimonsagi@gmail.com,m:jonathanlemon@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307733-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD55475D7C6

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ptp: ocp: add CPLD ISP support for ADVA TimeCard X1

This commit adds sysfs interfaces on the ADVA TimeCard X1 (PCI 0x0410) to
program a Lattice MachXO3 CPLD over a shared I2C bus.  It exposes an
i2c_bus_ctrl attribute for arbitrating the bus against the on-board
MicroBlaze, and a cpld_i2c_xfer binary attribute that acts as an I2C
passthrough restricted to slave addresses 0x40 and 0x74.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78..8df9feb030aa 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -416,6 +417,11 @@ struct ptp_ocp {
>  	dpll_tracker tracker;
>  	int signals_nr;
>  	int freq_in_nr;
> +	/* cpld_i2c_xfer sysfs (adva_x1) */
> +	struct mutex		tap_i2c_lock;
> +	int			tap_i2c_adap_nr; /* adapter nr; -1 if absent */
> +	u8			tap_i2c_rsp[21]; /* [status, read_data...] */
> +	size_t			tap_i2c_rsp_len;
>  };

[ ... ]

> @@ -3188,6 +3194,12 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  	ptp_ocp_nmea_out_init(bp);
>  	ptp_ocp_signal_init(bp);
>  
> +	/* tap_i2c is x1-only; the base adva variant has no CPLD I2C path. */
> +	if (info->attr_groups == adva_timecard_x1_groups) {
> +		mutex_init(&bp->tap_i2c_lock);
> +		bp->tap_i2c_adap_nr = -1;
> +	}
> +

[Critical]
Could this initialization order leave cpld_i2c_xfer non-functional in the
common configuration where xiic-i2c is already loaded when ptp_ocp probes?

The adva_x1 resource table places OCP_I2C_RESOURCE(i2c_ctrl) before the
ptp_ocp_adva_board_init entry, and ptp_ocp_register_resources iterates the
table sequentially.  If xiic-i2c is built-in or preloaded,
platform_device_register_resndata() inside ptp_ocp_register_i2c() will run
the xiic-i2c probe synchronously:

  ptp_ocp_register_i2c()
    platform_device_register_resndata()
      xiic-i2c probe -> i2c_add_adapter() -> device_add()
        BUS_NOTIFY_ADD_DEVICE -> ptp_ocp_i2c_notifier_call()
          WRITE_ONCE(bp->tap_i2c_adap_nr, ...->nr);

Control then returns to ptp_ocp_register_resources() which invokes
ptp_ocp_adva_board_init(), and the x1 branch above overwrites the just
cached number with -1.

No further BUS_NOTIFY_ADD_DEVICE fires for the same adapter, so
tap_i2c_adap_nr stays -1 for the device lifetime and every cpld_i2c_xfer
write() falls through i2c_get_adapter(-1) returning NULL and reports
-ENODEV.

Should tap_i2c_adap_nr be initialised earlier (before resource
registration) so the notifier's write is not clobbered?

>  	err = ptp_ocp_attr_group_add(bp, info->attr_groups);
>  	if (err)
>  		return err;

[ ... ]

> @@ -4224,6 +4236,210 @@ static const struct ocp_attr_group art_timecard_groups[] = {

[ ... ]

> +static ssize_t
> +ptp_ocp_cpld_i2c_write(struct file *file, struct kobject *kobj,
> +		       const struct bin_attribute *attr,
> +		       char *buf, loff_t off, size_t count)
> +{

[ ... ]

> +	if (read_len > 0) {
> +		u16 rd_flags = I2C_M_RD;
> +
> +		if (flags & TAP_I2C_FLAG_NOSTART)
> +			rd_flags |= I2C_M_NOSTART;
> +		msgs[nmsgs].addr  = addr;
> +		msgs[nmsgs].flags = rd_flags;
> +		msgs[nmsgs].len   = read_len;
> +		/* Allocate a DMA-safe bounce buffer if needed; see
> +		 * Documentation/i2c/dma-considerations.rst.
> +		 */
> +		rdbuf = i2c_get_dma_safe_msg_buf(&msgs[nmsgs], 1);
> +		if (!rdbuf) {
> +			i2c_put_adapter(adap);
> +			return -ENOMEM;
> +		}
> +		msgs[nmsgs].buf = rdbuf;
> +		nmsgs++;
> +	}

[High]
Can this leak the bounce buffer returned by i2c_get_dma_safe_msg_buf()?

Because I2C_M_DMA_SAFE is never set on this msg, i2c_get_dma_safe_msg_buf()
always returns a fresh kzalloc'd buffer.  The code then aliases msg->buf
to that buffer:

    rdbuf = i2c_get_dma_safe_msg_buf(&msgs[nmsgs], 1);
    ...
    msgs[nmsgs].buf = rdbuf;

Later i2c_put_dma_safe_msg_buf(rdbuf, ..., ret > 0) is called, but that
helper begins with:

    void i2c_put_dma_safe_msg_buf(u8 *buf, struct i2c_msg *msg, bool xferred)
    {
        if (!buf || buf == msg->buf)
            return;
        ...
        kfree(buf);
    }

Since buf == msg->buf here, it returns without kfree().

In-tree callers (for example i2c-at91-master.c, mxs_i2c_xfer_msg,
mtk_i2c_do_transfer) keep msg->buf pointing at the caller's original
buffer and hold the bounce pointer in a separate driver variable so
buf != msg->buf at release time.

Would using a separate driver-owned pointer for the bounce buffer, or
setting msgs[nmsgs].flags |= I2C_M_DMA_SAFE and freeing with plain
kfree(), avoid the leak?

> +
> +	/* Serialise transfer+publish so concurrent writers cannot overwrite
> +	 * each other's response in tap_i2c_rsp.
> +	 */
> +	mutex_lock(&bp->tap_i2c_lock);

[ ... ]

> @@ -4902,6 +5125,8 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);
> +	if (bp->tap_i2c_adap_nr != 0)	/* initialised only on adva_x1 */
> +		mutex_destroy(&bp->tap_i2c_lock);
>  	device_unregister(&bp->dev);
>  }

[High]
Is this sentinel test reliable for deciding whether the mutex was
initialised?

mutex_init(&bp->tap_i2c_lock) only runs on adva_x1 in
ptp_ocp_adva_board_init(), but ptp_ocp_i2c_notifier_call() has no variant
filter — it walks up dev->parent looking for any driver named
KBUILD_MODNAME, matching fb, art and base adva just the same:

  found:
      bp = dev_get_drvdata(dev);
      if (add) {
          ...
          WRITE_ONCE(bp->tap_i2c_adap_nr, i2c_verify_adapter(child)->nr);
      } else {
          WRITE_ONCE(bp->tap_i2c_adap_nr, -1);
          ...
      }

Every non-x1 board that has an OCP_I2C_RESOURCE will end up with
tap_i2c_adap_nr set to -1 (or any adapter number != 0) by the notifier,
so mutex_destroy(&bp->tap_i2c_lock) is then invoked on a never-initialised
mutex.  With CONFIG_DEBUG_MUTEXES=y this runs DEBUG_LOCKS_WARN_ON() over
uninitialised memory, and under PREEMPT_RT mutex_destroy becomes a real
function that reads rt_mutex fields.

There is also the reverse case: adapter nr 0 is a legitimate I2C bus
number, so a genuine adva_x1 whose adapter happens to be 0 would skip
mutex_destroy even though the mutex was initialised.

Would a dedicated boolean flag set alongside mutex_init(), or gating on
info->attr_groups == adva_timecard_x1_groups explicitly, be a safer
condition?

> @@ -5217,11 +5442,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>  
>  found:
>  	bp = dev_get_drvdata(dev);
> -	if (add)
> +	if (add) {
>  		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		/* Cache adapter number; cpld_i2c_xfer uses i2c_get_adapter()
> +		 * for a reference-counted, unbind-safe lookup.
> +		 */
> +		WRITE_ONCE(bp->tap_i2c_adap_nr, i2c_verify_adapter(child)->nr);
> +	} else {
> +		WRITE_ONCE(bp->tap_i2c_adap_nr, -1);	/* invalidate before free */
>  		sysfs_remove_link(&bp->dev.kobj, "i2c");
> -
> +	}
>  	return 0;
>  }

