Return-Path: <netdev+bounces-271193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ+mJg3HwmmIlgQAu9opvQ
	(envelope-from <netdev+bounces-271193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:17:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD4319E12
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A41330053BE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEAE3CFF6C;
	Tue, 24 Mar 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="JBlhowD/"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF73D34BE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372155; cv=none; b=lmFnkzDQC5dJ5GNKLnK3jWxeuq6NEr30QNYMwCiNLXFAvGmfWan3MGiKRsb31JT5KUg3oLZTwalfFVIhlTzw57frS9qnV0A7X1U+mWJm+Xzsu22e+zAIyr8PPGIUaZDir2PSVS7cWFne5eDuI/YFxyY1UAza7o6lHjkp30Hyuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372155; c=relaxed/simple;
	bh=jQjmfK7wVzXZt3XDwE4POrg9WFrVR0rn1KcplLuWa0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7zGCp/Mlmv8CNQ2ZhdG1qwiI1bM2RCOUsPhoUuL5EHXHjPRXvu9GnaUc4pmoX8a78W0vz6k8an98P/dtZIbX8Kks/xVS9J1t8A6XUQ/k+GMZpu0IQ4HuAD9U67esjfCC0KK4mS79whcmxX1kLf3gLzrzv2tNE9DJiLChFAmBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=JBlhowD/; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (39.25.31.150.dy.iij4u.or.jp [150.31.25.39])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62OH8Sa1000982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Mar 2026 02:08:29 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=jyHsLzXWaR2zRPbZGuPTHNB97BRLzepDzCHvvesUcbY=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774372110; v=1;
        b=JBlhowD/CR2vejrT+7U7Cxl5IYnPvFmZUiK3tbHfRagOgB7FoVa9MJ1xWBUGSHSd
         XTmWEs4NUzP3MSUn6swQFFM/wTR2uEXrAWQ4T8iMTELmZHefn6IBOGcOpz4lN1fu
         kPHcrgUMksSyFYHPatAhihvA1svL11+70oA+Q0M4ug8s73eq/zSlofVTBpryBTU2
         zLNmzNOW3yUp7Mowq1Yp/GACjryfTfwGEW0FTrgyREkCdInBpNQHieprh18+E95q
         P6u2VY9EQVIaJR4eIUlQLMgOL032xdm/2iFg4fDean0qnDnkwE5NIoieYHPhf06x
         R3lKQMhBZL3lgf7Uu5uEew==
Date: Wed, 25 Mar 2026 02:08:28 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: migrate to netdev
 ops lock
Message-ID: <acLExfyijq7HCEc4@x1>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
 <20260318163505.31765-4-aleksander.lobakin@intel.com>
 <abripOPt4oVu-Ksb@x1>
 <abrzq5_S7p-YjqhE@x1>
 <1ec79e7b-50e8-4c64-9e79-fc377a505cfa@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ec79e7b-50e8-4c64-9e79-fc377a505cfa@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271193-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:dkim,enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14AD4319E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/24 17:56, Alexander Lobakin wrote:
> From: Kohei Enju <kohei@enjuk.jp>
> Date: Thu, 19 Mar 2026 03:56:19 +0900
> 
> > On 03/19 02:55, Kohei Enju wrote:
> >> On 03/18 17:35, Alexander Lobakin wrote:
> >>> Queue management ops unconditionally enable netdev locking. The same
> >>> lock is taken by default by several NAPI configuration functions,
> >>> such as napi_enable() and netif_napi_set_irq().
> >>> Request ops locking in advance and make sure we use the _locked
> >>> counterparts of those functions to avoid deadlocks, taking the lock
> >>> manually where needed (suspend/resume, queue rebuild and resets).
> >>
> >> Hi Alexander,
> 
> 
> Uff, sorry, I didn't notice this thread for some reason. Maybe it landed
> into the IWL folder in my mail client and I haven't checked it for some
> time... But I read LKML online on a daily basis and missed this reports =\

NP, thanks for taking a look!

Regards,
Kohei

> 
> >> After applying this patch (3/5) along with the preceding ones on top of
> >> net-next, I got some WARNING splats when changing the admin state
> >> (up/down) using the ip link command. [1, 2]
> >>
> >> Since I haven't looked into this series in detail, I'm reporting the
> >> splats anyway. 
> >> I'm wondering why I haven't seen anyone report this type of issue up to
> >> v3. Maybe there is something wrong with my setup or devices?
> >>
> >> Device: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)
> > 
> > Ah, I think I figured out the reason. My adapter accidentally fell into
> > safe mode. When the adapter is in the safe mode, netdev->queue_mgmt_ops
> > == NULL and netdev->request_ops_lock == false, so
> > netdev_assert_locked_or_invisible() complains about not holding the
> > netdev lock.
> > 
> > Setting netdev->request_ops_lock = true in the safe mode path also
> > worked fine for me.
> > 
> > ---
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 9ef258d5ab48..3477c53316ba 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3519,6 +3519,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> > 
> >         if (ice_is_safe_mode(pf)) {
> >                 netdev->netdev_ops = &ice_netdev_safe_mode_ops;
> > +               netdev->request_ops_lock = true;
> 
> This fix looks good to me, thanks!
> 
> >                 ice_set_ethtool_safe_mode_ops(netdev);
> >                 return;
> >         }
> 
> Tony, could you please pick it up to patch 3/5 when sending a new PR?
> 
> Thanks,
> Olek

