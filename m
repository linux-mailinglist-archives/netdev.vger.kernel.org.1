Return-Path: <netdev+bounces-189776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2DAB3AA6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1979E19E1846
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFC227EA8;
	Mon, 12 May 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC94YVJW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B119CC3A;
	Mon, 12 May 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060273; cv=none; b=qMj4Twyvpk6jelZGH2yFb2yLDCI4xACNKVvDNljjS8V1VrDdlwOWTfGqdwfFbdkNqdSRV7DcqhRvrtQzX/p+2AN9zFhKz4UCkpO17uJMo/ZirH5f5QLoOlTB5hIBawrpb8KX4EXI9LtzgIK4Dtwofmt2h0+teWEiOi+/c48J2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060273; c=relaxed/simple;
	bh=D22xfF7vCMy0iXUF0syExk/uQGvJjAMT981A7+9a/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqFRBMQhMSpuAP6hgifV15XLVhGKmAmwHokPvT1DqVZdFj9Dn13KGlkEhSj/4AJEpoAH9GB+kCxgsNRDq65yiaXgVni9bFHvrVEcnVOoImHnhHo54J6b2LRv1jqyyN7t+M/So0WH5Gwd43bZff1Xn+YsoDmIHMSWLvC6ssmnP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC94YVJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC39BC4CEE7;
	Mon, 12 May 2025 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747060273;
	bh=D22xfF7vCMy0iXUF0syExk/uQGvJjAMT981A7+9a/pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC94YVJWtfERDpHpUjGuLpEBIiXd3JHOUCWKdwQmymUXdY9aQFiVmLgwaAUjoCn5V
	 HI/MOBymy5XxT7KitVdJN/eVNbtVoSMk+4deNc5mLxsMr3XKrfEUA/UQZTsjUpi4pC
	 X2G7EzJ1UUBkQPqfm38sB5kZDqub86EYtuCa8AvRKSiDOd0bu9SsDPh750VSW7j2GV
	 UuEc1RVQ4Wx6SVHH15BCvl4rBhBNmk/uBgnXaNuni0Dnxiywm3NjAIwpjYfr39oO8T
	 CxikRewOwS7NtIMKmleP+un7KX0qva5yxDZyPiQn1rptgQQaF14DyI+FtgsWl2hbkM
	 4pc4hVm4l/f0A==
Date: Mon, 12 May 2025 15:31:07 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] eth: fbnic: Add devlink dev flash support
Message-ID: <20250512143107.GJ3339421@horms.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-6-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510002851.3247880-6-lee@trager.us>

On Fri, May 09, 2025 at 05:21:17PM -0700, Lee Trager wrote:
> Add support to update the CMRT and control firmware as well as the UEFI
> driver on fbnic using devlink dev flash.
> 
> Make sure the shutdown / quiescence paths like suspend take the devlink
> lock to prevent them from interrupting the FW flashing process.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

...

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c

...

> @@ -109,8 +111,264 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
>  	return 0;
>  }
> 
> +static bool
> +fbnic_pldm_match_record(struct pldmfw *context, struct pldmfw_record *record)
> +{
> +	struct pldmfw_desc_tlv *desc;
> +	u32 anti_rollback_ver = 0;
> +	struct devlink *devlink;
> +	struct fbnic_dev *fbd;
> +	struct pci_dev *pdev;
> +
> +	/* First, use the standard PCI matching function */
> +	if (!pldmfw_op_pci_match_record(context, record))
> +		return -ENODEV;

Hi Lee,

The return type of this function is bool, but here a negative integer is
being returned. Perhaps this should be:

		return false;

Flagged by Smatch

> +
> +	pdev = to_pci_dev(context->dev);
> +	fbd = pci_get_drvdata(pdev);
> +	devlink = priv_to_devlink(fbd);
> +
> +	/* If PCI match is successful, check for vendor-specific descriptors */
> +	list_for_each_entry(desc, &record->descs, entry) {
> +		if (desc->type != PLDM_DESC_ID_VENDOR_DEFINED)
> +			continue;
> +
> +		if (desc->size < 21 || desc->data[0] != 1 ||
> +		    desc->data[1] != 15)
> +			continue;
> +
> +		if (memcmp(desc->data + 2, "AntiRollbackVer", 15) != 0)
> +			continue;
> +
> +		anti_rollback_ver = get_unaligned_le32(desc->data + 17);
> +		break;
> +	}
> +
> +	/* Compare versions and return error if they do not match */
> +	if (anti_rollback_ver < fbd->fw_cap.anti_rollback_version) {
> +		char buf[128];
> +
> +		snprintf(buf, sizeof(buf),
> +			 "New firmware anti-rollback version (0x%x) is older than device version (0x%x)!",
> +			 anti_rollback_ver, fbd->fw_cap.anti_rollback_version);
> +		devlink_flash_update_status_notify(devlink, buf,
> +						   "Anti-Rollback", 0, 0);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}

...

