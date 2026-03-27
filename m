Return-Path: <netdev+bounces-272503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KhSG0tgxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEE342D39
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7B13026AA9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2EA344D92;
	Fri, 27 Mar 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1e2SwED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780293431E3
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608456; cv=none; b=mzHxdjJCJVHVG0Q0c1rj8zZv8qZw3RsNZZq77of9mVDA24zZlbwySjhWDO2DMqlZnmE0KD1DTvLKL80zhBKAQf/ZRD9IxEzskhq/h6ZtRe92wHzSlE18KSWOd6kAJ9OoLK8I2jpCu9N0HGk1rGDYoCiJUbV/zmNYE2LBC1i9Pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608456; c=relaxed/simple;
	bh=r8OjbGRJ6dRl5LnFR7ool+5ejKgvKJDtEWK8kYX9IKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKboJQ8XShcd4mz17iZcOIotaAsnTTYmMQzLw5N4ImEOm3jDguX32YPkKTx8kXrQELwV1PitbAtin+bSYe6ThTf3Ql5LTgR66GlovlYMLRjLyPrLI6R6pVLidtfa3bFtp3wj6GyUfECebZG8IZ7rmoSmrTr6rDReWIEZ98QAZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1e2SwED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D73C19423;
	Fri, 27 Mar 2026 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608456;
	bh=r8OjbGRJ6dRl5LnFR7ool+5ejKgvKJDtEWK8kYX9IKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1e2SwED2RVc9xwPFJddwd7l0aG9w8ww3zAFuC3hxAl4vGwrPcmOsoV3toopAjA/7
	 E+5SR/x1Bi6ptb/m1EaVXNwOyXx/mtnR3SyJnwAfxbmpV7GOB/RUqXZOZJskYAwM8o
	 bebwwg7A737E4jpYTVzge/4LqV+/e4A9dphKhsQYrGb6U2U7cWMQCVoDIimlkS89Om
	 2LTv4rKhkiNHQ9ZHpWVI/KkVAMjojTBwkwEKIqr51YbNYw6CoHqwyOWnPyBBKJfhQ4
	 M8ILvVKuT++cygF5tgUmzP9rcHIwFCIRKwnKThBayO+LJG8qLo00FUi2PchnBrGlw7
	 pYBAR1dQQZ+CA==
Date: Fri, 27 Mar 2026 10:47:32 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-next v3] ice: add 200G_AUI8 PHY type definitions and
 wire them up
Message-ID: <20260327104732.GB567789@horms.kernel.org>
References: <20260324153542.674859-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324153542.674859-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: C4EEE342D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:35:42PM +0100, Aleksandr Loktionov wrote:
> ice_link_mode_str_high[] lacks entries for phy_type_high bits 5-14
> (all 200G PHY types on E825C); ice_dump_phy_type() prints nothing for
> them when ICE_DBG_LINK is set (e.g. 'ethtool -s ethX msglvl 0x10').
> The loop also iterates all 64 bits against a 5-entry array - undefined
> behaviour for any matched bit beyond the end.  Add strings for bits
> 5-14 and guard the loop with ARRAY_SIZE(), falling back to "unknown"
> for unrecognised bits.
> 
> ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC (bit 13) and 200G_AUI8 (bit 14)
> were absent from ice_adminq_cmd.h; ICE_PHY_TYPE_HIGH_MAX_INDEX capped
> at 12 caused ice_update_phy_type() to skip them entirely, leaving both
> invisible to 200G speed requests.  Add the definitions and bump
> MAX_INDEX to 14.
> 
> Wire the two new types throughout the driver:
> - ice_get_media_type(): handle all ten 200G phy_type_high values so
>   E825C ports no longer return ICE_MEDIA_UNKNOWN.  AOC_ACC interfaces
>   map to FIBER; bare AUI4/AUI8 to DA with cage, else BACKPLANE
>   (matching existing AUI2/CAUI2 logic); CR4_PAM4 to DA; SR4/FR4/LR4/
>   DR4 to FIBER; KR4_PAM4 to BACKPLANE.
> - ice_get_link_speed_based_on_phy_type(): return ICE_AQ_LINK_SPEED_200GB
>   for both new types so ice_update_phy_type() enables them correctly.
> - phy_type_high_lkup[13,14]: AUI8 is 8-lane 25G-per-lane; no
>   200000baseSR8/CR8 ethtool modes exist yet, so approximate with
>   SR4_Full/CR4_Full - matching AUI4 at indices 11-12.  FIXME once
>   those link modes land upstream.
> - ICE_PHY_TYPE_HIGH_MASK_200G: add bits 13-14 for the minimum-speed
>   floor in ice_mask_min_supported_speeds().
> 
> Suggested-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v3 -> v4: add ARRAY_SIZE() OOB guard in ice_dump_phy_type(); cover all
>           ten 200G phy_type_high values in ice_get_media_type(); add FIXME
>           to lkup[13..14] for missing SR8/CR8 modes; rename subject
>           fix subject; fix debug enable example (ethtool, not modprobe);
>           add AUI8 speed mapping, lkup[13-14], MASK_200G bits 13-14,
>           and AUI8->SR4/CR4 approximation comment
> v1 -> v2: add ICE_PHY_TYPE_HIGH_MAX_INDEX update

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


