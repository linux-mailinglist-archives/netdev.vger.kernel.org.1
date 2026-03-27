Return-Path: <netdev+bounces-272584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMPmGu6OxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:06:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD229345BF8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F4C030EE4AB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A03EFD00;
	Fri, 27 Mar 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaNUDrBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971813ED13E;
	Fri, 27 Mar 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619944; cv=none; b=ei+ZexzAfN+v7KJCFpc1TAz788uhUvmsANlVqa0gyQPPeqNNtHah/aT46JE30BCqkn+XaREwDyBJiDJDxJe4E8pjXe+xyqdxVYE5WjgsBprXmd46a83Ld9n6o2u3o+f6eoZWQkKgbu/En2HagpiAQtgN5Ct0kTbxWS59T0t5NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619944; c=relaxed/simple;
	bh=RxwxYCW56PNiCQCHThhCbANEJOjI+CRqaSU3dcjzd+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1ghKhsukogxF8qUCCe9SDJTyJmfaTKCzR8pkVmmZDKePD/3YBU4abDrmW+5OQNhnnPltT/FP0mdnTfucuDLqeuAG7ZWUtMRY4VtD2YnhdZ4jTeU+9appNJidVoKynqKANo08cGp9QKUYiwrQWOpGX6HbJboBZKlk8JZXCzVCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaNUDrBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9FCC2BC87;
	Fri, 27 Mar 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774619944;
	bh=RxwxYCW56PNiCQCHThhCbANEJOjI+CRqaSU3dcjzd+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SaNUDrBR/CivKiWnUyg4LQb3RDVGBbPowDqYDRYgLYXsGvbw43RTT//1hPZpDqEJa
	 zjGVUtzi76Ax6BCaqFo2wNRygHQABehUmInPLa8QCWWwmNpg1h0OIj4aLZwmfVAB9p
	 bAtBUIeA758fbZhZemYWYHQI6poxiAygUM2cwmH8gLklRju329G2FPlO9nUwltuW/6
	 B8Vunnuumu3hgMbh8CHID4UNVSYJ1bXtnfWg+Aceh3MP78mJ16U8ochX1/QHDoU+x8
	 8VEyPFdDuNeQgx7G5Xg2/l13V6Ptq1gv/5L+ucvgRK0SzVmuE5m9WEfrvU3D/sXciy
	 mgVTiYn9YcqMQ==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	daniel@iogearbox.net,
	davem@davemloft.net,
	aleksander.lobakin@intel.com,
	kohei@enjuk.jp,
	pabeni@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	aleksandr.loktionov@intel.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 3/5] ice: migrate to netdev ops lock
Date: Fri, 27 Mar 2026 13:57:09 +0000
Message-ID: <20260327135707.590630-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325200644.2528726-4-anthony.l.nguyen@intel.com>
References: <20260325200644.2528726-4-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,fomichev.me,iogearbox.net,davemloft.net,enjuk.jp,redhat.com,lunn.ch,vger.kernel.org,google.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-272584-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: DD229345BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: migrate to netdev ops lock

Queue management ops unconditionally enable netdev locking. The same
lock is taken by default by several NAPI configuration functions, such
as napi_enable() and netif_napi_set_irq().  Request ops locking in
advance and make sure we use the _locked counterparts of those functions
to avoid deadlocks, taking the lock manually where needed (suspend/resume,
queue rebuild and resets).

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index bd77f1c001ee..2ca3fc6e8abd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c

[ ... ]

> @@ -273,14 +273,13 @@ void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi)
>  /**
>   * ice_dcb_ena_dis_vsi - disable certain VSIs for DCB config/reconfig
>   * @pf: pointer to the PF instance
>   * @ena: true to enable VSIs, false to disable
> - * @locked: true if caller holds RTNL lock, false otherwise
>   *
>   * Before a new DCB configuration can be applied, VSIs of type PF, SWITCHDEV
>   * and CHNL need to be brought down. Following completion of DCB configuration
>   * the VSIs that were downed need to be brought up again. This helper function
>   * does both.
>   */
> -static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
> +static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena)
>  {
>  	int i;
>
> @@ -294,9 +293,9 @@ static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
>  		case ICE_VSI_CHNL:
>  		case ICE_VSI_PF:
>  			if (ena)
> -				ice_ena_vsi(vsi, locked);
> +				ice_ena_vsi(vsi);
>  			else
> -				ice_dis_vsi(vsi, locked);
> +				ice_dis_vsi(vsi);
>  			break;
>  		default:
>  			continue;

[Simon says: this seems to be a false positive and what the AI
 suggests seems to be the exact opposite of what is correct]

The DCB callers all hold the RTNL lock rather than the netdev lock. While
ice_ena_vsi() and ice_dis_vsi() now take the netdev lock internally, their
_locked counterparts (ice_ena_vsi_locked and ice_dis_vsi_locked) would be
more appropriate here since the netdev lock is not held by ice_pf_dcb_cfg()
or ice_dcb_process_lldp_set_mib_change().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e7308e381e2f..82f6523bc726 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -7263,7 +7271,7 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
>  		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
>
>  		if (q_vector->rx.rx_ring || q_vector->tx.tx_ring)
> -			napi_disable(&q_vector->napi);
> +			napi_disable_locked(&q_vector->napi);
>
>  		cancel_work_sync(&q_vector->tx.dim.work);
>  		cancel_work_sync(&q_vector->rx.dim.work);

[Simon says: this one seems plausible to me. Could you take a look?]

Does this introduce a lockdep warning in the eswitch/switchdev path?

ice_napi_disable_all() is called via ice_down(), and ice_down() can be
reached through the eswitch path without holding the netdev lock:

ice_eswitch_attach()
  -> ice_eswitch_enable_switchdev()
    -> ice_eswitch_setup_env()
      -> ice_down(uplink_vsi)
        -> ice_napi_disable_all()
          -> napi_disable_locked()

At this point napi_disable_locked() will assert that the netdev lock is
held, but the eswitch code path doesn't take it. The uplink_vsi is the
main PF VSI with a valid netdev, so the early return won't trigger.

Should ice_eswitch_setup_env() take the netdev lock before calling
ice_down(), or should ice_down() have both locked and unlocked variants?

