Return-Path: <netdev+bounces-295011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yak3BUraIGr88QAAu9opvQ
	(envelope-from <netdev+bounces-295011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:52:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F0363C4A9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G1FmiHCy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295011-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EB303007886
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C42253A1;
	Thu,  4 Jun 2026 01:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03B22083;
	Thu,  4 Jun 2026 01:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537891; cv=none; b=bbbJL2SLEnGdpb2+vGD9BcTuxm+j8pYv71o3NsC17TPa2iFYq9BsCLpdUFFMkLKT2fki/o8IPLsmeePv17GjUClAna8Iy/agQbqnVu4ioFXJv+oO+XEHI1gAPP+ZP9Ds4WSibIXIcwaTcfAZ800B7Y8TtHWqQLE/kWkehGs5S/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537891; c=relaxed/simple;
	bh=X04wkXjI1792o9HLl6uqad3TgnsKV7dOPvS32OIAAj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvCFlXF/c22/rMd6+BP1eKzzxQvcc33nIvm2MEQc251OS1bQ+7AHCf5YHWvWP6E+aSRTquXfkY5gvvbtYql816g6TG8QoKCavRL2PVh2WisTa8I2Pya5XitNwQ0oFdRAhuBSmUtWHeZtkjP36uGrjs3Dfz1HRer7VbZhhdo8oOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1FmiHCy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A211F00893;
	Thu,  4 Jun 2026 01:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537889;
	bh=WHkQoA4Iqk3ogNHbQenV4MbytQgjYsDKnNmK7qXa4PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G1FmiHCyXYijodHT2OohSuOVHVInhVaoMGnk86knh3o6vAEkntcc+6RZOenTDDQUM
	 rb87+WXtyzQcAr1WuBHjOOaNpcBzQdNwVwM1X6pPsJwq0BJKoaiHYUOaFNJnmBAadJ
	 nSgsdqpOeCzx0/uSWJHecfWfggNhBLN/REEpm0ZeYPxvBm2av6jn4Qlr3OJOTQyyvF
	 3kCmh2/rTjk6rdOZWaZvCkYsEgyXtta/xZDSIo8lEydC2cS/QD8ienhEhFGrYD/vB5
	 0OQsyv+WxQCZtv0BUH5dC1O0l5PCGtOcQPUYC4IB+tu3+NMGkBg43QdTuZJkCKtMj7
	 UKRoxBo2TMGCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	poros@redhat.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	jiri@resnulli.us,
	mschmidt@redhat.com,
	pabeni@redhat.com,
	pvaanane@redhat.com,
	Prathosh.Satish@microchip.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/4] dpll: zl3073x: add per-DPLL serialization lock
Date: Wed,  3 Jun 2026 18:51:27 -0700
Message-ID: <20260604015127.2872457-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531194423.383366-4-ivecera@redhat.com>
References: <20260531194423.383366-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,microchip.com,linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F0363C4A9

This is an AI-generated review of your patch. The human sending this
email says "While we wait for more acks - claude says.."
---
dpll: zl3073x: add per-DPLL serialization lock

This patch adds a per-DPLL mutex serializing netlink callbacks and the
periodic worker, moves zl3073x_chan_state_update() under the new lock,
defers change notifications outside the lock to avoid ABBA with
dpll_lock, and converts pin->freq_offset from atomic64_t to plain s64.

> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 0b2050aa2ed9..27c71807e4ef 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -567,19 +567,7 @@ zl3073x_dev_ref_states_update(struct zl3073x_dev *zldev)
>  	}
>  }
>  
> -static void
> -zl3073x_dev_chan_states_update(struct zl3073x_dev *zldev)
> -{
> -	int i, rc;
>  
> -	for (i = 0; i < zldev->info->num_channels; i++) {
> -		rc = zl3073x_chan_state_update(zldev, i);
> -		if (rc)
> -			dev_warn(zldev->dev,
> -				 "Failed to get DPLL%u state: %pe\n", i,
> -				 ERR_PTR(rc));
> -	}
> -}

