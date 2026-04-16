Return-Path: <netdev+bounces-279023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HPCMAjM4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2860D40D9E6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5934D3028835
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE931E830;
	Thu, 16 Apr 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="dj13IMnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FA224B15
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339971; cv=none; b=KET6/QPmsWwhjAEY9ji2I8tU5iNDoRCHe1adcgUv5bpG0wEUUXjO1CXwmi9sUYaPU1kACWdTN3Vol9jFBK0ILMmU769r/oUD5WZIX+1dqq7AbJhJrk6DSnwNfEYfp7jfUwo8+9/BfAVe3CmKfOW89E0QPtXHjJEkDEOTvXGyQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339971; c=relaxed/simple;
	bh=WSiOZ0jW1UG425zcaT3gYGZt4PzBolyeWV4f36d3j/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhh8A3IiCqmPNrKvTcg77McWT+zPYDW0LEtfx0iGh0g0vWQR+UrWM8a35rlb3VmzW10o/JpmPqdgXCsOP05mQL1gofRWW0Ac58yGSGXBB2af44N6fpeqkJwSxvj/m2xgq6szZGSq1HV2ehU/Yol+SB0Trz7O6ns76lx72oAt60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dj13IMnX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso5352455e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776339968; x=1776944768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtLBep4veGMaf+LZNsilLGz5p0/XIc0cvD6mQ+AZGPM=;
        b=dj13IMnXFu1EvyPc6H2R1YOakn8JK5SFGFWlKajyiDKhLpw3KeUW6kJdkdx6oGZC51
         qcRpUDmzq52qp7hPNDwHoSMESVsJHNgBLx+JRLoJ+D1EJGOpA0hC0ul9KmCRi7HlH295
         miZBZbJ7virbWoSSlOxMOaC8lMBJFTOe/bxSvsm6K4ZgReMew7YTaWYG0+3s8XEiZYlS
         OYoNtatWd7ZD5NNEGWQ2FRfcciWe55xy6/UCzXXV7RQea1pScqYirs8KGIMNr/OiHi0P
         DYMMEiO0qxdo200danmNAPs34dcsNmNDInzQ9rMIXz1W6swasCUHNJzZmpTEFxj+aqcf
         Ngtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339968; x=1776944768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtLBep4veGMaf+LZNsilLGz5p0/XIc0cvD6mQ+AZGPM=;
        b=LY1JOYvDGHd+su81QufMJz1E9m14mcKss0sFpMyxvf+cRO+ICmZmm1ZFHfVX+Dr0U9
         5t2PNnK8/3SIiwOysOB9WQdM6sTIAxsFtoeidoXDxc92v+uq77L96OFCZ70Uxv4DWFQk
         oOqeRahbJQGLJ77UA/7PGztUHFw6yAX6FUp/U5LFgRL6UlWfi9DtppQYyC6FD0DD2AeV
         JSY8LUl6std76hmhF1Jsj9EPhdm+P7hOry2ztKNB0hm913JI+lDImbKocLGxZcKV8Ncp
         fZDxQ8txG09jNAo7YEMfbddsNLuBgNtrvzxhgHbRQP6lK46S6YdJo9h9twjT2d4w9pYB
         8nqA==
X-Gm-Message-State: AOJu0YwRDBQ6QdRpOxsnRY64OhuVdWKwBdzfW/jJ+AHqA/rhgzXFO9+j
	6q1akCwMQdEm92LNPYP9p8pGzTQxZu3HCDU+OGP78k7VKvAG+F4l7SN4g3LDNC33Lkg=
X-Gm-Gg: AeBDietuu4BwvRZji2M3/j7nV6dz0DNNQS8zCHiHmLnSj5xUm7hy/SaDEG2Wo00EBfm
	5z/8SS1ZYfxW1gih3yDsfzrbNClntl1+fDI59qoIHRda3FaHC2rCm22MX8rRYYfU8U9Xhhut/0Q
	EuJk3qesaXxykdw6roWI71cUUUAifa7PQp4UdHxQI9qXv4hYb92wj9+5TU3G2aLnvp9bKfi2S20
	sSdzD8w9XmdbtduRJhaGwpuOaiJCUnWOy59oY15rELC/7wnEaA8fEh1Ctni2xJkF9utYt8NtIUn
	UtJc4gOCCDMomfjotoHq+SWxdM1SUusRVQNx2XIhIuOazQrsE6DlyBUxaQzMY3KnCc676VCYt3T
	qgTM5MSPbIiknVc89mOnA7kVmrpPqx6SRyjoP87T1i2a6lRE5FZ3Ij/Ls73MxaFFdLiuSYVpM9k
	7LD5xYZzKDfC006r50iqEMyYLPBFbKfxRNzA==
