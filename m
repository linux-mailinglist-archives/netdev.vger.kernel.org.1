Return-Path: <netdev+bounces-278366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOnIODkJ3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A532B3F7EE3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E316D300C31E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D43C276E;
	Tue, 14 Apr 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLqMiZxf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578073C1414
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159032; cv=none; b=Ax7qk9B32LRyAuWsHF9IQVjnwFh9hiDYhvKR+G8GeTcUZMv0+kMimtiWZJmzIJ6mFw4luMn0vDuvA4BxVSh825NtHjlwob53PeiLM0DdKTmwxIFxvV/gdBsd5EyXs6i4/CXW9GyQKYPdAxIpflzZ0rDlBo2bNXmAOwOLxbkX3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159032; c=relaxed/simple;
	bh=1d1ygII+o1vZ67bX6XRT+CLhn9aYyYEagc5yedDHR/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9xC7WTZhS3xfZftn7W8VKAE9i5xetrrJ3pbF5ect6mKm47oecbWzyAMeKLF9PVIo0lU4M48RHrIB30uRPR9Gq4nOolR4uKxCUAyi/vruUpjb2lsDY3MMBZQyJR86o/EXifkf/LkemV3jtZohRvXyyjfNw3Wmk2sOkamVs8uxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLqMiZxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA6C19425;
	Tue, 14 Apr 2026 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159032;
	bh=1d1ygII+o1vZ67bX6XRT+CLhn9aYyYEagc5yedDHR/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLqMiZxfbmvEpM+PfQ6Ye7FyRFWBk/D7qrBJd/qo38jUB26k2gd7JI9P1LZyIXsLe
	 O8q4NM/DFkoCfjtzDykbCgJNaajmaFK7H22Xi/evHnF3qIfORAFTwsLrlmffSzS8BU
	 CvR0/sUDiOgG+4KV/OArt4uIA5FRgAR6h20c0cvU5W7DvqyuWwGaOA4/brTn4E0dAJ
	 4tNmQCKhjIxsakiB6pz0UbGuBr6ToO6NSxxq/NtpWipGKdrL7187tM2EoR4Abk5tWf
	 +ioCOYfNGkfvyeRbOv2B4PBuzw53p3FoWG6wuf9kwLDVtXt9SyLXvsBf0ua7y0V6AN
	 CylUNfQZTHSpw==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-next 5/10] ice: improve Add/Update VSI error messages in ice_vsi_init()
Date: Tue, 14 Apr 2026 10:30:21 +0100
Message-ID: <20260414093021.746323-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410074921.1254213-6-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278366-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: A532B3F7EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: improve Add/Update VSI error messages in ice_vsi_init()

The error messages emitted when Add VSI or Update VSI Admin
Queue commands fail are missing the VSI index and the last AQ
error code. Add both to match the pattern used elsewhere in
the driver for AQ-command failures, which helps narrow down
firmware issues without requiring debug logs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 689c6025ea82e..0e79d66959d4f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1320,14 +1320,18 @@ static int ice_vsi_init(struct ice_vsi *vsi, u32 vsi_flags)
>  	if (vsi_flags & ICE_VSI_FLAG_INIT) {
>  		ret = ice_add_vsi(hw, vsi->idx, ctxt, NULL);
>  		if (ret) {
> -			dev_err(dev, "Add VSI failed, err %d\n", ret);
> +			dev_err(dev, "Add VSI %d failed, err %d aq_err %s\n",
> +				vsi->idx, ret,
> +				libie_aq_str(hw->adminq.sq_last_status));

Will this print a misleading "aq_err OK" if ice_add_vsi() fails for software
reasons?

For instance, if devm_kzalloc() fails inside ice_add_vsi(), it calls
ice_aq_free_vsi() to clean up before returning -ENOMEM:

int ice_add_vsi(...)
{
	...
	tmp_vsi_ctx = devm_kzalloc(ice_hw_to_dev(hw), ...
	if (!tmp_vsi_ctx) {
		ice_aq_free_vsi(hw, vsi_ctx, false, cd);
		return -ENOMEM;
	}
	...
}

The successful ice_aq_free_vsi() call resets hw->adminq.sq_last_status to OK.
Since the log unconditionally prints sq_last_status, it will display the
-ENOMEM error alongside "aq_err OK".

Additionally, could reading hw->adminq.sq_last_status outside the Admin Queue
lock be racy? Could a concurrent AQ command overwrite the status before it
is printed?

>  			ret = -EIO;
>  			goto out;
>  		}
>  	} else {
>  		ret = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
>  		if (ret) {
> -			dev_err(dev, "Update VSI failed, err %d\n", ret);
> +			dev_err(dev, "Update VSI %d failed, err %d aq_err %s\n",
> +				vsi->idx, ret,
> +				libie_aq_str(hw->adminq.sq_last_status));

A similar situation applies here. If ice_update_vsi() returns early due to an
invalid VSI handle, it returns -EINVAL without executing an AQ command. This
would result in printing whatever AQ status was left behind from a previous
command.

>  			ret = -EIO;
>  			goto out;
>  		}