[ ... ]

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 5e58ded5734d..4bee3d0c4659 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c

[ ... ]

> @@ -1817,27 +1906,37 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
>  void
>  zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>  {
> +	DECLARE_BITMAP(changed_pins, ZL3073X_NUM_INPUT_PINS);
>  	struct zl3073x_dev *zldev = zldpll->dev;
>  	enum dpll_lock_status lock_status;
>  	struct device *dev = zldev->dev;
>  	struct zl3073x_dpll_pin *pin;
> +	bool dev_changed = false;
>  	int rc;
>  
> +	bitmap_zero(changed_pins, ZL3073X_NUM_INPUT_PINS);
> +
> +	mutex_lock(&zldpll->lock);
> +
>  	zldpll->check_count++;
>  
> -	/* Get current lock status for the DPLL */
> -	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
> -					  &lock_status, NULL, NULL);
> +	rc = zl3073x_chan_state_update(zldev, zldpll->id);
> +	if (rc) {
> +		dev_err(dev, "Failed to get DPLL%u state: %pe\n",
> +			zldpll->id, ERR_PTR(rc));
> +		goto unlock;
> +	}

[Low]
The previous code path, zl3073x_dev_chan_states_update() in core.c, used
dev_warn() and continued the periodic update for the device, allowing the
subsequent lock-status, phase-offset and per-pin checks to run for every
DPLL even when an individual chan_state_update() failed.

After this change, a single failure of zl3073x_chan_state_update() inside
zl3073x_dpll_changes_check() is logged at dev_err and triggers
goto unlock, skipping all remaining work for that DPLL in that cycle:

	rc = zl3073x_chan_state_update(zldev, zldpll->id);
	if (rc) {
		dev_err(dev, "Failed to get DPLL%u state: %pe\n",
			zldpll->id, ERR_PTR(rc));
		goto unlock;
	}

The commit message describes the move only as a serialization change so
that it "runs under zldpll->lock". Should the log-level promotion from warn
to err and the new short-circuit of the rest of the cycle on transient
register-read failures be mentioned in the commit message, or alternatively
preserved as warn-and-continue?

> +
> +	rc = __zl3073x_dpll_lock_status_get(zldpll, &lock_status);
>  	if (rc) {
>  		dev_err(dev, "Failed to get DPLL%u lock status: %pe\n",
>  			zldpll->id, ERR_PTR(rc));
> -		return;
> +		goto unlock;
>  	}

[ ... ]

>  }

The commit message states:

    All DPLL pin and device callbacks that access mutable state take the
    lock as the first operation.

[Low]
Does this hold for zl3073x_dpll_freq_monitor_get() and
zl3073x_dpll_freq_monitor_set()? Both are device callbacks that read or
write zldpll->dev->freq_monitor, but neither takes zldpll->lock:

	static int
	zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll, ...)
	{
		struct zl3073x_dpll *zldpll = dpll_priv;

		if (zldpll->dev->freq_monitor)
			*state = DPLL_FEATURE_STATE_ENABLE;
		else
			*state = DPLL_FEATURE_STATE_DISABLE;

		return 0;
	}

	static int
	zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll, ...)
	{
		struct zl3073x_dpll *item, *zldpll = dpll_priv;

		zldpll->dev->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
		...
	}

The same field is read in zl3073x_dpll_pin_measured_freq_check() under
lockdep_assert_held(&zldpll->lock):

	static bool
	zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
	{
		...
		lockdep_assert_held(&zldpll->lock);

		if (!zldpll->dev->freq_monitor)
			return false;
		...
	}

freq_monitor is a per-device bool shared by all channels, so the per-DPLL
lock would not provide cross-DPLL serialization for it anyway. Should the
commit message carve out an exception for this per-device field, or should
some appropriate lock be taken in the freq_monitor get/set callbacks to
match the stated invariant?

