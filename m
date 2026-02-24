Return-Path: <netdev+bounces-260594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP1bNUzZnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:01:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32318A389
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7925C303A11A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2973A8FE0;
	Tue, 24 Feb 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8t3n5vr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F93A7F58
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951909; cv=none; b=sERCeTzz71mGF6X6aFY6UmyMn76XBrP2f/xiEbGOSCn/C9KuDJlLwPDLiEklJg9kKKPGneEKpWkXmxtis+sHuyRxhATf3wE6br2A9iOFz6tHuSIJ9k/cYaXTVoPBLekE/hit4aQh5Vbw/uN77qLas1JzKjCbLifJsWhCv6FltVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951909; c=relaxed/simple;
	bh=NbJZkDphPUQpxbHFYoF66qaDcKzRN4oeXu/r0CVUxhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg5XKhQmJ25PH3NHwWsC7BrRa+Cbjpb4Jo8aqlOjV+XfzKgaclVyAkhnAHL1ECi8sWxn/uIdTeuhJtfuuHsyiwLbD+JAZJcBq4nGHfGrtYPrv6U0b2nqTp0XPAlzilIK17ojfyilK3f0OIXRPzyHSPIwKv/Cu2Iq91EQ5XeCvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8t3n5vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D678DC116D0;
	Tue, 24 Feb 2026 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951909;
	bh=NbJZkDphPUQpxbHFYoF66qaDcKzRN4oeXu/r0CVUxhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8t3n5vrKeBclrgxx/DXcZSaeTJtDIoC7NTnka3pudEyN12jLjzMCfPzRFSwmHvNH
	 cqNjdRGYSj7GqfLEBxbf9rJQH5cnnfXas96W3UUPPGXphKQ6iQgihcCsSxGukNim0x
	 m8o78nbhwzW6h6cgkh5w6DQZRMLyTLfi7MV0cf/lGTiGje8PBMLn6AbdPog3y6hBIo
	 ubbZUxJAh9htnvRPy3iGNi99CBY4Va4P3DJJIfv+sfy8CWDila94nOt8kezpt8Q2ru
	 bPoGQpQD4ujLJZownHPzSU326ehGEEIL0aa2LI/c5z55KnZmBUMKDYU8Y2wEyWXpDb
	 3orzodgnHpCjw==
Date: Tue, 24 Feb 2026 16:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH] ice: mention fw_activate action along with devlink reload
Message-ID: <aZ3XIa2a1XiI4cQY@horms.kernel.org>
References: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jacob.e.keller.intel.com:query timed out,aleksandr.loktionov.intel.com:query timed out,horms.kernel.org:query timed out,przemyslaw.kitszel.intel.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A32318A389
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:12:17PM -0800, Jacob Keller wrote:
> The ice driver reports a helpful status message when updating firmware
> indicating what action is necessary to enable the new firmware. This is
> done because some updates require power cycling or rebooting the machine
> but some can be activated via devlink.
> 
> The ice driver only supports activating firmware with the specific action
> of "fw_activate" a bare "devlink dev reload" will *not* update the
> firmware, and will only perform driver reinitialization.
> 
> Update the status message to explicitly reflect that the reload must use
> the fw_activate action.
> 
> I considered modifying the text to spell out the full command, but felt
> that was both overkill and something that would belong better as part of
> the user space program and not hard coded into the kernel driver output.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks Jacob, all,

I agree that this text strikes a good balance.

Reviewed-by: Simon Horman <horms@kernel.org>

