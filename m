Return-Path: <netdev+bounces-291914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IiqtBkz3FWpxgQcAu9opvQ
	(envelope-from <netdev+bounces-291914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:41:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3715DC137
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 426233015A7A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820A3ACF15;
	Tue, 26 May 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RInNDfHP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B0318EE2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824455; cv=none; b=rrO+NzEJsxDN8pEM+fPzhaVzPETFQrKhcd0GbWslzxow8rJvtwSMYufjOHc9MBrPDAvJ70QNWoe5DIfbkMpQ0yVzeAXV5MxJd940x2CUZ3Q9MEPCpxTIiQjNIUI3pgOGpFd/yVSHsd1rr/KIZ+h04ZV3c/0+yIYgUf8oEAt01R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824455; c=relaxed/simple;
	bh=F5frrW998FNG+MVyldwv0/1kfiMGHYyr5DBhehAhFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApD3xrrN/pi591zVgEBEyxHSm4oKqwXCFJ0fwVTXVDp3A+qK45xfKPszl83OaSwbLEqu7pNIh72ex8R0dQBgsgM7N1gxYgancfuCNMFApAIySKLdoSSvbO+7JWgyD501r43wmeo/GjuzYIaXeQ6poSxNOL+aPtv/bkGl0KT5AoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RInNDfHP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53231F000E9;
	Tue, 26 May 2026 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824453;
	bh=3dc3s5FcGv5TWeqnsXrMMOMRbRrCCsMuvBGziG/wGiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RInNDfHPD2F13iiBXuM2riLL4luuizpzpHuIIMCA+VQ5qip00sf7n+PbDrNZAfECb
	 XOzErwmPBYnRivhowJTiOrxIHHvy7qydP/OOsyJET/rRa6J6vXDv7iVQRiUTz3T2Lu
	 5+zN1G+dl+DjtCFIJWRg3f7mHTMqU4s8t/47XPQPvwbojeAQNC4EYMMpU/cqmo7+B+
	 2t4N70AmhbPelQtIYzFaTDB51lIAyDOqxXAwMsQpuft3J3JuaHMR28wyNckXNZ6D6Q
	 WBF9YHmX1VnZUpC093zsFGmqiCPZauViIpbpIP17jo7Kguz3+MFIHSi282jPgVQEST
	 Lu+9RtCOrq/3w==
Date: Tue, 26 May 2026 20:40:50 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/2] iavf: log PF diagnostic message on cloud
 filter add failure
Message-ID: <20260526194050.GC2256768@horms.kernel.org>
References: <20260522025702.1764129-1-aleksandr.loktionov@intel.com>
 <20260522025702.1764129-2-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522025702.1764129-2-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291914-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 0B3715DC137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 04:57:01AM +0200, Aleksandr Loktionov wrote:
> When the PF rejects a cloud filter add request it may include a
> diagnostic string in the virtchnl response. Use dev_info() to log it
> so operators can diagnose offload failures without enabling verbose
> tracing.
> 
> Use %.*s with an explicit length bound to avoid reading past the end of
> the message buffer when the PF fills all 4096 bytes and leaves no NUL
> terminator. Add the missing cloud_filter_list_lock around both the
> VIRTCHNL_OP_ADD_CLOUD_FILTER and VIRTCHNL_OP_DEL_CLOUD_FILTER error
> paths to close a pre-existing race against iavf_add_cloud_filter() and
> iavf_del_cloud_filter(). Apply the same %.*s fix to the equivalent
> VIRTCHNL_OP_ADD_FDIR_FILTER error path which carried the same bug.

This seems to be doing several things. So I would suggest it warrants
being split into several patches.

And, if they are fixes, some consideration should be given
to targeting iwl and including Fixes tags in the patches.

Partially flagged by: https://netdev-ai.bots.linux.dev/sashiko/


Also, the locking fix here is made to the error path,
but not the non-error path (v_retval == 0) where
the VIRTCHNL_OP_ADD_CLOUD_FILTER and VIRTCHNL_OP_DEL_CLOUD_FILTER cases
traverse and update  cloud_filter_list.

Flagged by https://sashiko.dev/


> Suggested-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

...

> @@ -2434,8 +2443,10 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  							       v_retval));
>  					iavf_print_fdir_fltr(adapter, fdir);
>  					if (msglen)
> -						dev_err(&adapter->pdev->dev,
> -							"%s\n", msg);
> +						dev_info(&adapter->pdev->dev,
> +							 "%.*s\n",
> +							 (int)msglen,
> +							 (const char *)msg);

As well as addressing the length of msg, ad described in the commit
message, this also changes the priority of the message from err to info.
This seems to be a separate change that is not mentioned in the commit
message.

Also flagged by: https://sashiko.dev/

>  					list_del(&fdir->list);
>  					iavf_dec_fdir_active_fltr(adapter, fdir);
>  					kfree(fdir);

