Return-Path: <netdev+bounces-286709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGBOAh32AWpXmwEAu9opvQ
	(envelope-from <netdev+bounces-286709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D35112FD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E84E3026F26
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481EF373BFC;
	Mon, 11 May 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boEklgmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23612313527
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513248; cv=none; b=LtBAxVl2jEweHE8fIaNthwY4DxljvQ4D/whnobe7Bsrpnpa9Ja7nU0wEtjzHmY+8fdJnL3sesDvYT0S7CYcBCSe7/N8tjUcYjBRh9XrmU8GTI9yJBYW2uLDIOiEItzQO+tC7cpLAM85Cp+7O3pWPm5aIG42GunwPofyje3pZ1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513248; c=relaxed/simple;
	bh=lPTcpIsJwfOPf9wIvYhMTgk0EC/36bqpraey/F/PXmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Julv+fBpRhWwOTsZm62Aqg2KBMYVFP3EbuniBiH7iKjtJ3kim3q/mMq2Pb70DIbWVIvOFe7o2FjrvCM29t7Ywdj1V2PPP00lNCYvJ72mIWs4SdXZm4B5ZEDMY7mLJVGuVxYAVuoRUUM7l/PN4bWEH9GjuivoHsc3ZxXvjyYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boEklgmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925AFC2BCB0;
	Mon, 11 May 2026 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778513247;
	bh=lPTcpIsJwfOPf9wIvYhMTgk0EC/36bqpraey/F/PXmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boEklgmpUgjm3ZGvguW45hRvg6UioP/0VSQjV4B3/HCdc7YkGjfIOBXywZ7AhK3lS
	 oDs/ruDkNRgfXKfuZGHL8eumdvEZHd1Dl3G+uYVTfDrZXf+FlQZ4NtJhEPTDxfCu0B
	 8QLNPTPQoyfrNndjshQBoUj1Eu8uiEG1K8lVNQd+D3qZT/6V5OjqUIjlygMxbkHjro
	 QoPUBsG25piHiTrRel07rlRAMrYqnLC6nMm89woYz5JSzWAKZCTnOh5CaRjU48qMDS
	 zcZt8QxNmhVC2EO7vaGvfZHMhkFoitO/95Qm5wYC34wqVW17RTehPLr8PqV807TwKX
	 GTLBC5VUaymkw==
Date: Mon, 11 May 2026 16:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 1/8] ixgbe: rename numa_node to node in struct
 ixgbe_q_vector
Message-ID: <20260511152724.GA27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-2-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: 5A6D35112FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:12:19AM +0200, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The 'numa_node' field in struct ixgbe_q_vector shadows the 'numa_node'
> accessor for struct device, which triggers a sparse warning about
> shadowing a built-in object.  The stored value here is a plain NUMA
> node number, not a device attribute, so rename it to 'node' to avoid
> the shadow and keep the naming consistent with other Intel drivers.
> 
> Update all three usage sites in ixgbe_lib.c and ixgbe_main.c.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