X-Received: by 2002:a05:6000:2384:b0:43d:779e:afa8 with SMTP id ffacd0b85a97d-43fdbb4c547mr2401612f8f.16.1776339967967;
        Thu, 16 Apr 2026 04:46:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead2decafsm11733648f8f.0.2026.04.16.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:46:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:46:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
	Rinitha S <sx.rinitha@intel.com>, Michal Schmidt <mschmidt@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v6 2/2] ice: fix missing dpll notifications for SW
 pins
Message-ID: <ac7iry5ffmiecu2oefmcxgso2mkgbfcdpfeefz4564ecg4ikhl@2zerhrznznvk>
References: <20260416113952.389405-1-poros@redhat.com>
 <20260416113952.389405-3-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416113952.389405-3-poros@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279023-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2860D40D9E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 16, 2026 at 01:39:52PM +0200, poros@redhat.com wrote:
>The SMA/U.FL pin redesign (commit 2dd5d03c77e2 ("ice: redesign dpll
>sma/u.fl pins control")) introduced software-controlled pins that wrap
>backing CGU input/output pins, but never updated the notification and
>data paths to propagate pin events to these SW wrappers.
>
>The periodic work sends dpll_pin_change_ntf() only for direct CGU input
>pins.  SW pins that wrap these inputs never receive change or phase
>offset notifications, so userspace consumers such as synce4l monitoring
>SMA pins via dpll netlink never learn about state transitions or phase
>offset updates.  Similarly, ice_dpll_phase_offset_get() reads the SW
>pin's own phase_offset field which is never updated; the PPS monitor
>writes to the backing CGU input's field instead.
>
>On top of that, when SMA or U.FL pin state changes via PCA9575 GPIO
>write, the paired pin's state also changes because they share physical
>signal paths, but no notification is sent for the peer pin.
>
>Fix by introducing ice_dpll_pin_ntf(), a wrapper around
>dpll_pin_change_ntf() that also notifies any registered SMA/U.FL pin
>whose backing CGU input matches.  Replace all direct
>dpll_pin_change_ntf() calls in the periodic notification paths with
>this wrapper.  Fix ice_dpll_phase_offset_get() to return the backing
>CGU input's phase_offset for input-direction SW pins.  Add
>ice_dpll_sw_pin_notify_peer() to send a notification for the paired
>SW pin after PCA9575 writes.  The peer notification is called from
>the dpll_pin_ops callback wrappers after pf->dplls.lock is released,
>because dpll_pin_change_ntf() sends a netlink message that invokes
>driver callbacks which acquire the same lock.
>
>Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
>v6:
> - fix deadlock reported by Michal Schmidt: dpll_pin_change_ntf() in
>   peer notification was called with dpll_lock held, causing deadlock.
>   Move the peer notification calls out of ice_dpll_sma_direction_set()
>   and ice_dpll_ufl_pin_state_set() into their dpll_pin_ops callback
>   wrappers, after pf->dplls.lock is released, and use
>   __dpll_pin_change_ntf() because dpll_lock is still held by the dpll
>   netlink layer (dpll_pin_pre_doit).
>v5: https://lore.kernel.org/all/20260409102501.1447628-1-poros@redhat.com/
> - add ice_dpll_sw_pin_notify_peer() for SMA/U.FL peer notification
>   when PCA9575 routing changes affect the paired pin (reported by
>   Intel test: SMA state change did not log U.FL status change in
>   subscribe monitor)
>v4: https://lore.kernel.org/all/20260319205256.998876-1-poros@redhat.com/
>v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
>v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
>v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/
>---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 80 +++++++++++++++++++----
> 1 file changed, 68 insertions(+), 12 deletions(-)

Can this patch be split to 2? Looks like 2 fixes to me.

